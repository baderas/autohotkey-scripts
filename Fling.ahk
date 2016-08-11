;; Fling defines hotkeys for fling2, so that Fling2.ahk can be imported via WindowPlacementFunctions.ahk
;; See Fling2.ahk for more details

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk

#<::          Win__Fling2(1, "A", 0, 0)
#Right::      Win__Fling2(1, "A", 1, 0)
#Left::       Win__Fling2(-1, "A", 1, 0)
#Numpad1::    Win__Fling2(1, "A", 0, 1)
#Numpad2::    Win__Fling2(1, "A", 0, 2)
#Numpad3::    Win__Fling2(1, "A", 0, 3)
#Numpad4::    Win__Fling2(1, "A", 1, 1)
#Numpad5::    Win__Fling2(1, "A", 1, 3)