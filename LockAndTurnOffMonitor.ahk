;; Win+L turns off monitor and locks screen without monitor turning back on
;; Normally windows does this by itself by sending the monitor to standby after X minutes
;; X is not configurable anymore in Windows 10
;; Windows method does not work with some monitors (e.g. LG 34UC98-W)
;; This script replaces the "normal" Win+L hotkey

;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#l::
Sleep 1000 ; Give user a chance to release keys (in case their release would wake up the monitor again).
; Turn Monitor Off:
SendMessage, 0x112, 0xF170, 2,, Program Manager ; 0x112 is WM_SYSCOMMAND, 0xF170 is SC_MONITORPOWER.
; Note for the above: Use -1 in place of 2 to turn the monitor on.
; Use 1 in place of 2 to activate the monitor's low-power mode.
; Lock Workstation:
DllCall("LockWorkStation")
return