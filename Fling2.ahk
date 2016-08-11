;; Fling2 replaced Win+Left and Win+Right by using thirds and halfs instead of only halfs in a monitor setup with a ultra wide monitor 
;; It uses thirds on a ultra wide monitor (e.g. LG 34UC98-W) and halfs on standard 16:9/16:10 monitors
;; It also supports doubleColumns when using thirds, so that one windows can use 2/3 of the screen and another 1/3440x1440
;; -----------------------------------------------------------------------
;; Fling2 is based on Fling from Patrick Sheppard (2010)
;; Thank you very much for your great work!
;; Fling Source: https://autohotkey.com/board/topic/51956-flinging-windows-across-a-multi-monitor-system/
;; -----------------------------------------------------------------------
;; Fling (or shift) a window between columns and monitors in a multi-monitor system, using thirds on ultra wide monitors and halfs on wide screen monitors.
;;
;; Function Parameters:
;;
;;      FlingDirection      The direction of the fling, expected to be either +1 or -1.
;;                          The function is not limited to just two monitors; it supports
;;                          as many monitors as are currently connected to the system and
;;                          can fling a window serially through each of them in turn.
;;
;;      WinID               The window ID of the window to move. There are two special WinID
;;                          values supported:
;;
;;                          1) The value "A" means to use the Active window (default).
;;                          2) The value "M" means to use the window currently under the Mouse.
;;
;;      DoubleColumns      Can be either 1 or 0. 1 means that on a ultra wide monitor, where thirds are used, 
;;                         two coulmn steps are used so that a window can take 2/3 of the screen.
;;
;;      Column             Can be 0 or more. When 0, Fling3 flings window as expected, when giving a column > 0,
;;                         the window is flinged to this position ignoring the Direction setting
;;                         When DoubleCoumn = 1 is used, the column is extended to the right, the last column is extended to the left
;;                         (e.g. column 1 is then a double column over 1 and 2)
;;
;; Minimized windows are not modified; they are left exactly where they were.
;;
;; The return value of the function is non-zero if the window was successfully flung.
;;
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk

