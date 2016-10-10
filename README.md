# autohotkey-scripts

My personal authotkey scripts. Hope, they are useful for others, too.

## Ultra Wide Monitors

Most of the scripts is adopted for usage with an Ultra Wide Monitor like LG 34UC98-W. They replace most of the window placement/movement shortcuts in windows. The idea is to use thirds instead of halfs on ultra wide monitors and halfs on standard (16:9/16:10) monitors. The script is intendend to work without monitor-specific configuration.
When using thirds, double columns are supported, which means that a window can take two thirds of the screen.

## Setup

* Install [Autohotkey](http://www.autohotkey.com/)
  * e.g. with [Chocolatey](https://chocolatey.or): `choco.exe install autohotkey`
* git clone git@github.com:baderas/autohotkey-scripts.git
* copy Autorun_ahk.ahk in autostart folder (C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Autostart\)


## Keybindings

Shortcut | Note | Application | File
-------- | ---- | ----------- | ----
`Win-^`  | Opens Windows Windows Calculator (^ is the key next to numbers on a german keyboard). | Windows Calculator | [Calc.ahk](Calc.ahk)
`Win-t`  | Opens ConEmu, my favorite **t**erminal. | [ConEmu](https://conemu.github.io/) | [ConEmu.ahk](ConEmu.ahk)
`Win-e`  | Opens Windows **E**xplorer, replaces Windows default shortcut, uses window placement. | Windows Explorer | [Explorer.ahk](Explorer.ahk)
`Win-<`  | Moves a window without double column positions in right direction. | | [Fling.ahk](Fling.ahk)
`Win-Right`  | Moves a window with double column positions in right direction. | | [Fling.ahk](Fling.ahk)
`Win-Left`  | Moves a window with double column positions in left direction. | | [Fling.ahk](Fling.ahk)
`Win-Numpad1`  | Moves a window on first column on the ultra wide monitor. |  | [Fling.ahk](Fling.ahk)
`Win-Numpad2`  | Moves a window on second column on the ultra wide monitor. |  | [Fling.ahk](Fling.ahk)
`Win-Numpad3`  | Moves a window on third column on the ultra wide monitor. |  | [Fling.ahk](Fling.ahk)
`Win-Numpad4`  | Moves a window to the first two columns on the ultra wide monitor. |  | [Fling.ahk](Fling.ahk)
`Win-Numpad5`  | Moves a window to the last two columns on the ultra wide monitor. |  | [Fling.ahk](Fling.ahk)
`Win-n`  | Opens KeePass2 and its "add **n**ew password" dialog. Automatically fills in the actual window title (works with Firefox).   | [KeePass2](http://keepass.info/) | [Keepass1.ahk](Keepass1.ahk)
`Win-a`  | Starts **a**uto-type of KeePass2 (Ctrl+Alt+A). Release Windows Key immediately, otherwise the pasted characters will be interpreted as shortcuts. | [KeePass2](http://keepass.info/) | [Keepass2.ahk](Keepass2.ahk)
`Win-k`  | Starts **K**eepNote. | [KeepNote](http://keepnote.org/) | [Keepnote.ahk](Keepnote.ahk)
`Win-l`  | **L**ogs user off and sends monitor immediately into standby. Replaces default windows shortcut. | | [LockAndTurnOffMonitor.ahk](LockAndTurnOffMonitor.ahk)
`Win-s`  | Moves the actual Notepad++ instance into foreground or opens a new Notepad++ instance. The shortcut comes from **S**ciTE, which I used before Notepad++. | [Notepad++](https://notepad-plus-plus.org/) | [Notepad++.ahk](Notepad++.ahk)
`Ctrl+h` | Toggles display of **h**idden files in Windows Explorer. | Windows Explorer | [ToggleHiddenFiles.ahk](ToggleHiddenFiles.ahk)

## Scripts

Some of the functions of autohotkey is used without hotkeys. Therefore a list of these scripts and their functions:

File | Function
-------- |  -----------
[Autorun.ahk](Autorun.ahk) | Starts programs in a defined order after user has logged in. |
[Autorun_ahk.ahk](Autorun_ahk.ahk) | Executes all .ahk scripts in C:\Users\%USERNAME%\ahk_scripts except itself, [Fling2.ahk](Fling2.ahk), and [WindowPlacementFunctions.ahk](WindowPlacementFunctions.ahk). Copy this script in your autostart folder. |
[Encfsmp.ahk](Encfsmp.ahk) | Mounts a [EncFSMP](http://encfsmp.sourceforge.net/) encrypted folder and starts [KeePass2](http://keepass.info/) afterwards. |
[Fling2.ahk](Fling2.ahk) | Provides the fling function for [Fling.ahk](Fling.ahk), [WindowPlacementFunctions.ahk](WindowPlacementFunctions.ahk), and [ConEmu.ahk](ConEmu.ahk).  |
[Maximize.ahk](Maximize.ahk) | Used to maximize specific programs after they are started via [Autorun.ahk](Autorun.ahk). |
[WindowPlacementFunctions.ahk](WindowPlacementFunctions.ahk) | Library of some often used functions for window placement, etc. | 

## Other Authotkey Links/Repos

* https://github.com/koppor/autohotkey-scripts
* https://autohotkey.com/board/topic/51956-flinging-windows-across-a-multi-monitor-system/
* https://gist.github.com/AWMooreCO/1ef708055a11862ca9dc
* http://davejamesmiller.com/blog/autohotkey-toggle-hidden-files-andor-file-extensions-in-windows-explorer
* https://autohotkey.com/board/topic/37352-dockndrag-docks-two-windows-together-for-move-and-resize/
