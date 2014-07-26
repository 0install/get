#!/bin/sh

APP_NAME = "--------------------AppName--------------------"
APP_URI = "----------------------------------------AppUri----------------------------------------"

echo "This will first install Zero Install using your native package manager and then install $APP_NAME"
pause

if command pacman > /dev/null; then
  pacman -S zeroinstall-injector
elif command emerge > /dev/null; then
  emerge zeroinstall-injector
elif command apt-get > /dev/null; then
  apt-get install zeroinstall-injector
elif command yast > /dev/null; then
  yast -i zeroinstall-injector
elif command urpmi > /dev/null; then
  urpmi zeroinstall-injector
elif command yum > /dev/null; then
  yum install zeroinstall-injector
fi

0desktop $APP_URI
