;; This script opens ConEmu with Win+T
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk
#t::
{
Run "C:\Program Files\ConEmu\ConEmu64.exe",,, process_id
WaitActiveTop(process_id)
;MoveToMouse(process_id)
WinGet, wid, ID, ahk_pid %process_id%
Win__Fling2(1, wid, 0, 3)
Return
}