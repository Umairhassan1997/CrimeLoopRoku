sub init()
     m.global.RAT=true
     m.scene=m.top.getScene()
     m.btn1=m.top.findNode("btn1")
      m.btn2=m.top.findNode("btn2")
      m.btn3=m.top.findNode("btn3")
      m.btn4=m.top.findNode("btn4")
      m.btnSF=m.top.findNode("btnSF")
      m.isSlow=false
      m.isCrash=false
      m.isNotLoad=false
      m.isNotHelpful=false
      m.btn1.observeField("buttonSelected","onbtn1Select")
      m.btn2.observeField("buttonSelected","onbtn2Select")
      m.btn3.observeField("buttonSelected","onbtn3Select")
      m.btn4.observeField("buttonSelected","onbtn4Select")
      m.btnSF.observeField("buttonSelected","onbtnSFSelect")

     m.navBar=m.top.findNode("navBar")
         m.blurOL=m.top.findNode("blurOL")

   navBarInit("Setting")
    m.videosList=m.top.findNode("videosList")
        m.videosList.observeField("ItemSelected","onVideoSelect")
    m.Video=m.top.findNode("VideoPlayer")

     m.btnHis=m.top.findNode("btnHis")
    m.btnPP=m.top.findNode("btnPP")
    m.btnAU=m.top.findNode("btnAU")
     m.btnHis.observeField("buttonSelected","onbtnHisSelect")
    m.btnPP.observeField("buttonSelected","onbtnPPSelect")
    m.btnAU.observeField("buttonSelected","onbtnAUSelect")
    m.top.observeField("visible","onVisibleChange")
        m.video.ObserveField("state", "onVideoState")


        m.TPG=m.top.findNode("TPG")
    m.legaltextLabel=m.top.findNode("legaltextLabel")
    m.videoDurationTimer = m.top.findNode("videoDurationTimer")
    m.videoDurationTimer.ObserveField("fire", "onVideoDurationChange")
' m.legaltextLabel.drawingStyles = {

'     "Heading": {
'         "fontSize": 60
'         "fontUri": "pkg:/components/fonts/Roboto-Regular.ttf"
'         "color": "#FFFFFF"
'     },
'         "Body": {
'             "fontSize": 36
'            "fontUri": "pkg:/components/fonts/Roboto-Regular.ttf"
'             "color": "#FFFFFF"

'     }
    
' }
  


end sub

sub onVideoDurationChange()
    m.scene.callFunc("setCurrentDuration")

end sub

sub onVideoState()
    if m.video.state <> invalid and m.video.state = "playing"

    else if m.video.state = "finished" or m.video.state = "paused"
        m.videoDurationTimer.control = "stop"
    end if

end sub

sub onbtn1Select()
    if m.btn1.focusBitmapUri="pkg:/images/btn1USF.png"
        m.btn1.focusBitmapUri="pkg:/images/btn1SF.png"
        m.btn1.focusFootprintBitmapUri="pkg:/images/btn1SUF.png"
        m.isSlow=true
    else
         m.btn1.focusBitmapUri="pkg:/images/btn1USF.png"
        m.btn1.focusFootprintBitmapUri="pkg:/images/btn1USUF.png"
        m.isSlow=false
    end if

end sub

sub onbtn2Select()
    if m.btn2.focusBitmapUri="pkg:/images/btn2USF.png"
        m.btn2.focusBitmapUri="pkg:/images/btn2SF.png"
        m.btn2.focusFootprintBitmapUri="pkg:/images/btn2SUF.png"
        m.isCrash=true
    else
         m.btn2.focusBitmapUri="pkg:/images/btn2USF.png"
        m.btn2.focusFootprintBitmapUri="pkg:/images/btn2USUF.png"
        m.isCrash=false
    end if

end sub

