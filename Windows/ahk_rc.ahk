#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#NoTrayIcon

; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Ctrl+Win+2
^#2::
	Send ²
	
	return


; Minimizes and Focuses Window Terminal
!`::
    Process, Exist, WindowsTerminal.exe
    ID := ErrorLevel

    ; If Found
    if (!ID = 0)
    {
        WinGet, MinimizedState, MinMax, ahk_pid %ID%    ; Check if Terminal Is Minimized

        if (MinimizedState = -1)                ; Unminimize Terminal
        {
            WinActivate, ahk_pid %ID%
        }

        else                                    ; Minimize Terminal
        {
            WinMinimize, ahk_pid %ID%
        }        
    }

    return


; Shortkey to Close Currently Active Window     (Win + q)
#q::
    WinGetActiveTitle, title
    WinClose, %title%
    return

; Shortkey to set Current Window AlwaysOnTop    (Win + SPACE)
#SPACE:: 
    Winset AlwaysOnTop, , A
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

    ; Next-Desktop Wallpaper (Win + Shift + N)
    #+N::
        try if ((pDesktopWallpaper := ComObjCreate("{C2CF3110-460E-4fc1-B9D0-8A1C0C9CC4BD}", "{B92B56A9-8B55-4E14-9A89-0199BBB6F93B}"))) {
            DllCall(NumGet(NumGet(pDesktopWallpaper+0)+16*A_PtrSize), "Ptr", pDesktopWallpaper, "Ptr", 0, "UInt", 0) ; IDesktopWallpaper::AdvanceSlideshow - https://msdn.microsoft.com/en-us/library/windows/desktop/hh706947(v=vs.85).aspx
            ObjRelease(pDesktopWallpaper)
        }
    return

; Home Button Remap (Win+[)
#[::
  Send {Home}
  return

; End Button Remap (Win+])
#]::
  Send {End}
  return
; Shift End
#+]::
  Send +{End}
  return
; Shift Home
#+[::
  Send +{Home}
  return
; Ctrl Shift End
^#+]::
  Send ^+{End}
  return
; Ctrl Shift Home
^#+[::
  Send ^+{Home}
  return
; Ctrl End
^#]::
  Send ^{End}
  return
; Ctrl Home
^#[::
  Send ^{Home}
  return


; Remap Right Shift to Forward-Slash
RShift::/
; Full-Screen Toggle (Win+F)
#F::
  WinGetPos, winWidth, winHeight, , , A

  ; Window is Max when both Sizes are -8
  if ( winWidth == -8 and winHeight == -8 ) {
    WinRestore, A
  } else {
    WinMaximize, A
  }
  return