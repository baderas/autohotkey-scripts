;; This script replaces tradiitonal Win+E, Win+E now moves the explorer window to the screen where the mouse coursor actually is
;; and flings the windows to a column
;; Explorer needs special handling - first start after boot with win+e still buggy sometimes
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk
#e:: 
{
ExplorerSpecial()
}
return