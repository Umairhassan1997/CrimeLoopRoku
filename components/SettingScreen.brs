sub init()
     m.global.RAT=true

     m.navBar=m.top.findNode("navBar")
         m.blurOL=m.top.findNode("blurOL")

   navBarInit("Setting")
    m.videosList=m.top.findNode("videosList")
        m.videosList.observeField("ItemSelected","onVideoSelect")
    m.VideoPlayer=m.top.findNode("VideoPlayer")

     m.btnHis=m.top.findNode("btnHis")
    m.btnPP=m.top.findNode("btnPP")
    m.btnAU=m.top.findNode("btnAU")
     m.btnHis.observeField("buttonSelected","onbtnHisSelect")
    m.btnPP.observeField("buttonSelected","onbtnPPSelect")
    m.btnAU.observeField("buttonSelected","onbtnAUSelect")
    m.top.observeField("visible","onVisibleChange")

        m.TPG=m.top.findNode("TPG")
    m.legaltextLabel=m.top.findNode("legaltextLabel")
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

sub showSubPopup()
    if m.top.isTrialExpired
      
        m.top.setFocus(false)
        m.AppLockPopup.visible=true
        m.AppLockPopup.setFocus(true)
            m.video.visible=false
        m.video.control="stop"
        
        m.top.isTrialExpired=false

    end if

end sub


sub onVideoSelect(evt)


    index = evt.getData()
    m.videoIndex = m.videosList.content.getChild(index)
    m.videoContent = CreateObject("rosgNode", "ContentNode")
    m.videoContent.url = m.videoIndex.videoUrl
    ?"Video Url:"m.videoIndex.videoUrl
    m.videoContent.title = m.videoIndex.videoTitle

    m.videoContent.streamFormat = "hls"
    if m.global.duration >= m.global.videoDurationLimit and m.top.getScene().isSubscribed = false
        m.scene.callFunc("ShowSubscriptionPromptDialog")

    else
    m.fixTask = CreateObject("roSGNode", "FixM3U8Task")
    m.fixTask.url = m.videoIndex.videoUrl ' your original .m3u8 URL
    m.fixTask.ObserveField("fixedUrl", "onM3U8Fixed")
    m.fixTask.control = "run"

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

sub onbtnHisSelect()
     ?"History Count"CountHistoryVideos()
    if CountHistoryVideos()>0
        loadVideos()
 
    end if
    

end sub

sub onbtnPPSelect()
    m.isPP=true
     m.btnpp.setFocus(false)
     m.TPG.setFocus(true)
    m.TPG.visible=true
m.legaltextLabel.text = "Privacy Policy " + chr(10) + chr(10) + "Calm - Meditations & Relaxation is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your information when you use our mobile application (“App”)." + chr(10) + chr(10) + "---" + chr(10) + "1. Information We Collect" + chr(10) + "We respect your privacy and limit the amount of personal data we collect. Depending on how you use the App, we may collect:" + chr(10) + "- Basic Information: Such as your email address (if you sign up for an account or newsletter)." + chr(10) + "- Usage Data: Non-identifiable information such as how often you use the app, the features you interact with, and general analytics." + chr(10) + "- Payment Information: If you subscribe to premium features, payments are processed securely through the App Store / Play Store. We do not store your credit card or banking details." + chr(10) + chr(10) + "---" + chr(10) + "2. How We Use Your Information" + chr(10) + "We use collected information to:" + chr(10) + "- Provide and improve the App experience." + chr(10) + "- Personalize content recommendations." + chr(10) + "- Process subscription payments." + chr(10) + "- Respond to customer support requests." + chr(10) + "- Ensure compliance with legal obligations." + chr(10) + chr(10) + "---" + chr(10) + "3. Data Sharing & Third Parties" + chr(10) + "We do not sell, trade, or rent your personal information to third parties. We may share limited non-personal usage data with trusted analytics providers to help us improve the app." + chr(10) + chr(10) + "---" + chr(10) + "4. Data Security" + chr(10) + "We take reasonable measures to protect your information from unauthorized access, disclosure, alteration, or destruction." + chr(10) + chr(10) + "---" + chr(10) + "5. Your Rights" + chr(10) + "You may:" + chr(10) + "- Request access to your personal data." + chr(10) + "- Request deletion of your data." + chr(10) + "- Opt out of promotional emails at any time." + chr(10) + "To exercise these rights, please contact us at: henryreeve80@gmail.com" + chr(10) + chr(10) + "---" + chr(10) + "6. Children’s Privacy" + chr(10) + "Our App may be used by families and children under parental supervision. We do not knowingly collect personal data from children under 13. Parents/guardians can request removal of any such data by contacting us." + chr(10) + chr(10) + "---" + chr(10) + "7. External Content Disclaimer" + chr(10) + "Our App provides access to meditation music, relaxing sounds, and related content that may include links or streams from YouTube. We do not host any content on our own servers. All YouTube content is streamed under the principles of Fair Use (17 U.S.C. § 107) for educational and relaxation purposes. We are not affiliated, associated, authorized, endorsed by, or in any way officially connected with the Calm official channel or any other brand. All content remains the property of its rightful owners." + chr(10) + chr(10) + "---" + chr(10) + "8. Updates to This Policy" + chr(10) + "We may update this Privacy Policy from time to time. The latest version will always be available in the App." + chr(10) + chr(10) + "---" + chr(10) + "9. Contact Us" + chr(10) + "If you have any questions about this Privacy Policy, please contact us at: henryreeve80@gmail.com"
m.legaltextLabel.setFocus(true)
end sub

sub onbtnAUSelect()
    m.isPP=false
    m.btnau.setFocus(false)
         m.TPG.setFocus(true)

     m.TPG.visible=true
    m.legaltextLabel.text="About Us"+chr(10)+chr(10)+"At Calm - Meditations & Relaxation, we believe that a calmer mind creates a better life. In today’s fast-paced world, stress, noise, and endless distractions have become part of daily living. That’s why we created this space—a place where you can pause, breathe, and reconnect with yourself.With a carefully curated library of soothing music, guided meditations, and relaxing soundscapes, we’ve designed Calm - Meditations & Relaxation to be your personal sanctuary—always available at your fingertips.But we’re more than just an app. We’re a movement towards mindful living. Every track, every session, and every feature has been thoughtfully crafted to nurture your mental well-being, reduce stress, and support your journey to a healthier, happier you. Because we believe: Calm is not a luxury—it’s a necessity.Welcome to Calm - Meditations & Relaxation—your safe space for peace, clarity, and renewal."
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
        ' else if key="down" and m.btnHis.hasFocus()
        ' m.btnHis.setFocus(false)
        ' m.btnpp.setFocus(true)
        ' result=true
    else if key="down" and m.btnpp.hasFocus()
        m.btnpp.setFocus(false)
        m.btnau.setFocus(true)
        result=true
        
         else if key="up" and m.btnau.hasFocus()
        m.btnau.setFocus(false)
        m.btnpp.setFocus(true)
        result=true
         else if key="up" and m.btnpp.hasFocus()
        m.btnpp.setFocus(false)
        m.btnHis.setFocus(true)
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

         else if key="back" and m.VideoPlayer.visible
            m.VideoPlayer.control="stop"
            m.VideoPlayer.visible=false
            m.VideoPlayer.setFocus(false)
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