;; Some often needed functions

;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\Fling2.ahk

MoveToMouse(pid) {
    WinGet, WinOriginalMinMaxState, MinMax, ahk_pid %pid%
    if (WinOriginalMinMaxState = 1)
	{
        ; fixes problems
		WinRestore, ahk_pid %pid%
	}
	WinGetPos, xtemp, ytemp,,,ahk_pid %pid%
	MouseGetPos, X, Y 
	xpos:=X+xtemp
	ypos:=Y+ytemp
	WinMove, ahk_pid %pid%, , %xpos%, %ypos%  ; move window to mouse 
    if (WinOriginalMinMaxState = 1)
	{
		WinMaximize, ahk_pid %pid%
	}
	return
}

MoveToMouseId(id) {
    WinGet, WinOriginalMinMaxState, MinMax, ahk_id %id%
    if (WinOriginalMinMaxState = 1)
	{
        ; fixes problems
		WinRestore, ahk_id %id%
	}
	WinGetPos, xtemp, ytemp,,,ahk_id %id%
	MouseGetPos, X, Y 
	xpos:=X+xtemp
	ypos:=Y+ytemp
	WinMove, ahk_id %id%, , %xpos%, %ypos%  ; move window to mouse 
    if (WinOriginalMinMaxState = 1)
	{
		WinMaximize, ahk_id %id%
	}
	return
}

MoveToMouseTitle(title) {
    WinGet, WinOriginalMinMaxState, MinMax,%title%
    if (WinOriginalMinMaxState = 1)
	{
        ; fixes problems
		WinRestore,%title%
	}
	WinGetPos, xtemp, ytemp,,,%title%
	MouseGetPos, X, Y 
	xpos:=X+xtemp
	ypos:=Y+ytemp
	WinMove, %title%, , %xpos%, %ypos%  ; move window to mouse 
    if (WinOriginalMinMaxState = 1)
	{
		WinMaximize,%title%
	}
	return
}

MoveToMouseClass(classname) {
    WinGet, WinOriginalMinMaxState, MinMax, ahk_class %classname%
    if (WinOriginalMinMaxState = 1)
	{
        ; fixes problems
		WinRestore, ahk_class %classname%
	}
	WinGetPos, xtemp, ytemp,,, ahk_class %classname%
	MouseGetPos, X, Y 
	xpos:=X+xtemp
	ypos:=Y+ytemp
	WinMove, ahk_class %classname%, , %xpos%, %ypos%  ; move window to mouse 
    if (WinOriginalMinMaxState = 1)
	{
		WinMaximize, ahk_class %classname%
	}
	return
}

WaitActiveTop(pid) {
	WinWait, ahk_pid %pid%
	WinActivate, ahk_pid %pid%
	WinSet, Top,, ahk_pid %pid%
	return
}

WaitActiveTopId(id) {
	WinWait, ahk_id %id%
	WinActivate, ahk_id %id%
	WinSet, Top,, ahk_id %id%
	return
}

WaitActiveTopTitle(title) {
	WinWait, %title%
	WinActivate, %title%
	WinSet, Top,, %title%
	return
}

WaitActiveTopClass(classname) {
	WinWait, ahk_class %classname%
	WinActivate, ahk_class %classname%
	WinSet, Top,, ahk_class %classname%
	return
}

WaitMaximizeTitle(title) {
	WinWait, %title%
	WinMaximize, %title%
	return
}

WaitMaximize(pid) {
	WinWait, ahk_pid %pid%
	WinMaximize, ahk_pid %pid%
	return
}

WaitMaximizeClass(classname) {
	WinWait, ahk_class %classname%
	WinMaximize, ahk_class %classname%
	return
}

WaitMaximizeExe(exe) {
	WinWait, ahk_exe %exe%
	WinMaximize, ahk_exe %exe%
	return
}

WaitMinimizeTitle(title) {
	WinWait,  %title%
	WinMaximize,  %title%
	return
}

ExplorerSpecial() {
	Process, Exist, Explorer.exe
	;PID1 := errorlevel
	ID1 := WinExist("A")
	Run, Explorer.exe %HOMEPATH%
	Loop {
		Sleep 10
		;WinGet, PID2, PID, A
		ID2 := WinExist("A")
		; If using Explorer.exe without argument like C:\, you need to compare also PID1 and PID2 like
		; If ( PID2 = PID1 AND ID2 <> ID1 ) 
		If (ID2 and ID2 <> ID1 )
			Break
	}
	WaitActiveTopId(ID2)
	;MoveToMouseId(ID2)
	Win__Fling2(1, "A", 0, 1)
}
