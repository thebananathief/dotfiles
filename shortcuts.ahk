#MaxThreadsPerHotkey 2

; Cerl+Shift+Z -> Terminal
+^q::Run("wt.exe")

; Ctrl+Shift+X -> Paperwork folder for this month
dateString := FormatTime(, "yyyy") . " Paperwork\" . FormatTime(, "MM MMM")
+^x::Run("\\titan\Paperwork\" . dateString)

; Ctrl+Shift+A -> VS Code
+^a::Run("C:\Users\csalomone\AppData\Local\Programs\Microsoft VS Code\Code.exe")

; Ctrl+Shift+S -> DevToys
+^s::Run("shell:appsFolder\64360VelerSoftware.DevToys_j80j2txgjg9dj!App")

; Rocker
; ~LButton & RButton::Browser_Forward
; ~RButton & LButton::Browser_Back

; AFK loop
toggle := false
+^n::{
  global
  toggle := !toggle
  Loop {
    Send("Test")
    Sleep(5000)
  } until !toggle
}

