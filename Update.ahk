;; This script is used to start Chocolatey update via Powershell and update of MSYS2 (pacman -Syu)
;; Author: Andreas Bader
;; Date: October, 2016
;; https://github.com/baderas/autohotkey-scripts

;; The Fling function does not work for admin powershell window (without ConEmu)
;; Choco should be updated from Powershell, not from ConEmu, because if ConEmu is updated via Chocolatey problems occur and ConEmu is not updated
;; When using ConEmu for choco updates: UAC dialoge often is not active (can't change this via autohotkey)
;; When using Powershell for choco updates: Window is not Fling-able

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk

SetTitleMatchMode 2 

#u:: {
If !WinExist("Running Chocolatey Update") and !WinExist("Running MSYS2 Update")
{
    Run *runas C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command "$Host.UI.RawUI.WindowTitle = \"Running Chocolatey Update\"; choco upgrade all; Write-Host \"Press any key to exit ...\";$x = $host.UI.RawUI.ReadKey(\"NoEcho`,`IncludeKeyDown\");",,, process_id
    ;Run C:\Program Files\ConEmu\ConEmu64.exe -Title "Running Chocolatey Update" -run powershell.exe -new_console:a -command "$Host.UI.RawUI.WindowTitle = \"Running Chocolatey Update\"; choco upgrade all; Write-Host \"Press any key to exit ...\";$x = $host.UI.RawUI.ReadKey(\"NoEcho`,`IncludeKeyDown\");",,, process_id
    WaitActiveTop(process_id)
    ;MoveToMouse(process_id)
    WinGet, wid, ID, ahk_pid %process_id%
    Win__Fling2(1, wid, 0, 3)
    WinWait, Running Chocolatey Update
    WinWaitClose
    Run C:\Program Files\ConEmu\ConEmu64.exe -Title "Running MSYS2 Update" -run c:\msys64\usr\bin\bash.exe --login -i -c "export PATH=\"/c/ProgramData/chocolatey/bin:/c/Program Files (x86)/GNU/GnuPG/pub:/c/ProgramData/Chocolatey/bin:/usr/bin/\"; pacman -Syu; read -p \"Press any key to exit ...\" -n1 -s;",,, process_id
    WaitActiveTop(process_id)
    ;MoveToMouse(process_id)
    WinGet, wid, ID, ahk_pid %process_id%
    Win__Fling2(1, wid, 0, 3)

}
else 
{
    If WinExist("Running Chocolatey Update")
    {
        MoveToMouseTitle("Running Chocolatey Update")
        WaitActiveTopTitle("Running Chocolatey Update")
        WinGet, wid, ID, Running Chocolatey Update
        Win__Fling2(1, wid, 0, 3)
    }
    If WinExist("Running MSYS2 Update")
    {
        MoveToMouseTitle("Running MSYS2 Update")
        WaitActiveTopTitle("Running MSYS2 Update")
        WinGet, wid, ID, Running MSYS2 Update
        Win__Fling2(1, wid, 0, 3)
    }
}

Return
}

