#!/bin/sh
set -e

if [ "$#" -eq 0 ]; then
    echo "This script runs 0install from your PATH or downloads it on-demand."
    echo ""
    echo "To run 0install commands without adding 0install to your PATH:"
    echo "./0install.sh --help"
    echo "./0install.sh COMMAND [OPTIONS]"
    echo ""
    echo "To install to /usr/local:"
    echo "sudo ./0install.sh install local"
    echo ""
    echo "To install to your home directory:"
    echo "./0install.sh install home"
    exit 1
fi

download_zeroinstall() {
    zeroinstall_release="0install-$(uname | tr '[:upper:]' '[:lower:]')-$(uname -m)-${ZEROINSTALL_VERSION:-latest}"
    dir="$HOME/.cache/0install.net/$zeroinstall_release"

    if [ ! -f "$dir/files/0install" ]; then
        echo "Downloading 0install..." >&2
        rm -rf "$dir"
        mkdir -p "$dir"
        curl -fSL https://get.0install.net/$zeroinstall_release.tar.bz2 | tar xj --strip-components 1 --directory "$dir"
    fi

    echo "$dir"
}

run_zeroinstall() {
    if command -v 0install >/dev/null 2>&1; then
        0install "$@"
    else
        "$(download_zeroinstall)/files/0install" "$@"
    fi
}

if [ "$1" = "install" ]; then
    shift 1
    "$(download_zeroinstall)/install.sh" "$@"
else
    run_zeroinstall "$@"
fi
