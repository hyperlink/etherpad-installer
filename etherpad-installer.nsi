; Requires nsisFirewall plugin: http://wiz0u.free.fr/prog/nsisFirewall/

Name "Etherpad Lite"
OutFile "etherpad-setup.exe"
InstallDir "$PROGRAMFILES\Etherpad Foundation"

RequestExecutionLevel admin

Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

Section ""
	SetOutPath $INSTDIR
	WriteUninstaller "uninstall.exe"
	File /r etherpad-lite-win
	SetOutPath "$INSTDIR\etherpad-lite-win"
	
	CreateShortCut "$DESKTOP\Start Etherpad.lnk" "$INSTDIR\etherpad-lite-win\start.bat" "" $INSTDIR\etherpad-lite-win\static\favicon.ico"

	CreateShortCut "$DESKTOP\Stop Etherpad.lnk" "$INSTDIR\etherpad-lite-win\stop.cmd" "" $INSTDIR\etherpad-lite-win\static\favicon.ico"

	nsisFirewall::AddAuthorizedApplication "$INSTDIR\etherpad-lite-win\bin\node.exe" "Etherpad Lite"
SectionEnd

Section "Uninstall"
  ; Remove files and uninstaller
  Delete $INSTDIR\etherpad-lite-win\*.*
  Delete $INSTDIR\*.*

  ; Remove shortcuts, if any
  Delete "$DESKTOP\Start Etherpad Lite.lnk"

  ; Remove directories used
  RMDir "$SMPROGRAMS\etherpad-lite-win"
  RMDir "$INSTDIR"

  nsisFirewall::RemoveAuthorizedApplication "$INSTDIR\etherpad-lite-win\bin\node.exe"
SectionEnd