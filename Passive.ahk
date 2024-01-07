#MaxThreadsPerHotkey 2
#SingleInstance force

LocalAppData := EnvGet("LOCALAPPDATA")
Roaming := EnvGet("APPDATA")
ProgramFiles := EnvGet("ProgramFiles")

; Quick app binds
; Win + A - Terminal
;       D - Obsidian
;       C - VSCode
;       S - DevToys
;       S - Spotify
;       W - Close window
#a::Run "wt.exe"
#d::Run LocalAppData "\Obsidian\Obsidian.exe"
#c::Run LocalAppData "\Programs\VSCodium\VSCodium.exe"
; #s::Run "shell:appsFolder\64360VelerSoftware.DevToys_j80j2txgjg9dj!App"
#s::Run Roaming "\Spotify\Spotify.exe"
#f::Run ProgramFiles "\Mozilla Firefox\firefox.exe"
#w::!F4

; Rocker
; ~LButton & RButton::Browser_Forward
; ~RButton & LButton::Browser_Back

; AFK loop
toggle := false
+^n::{
  global toggle := !toggle
  Loop {
    Send "zZz..."
    Sleep(5000)
  } until !toggle
}

; Split keyboard gaming mode toggle
sgamemode := false
:*:poiu::
{
  global sgamemode := !sgamemode
}
#HotIf sgamemode
w::q
e::w
r::e
t::r
q::t
s::a
d::s
f::d
g::f
z::g
Delete::Space
a::LShift
#HotIf

; https://www.autohotkey.com/board/topic/64576-the-definitive-autofire-thread/
; a::a hotkey rebind
; :*:asd::asd hotstring rebind

; Browser_Back and Browser_Forward
; XButton1 = Back button
; XButton2 = Forward button
; \ = Sniper button

; Shift = + | Ctrl = ^ | Alt = ! | Win = # | Prefix the button with these to have them respond only when these modifiers are pressed
; What are $ and ~ responsible for?