sub onbtn3Select()
    if m.btn3.focusBitmapUri="pkg:/images/btn3USF.png"
        m.btn3.focusBitmapUri="pkg:/images/btn3SF.png"
        m.btn3.focusFootprintBitmapUri="pkg:/images/btn3SUF.png"
        m.isNotLoad=true
    else
         m.btn3.focusBitmapUri="pkg:/images/btn3USF.png"
        m.btn3.focusFootprintBitmapUri="pkg:/images/btn3USUF.png"
        m.isNotLoad=false
    end if

end sub

sub onbtn4Select()
    if m.btn4.focusBitmapUri="pkg:/images/btn4USF.png"
        m.btn4.focusBitmapUri="pkg:/images/btn4SF.png"
        m.btn4.focusFootprintBitmapUri="pkg:/images/btn4SUF.png"
        m.isNotHelpful=true
    else
         m.btn4.focusBitmapUri="pkg:/images/btn4USF.png"
        m.btn4.focusFootprintBitmapUri="pkg:/images/btn4USUF.png"
        m.isNotHelpful=false
    end if

end sub

sub onbtnSFSelect()
    if m.isSlow
         m.global.analytics.callFunc("logEvent", "is_slow", {
            "screen_name": "OnboardingScreen"
        })
    end if
    if m.isCrash
         m.global.analytics.callFunc("logEvent", "app_crashing", {
            "screen_name": "OnboardingScreen"
        })
    end if
    if m.isNotHelpful
         m.global.analytics.callFunc("logEvent", "search_not_helpful", {
            "screen_name": "OnboardingScreen"
        })
    end if
if m.isNotLoad
         m.global.analytics.callFunc("logEvent", "app_wont_load", {
            "screen_name": "OnboardingScreen"
        })
    end if
    m.top.setFocus(false)
    m.TPG.visible=false
    m.btnPP.setFocus(true)
    ShowFeedbackConfirmationDialog()
end sub
sub onbtnPPSelect()
    m.isPP=true
     m.btnpp.setFocus(false)
     m.btn1.setFocus(true)
    m.TPG.visible=true
    ' m.legaltextLabel.text="<Heading>Privacy Policy</Heading>"+chr(10)+chr(10)+"<Body>This music app (the “App”) uses YouTube API Services to stream and recommend music while protecting your privacy. We may collect limited personal information (like name, email, and usage data such as searches, songs played, favorites, and device info) to personalize your experience, improve functionality, and ensure security. Your data is protected with measures like HTTPS and limited access, though no system is 100% secure. We do not sell your data and only share it with trusted providers, for legal compliance, or to protect user safety. By using the App, you agree to the YouTube Terms of Service and Google Privacy Policy. You may request access, correction, or deletion of your data, or withdraw consent by contacting us at 📧 exactmatch2123@gmail.com. The App is not for children under 13. This policy may be updated, and significant changes will be communicated via the App or email.</Body>"

end sub

sub ShowFeedbackConfirmationDialog()
    dialog = CreateObject("roSGNode", "StandardMessageDialog")
    dialog.title = "Feedback Submitted"
    dialog.message = ["Thsnk You for Submitting Feedback."]
    dialog.buttons = ["OK"]
    dialog.observeField("buttonSelected", "OnDismissConfirmationDialog")

    m.scene.dialog = dialog
end sub

sub OnDismissConfirmationDialog()
    m.scene.dialog.close = true
end sub

sub showSubPopup()
    if m.top.isTrialExpired
      
        m.top.setFocus(false)
        m.AppLockPopup.visible=true
        m.AppLockPopup.setFocus(true)
            m.video.visible=false
        m.video.control="stop"
                EndUserTrial()

        
        m.top.isTrialExpired=false

    end if

end sub


sub onVideoSelect(evt)


    index = evt.getData()
    m.videoIndex = m.videosList.content.getChild(index)
    m.videoContent = CreateObject("rosgNode", "ContentNode")
    m.videoContent.url = m.videoIndex.videoUrl
     m.videoContent.title = m.videoIndex.videoTitle

    m.videoContent.streamFormat = "mp4"
    if m.global.duration >= m.global.videoDurationLimit and m.top.getScene().isSubscribed = false
        m.top.setFocus(false)
        m.AppLockPopup.visible=true
        m.AppLockPopup.setFocus(true)
    else
        m.video.content = m.videoContent
        m.video.visible = true
        m.video.control = "play"
        '  m.videoDurationTimer.control = "start"
        m.video.setFocus(true)

     end if





