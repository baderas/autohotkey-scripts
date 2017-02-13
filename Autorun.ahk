;; This script is used to start programs (etc.) after windows has started and user has logged in
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#Include %A_LineFile%\..\WindowPlacementFunctions.ahk
{
SetTitleMatchMode, 2
IfWinNotExist,KeePass
{
    ; Delete old cygwinsocket if still existing
    ; (KeePass + KeeAgent)
    IfWinNotExist,  database.kdbx - KeePass
    {
        FileDelete, C:\Users\%USERNAME%\.ssh\cygwinsocket
    }
}
IfWinNotExist,Google Chrome
{
    Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
}
IfWinNotExist,Mozilla Thunderbird
{
    Run "C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"
}
IfWinNotExist,Skype
{
    Run "C:\Program Files (x86)\Skype\Phone\Skype.exe"
}
return
}