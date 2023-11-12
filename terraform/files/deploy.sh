#!/bin/bash
set -e
echo Waiting for apt-get to finish...
a=1; while [ -n "$(pgrep apt-get)" ]; do echo $a; sleep 1s; a=$(expr $a + 1); done
echo Done.
APP_DIR=${1:-$HOME}
sudo apt-get install -y git
#sleep 30
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
#sleep 30
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
