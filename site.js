function is(os) {
    return navigator.userAgent.indexOf(os) >= 0;
}

function detectOS() {
    if (is('Debian') || is('Ubuntu')) { return 'linux-ubuntu'; }
    if (is('Fedora')) { return 'linux-fedora'; }
    if (is('Red Hat')) { return 'linux-redhat'; }
    if (is('SUSE')) { return 'linux-suse'; }
    if (is('Arch')) { return 'linux-arch'; }
    if (is('Linux')) { return 'linux-generic'; }
    if (is('OS X')) { return 'mac-homebrew'; }
    if (is('Windows')) { return 'windows'; }
    return null;
}

// Runs before the tabs from https://0install.net/js/site.js initialize, which then pick up the hash
if (!window.location.hash) {
    var os = detectOS();
    if (os) { history.replaceState(null, '', '#' + os); }
}

if (is('Windows NT 6.2') || is('Windows NT 6.3') || is('Windows NT 10.0')) {
    document.getElementById('windows-tls-notice').hidden = true;
}
if (is('Windows NT 10.0')) {
    document.getElementById('windows-netframework-notice').hidden = true;
}
