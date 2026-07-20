sub init()
     m.global.RAT=true

     m.scene = m.top.getScene()
     m.navbar=m.top.findNode("navBar")
    m.blurOL=m.top.findNode("blurOL")

     navBarInit("Favorite")

    m.videosList = m.top.findNode("videosList")
         m.btnBack=m.top.findNode("btnBack")

     m.btnNoFav=m.top.findNode("btnNoFav")
     m.focusTimer=m.top.findNode("focusTimer")
     m.focusTimer.ObserveField("fire","onTimerFire")
    SetContent()
    m.videosList.observeField("itemSelected","onVideoSelect")
    m.videosList.observeField("itemFocused","onVideoFocus")
        m.video=m.top.findNode("videoPlayer")
            m.video.ObserveField("state","onVideoState")

      
    m.btnNoFav.ObserveField("buttonSelected","onbtnNoFavSelect")
 m.top.observeField("visible","onVisibleChange")

m.videoDurationTimer = m.top.findNode("videoDurationTimer")
    m.videoDurationTimer.ObserveField("fire", "onVideoDurationChange")


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

sub SetContent()
 videoGridContent = CreateObject("rosgNode", "ContentNode")

     m.FaveArray=GetFaves()

     for each FaveEntry in m.FaveArray
        childContent = videoGridContent.createChild("RowItemData")
        childContent.videoTitle = FaveEntry.VideoTitle
        childContent.videoUrl = FaveEntry.VideoURL
        childContent.videoThumbnail = FaveEntry.VideoThumbnail

     end for

     m.videosList.content=videoGridContent
       if m.videosList.content.getChildCount()>0
                 m.videosList.setFocus(true)


        else
            m.btnNoFav.visible=true
            m.focusTimer.control="start"

        end if
end sub

sub ShowRemoveFavesHintDialog()
    regSection = "AppPrefs"
    regKey = "hideRemoveFavoritesHint"

    reg = CreateObject("roRegistrySection", regSection)
    if reg.Read(regKey) = "true"
        return ' Don't show if previously dismissed
    end if

    dialog = CreateObject("roSGNode", "StandardMessageDialog")
    dialog.title = "Remove from Favorites"
    dialog.message = ["Press * on the remote to remove videos from your favorites."]
    dialog.buttons = ["OK", "Don't Show Again"]
    dialog.observeField("buttonSelected", "OnRemoveFavesHintDismissed")

    m.scene.dialog = dialog
end sub

sub OnRemoveFavesHintDismissed()
    idx = m.top.dialog.buttonSelected

    if idx = 1 ' "Don't Show Again"
        reg = CreateObject("roRegistrySection", "AppPrefs")
        reg.Write("hideRemoveFavoritesHint", "true")
        reg.Flush()
    end if

    m.scene.dialog = invalid
end sub



sub RemoveFromFaves(itemContent as Object)
    section = CreateObject("roRegistrySection", "FaveReg")
    entries = []

    ' Read existing entries
    if section.Exists("entries")
        storedJson = section.Read("entries")
        if storedJson <> ""
            parsed = ParseJson(storedJson)
            if parsed <> invalid and parsed.count() > 0
                entries = parsed
            end if
        end if
    end if

    ' Filter out the item matching by videoUrl
    filteredEntries = []
    for each entry in entries
        if entry.videoUrl <> itemContent.videoUrl
            filteredEntries.Push(entry)
        end if
    end for

    ' Write updated list back to registry
    section.Write("entries", FormatJson(filteredEntries))
    section.Flush()

    ' Optional: show confirmation
    
    ShowFavoritesRemovedDialog()
    SetContent()
end sub

sub ShowFavoritesRemovedDialog()
    dialog = CreateObject("roSGNode", "Dialog")
    dialog.title = "Removed"
    dialog.message = "Video removed from favorites."
    dialog.buttons = ["OK"]
    dialog.observeField("buttonSelected", "OnDismissConfirmationDialog")

    m.scene.dialog = dialog
end sub

sub OnDismissConfirmationDialog()
    m.scene.dialog = invalid
end sub





sub onVideoDurationChange()
    m.scene.callFunc("setCurrentDuration")

end sub

sub onVideoState()
    if m.video.state<>invalid and m.video.state="playing"
         m.videoDurationTimer.control="start"

    else if m.video.state="finished" or m.video.state="paused" or m.video.state="stopped"
         m.videoDurationTimer.control="stop"
         if m.video.state="finshed"
            m.video.visible=false
            m.video.setFocus(false)
            m.videosList.setFocus(true)

         end if
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
            m.btnFavN.focusBitmapUri="pkg:/images/btnfavF.png"
             m.btnSubN.focusfootprintbitmapuri="pkg:/images/btnSubUF.png"
            m.btnSubN.focusBitmapUri="pkg:/images/btnSubF.png"
             m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetUF.png"
            m.btnSettingN.focusBitmapUri="pkg:/images/btnSetF.png"

