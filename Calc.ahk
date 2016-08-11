;; This script opens windows calculator with Win+^
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk
#^:: 
{
Run calc.exe,,, process_id
}
return