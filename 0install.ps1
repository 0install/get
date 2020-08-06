$ErrorActionPreference = "Stop"

if ($args.Count -eq 0) {
    echo "This script runs 0install from your PATH or downloads it on-demand."
    echo ""
    echo "To run 0install commands without adding 0install to your PATH:"
    echo ".\0install.ps1 COMMAND [OPTIONS]"
    echo ""
    echo "To deploy 0install to your user profile:"
    echo ".\0install.ps1 self deploy"
    echo ""
    echo "To deploy 0install to your machine:"
    echo ".\0install.ps1 self deploy --machine"
    exit 1
}

function download {
    $downloadDir = "$env:LOCALAPPDATA\0install.net\bootstrapper"
    if (!(Test-Path "$downloadDir\0install.exe")) {
        mkdir -Force $downloadDir | Out-Null
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls11,Tls12'
        Invoke-WebRequest "https://get.0install.net/0install.exe" -OutFile "$downloadDir\0install.exe"
    }
    return $downloadDir
}

if (Get-Command 0install -ErrorAction SilentlyContinue) {
    0install @args
} else {
    . "$(download)\0install.exe" @args
}
