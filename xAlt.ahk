; <COMPILER: v1.0.47.0>
#singleinstance force

If (A_AhkVersion < "1.0.39.00")
{
    MsgBox,20,,This script may not work properly with your version of AutoHotkey. Continue?
    IfMsgBox,No
    ExitApp
}





SetWinDelay,2

CoordMode,Mouse
return

!LButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id


    PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
    DoubleAlt := false
    return
}


MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return

WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
gui, +AlwaysOnTop -caption +border
Gui, Add, Text, x21 y6 w10 h20 , x:
Gui, Add, Text, x31 y6 w30 h20 , %KDE_WinX1%;
Gui, Add, Text, x61 y6 w10 h20 , y:
Gui, Add, Text, x71 y6 w30 h20 , %KDE_WinY1%
Gui, Show, xcenter ycenter h25 w107, Pixels
Loop
{
    GetKeyState,KDE_Button,LButton,P
    If KDE_Button = U
{
gui,destroy
 break
}

    MouseGetPos,KDE_X2,KDE_Y2
    KDE_X2 -= KDE_X1
    KDE_Y2 -= KDE_Y1
    KDE_WinX2 := (KDE_WinX1 + KDE_X2)
    KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
    WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2%
GuiControl,text, Static2, %KDE_WinX2%
GuiControl,text,Static4, %KDE_WinY2%

}
return

!RButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id

    WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    If KDE_Win
        WinRestore,ahk_id %KDE_id%
    Else
        WinMaximize,ahk_id %KDE_id%
    DoubleAlt := false
    return
}


MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return

WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%


If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
   KDE_WinLeft := 1
Else
   KDE_WinLeft := -1
If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
   KDE_WinUp := 1
Else
   KDE_WinUp := -1

gui, +AlwaysOnTop -caption +border
Gui, Add, Text, x21 y6 w10 h20 , h:
Gui, Add, Text, x31 y6 w30 h20 , %KDE_WinH%
Gui, Add, Text, x61 y6 w10 h20 , w:
Gui, Add, Text, x71 y6 w30 h20 , %KDE_WinW%
Gui, Show, xcenter ycenter h25 w107, Size
Loop
{
    GetKeyState,KDE_Button,RButton,P
    If KDE_Button = U
{
gui,destroy
        break
}
    MouseGetPos,KDE_X2,KDE_Y2

    WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
    KDE_X2 -= KDE_X1
    KDE_Y2 -= KDE_Y1

    WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2
                            , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2
                            , KDE_WinW  -     KDE_WinLeft  *KDE_X2
                            , KDE_WinH  -       KDE_WinUp  *KDE_Y2
    KDE_X1 := (KDE_X2 + KDE_X1)
    KDE_Y1 := (KDE_Y2 + KDE_Y1)

win_height:=KDE_WinH  -       KDE_WinUp  *KDE_Y2
win_width:=KDE_WinW  - KDE_WinLeft  *KDE_X2
GuiControl,text, Static2, %KDE_WinH%
GuiControl,text,Static4, %KDE_WinW%
}
return




!MButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id
    WinClose,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
return


~Alt::
DoubleAlt := A_PriorHotKey = "~Alt" AND A_TimeSincePriorHotkey < 400
Sleep 0
KeyWait Alt
return