end sub

sub onM3U8Fixed()
    fixedUrl = m.fixTask.fixedUrl
    if fixedUrl <> invalid
        m.videoContent.url = fixedUrl
        ' m.video.content = m.videoContent
        m.video.content = m.videoContent
        m.video.visible = true
        m.video.control = "play"
        '  m.videoDurationTimer.control = "start"
        m.video.setFocus(true)

    end if
end sub
function CountHistoryVideos() as Integer
    sec = CreateObject("roRegistrySection", "RecentRegCalmApp")
    key = "Recents"

    if sec.Exists(key)
        stored = sec.Read(key)
        if stored <> ""
            videos = ParseJson(stored)
            if videos <> invalid and Type(videos) = "roArray"
                return videos.Count()
            end if
        end if
    end if

    return 0
end function

 sub loadVideos()
    sec = CreateObject("roRegistrySection", "RecentRegCalmApp")

    if sec.Exists("Recents")
        stored = sec.Read("Recents")
        if stored <> ""
            items = ParseJson(stored)

            content = createObject("roSGNode", "ContentNode")

            for each item in items
                ?"playlist video item: " item

                itemNode = content.createChild("RowItemData")
                itemNode.videoTitle       = item.videoTitle
                itemNode.videoThumbnail  = item.videoThumbnail
                 itemNode.VideoURL  = item.VideoURL

            
            end for

            m.videosList.content = content
            m.btnHis.setFocus(false)
            m.videosList.setFocus(true)
        end if
    end if

    ?"Channel Count: " m.videosList.content.GetChildCount()
end sub

sub onSHowRateus()
    if m.top.isRateUs
        onbtnPPSelect()
    end if

end sub

sub onbtnHisSelect()
     ?"History Count"CountHistoryVideos()
    if CountHistoryVideos()>0
        loadVideos()
 
    end if
    

end sub



sub onbtnAUSelect()
    m.isPP=false
    m.btnau.setFocus(false)
         m.TPG.setFocus(true)

     m.TPG.visible=true
    m.legaltextLabel.setFocus(true)
end sub




sub onVisibleChange()
  if m.top.visible
    navBarInit("Setting")
    revertButtons()
    m.btnHis.setFocus(true)
    
  end if

 end sub

  sub revertButtons()
                                    m.blurOL.visible=false

                        m.NBG.width=198
                                m.NBG.uri="pkg:/images/NBC.png"

     m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoUF.png"
            m.btnHomeN.focusBitmapUri="pkg:/images/btnHoF.png"
             m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaUF.png"
            m.btnSearchN.focusBitmapUri="pkg:/images/btnSeaF.png"
             m.btnFavN.focusfootprintbitmapuri="pkg:/images/btnfavF.png"
            m.btnFavN.focusBitmapUri="pkg:/images/btnfavUF.png"
             m.btnSubN.focusfootprintbitmapuri="pkg:/images/btnSubUF.png"
            m.btnSubN.focusBitmapUri="pkg:/images/btnSubF.png"
             m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetUF.png"
            m.btnSettingN.focusBitmapUri="pkg:/images/btnSetF.png"

end sub


