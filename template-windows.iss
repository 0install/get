;Automatic dependency download and installation
#include "innosetup_scripts\products.iss"
#include "innosetup_scripts\products\zeroinstall.iss"

[CustomMessages]
en.integrate_0install=Integrating application using Zero Install...
de.integrate_0install=Integriere Anwendung mit Zero Install...

;Used by downloader
appname={code:GetAppParam|Name}

[Setup]
PrivilegesRequired=lowest
OutputBaseFilename=template-windows
OutputDir=.
UsePreviousLanguage=no
AppName={code:GetAppParam|Name}
DefaultDirName={userappdata}
Uninstallable=no

ShowLanguageDialog=auto
MinVersion=0,5.0
AppVerName={code:GetAppParam|Name}
DisableDirPage=true
DisableProgramGroupPage=true
Compression=lzma/ultra
SolidCompression=true

[Languages]
Name: en; MessagesFile: compiler:Default.isl
Name: de; MessagesFile: compiler:Languages\German.isl

[Files]
Source: AppParams.ini; Flags: dontcopy nocompression dontverifychecksum

[Run]
Filename: {code:GetZeroInstallLocation}\0install-win.exe; Parameters: "integrate {code:GetAppParam|Uri}"; StatusMsg: "{cm:integrate_0install}"; Flags: runasoriginaluser
Filename: {code:GetZeroInstallLocation}\0install-win.exe; Parameters: "run {code:GetAppParam|Uri}"; Description: {cm:LaunchProgram,{code:GetAppParam|Name}}; Flags: nowait postinstall runasoriginaluser skipifsilent

[Code]
function GetAppParam(Param: String): String;
begin
  ExtractTemporaryFile('AppParams.ini');
  Result := GetIniString('App', Param, '', ExpandConstant('{tmp}\AppParams.ini'));
end;

function InitializeSetup(): Boolean;
begin
	// Add all required products to the list
	zeroinstall();

	Result := true;
end;
