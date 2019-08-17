#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#NoTrayIcon

; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Shortkey to open Terminal                     (Win + `)
#`::
; Run, ubuntu.exe
Run, "E:\Program Files\cmder_mini\vendor\conemu-maximus5\ConEmu64.exe" -run ubuntu.exe -cur_console:n
return

; Shortkey to Close Currently Active Window     (Win + q)
#q::
WinGetActiveTitle, title
WinClose, %title%
return

; Shortkey to set Current Window AlwaysOnTop    (Win + SPACE)
#SPACE:: Winset AlwaysOnTop, , A
Return

; Shortkey to open Eveything (Search)                     (Win + S)
#S::
Process, Exist, Everything.exe
If (!ErrorLevel=0)              ; Check if App Found
{
    ; Process Exists, Send Raw Key Input to open Everything.exe using the its Settings to show window hotkey
    Send ^!+\   ; Ctrl+Alt+Shift+\
}

; Open App Again
Else 
{
    Run, "E:\Documents\Programs\Everything\Everything.exe"
}

return


; Shortkey to Minimize Current Window (Win + M)
#M::
WinGetActiveTitle, title
WinMinimize , %title%
return

; ShortKey to open Chrome (Win + C)
#C::
Run, "chrome.exe"
return


; Right-Click (Win + Shift + R)
#+R::
	SendInput, +{F10}
return