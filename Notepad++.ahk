;; This script is used to start notepad++ or bring back an existing instance when pressing Win+S
;; Author: Andreas Bader
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk
#s:: {
IfWinNotExist, ahk_class Notepad++
{
    ;Run "C:\Program Files (x86)\Notepad++\notepad++.exe",,, process_id
    Run "C:\Program Files\Notepad++\notepad++.exe",,, process_id
    WaitActiveTop(process_id)
    MoveToMouse(process_id)
    WaitMaximize(process_id)
}
else 
{
    MoveToMouseClass("Notepad++")
    WaitActiveTopClass("Notepad++")
    WaitMaximizeClass("Notepad++") 
}
Return
}
