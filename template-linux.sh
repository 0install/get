#!/bin/bash

# Constants
APP_NAME="--------------------AppName--------------------"
APP_URI="----------------------------------------AppUri----------------------------------------"

if command -v 0install > /dev/null; then
  read -p "This will install $APP_NAME using Zero Install. Press ENTER to continue."
elif command -v emerge > /dev/null; then
  read -p "This will first install Zero Install using emerge and then install $APP_NAME using Zero Install. Press ENTER to continue."
  emerge zeroinstall-injector
elif command -v apt-get > /dev/null; then
  read -p "This will first install Zero Install using apt-get and then install $APP_NAME using Zero Install. Press ENTER to continue."
  apt-get install zeroinstall-injector
elif command -v yast > /dev/null; then
  read -p "This will first install Zero Install using yast and then install $APP_NAME using Zero Install. Press ENTER to continue."
  yast -i zeroinstall-injector
elif command -v urpmi > /dev/null; then
  read -p "This will first install Zero Install using urpmi and then install $APP_NAME using Zero Install. Press ENTER to continue."
  urpmi zeroinstall-injector
elif command -v yum > /dev/null; then
  read -p "This will first install Zero Install using yum and then install $APP_NAME using Zero Install. Press ENTER to continue."
  yum install zeroinstall-injector
else
  echo "Zero Install is not installed on this system. Please visit http://0install.net/install-linux.html for instructions."
  exit 1
fi

if [ -n "$DISPLAY" ]; then
  0desktop $APP_URI
else
  0install add $APP_NAME $APP_URI
  echo "Created command-line alias '$APP_NAME'. Can be removed with '0install destroy $APP_NAME'."
fi
