[CustomMessages]
zeroinstall_title=Zero Install
zeroinstall_size=5 MB

[Code]	
const
	zeroinstall_url = 'http://0install.de/files/zero-install-per-user.exe';

procedure zeroinstall();
var
	installLocationCurrentUser: string;
	installLocationLocalMachine: string;
begin
	RegQueryStringValue(HKCU, 'Software\Zero Install', 'InstallLocation', installLocationCurrentUser);
	RegQueryStringValue(HKLM, 'Software\Zero Install', 'InstallLocation', installLocationLocalMachine);
	if (not FileExists(installLocationCurrentUser + '\0install-win.exe') and not FileExists(installLocationLocalMachine + '\0install-win.exe')) then
		AddProduct('zero-install-per-user.exe', '/silent /norestart',
			CustomMessage('zeroinstall_title'),
			CustomMessage('zeroinstall_size'),
			zeroinstall_url);
end;
