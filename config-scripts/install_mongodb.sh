#!/bin/bash
# This is a script to install MongoDB
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

apt update -y
apt install mongodb -y
# Start mongodb
systemctl start mongodb

# Enable service mongodb
systemctl enable mongodb
# end
