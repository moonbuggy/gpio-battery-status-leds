#! /bin/sh

FREENOVE_PATH="${1:-$(pwd)}"
[ "${FREENOVE_PATH#${FREENOVE_PATH%?}}" != "/" ] && FREENOVE_PATH="${FREENOVE_PATH}/"

# check the Freenove server files exist at the specified path
[ ! -f "${FREENOVE_PATH}Freenove_Robot_Dog_Kit_for_Raspberry_Pi/Code/Server/main.py" ] \
  && echo "ERROR: Cannot find 'Freenove_Robot_Dog_Kit_for_Raspberry_Pi/Code/Server/main.py' at ${FREENOVE_PATH}." \
  && exit 1

TEMP_DIR="/tmp/robot-dog-installer"
mkdir -p "${TEMP_DIR}"

sed -e "s|<FREENOVE_PATH>|${FREENOVE_PATH}|" robot-dog-server.service \
  >"${TEMP_DIR}/robot-dog-server.service"

# robot dog control server
/usr/bin/install -m 644 "${TEMP_DIR}/robot-dog-server.service" '/etc/systemd/system'

# check_battery script
pip3 install -r requirements.txt
/usr/bin/install -m 755 check_battery.py '/usr/local/bin'

# check_battery service
/usr/bin/install -m 644 robot-dog-battery-check.service '/etc/systemd/system'

/usr/bin/systemctl daemon-reload
/usr/bin/systemctl enable robot-dog-server.service robot-dog-battery-check.service
/usr/bin/systemctl start robot-dog-server.service robot-dog-battery-check.service

rm -rf "${TEMP_DIR}"
