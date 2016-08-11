;; This script is used to maximize windows after boot/log-in
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk
Sleep, 1000
WaitMaximizeExe("thunderbird.exe")
WaitMaximizeExe("firefox.exe")