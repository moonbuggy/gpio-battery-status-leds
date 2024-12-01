EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Raspberry_Pi_2_3 RPi1
U 1 1 674713F2
P 8050 3450
F 0 "RPi1" H 8050 4931 50  0000 C CNN
F 1 "Raspberry_Pi_2_3" H 8050 4840 50  0000 C CNN
F 2 "RaspberryPi:raspberrypi_2_3" H 8050 3450 50  0001 C CNN
F 3 "https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3bplus_1p0_reduced.pdf" H 8050 3450 50  0001 C CNN
	1    8050 3450
	1    0    0    -1  
$EndComp
NoConn ~ 7250 2550
NoConn ~ 7250 2650
NoConn ~ 7250 2850
NoConn ~ 7250 2950
NoConn ~ 7250 3050
NoConn ~ 7250 3250
NoConn ~ 7250 3650
NoConn ~ 7250 3750
NoConn ~ 7250 3850
NoConn ~ 7250 3950
NoConn ~ 7250 4150
NoConn ~ 8850 4250
NoConn ~ 8850 4150
NoConn ~ 8250 4750
NoConn ~ 8150 4750
NoConn ~ 8050 4750
NoConn ~ 7950 4750
NoConn ~ 7850 4750
NoConn ~ 7750 4750
NoConn ~ 7650 4750
NoConn ~ 8850 3950
NoConn ~ 8850 3850
NoConn ~ 8850 3750
NoConn ~ 8850 3650
NoConn ~ 8850 3550
NoConn ~ 8850 3350
NoConn ~ 8850 3250
NoConn ~ 8850 3150
NoConn ~ 8850 2950
NoConn ~ 8850 2850
NoConn ~ 8850 2650
NoConn ~ 8850 2550
NoConn ~ 7850 2150
NoConn ~ 7950 2150
NoConn ~ 8150 2150
NoConn ~ 8250 2150
Wire Wire Line
	8350 4750 8350 4950
$Comp
L power:GND #PWR0101
U 1 1 67480DAB
P 8350 4950
F 0 "#PWR0101" H 8350 4700 50  0001 C CNN
F 1 "GND" H 8355 4777 50  0000 C CNN
F 2 "" H 8350 4950 50  0001 C CNN
F 3 "" H 8350 4950 50  0001 C CNN
	1    8350 4950
	1    0    0    -1  
$EndComp
Text GLabel 6900 3300 1    50   Output ~ 0
BAT_OK
Text GLabel 6900 3900 1    50   Output ~ 0
BAT_LOW
Text GLabel 3200 4100 2    50   Input ~ 0
BAT_LOW
Wire Wire Line
	3050 4100 3200 4100
Text GLabel 3200 2800 2    50   Input ~ 0
BAT_OK
$Comp
L Connector_Generic:Conn_02x02_Odd_Even J1
U 1 1 6747FB4B
P 3050 3300
F 0 "J1" V 3150 3450 50  0000 C CNN
F 1 "Conn_02x02_Odd_Even" V 3050 3800 50  0000 C CNN
F 2 "moonbuggy-custom:Socket_Strip_Straight_2x02_Pitch2.54mm-1-red" H 3050 3300 50  0001 C CNN
F 3 "~" H 3050 3300 50  0001 C CNN
	1    3050 3300
	0    1    -1   0   
$EndComp
NoConn ~ 3050 3000
Wire Wire Line
	3050 3500 3050 4100
Wire Wire Line
	2950 3600 2950 3500
Connection ~ 2950 2800
Wire Wire Line
	2950 2800 3200 2800
Wire Wire Line
	2550 3750 2550 3600
Wire Wire Line
	2550 3350 2550 3600
Connection ~ 2550 3600
Wire Wire Line
	2450 3600 2550 3600
Wire Wire Line
	2550 3600 2950 3600
