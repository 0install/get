#!/bin/sh
set -e
VERSION=latest

download_0install() {
  echo "Downloading 0install..." >&2
  DOWNLOAD_DIR=$(mktemp --directory)
  trap cleanup EXIT
  curl --silent --location https://get.0install.net/0install-$(uname | tr '[:upper:]' '[:lower:]')-$(uname -m)-$VERSION.tar.bz2 | tar xj --strip-components=1 --directory=$DOWNLOAD_DIR
}

cleanup() {
  rm -rf $DOWNLOAD_DIR
}

if [ "$#" -eq 0 ]; then
  echo "This script downloads and runs 0install."
  echo ""
  echo "To install to /usr/local:"
  echo "./0install.sh install local"
  echo ""
  echo "To install to your home directory:"
  echo "./0install.sh install home"
  echo ""
  echo "To run 0install commands without installing 0install itself:"
  echo "./0install.sh --help"
  echo "./0install.sh COMMAND [OPTIONS]"
  exit 1
fi

if [ "$1" = "install" ]; then
  download_0install
  shift 1
  $DOWNLOAD_DIR/install.sh "$@"
else
  if command -v 0install > /dev/null 2> /dev/null; then
    0install "$@"
  else
    download_0install
    $DOWNLOAD_DIR/files/0install "$@"
  fi
fi
