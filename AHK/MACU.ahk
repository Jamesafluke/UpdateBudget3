;Created this and verified it works great on Halftop. 9/13/24


#Requires AutoHotkey v2.0

#SingleInstance force
Esc::ExitApp


password := "M!mlkjpou79"


Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe https://o.macu.com/Authentication --new-window"
Sleep 8000

;Click sign in.
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Send "{Enter}"
Sleep 15000

;Select Checking
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Sleep 500
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Sleep 500
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Sleep 500
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Send "{Enter}"
Sleep 10000

;Select Download
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Sleep 500
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Sleep 500
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Sleep 500
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Send "{Enter}"
Sleep 10000

;Download configuration
Send "{Down}"
Send "{Enter}"

Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Sleep 500
Send "{Tab}"
Send "{Tab}"
Send "{Tab}"
Sleep 500

Send "{Enter}"
Sleep 10000


Send ^w