Win__Fling2(FlingDirection = 1, WinID = "A", DoubleColumns = 0, Column = 0)
{
    HeightCompensationFactor := 10 ;pixels
    WidthCompensationFactor := 20 ;pixels
    WidthCompensationFactor2 := Round(WidthCompensationFactor/2) ;pixels, other direction

    ; Figure out which window to move based on the "WinID" function parameter:
    ;   1) The letter "A" means to use the Active window
    ;   2) The letter "M" means to use the window under the Mouse
    ; Otherwise, the parameter value is assumed to be the AHK window ID of the window to use.

    if (WinID = "A")
    {
        ; If the user supplied an "A" as the window ID, we use the Active window
        WinID := WinExist("A")
    }
    else if (WinID = "M")
    {
        ; If the user supplied an "M" as the window ID, we use the window currently under the Mouse
        MouseGetPos, MouseX, MouseY, WinID      ; MouseX & MouseY are retrieved but, for now, not used
    }

    ; Check to make sure we are working with a valid window
    IfWinNotExist, ahk_id %WinID%
    {
        return 0
    }

    ; Here's where we find out just how many monitors we're dealing with
    SysGet, MonitorCount, MonitorCount

    ; For each active monitor, we get Top, Bottom, Left, Right of the monitor's
    ;  'Work Area' (i.e., excluding taskbar, etc.). From these values we compute Width and Height.
    ;  Results get put into variables named like "Monitor1Top" and "Monitor2Width", etc.,
    ;  with the monitor number embedded in the middle of the variable name.
    ; Also calculate how many positions are available on each monitor
    ; for this the width is dived by the height and round up to the next integer
    ; this gives 2 positions for a 16:9 Monitor (2560x1440 -> DPI corrected to 200% -> 1280x690 )
    ; and 3 positions for a ultra wide monitor (3440x1440)

    Loop, %MonitorCount%
    {
        SysGet, Monitor%A_Index%, MonitorWorkArea, %A_Index%
        Monitor%A_Index%Width  := Monitor%A_Index%Right  - Monitor%A_Index%Left
        Monitor%A_Index%Height := Monitor%A_Index%Bottom - Monitor%A_Index%Top
        Monitor%A_Index%Positions := Ceil(Monitor%A_Index%Width /  Monitor%A_Index%Height)
        Monitor%A_Index%PositionSize := (Monitor%A_Index%Width / Monitor%A_Index%Positions)
    }
   
    ; Retrieve the target window's original minimized / maximized state
    WinGet, WinOriginalMinMaxState, MinMax, ahk_id %WinID%
    ;WinGetClass, WinClass, ahk_id %WinID%

    ; We don't do anything with minimized windows (for now... this may change)
    if (WinOriginalMinMaxState = -1)
    {
        ; Debatable as to whether or not this should be flagged as an error
        return 0
    }
    
    ; If the window started out maximized, then the plan is to:
    ;   (a) restore it,
    ;   (b) fling it, then
    ;   (c) re-maximize it on the target monitor.
    ;
    ; The reason for this is so that the usual maximize / restore windows controls
    ; work as you'd expect. You want Windows to use the dimensions of the non-maximized
    ; window when you click the little restore icon on a previously flung (maximized) window.
    
    if (WinOriginalMinMaxState = 1)
    {
        ; Restore a maximized window to its previous state / size ... before "flinging".
        ;
        ; Programming Note: It would be nice to hide the window before doing this ... 
        ; the window does some visual calisthenics that the user may construe as a bug.
        ; Unfortunately, if you hide a window then you can no longer work with it. <Sigh>

        WinRestore, ahk_id %WinID%
    }

    ; Retrieve the target window's original (non-maximized) dimensions
    WinGetPos, WinX, WinY, WinW, WinH, ahk_id %WinID%

    ; Find the point at the centre of the target window then use it
    ; to determine the monitor to which the target window belongs
    ; (windows don't have to be entirely contained inside any one monitor's area).
    ; Determine in which Position it is on current monitor
    
    WinCentreX := WinX + WinW / 2
    WinCentreY := WinY + WinH / 2

    CurrMonitor = 0
    Loop, %MonitorCount%
    {
        if (    (WinCentreX >= Monitor%A_Index%Left) and (WinCentreX < Monitor%A_Index%Right )
            and (WinCentreY >= Monitor%A_Index%Top ) and (WinCentreY < Monitor%A_Index%Bottom))
        {
            CurrMonitor = %A_Index%
            ; using WinX does not work good enough here.
            CurrPos := Ceil((WinCentreX-Monitor%A_Index%Left) / Monitor%A_Index%PositionSize)
            
            ; if it is left from the centre
            ; due to rounding we need 0.1% margin
            if (FlingDirection == 1)
            {
                if ((WinCentreX-Monitor%A_Index%Left)*1.001 < ((Monitor%A_Index%PositionSize*(CurrPos-1)) + 0.5*Monitor%A_Index%PositionSize))
                {
                   CurrPos := CurrPos-1         
                }
            }
            else 
            {
                if ((WinCentreX-Monitor%A_Index%Left)*1.001 > ((Monitor%A_Index%PositionSize*(CurrPos-1)) + 0.5*Monitor%A_Index%PositionSize))
                {
                   CurrPos := CurrPos+1         
                }
            }
            break
        }
    }
    
    HeightCompensationFactor := (Monitor%CurrMonitor%Height//100)-(Mod(Monitor%CurrMonitor%Height//100,5))
    ;WidthCompensationFactor := (Monitor%CurrMonitor%Width//100)-(Mod(Monitor%CurrMonitor%Width//100,5))
    ;WidthCompensationFactor2 := (WidthCompensationFactor/2)
    WidthCompensationFactor := 20
    WidthCompensationFactor2 := Round(WidthCompensationFactor/2)
    ; If a columnt is set, ignore the rest.
    if (Column > 0)
    {
        if (Column > Monitor%CurrMonitor%Positions)
        {
            Column := Monitor%CurrMonitor%Positions
        }
        if (DoubleColumns == 1 and Monitor%CurrMonitor%Positions > 2)
        {
            if (Column == Monitor%CurrMonitor%Positions)
            {
                Column := Monitor%CurrMonitor%Positions - 1
            }
            ; Only change positions on the same Monitor
            WinFlingX := Monitor%CurrMonitor%Left + ((Monitor%CurrMonitor%PositionSize*(Column-1))) - WidthCompensationFactor2
            WinFlingY := Monitor%CurrMonitor%Top
            WinFlingW := (Monitor%CurrMonitor%PositionSize*2) + WidthCompensationFactor
            WinFlingH := Monitor%CurrMonitor%Height + HeightCompensationFactor

        }
        else
        {
            ; Only change positions on the same Monitor
            WinFlingX := Monitor%CurrMonitor%Left+((Monitor%CurrMonitor%PositionSize*(Column-1))) - WidthCompensationFactor2
            WinFlingY := Monitor%CurrMonitor%Top
            WinFlingW := Monitor%CurrMonitor%PositionSize + WidthCompensationFactor
            WinFlingH := Monitor%CurrMonitor%Height + HeightCompensationFactor
        }
    }
    else 
    {
        ; Compute the next Position
        ; coordinates are not exact, +-HeightCompensationFactor and +-WidthCompensationFactor and +-WidthCompensationFactor2 are found by manual testing
        if (FlingDirection == 1) 
        {
            if (CurrPos < Monitor%CurrMonitor%Positions)
            {
                ; Check if double columns are activated and move window accordingly
                if (DoubleColumns == 1 and Monitor%CurrMonitor%Positions > 2)
                {
                    if (WinW > (Monitor%CurrMonitor%PositionSize+30))
                    {
                        ; Only change positions on the same Monitor
                        WinFlingX := Monitor%CurrMonitor%Left + ((Monitor%CurrMonitor%PositionSize*(CurrPos))) - WidthCompensationFactor2
                        WinFlingY := Monitor%CurrMonitor%Top
                        WinFlingW := Monitor%CurrMonitor%PositionSize + WidthCompensationFactor
                        WinFlingH := Monitor%CurrMonitor%Height + HeightCompensationFactor
                    }
                    else 
                    {
                        ; Only change positions on the same Monitor
                        WinFlingX := Monitor%CurrMonitor%Left + ((Monitor%CurrMonitor%PositionSize*(CurrPos-1))) - WidthCompensationFactor2
                        WinFlingY := Monitor%CurrMonitor%Top
                        WinFlingW := (Monitor%CurrMonitor%PositionSize*2) + WidthCompensationFactor
                        WinFlingH := Monitor%CurrMonitor%Height + HeightCompensationFactor   
                    }
                }
                else
                {
                    ; Only change positions on the same Monitor
                    WinFlingX := Monitor%CurrMonitor%Left + ((Monitor%CurrMonitor%PositionSize*(CurrPos))) - WidthCompensationFactor2
                    WinFlingY := Monitor%CurrMonitor%Top
                    WinFlingW := Monitor%CurrMonitor%PositionSize + WidthCompensationFactor
                    WinFlingH := Monitor%CurrMonitor%Height + HeightCompensationFactor
                }
            }
            else
            {
                ; Change Monitor
                ; Compute the number of the next monitor in the direction of the specified fling (+1 or -1)
                ;  Valid monitor numbers are 1..MonitorCount, and we effect a circular fling.
                NextMonitor := CurrMonitor + FlingDirection
                if (NextMonitor > MonitorCount)
                {
                    NextMonitor = 1
                }
                else if (NextMonitor <= 0)
                {
                    NextMonitor = %MonitorCount%
                }
                HeightCompensationFactor := (Monitor%NextMonitor%Height//100)-(Mod(Monitor%NextMonitor%Height//100,5))
                ;WidthCompensationFactor := (Monitor%NextMonitor%Width//100)-(Mod(Monitor%NextMonitor%Width//100,5))
                ;WidthCompensationFactor2 := (WidthCompensationFactor/2)
                WidthCompensationFactor := 20
                WidthCompensationFactor2 := Round(WidthCompensationFactor/2)
                ; Scale the position / dimensions of the target window by the ratio of the monitor sizes.
                ; Programming Note: Do multiplies before divides in order to maintain accuracy in the integer calculation.
                WinFlingX := Monitor%NextMonitor%Left - WidthCompensationFactor2
                WinFlingY := Monitor%NextMonitor%Top
                WinFlingW := Monitor%NextMonitor%PositionSize + WidthCompensationFactor
                WinFlingH := Monitor%NextMonitor%Height + HeightCompensationFactor
                
            }
        }
        else
        {
            ; The next (quite complex) if is required to perform the step from the most left column to the next monitor without moving into a double column
            if (CurrPos > 2 or (CurrPos > 1 and DoubleColumns == 1 and Monitor%CurrMonitor%Positions > 2 and WinW > (Monitor%CurrMonitor%PositionSize + WidthCompensationFactor2 + WidthCompensationFactor)))
            {      
                ; check if double columns are activated and move window accordingly
                if (DoubleColumns == 1 and Monitor%CurrMonitor%Positions > 2)
                {
                    if (WinW > (Monitor%CurrMonitor%PositionSize+30))
                    {
                        ; Only change positions on the same Monitor
                        WinFlingX := Monitor%CurrMonitor%Left + ((Monitor%CurrMonitor%PositionSize*(CurrPos-2))) - WidthCompensationFactor2
                        WinFlingY := Monitor%CurrMonitor%Top
                        WinFlingW := Monitor%CurrMonitor%PositionSize + WidthCompensationFactor
                        WinFlingH := Monitor%CurrMonitor%Height + HeightCompensationFactor
                    }
                    else 
                    {
                        ; Only change positions on the same Monitor
                        WinFlingX := Monitor%CurrMonitor%Left + ((Monitor%CurrMonitor%PositionSize*(CurrPos-3))) - WidthCompensationFactor2
                        WinFlingY := Monitor%CurrMonitor%Top
                        WinFlingW := (Monitor%CurrMonitor%PositionSize*2) + WidthCompensationFactor
                        WinFlingH := Monitor%CurrMonitor%Height + HeightCompensationFactor   
                    }
                }
                else
                {
                    ; Only change positions on the same Monitor
                    WinFlingX := Monitor%CurrMonitor%Left + ((Monitor%CurrMonitor%PositionSize*(CurrPos-3))) - WidthCompensationFactor2
                    WinFlingY := Monitor%CurrMonitor%Top
                    WinFlingW := Monitor%CurrMonitor%PositionSize + WidthCompensationFactor
                    WinFlingH := Monitor%CurrMonitor%Height + HeightCompensationFactor
                }
            }
            else
            {
                ; Change Monitor
                ; Compute the number of the next monitor in the direction of the specified fling (+1 or -1)
                ;  Valid monitor numbers are 1..MonitorCount, and we effect a circular fling.
                NextMonitor := CurrMonitor + FlingDirection
                if (NextMonitor > MonitorCount)
                {
                    NextMonitor = 1
                }
                else if (NextMonitor <= 0)
                {
                    NextMonitor = %MonitorCount%
                }
                HeightCompensationFactor := (Monitor%NextMonitor%Height//100)-(Mod(Monitor%NextMonitor%Height//100,5))
                ;WidthCompensationFactor := (Monitor%NextMonitor%Width//100)-(Mod(Monitor%NextMonitor%Width//100,5))
                ;WidthCompensationFactor2 := (WidthCompensationFactor/2)
                WidthCompensationFactor := 20
                WidthCompensationFactor2 := Round(WidthCompensationFactor/2)
                ; Scale the position / dimensions of the target window by the ratio of the monitor sizes.
                ; Programming Note: Do multiplies before divides in order to maintain accuracy in the integer calculation.
                WinFlingX := Monitor%NextMonitor%Left + ((Monitor%NextMonitor%PositionSize*(Monitor%NextMonitor%Positions-1))) - WidthCompensationFactor2
                WinFlingY := Monitor%NextMonitor%Top
                WinFlingW := Monitor%NextMonitor%PositionSize + WidthCompensationFactor
                WinFlingH := Monitor%NextMonitor%Height + HeightCompensationFactor
                
            }
        }
    }

    ; It's time for the target window to make its big move
    WinMove, ahk_id %WinID%,, WinFlingX, WinFlingY, WinFlingW, WinFlingH
       
    ; Fix for some windows like ConEmu
    WinGetPos, WinX2, WinY2, WinW2, WinH2, ahk_id %WinID%
    if (WinFlingH != WinH2 or Abs(WinFlingW-WinW2) > 1) 
    {
        if (WinFlingH != WinH2) 
        {
            WinFlingH := WinFlingH-((Abs(WinFlingH-WinH2)/2)+1)
        }
        if (Abs(WinFlingW-WinW2) > 1) 
        {
            WinFlingW := WinFlingW-((Abs(WinFlingW-WinW2)/2)+1)
        }
        WinMove, ahk_id %WinID%,, WinFlingX, WinFlingY, WinFlingW, WinFlingH
    }
    return 1
}