end sub
sub onVisibleChange()
    if m.top.visible
         navBarInit("Favorite")
         revertButtons()
        if m.videosList.content.getChildCount()>0
        m.videosList.setFocus(true)
        else
            m.btnNoFav.setFocus(true)

        end if
        else



    end if

end sub


sub onTimerFire()
    m.videosList.setFocus(false)
    m.btnNoFav.setFocus(true)

end sub

sub onbtnNoFavSelect()
    ?"Homescreen called"
    m.top.getScene().callFunc("CallHomeScreen")

end sub

sub onVideoFocus(evt)
    index=evt.getData()
    m.videoIndex=m.videosList.content.getChild(index)

end sub

sub onVideoSelect(evt)
    index=evt.getData()
    m.videoIndex=m.videosList.content.getChild(index)
    m.videoContent=CreateObject("rosgNode","ContentNode")
    m.videoContent.url=m.videoIndex.videoUrl
    ?"Video Url:"m.videoIndex.videoUrl
    m.videoContent.title=m.videoIndex.videoTitle
    m.videoContent.streamFormat="hls"
    m.fixTask = CreateObject("roSGNode", "FixM3U8Task")
    m.fixTask.url = m.videoIndex.videoUrl ' your original .m3u8 URL
    m.fixTask.ObserveField("fixedUrl", "onM3U8Fixed")
    m.fixTask.control = "run"

   

   

end sub

sub onM3U8Fixed()
  fixedUrl = m.fixTask.fixedUrl
  if fixedUrl <> invalid
    m.videoContent.url = fixedUrl
    ' m.video.content = m.videoContent
     m.video.content=m.videoContent
    m.video.visible=true
    m.video.control="play"

    m.video.setFocus(true)
  end if
end sub



function onKeyEvent(key as string, press as boolean) as boolean
    result=false

    if press
        if key="back" and m.video.hasFocus()
            m.video.visible=false
            m.video.control="stop"

            m.video.setFocus(false)
           m.videosList.setFocus(true)
           result=true
            ' else if key="up" and (m.videosList.hasFocus() or m.btnNoFav.hasFocus())
            ' m.videosList.setFocus(false)
            ' m.btnNoFav.setFocus(false)
            ' m.btnBack.setFocus(true)

            ' return true

            ' else if key="down" and m.btnBack.hasFocus()
            ' m.btnBack.setFocus(false)
            ' if m.btnNoFav.visible
            '     m.btnNoFav.setFocus(true)
            ' else
            ' m.videosList.setFocus(true)
            ' end if
            ' return true
        else       if key = "left" and (m.videosList.hasFocus() or m.btnNoFav.hasFocus())
            m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnFavUF.png"
            m.videosList.setFocus(false)
            m.btnNoFav.setFocus(false)
              m.blurOL.visible=true

              m.NBG.width=658
                                m.NBG.uri="pkg:/images/NBE.png"
            m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoEUF.png"
            m.btnHomeN.focusBitmapUri="pkg:/images/btnHoEF.png"
             m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaEUF.png"
            m.btnSearchN.focusBitmapUri="pkg:/images/btnSeaEF.png"
             m.btnFavN.focusfootprintbitmapuri="pkg:/images/btnfavS.png"
            m.btnFavN.focusBitmapUri="pkg:/images/btnfavEF.png"
             m.btnSubN.focusfootprintbitmapuri="pkg:/images/btnSubEUF.png"
            m.btnSubN.focusBitmapUri="pkg:/images/btnSubEF.png"
             m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetEUF.png"
            m.btnSettingN.focusBitmapUri="pkg:/images/btnSetEF.png"
           
            m.btnFavN.setFocus(true)
            return true
        else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus())
            m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnFavF.png"
            m.top.setFocus(false)
            revertButtons()
            if m.btnNoFav.visible
                m.btnNoFav.setFocus(true)
                 else
            m.videosList.setFocus(true)
           

            end if
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

             else if key = "options" and m.videosList.hasFocus()
            RemoveFromFaves(m.videoIndex)
            return true
       
       
        end if

    end if

    return result
end function


function GetFaves() as Object
    section = CreateObject("roRegistrySection", "FaveReg")
    entries = []

    if section.Exists("entries")
        storedJson = section.Read("entries")
        if storedJson <> ""
            parsed = ParseJson(storedJson)
            if parsed <> invalid and parsed.count() > 0
                entries = parsed
            end if
        end if
    end if

    return entries
end function