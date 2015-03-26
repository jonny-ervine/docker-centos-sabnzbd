#!/bin/bash
##
## Start up script for SABnzbd on CentOS docker container
##

## Initialise any variables being called:
# Set the correct timezone
TZ=${TZ:-UTC}
setup=/config/sabnzbd/.setup

if [ ! -f "${setup}" ]; then
  rm -f /etc/localtime
  cp /usr/share/zoneinfo/$TZ /etc/localtime
  touch $setup
fi

## Start up SABnzbd daemon via supervisord
/usr/bin/supervisord -n -c /etc/supervisord.conf
