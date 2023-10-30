#!/bin/bash
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo apt update -y
sudo apt install git -y
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
# end
