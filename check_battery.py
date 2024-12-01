#!/usr/bin/env python3
"""
SMBus Battery Status LEDs.

Monitor a battery voltage via an ADC and switch status LEDs accordingly.
"""

import os
import sys
import time
import signal
import logging
import traceback
import atexit
import gpio  # type: ignore
import smbus3 as smbus
import sdnotify  # type: ignore

CHECK_INTERVAL = 5

# it's 3.2V per cell in Server.py, and we want to switch to red before it
# shuts down, but we'll need to tune the number to give an appropriate warning
# time
LOW_VOLTAGE = 3.3

LED_PIN_GREEN = 21
LED_PIN_RED = 26

DEFAULT_LOG_LEVEL = logging.INFO

STDOUT_HANDLER = logging.StreamHandler(sys.stdout)
STDOUT_HANDLER.setFormatter(logging.Formatter(
                            '%(name)s - %(levelname)s - %(message)s'))

logger = logging.getLogger(os.path.splitext(os.path.basename(__file__))[0])
logger.addHandler(STDOUT_HANDLER)
logger.setLevel(DEFAULT_LOG_LEVEL)


def signal_handler(sig, _frame):  # pylint: disable=unused-argument
    """Handle SIGINT cleanly."""
    logger.info('Caught signal %s, exiting..', sig)
    sys.exit(0)


signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

notifier = sdnotify.SystemdNotifier()


class ADS7830:  # pylint: disable=invalid-name
    """
    An ADS730 ADC on the SMBus.

    Read the ADC via the SMBus and convert the data to a voltage for the
    battery it's monitoring.
    """

    def __init__(self, channel=0):
        """Get the bus, set address and command."""
        self.bus = smbus.SMBus(1)
        self.ADC_ADDRESS = 0x48
        self.ADC_COMMAND = 0x84  # Single-Ended Inputs
        self.channel = channel

        # convert ADC data to voltage
        #
        # NOTE: Dog's PDF say's it's multilpied by 3, example code says it's
        #       multiplied by 2. This number should match the number of
        #       battery cells, so 2 is correct for the Freenove Robot Dog.
        self.ADC_SCALE = 1 / 255.0 * 5.0 * 2

    def read_adc(self):
        """Read the ADC as defined by __init__."""
        command_set = self.ADC_COMMAND | \
            ((((self.channel << 2) | (self.channel >> 1)) & 0x07) << 4)
        self.bus.write_byte(self.ADC_ADDRESS, command_set)
        data = self.bus.read_byte(self.ADC_ADDRESS)
        return data

    def get_data(self):
        """Convert the raw ADC data into an integer."""
        data = ['', '', '', '', '', '', '', '', '']
        for i in range(9):
            data[i] = self.read_adc()
        data.sort()
        return data[4]

    def voltage(self, data=None):
        """
        Convert ADC data into a voltage based on the calibration.

        If not data is provided, fetch it from get_data().
        """
        if not data:
            data = self.get_data()
        return data * self.ADC_SCALE


class StatusIndicator:
    """Indicate the status of the battery via LEDs attached tot he GPIO.."""

    def __init__(self, adc):
        """Set pin numbers for LEDs."""
        try:
            self.pin_green = gpio.GPIOPin(LED_PIN_GREEN, gpio.OUT)
            self.pin_red = gpio.GPIOPin(LED_PIN_RED, gpio.OUT)
        except PermissionError:
            logger.error('No write permission to /sys/class/gpio/export.')
            sys.exit(1)

        self.adc = adc
        self.low_volt = LOW_VOLTAGE
        self.status_text = ['LOW', 'OKAY']

        # it's less maths overall if we convert the low voltage limit into the
        # same scale as the raw ADC data, then we only have to do the maths
        # once during init
        self.low_volt_cutoff = self.low_volt / adc.ADC_SCALE

        self.last_bat_status = None

        logger.info('Initialization done. Signalling readiness.')
        notifier.notify('READY=1')

    def check(self):
        """Check the voltage and determine if status has changed."""
        data = self.adc.read_adc()
        this_bat_status = bool(data > self.low_volt_cutoff)

        if this_bat_status != self.last_bat_status:
            self.set_status(this_bat_status)
        self.last_bat_status = this_bat_status

        # return the scaled voltage
        return self.adc.voltage(data)

    def set_status(self, this_status=False):
        """
        Switch the LEDs based on the status.

        When status is 'true', indicate 'okay'. Otherwise, indicate 'low'.
        """
        if this_status:
            self.pin_green.write(gpio.HIGH)
            self.pin_red.write(gpio.LOW)
        else:
            self.pin_green.write(gpio.LOW)
            self.pin_red.write(gpio.HIGH)

        # including the voltage here is extra maths every run, defeats the point
        # of being efficient by doing the comparison on the un-scaled data in
        # check()
        logger.info('Battery status changed to %s (%sV)',
                    self.status_text[this_status], str(self.adc.voltage())[:5])

    def disable(self):
        """Switch both LEDs off."""
        logger.info("Disabling both status LEDs.")
        self.pin_green.write(gpio.LOW)
        self.pin_red.write(gpio.LOW)


def main():
    """Do all the things."""
    adc = ADS7830()
    bat_status = StatusIndicator(adc)
    atexit.register(bat_status.disable)

    while True:
        try:
            volts = bat_status.check()
            notifier.notify(f'STATUS=Battery voltage: {volts:.3f}V')
        except Exception:  # pylint: disable=broad-exception-caught
            logger.error(traceback.format_exc())
            sys.exit(1)

        time.sleep(CHECK_INTERVAL)


if __name__ == '__main__':
    main()
