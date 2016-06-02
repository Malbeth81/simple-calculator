!include "MUI.nsh"

;--------------------------------
; Variables

  !define Product "SimpleCalculator"
  !define Version "1.3.0"

;--------------------------------
; Configuration

  Name "${Product} ${Version}"
  OutFile "..\SCalcSetup.exe"
  InstallDir "$PROGRAMFILES\${Product}"
  InstallDirRegKey HKLM "Software\${Product}" "Install Dir"
  
;--------------------------------
; Modern UI Configuration

  !define MUI_ICON "install.ico"
  !define MUI_UNICON "uninstall.ico"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "install.bmp"
  !define MUI_HEADERIMAGE_UNBITMAP "uninstall.bmp"
  !define MUI_HEADERIMAGE_RIGHT
  !define MUI_WELCOMEFINISHPAGE_BITMAP "welcome.bmp"
  !define MUI_ABORTWARNING
  !define MUI_WELCOMEPAGE_TITLE_3LINES

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES

  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
; Languages

;  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "French"

;  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
; Data

  LicenseData "License.txt"

;--------------------------------
; Begin Section

Section "SimpleCalculator" SecSC
  ;Add files
  SetOutPath "$INSTDIR"
  SetOverWrite On
  File "Changes.txt"
  File "License.txt"
  File "SimpleCalc.exe"
  SetOverWrite Off

  ;Create start-menu items
  CreateDirectory "$SMPROGRAMS\${Product}"
  CreateShortCut "$SMPROGRAMS\${Product}\SimpleCalculator.lnk" "$INSTDIR\SimpleCalc.exe" "" "$INSTDIR\SimpleCalc.exe" 0
;  StrCmp $LANGUAGE ${LANG_ENGLISH} 0 +2
;    CreateShortCut "$SMPROGRAMS\${Product}\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0
;  StrCmp $LANGUAGE ${LANG_FRENCH} 0 +2
    CreateShortCut "$SMPROGRAMS\${Product}\Désinstaller.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0

  ; Write installation information to the registry
  WriteRegStr HKLM "Software\${Product}" "Install Dir" "$INSTDIR"
  WriteRegDWORD HKLM "Software\${Product}" "Install Language" $LANGUAGE

  ;Write uninstall information to the registry
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${Product}" "DisplayIcon" "$INSTDIR\SimpleCalc.exe,0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${Product}" "DisplayName" "${Product}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${Product}" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${Product}" "ModifyPath" "$INSTDIR"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${Product}" "NoModify" 1

  ; Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

;--------------------------------
;Installer Functions
;Function .onInit
;  !insertmacro MUI_LANGDLL_DISPLAY
;FunctionEnd

;--------------------------------
; Uninstaller Section
Section "Uninstall"

  ;Delete Files And Directory
  Delete "$INSTDIR\*.*"
  RmDir "$INSTDIR"

  ;Delete Shortcuts
  Delete "$SMPROGRAMS\${Product}\*.*"
  RmDir  "$SMPROGRAMS\${Product}"

  ;Delete Uninstaller And Unistall Registry Entries
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\${Product}"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${Product}"
SectionEnd

;--------------------------------
;Uninstaller Functions

;Function un.onInit
;  !insertmacro MUI_UNGETLANGUAGE
;FunctionEnd
