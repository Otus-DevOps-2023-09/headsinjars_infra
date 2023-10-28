#!/bin/bash
# This is a script to install MongoDB
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

sudo apt update -y
sudo apt install mongodb -y
# Start mongodb
sudo systemctl start mongodb

# Enable service mongodb
sudo systemctl enable mongodb
# end