$Comp
L Device:R_Small R2
U 1 1 67484841
P 2750 2800
F 0 "R2" V 2950 2750 50  0000 L CNN
F 1 "100k" V 2850 2700 50  0000 L CNN
F 2 "Resistors_SMD:R_0603" H 2750 2800 50  0001 C CNN
F 3 "~" H 2750 2800 50  0001 C CNN
	1    2750 2800
	0    1    -1   0   
$EndComp
Wire Wire Line
	2650 2800 2550 2800
Wire Wire Line
	2550 2800 2550 3150
Wire Wire Line
	2700 4100 2550 4100
Wire Wire Line
	2550 4100 2550 3950
$Comp
L Device:LED_Small D1
U 1 1 67485EE8
P 2550 3850
F 0 "D1" V 2500 4000 50  0000 C CNN
F 1 "LED_Red" V 2600 4100 50  0000 C CNN
F 2 "LEDs:LED_0603" V 2550 3850 50  0001 C CNN
F 3 "~" V 2550 3850 50  0001 C CNN
	1    2550 3850
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 67483080
P 2450 3600
F 0 "#PWR0102" H 2450 3350 50  0001 C CNN
F 1 "GND" V 2450 3400 50  0000 C CNN
F 2 "" H 2450 3600 50  0001 C CNN
F 3 "" H 2450 3600 50  0001 C CNN
	1    2450 3600
	0    1    -1   0   
$EndComp
$Comp
L Device:R_Small R1
U 1 1 67484DC6
P 2800 4100
F 0 "R1" V 3000 4150 50  0000 R CNN
F 1 "15k" V 2900 4150 50  0000 R CNN
F 2 "Resistors_SMD:R_0603" H 2800 4100 50  0001 C CNN
F 3 "~" H 2800 4100 50  0001 C CNN
	1    2800 4100
	0    -1   -1   0   
$EndComp
Connection ~ 3050 4100
Wire Wire Line
	2900 4100 3050 4100
$Comp
L Device:LED_Small D2
U 1 1 674854B3
P 2550 3250
F 0 "D2" V 2600 3100 50  0000 C CNN
F 1 "LED_Green" V 2500 2950 50  0000 C CNN
F 2 "LEDs:LED_0603" V 2550 3250 50  0001 C CNN
F 3 "~" V 2550 3250 50  0001 C CNN
	1    2550 3250
	0    1    -1   0   
$EndComp
Wire Wire Line
	2950 2800 2850 2800
Wire Wire Line
	2950 2800 2950 3000
$Comp
L moonbuggy_custom:GPIO_Status_LEDs U1
U 1 1 674CD39E
P 6000 3350
F 0 "U1" H 6000 3715 50  0000 C CNN
F 1 "GPIO_Status_LEDs" H 6000 3624 50  0000 C CNN
F 2 "moonbuggy-custom:GPIO_Status_LEDs" H 6000 3000 50  0001 C CNN
F 3 "" H 6000 3400 50  0001 C CNN
	1    6000 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6550 3450 6900 3450
Wire Wire Line
	6900 3300 6900 3450
Connection ~ 6900 3450
Wire Wire Line
	6900 3450 7250 3450
Wire Wire Line
	5150 4050 5150 3250
Wire Wire Line
	5150 3250 5450 3250
Wire Wire Line
	5150 4050 6900 4050
Wire Wire Line
	6900 3900 6900 4050
Connection ~ 6900 4050
Wire Wire Line
	6900 4050 7250 4050
$Comp
L power:GND #PWR0103
U 1 1 674D2909
P 5300 3550
F 0 "#PWR0103" H 5300 3300 50  0001 C CNN
F 1 "GND" H 5305 3377 50  0000 C CNN
F 2 "" H 5300 3550 50  0001 C CNN
F 3 "" H 5300 3550 50  0001 C CNN
	1    5300 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 3550 5300 3450
Wire Wire Line
	5300 3450 5450 3450
NoConn ~ 6550 3250
$EndSCHEMATC
