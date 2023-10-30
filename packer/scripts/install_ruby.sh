#!/bin/bash
# This is a script to install Ruby Programming Language

apt-get update -y

# fix a locale setting warning from Perl
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sleep 20
apt-get install -y ruby-full ruby-bundler build-essential

#sudo apt update -y > ~/install_Ruby.log
#sudo apt install -y ruby-full ruby-bundler build-essential >> ~/install_Ruby.log
#err_count=cat ~/install_Ruby.log | grep "error" | wc
#warn_count=cat /install_Ruby.log | grep "warning" | wc
#echo "There are $err_count errors: "
#cat ~/install_Ruby.log | grep "error" 
#echo "There are $warn_count warnings: "
#cat ~/install_Ruby.log | grep "warning"
