function is(os) {
    return navigator.userAgent.search(os) >= 0;
}

function detectOS() {
    if (is('Debian') || is('Ubuntu')) { return 'linux-debian'; }
    if (is('Fedora')) { return 'linux-fedora'; }
    if (is('Red Hat')) { return 'linux-redhat'; }
    if (is('SUSE')) { return 'linux-suse'; }
    if (is('Arch')) { return 'linux-arch'; }
    if (is('Linux')) { return 'linux-generic'; }
    if (is('OS X')) { return 'mac'; }    
    if (is('Windows')) { return 'windows'; }
    return null;
}

function hideTabs() {
    $('.nav-tabs a.nav-link').removeClass('active');
    $('.tab-body').hide();
}

function showTab(name) {
    $('.nav-tabs a.nav-link[href="#' + name + '"]').addClass('active');
    $('#' + name + '-tab').show();
}

function updateTabs() {
    hideTabs();

    if (window.location.hash) {
        tabName = window.location.hash.slice(1);
        if (tabName == 'linux') { tabName = 'linux-generic'; }
    } else {
        tabName = detectOS();
        if (tabName == null) return;
    }
    history.replaceState({}, '', '#' + tabName);

    showTab(tabName.split('-')[0]);
    showTab(tabName);
}

function copy(id) {
    $('#' + id).select();
    document.execCommand('copy');
}

$(window).bind('hashchange', updateTabs);
$(function() {
    updateTabs();
    if (is('Windows NT 6.2') || is('Windows NT 6.3') || is('Windows NT 10.0')) {
        $('#windows-legacy').hide();
    }
});