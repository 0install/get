[CustomMessages]
zeroinstall_title=Zero Install
zeroinstall_size=5 MB

[Code]
function GetZeroInstallLocation(Param: String): String;
var
	installLocationLocalMachine: string;
	installLocationCurrentUser: string;
begin
	RegQueryStringValue(HKLM, 'Software\Zero Install', 'InstallLocation', installLocationLocalMachine);
	RegQueryStringValue(HKCU, 'Software\Zero Install', 'InstallLocation', installLocationCurrentUser);
	if (FileExists(installLocationLocalMachine + '\0install-win.exe')) then
		Result := installLocationLocalMachine;
	if (FileExists(installLocationCurrentUser + '\0install-win.exe')) then
		Result := installLocationCurrentUser;
end;

const
	zeroinstall_url = 'http://0install.de/files/zero-install-per-user.exe';

procedure zeroinstall();
begin
	if (GetZeroInstallLocation('') = '') then
		AddProduct('zero-install-per-user.exe', '/silent /norestart',
			CustomMessage('zeroinstall_title'),
			CustomMessage('zeroinstall_size'),
			zeroinstall_url);
end;
