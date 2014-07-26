#!/bin/bash

# Constants
APP_NAME="--------------------AppName--------------------"
APP_URI="----------------------------------------AppUri----------------------------------------"

if command -v 0install > /dev/null; then
  read -p "This will install $APP_NAME using Zero Install."
elif command -v emerge > /dev/null; then
  read -p "This will first install Zero Install using emerge and then install $APP_NAME using Zero Install."
  emerge zeroinstall-injector
elif command -v apt-get > /dev/null; then
  read -p "This will first install Zero Install using apt-get and then install $APP_NAME using Zero Install."
  apt-get install zeroinstall-injector
elif command -v yast > /dev/null; then
  read -p "This will first install Zero Install using yast and then install $APP_NAME using Zero Install."
  yast -i zeroinstall-injector
elif command -v urpmi > /dev/null; then
  read -p "This will first install Zero Install using urpmi and then install $APP_NAME using Zero Install."
  urpmi zeroinstall-injector
elif command -v yum > /dev/null; then
  read -p "This will first install Zero Install using yum and then install $APP_NAME using Zero Install."
  yum install zeroinstall-injector
else
  echo "Zero Install is not installed on this system. Please visit http://0install.net/install-linux.html for instructions."
  exit
fi

0desktop $APP_URI
