#MaxThreadsPerHotkey 2
#SingleInstance force

; Type :co* or c@ to autotype email
:co*:c@::cameron.salomone@gmail.com

; Quick app binds
; Win + A - Terminal
;       D - Obsidian
;       C - VSCode
;       S - DevToys
;       W - Close window
#a::Run "wt.exe"
#d::Run "C:\Users\cameron\AppData\Local\Obsidian\Obsidian.exe"
#c::Run "C:\Users\cameron\AppData\Local\Programs\VSCodium\VSCodium.exe"
#s::Run "shell:appsFolder\64360VelerSoftware.DevToys_j80j2txgjg9dj!App"
#w::!F4

; Rocker
~LButton & RButton::Browser_Forward
~RButton & LButton::Browser_Back

; AFK loop
toggle := false
+^n::{
  global toggle := !toggle
  Loop {
    Send "zZz..."
    Sleep(5000)
  } until !toggle
}

; https://www.autohotkey.com/board/topic/64576-the-definitive-autofire-thread/
; a::a hotkey rebind
; :*:asd::asd hotstring rebind

; Browser_Back and Browser_Forward
; XButton1 = Back button
; XButton2 = Forward button
; \ = Sniper button

; Shift = + | Ctrl = ^ | Alt = ! | Win = # | Prefix the button with these to have them respond only when these modifiers are pressed
; What are $ and ~ responsible for?