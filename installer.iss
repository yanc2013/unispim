; Installer Settings for Inno Setup
; (Release Version)

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{299CEEFB-1F96-4C09-870B-01E4B3C2AC75}
AppName=Unispim PinYin input
AppVerName=Unispim PinYin 0.0
AppPublisher=yanc2013
AppPublisherURL=https://github.com/yanc2013/unispim
AppSupportURL=https://github.com/yanc2013/unispim
AppUpdatesURL=https://github.com/yanc2013/unispim
DefaultDirName={pf}\Unispim
DefaultGroupName=Unispim PinYin input (Simplified Chinese)
OutputDir=.
OutputBaseFilename=Unispim-0.0-setup
Compression=lzma
SolidCompression=yes
VersionInfoVersion=0.0
VersionInfoTextVersion=0.0
AlwaysRestart=yes

[Files]
Source: "README.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\Release\unispim6.ime"; DestDir: "{sys}"; Flags: ignoreversion
Source: "build\Release\ime_setup.exe"; DestDir: "{app}"; Flags: ignoreversion

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\README.txt"; Filename: "{app}\README.txt"
Name: "{group}\LICENSE.txt"; Filename: "{app}\LICENSE.txt"
Name: "{group}\Uninstall Unispim"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\ime_setup.exe"; Parameters: "/i unispim6.ime"

[UninstallRun]
Filename: "{app}\ime_setup.exe"; Parameters: "/u unispim6.ime"
