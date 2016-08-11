;; This script opens KeePass, opens the new entry dialog and automatically passes the title of the actual windows
;; Works with Firefox for example
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk
#n::
{
WinGetTitle, title, A
DetectHiddenWindows, On
WinActivate, database.kdbx - KeePass
WinWaitActive, database.kdbx - KeePass
WinRestore,  database.kdbx - KeePass
MoveToMouseTitle("database.kdbx - KeePass")
WinMaximize,  database.kdbx - KeePass
Send, {ctrl down}i{ctrl up}
WinWaitActive, Add Entry
IfWinActive, Add Entry
{
	ControlSetText, WindowsForms10.EDIT.app.0.141b42a_r8_ad14, %title%, Add Entry
}
return
}