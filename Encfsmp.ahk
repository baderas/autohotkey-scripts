;; This script mounts an EncFS folder and opens KeePass afterwards (KeePass file lies in encFS folder)
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

Run, "C:\Program Files\EncFSMP\EncFSMP.exe" mount --mount="Dropbox"
WinWait, EncFS MP
WinMinimize
Sleep, 1000
Run, "C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe"