;; This script enables Win+K hotkey for opening KeepNote
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk
#k:: {
Run "C:\Program Files (x86)\KeepNote\keepnote.exe",,, process_id
WaitActiveTop(process_id)
MoveToMouse(process_id)
Return
}
