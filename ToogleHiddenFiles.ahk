;; Toogle hidden files in Ecplorer with CTRL+H
;; Source: http://davejamesmiller.com/blog/autohotkey-toggle-hidden-files-andor-file-extensions-in-windows-explorer

;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

^h::
{
RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
If HiddenFiles_Status = 2
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
Else
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
Send, {F5}
}
Return