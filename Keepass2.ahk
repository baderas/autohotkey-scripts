;; This script enables Win+A to use KeePass Autotype
;; Never hold Win button down after pressing Win+A! Release it immediately!
;; Author: Andreas Bader 
;; Date: August, 2016
;; https://github.com/baderas/autohotkey-scripts

#a:: 
{
Run, "C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe" -auto-type ,,Hide
}
return