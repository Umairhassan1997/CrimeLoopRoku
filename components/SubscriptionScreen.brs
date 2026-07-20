sub init()
    m.global.RAT = false
       m.timerLabel = m.top.findNode("timerLabel")
    m.totalSeconds = 600 ' 10 minutes = 600 seconds
    m.currentSeconds = m.totalSeconds
    m.timer = createObject("roSGNode", "Timer")
    m.timer.repeat = true
    m.timer.duration = 1.0 ' Update every second
    m.timer.observeField("fire", "onTimerFire")
       updateDisplay()
    startTimer()

    m.scene = m.top.getScene()
    m.blurOL = m.top.findNode("blurOL")

    m.navbar = m.top.findNode("navBar")

    navBarInit("Sub")
    m.BG = m.top.findNode("BG")


    m.btnMonthly = m.top.findNode("btnMonthly")
    m.btnYearly = m.top.findNode("btnYearly")
    m.btnCancel = m.top.findNode("btnCancel")
    m.btnMonthly.setFocus(true)
    m.top.observeField("visible", "onVisibleChange")



end sub

sub startTimer()
    m.timer.control = "start"
end sub

sub stopTimer()
    m.timer.control = "stop"
end sub

sub onTimerFire()
    if m.currentSeconds > 0
        m.currentSeconds = m.currentSeconds - 1
        updateDisplay()
        
        if m.currentSeconds = 0
            stopTimer()
        end if
    end if
end sub

sub updateDisplay()
    ' Convert seconds to mm:ss format (since we want 10:00, not 1:00:00)
    minutes = int(m.currentSeconds / 60)
    seconds = m.currentSeconds mod 60
    
    ' Format as mm:ss with large digital style
    timeText = formatTime(minutes) + ":" + formatTime(seconds)
    m.timerLabel.text = timeText
    
    ' Keep timer white for digital clock effect
    m.timerLabel.color = "0xFFFFFFFF"
end sub

sub resetAndStartTimer()
    ' Reset timer to 10:00
    m.currentSeconds = m.totalSeconds
    updateDisplay()
    
    ' Start the timer
    startTimer()
end sub

function formatTime(value as integer) as string
    ' Format number with leading zero if needed
    if value < 10
        return "0" + value.toStr()
    else
        return value.toStr()
    end if
end function

sub onVisibleChange()
    if m.top.visible

        navBarInit("Sub")
        m.btnMonthly.setFocus(true)
        revertButtons()
        resetAndStartTimer()

        m.global.RAT = false
    else
         stopTimer()

        m.global.RAT = true


    end if


end sub

sub revertButtons()
    m.blurOL.visible = false

    m.NBG.width = 168
    m.NBG.uri = "pkg:/images/NBC.png"

    m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoUF.png"
    m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoF.png"
    m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaUF.png"
    m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaF.png"
    m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavUF.png"
    m.btnFavN.focusBitmapUri = "pkg:/images/btnfavF.png"
    m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubF.png"
    m.btnSubN.focusBitmapUri = "pkg:/images/btnSubF.png"
    m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnSetUF.png"
    m.btnSettingN.focusBitmapUri = "pkg:/images/btnSetF.png"

end sub

function onKeyEvent(key as string, press as boolean) as boolean
    result = false

    if press
        if key = "down" and m.btnMonthly.hasFocus()
            m.btnMonthly.setFocus(false)
            m.btnYearly.setFocus(true)
            result = true
        else if key = "up" and m.btnYearly.hasFocus()
            m.btnYearly.setFocus(false)
            m.btnMonthly.setFocus(true)
            result = true


        else if key = "left" and (m.btnMonthly.hasFocus() or m.btnYearly.hasFocus())
            m.btnSubN.focusFootprintBitmapUri = "pkg:/images/btnSubUF.png"
            m.btnMonthly.setFocus(false)
            m.btnYearly.setFocus(false)
            m.blurOL.visible = true

            m.NBG.width = 658
            m.NBG.uri = "pkg:/images/NBE.png"
            m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
            m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoEF.png"
            m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaEUF.png"
            m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaEF.png"
            m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavEUF.png"
            m.btnFavN.focusBitmapUri = "pkg:/images/btnfavEF.png"
            m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubS.png"
            m.btnSubN.focusBitmapUri = "pkg:/images/btnSubEF.png"
            m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnSetEUF.png"
            m.btnSettingN.focusBitmapUri = "pkg:/images/btnSetEF.png"

            m.btnSubN.setFocus(true)
            return true
        else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus())
            m.btnSubN.focusFootprintBitmapUri = "pkg:/images/btnSubF.png"
            m.top.setFocus(false)
            revertButtons()
            m.btnMonthly.setFocus(true)
            return true

        else if key = "down" and m.btnHomeN.hasFocus()
            m.btnHomeN.setFocus(false)
            m.btnSubN.setFocus(true)
            return true
        else if key = "down" and m.btnSubN.hasFocus()
            m.btnSubN.setFocus(false)
            m.btnFavN.setFocus(true)
            return true

        else if key = "down" and m.btnFavN.hasFocus()
            m.btnFavN.setFocus(false)
            m.btnSettingN.setFocus(true)
            return true
        else if key = "down" and m.btnSearchN.hasFocus()
            m.btnSearchN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true

        else if key = "up" and m.btnHomeN.hasFocus()
            m.btnHomeN.setFocus(false)
            m.btnSearchN.setFocus(true)
            return true


        else if key = "up" and m.btnSubN.hasFocus()
            m.btnSubN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true
        else if key = "up" and m.btnFavN.hasFocus()
            m.btnFavN.setFocus(false)
            m.btnSubN.setFocus(true)
            return true
        else if key = "up" and m.btnSettingN.hasFocus()
            m.btnSettingN.setFocus(false)
            m.btnFavN.setFocus(true)
            return true


        end if

        return result

    end if

end function