function OnkeyEvent(key as string, press as boolean) as boolean

    result = false

    if press
       
                 if key = "left" and (m.btnHis.hasFocus() or m.btnAU.hasFocus() or m.btnPP.hasFocus())
            m.btnSettingN.focusFootprintBitmapUri = "pkg:/images/btnSetUF.png"
            m.btnAU.setFocus(false)
            m.btnHis.setFocus(false)
            m.btnPP.setFocus(false)
             m.blurOL.visible=true

              m.NBG.width=658
                                m.NBG.uri="pkg:/images/NBE.png"
            m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoEUF.png"
            m.btnHomeN.focusBitmapUri="pkg:/images/btnHoEF.png"
             m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaEUF.png"
            m.btnSearchN.focusBitmapUri="pkg:/images/btnSeaEF.png"
             m.btnFavN.focusfootprintbitmapuri="pkg:/images/btnfavEUF.png"
            m.btnFavN.focusBitmapUri="pkg:/images/btnfavEF.png"
             m.btnSubN.focusfootprintbitmapuri="pkg:/images/btnSubEUF.png"
            m.btnSubN.focusBitmapUri="pkg:/images/btnSubEF.png"
             m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetS.png"
            m.btnSettingN.focusBitmapUri="pkg:/images/btnSetEF.png"
           
            m.btnSettingN.setFocus(true)
            return true
        else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus())
            m.btnSettingN.focusFootprintBitmapUri = "pkg:/images/btnSetF.png"
            m.top.setFocus(false)
           m.btnHis.setFocus(true)
           revertButtons()
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
        else if key="down" and m.btnHis.hasFocus()
        m.btnHis.setFocus(false)
        m.btnpp.setFocus(true)
        result=true
    else if key="down" and m.btnpp.hasFocus()
        m.btnpp.setFocus(false)
        m.btnau.setFocus(true)
        result=true
        
        '  else if key="up" and m.btnau.hasFocus()
        ' m.btnau.setFocus(false)
        ' m.btnpp.setFocus(true)
        ' result=true
         else if key="up" and m.btnpp.hasFocus()
        m.btnpp.setFocus(false)
        m.btnHis.setFocus(true)
        result=true
        else if key="down" and m.btn1.hasFocus()
        m.btn1.setFocus(false)
        m.btn2.setFocus(true)
        result=true
        else if key="down" and m.btn2.hasFocus()
        m.btn2.setFocus(false)
        m.btn3.setFocus(true)
        result=true
        else if key="down" and m.btn2.hasFocus()
        m.btn2.setFocus(false)
        m.btn3.setFocus(true)
        result=true
        else if key="down" and m.btn3.hasFocus()
        m.btn3.setFocus(false)
        m.btn4.setFocus(true)
        result=true
        else if key="down" and m.btn4.hasFocus()
        m.btn4.setFocus(false)
        m.btnSF.setFocus(true)
        result=true
        else if key="up" and m.btnSF.hasFocus()
        m.btnSF.setFocus(false)
        m.btn4.setFocus(true)
        result=true
        else if key="up" and m.btn4.hasFocus()
        m.btn4.setFocus(false)
        m.btn3.setFocus(true)
        result=true
        else if key="up" and m.btn3.hasFocus()
        m.btn3.setFocus(false)
        m.btn2.setFocus(true)
        result=true
        else if key="up" and m.btn2.hasFocus()
        m.btn2.setFocus(false)
        m.btn1.setFocus(true)
        result=true
         else if key="left" and m.videosList.hasFocus()
        m.videosList.setFocus(false)
        m.btnHis.setFocus(true)
        result=true
         else if key="right" and (m.btnHis.hasFocus() or m.btnpp.hasFocus() or m.btnau.hasFocus()) and m.videosList.visible and CountHistoryVideos()>0
        m.btnHis.setFocus(false)
        m.btnpp.setFocus(false)
        m.btnau.setFocus(false)
        m.videosList.setFocus(true)
        result=true
       else if key="back" and m.AppLockPopup.hasFocus() 'and m.global.appDuration<  m.global.audioDurationLimit
            m.AppLockPopup.visible=false
            m.AppLockPopup.setFocus(false)
          
            m.videosList.setFocus(true)
            return true
         else if key="back" and m.video.visible
            m.video.control="stop"
            m.video.visible=false
            m.video.setFocus(false)
            m.videosList.setFocus(true)
            result=true
              else if key = "back" and m.TPG.visible
                ?"in 2"
            m.TPG.visible=false
            if m.isPP
                m.btnPP.setFocus(true)
            else
                m.btnAU.setFocus(true)
            end if
            result=true

        end if

   return result
    end if
    end function