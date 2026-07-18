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

function updateTabs() {
    hideTabs();

    var tabName;
    if (window.location.hash) {
        tabName = window.location.hash.slice(1);
        if (tabName == 'linux') { tabName = 'linux-generic'; }
        if (tabName == 'mac') { tabName = 'mac-homebrew'; }
    } else {
        tabName = detectOS();
        if (tabName == null) return;
    }
    history.replaceState({}, '', '#' + tabName);

    showTab(tabName.split('-')[0]);
    showTab(tabName);
}

addEventListener('hashchange', updateTabs);
updateTabs();

if (is('Windows NT 6.2') || is('Windows NT 6.3') || is('Windows NT 10.0')) {
    document.getElementById('windows-tls-notice').hidden = true;
}
if (is('Windows NT 10.0')) {
    document.getElementById('windows-netframework-notice').hidden = true;
}
