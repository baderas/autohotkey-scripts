;; This script is used to execute all .ahk (autohotkey scripts) files of a folder without itself
;; (also ignores WindowPlacementFunctions.ahk and Fling2.ahk)
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

Folder = C:\Users\%USERNAME%\autohotkey-scripts

Master = Autorun_ahk.ahk
Ingore1 = WindowPlacementFunctions.ahk
Ingore2 = Fling2.ahk

Loop %Folder%\*.ahk
{
    if (A_LoopFileName != Master && A_LoopFileName != Ingore1 && A_LoopFileName != Ingore2 )
    {
        Run  %Folder%\%A_LoopFileName%
    }
}

ExitApp