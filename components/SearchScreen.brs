sub init()
     m.global.RAT=true

    m.scene = m.top.getScene()
    m.navbar=m.top.findNode("navBar")
        m.blurOL=m.top.findNode("blurOL")

    navBarInit("Search")
    allVideos = []  ' will hold the merged list

for each key in m.global.videoArray
    ?"Key in search"key
    for each video in m.global.videoArray[key]
        allVideos.push(video)
    end for
end for
    m.VideosArray = allVideos
    m.inputGroup = m.top.findNode("inputGroup")
    m.textLabel = m.top.findNode("textLabel")
    m.inputKeyboard = m.top.findNode("inputKeyboard")
    m.btnSubmit = m.top.findNode("btnSubmit")
    m.inputKeyboard.observeField("text", "onKeyboardText")
    m.resultsGroup = m.top.findNode("resultsGroup")
    m.videosList = m.top.findNode("videosList")
    m.video = m.top.findNode("video")
    m.video.ObserveField("state", "onVideoState")

    m.btnNoFav = m.top.findNode("btnNoFav")

    m.btnSubmit.observeField("buttonSelected", "onBtnSubmitSelect")
    m.btnNoFav.ObserveField("buttonSelected", "onbtnNoResultSelect")
    m.top.observeField("visible", "onVisibleChange")
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

sub onVideoDurationChange()
    m.scene.callFunc("setCurrentDuration")

end sub

sub onVideoState()
    if m.video.state <> invalid and m.video.state = "playing"

    else if m.video.state = "finished" or m.video.state = "paused"
        m.videoDurationTimer.control = "stop"
    end if

end sub
sub onVisibleChange()
    if m.top.visible
      navBarInit("Search")
              revertButtons()

        if m.inputGroup.visible
                m.inputKeyboard.setFocus(true)
            else
                if m.btnNoFav.visible
                    m.btnNoFav.setFocus(true)
                else
           m.videosList.setFocus(true)
                end if
            end if
      
    end if

end sub


sub onbtnNoResultSelect()
    m.resultsGroup.visible = false
    m.btnNoFav.visible = false
    m.btnNoFav.setFocus(false)
    m.inputGroup.visible = true
    m.inputKeyboard.text = ""
    m.textLabel.text = ""
    m.inputKeyboard.setFocus(true)

end sub


sub onBtnSubmitSelect()
    m.inputGroup.visible = false
    m.resultsGroup.visible = true
    
    videoGridContent = CreateObject("rosgNode", "ContentNode")
    for each video in m.VideosArray
        if Instr(0, LCASE(video.EpisodeTitle), LCASE(m.textLabel.text))
            childContent = videoGridContent.createChild("RowItemData")
            childContent.videoTitle = video.EpisodeTitle
            childContent.videoUrl = video.EpisodeURL
            childContent.videoThumbnail = video.Thumbnail
        end if

    end for

    m.videosList.content = videoGridContent
    m.videosList.observeField("itemSelected", "onVideoSelect")
    m.videosList.observeField("itemFocused", "onVideoFocus")
    if m.videosList.content.getChildCount() > 0
        m.videosList.visible=true
        m.videosList.setFocus(true)
    else
        m.btnNoFav.visible = true
        m.btnNoFav.setFocus(true)

    end if

end sub

sub onVideoFocus(evt)
    index = evt.getData()
    m.videoIndex = m.videosList.content.getChild(index)


end sub

sub onVideoSelect(evt)
    index = evt.getData()
    m.videoIndex = m.videosList.content.getChild(index)
    m.videoContent = CreateObject("rosgNode", "ContentNode")
    m.videoContent.url = m.videoIndex.videoUrl
    ?"Video Url:"m.videoIndex.videoUrl
    m.videoContent.title = m.videoIndex.videoTitle
    m.videoContent.streamFormat = "hls"
     if m.global.duration>=m.global.videoDurationLimit and m.scene.isSubscribed=false

        m.top.setFocus(false)
        m.AppLockPopup.visible=true
        m.AppLockPopup.setFocus(true)
    else
          if instr(0, m.videoIndex.videoUrl, ".mp4")
                ?"In mp4 url"m.videoContent
                m.videoContent.streamFormat = "mp4"
                m.video.content = m.videoContent
                m.video.visible = true
                m.video.control = "play"
                m.video.setFocus(true)
            else

    m.fixTask = CreateObject("roSGNode", "FixM3U8Task")
    m.fixTask.url = m.videoIndex.videoUrl ' your original .m3u8 URL
    m.fixTask.ObserveField("fixedUrl", "onM3U8Fixed")
    m.fixTask.control = "run"
            end if
    end if
end sub

sub onM3U8Fixed()
    fixedUrl = m.fixTask.fixedUrl
    if fixedUrl <> invalid
        m.videoContent.url = fixedUrl
        ' m.video.content = m.videoContent
        m.video.content = m.videoContent
        m.video.visible = true
        AddToRecents(m.videoIndex)
        m.video.control = "play"
        m.videoDurationTimer.control = "start"

        m.video.setFocus(true)
    end if
end sub

sub onKeyboardText()
    m.textLabel.text = m.inputKeyboard.text


end sub

 sub revertButtons()


                                    m.blurOL.visible=false

                        m.NBG.width=198
                                m.NBG.uri="pkg:/images/NBC.png"

     m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoUF.png"
            m.btnHomeN.focusBitmapUri="pkg:/images/btnHoF.png"
             m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaF.png"
            m.btnSearchN.focusBitmapUri="pkg:/images/btnSeaF.png"
             m.btnFavN.focusfootprintbitmapuri="pkg:/images/btnfavUF.png"
            m.btnFavN.focusBitmapUri="pkg:/images/btnfavF.png"
             m.btnSubN.focusfootprintbitmapuri="pkg:/images/btnSubUF.png"
            m.btnSubN.focusBitmapUri="pkg:/images/btnSubF.png"
             m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetUF.png"
            m.btnSettingN.focusBitmapUri="pkg:/images/btnSetF.png"

end sub


function onKeyEvent(key as string, press as boolean) as boolean
    result = false

    if press
        if key = "down" and m.inputGroup.visible and m.inputKeyboard.visible and not (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus())
            m.inputKeyboard.setFocus(false)
            m.btnSubmit.setFocus(true)
            result = true
        else if key = "up" and m.btnSubmit.hasFocus()
            m.btnSubmit.setFocus(false)
            m.inputKeyboard.setFocus(true)
            return true
             else if key="back" and m.AppLockPopup.hasFocus() 'and m.global.appDuration<  m.global.audioDurationLimit
            m.AppLockPopup.visible=false
            m.AppLockPopup.setFocus(false)
           
            m.videosList.setFocus(true)
            return true
        else if key = "back" and m.resultsGroup.visible and m.video.visible = false
            m.btnNoFav.visible = false
            m.resultsGroup.visible = false
            m.btnNoFav.setFocus(false)
            m.videosList.setFocus(false)
            m.inputGroup.visible = true
            m.inputKeyboard.setFocus(true)

            return true
        else if key = "back" and m.video.hasFocus()
            m.video.visible = false
            m.video.control = "stop"
            m.videoDurationTimer.control = "stop"

            m.video.setFocus(false)
            m.videosList.setFocus(true)
            result = true
        else if key = "options" and m.videosList.hasFocus()
            AddToFaves(m.videoIndex)
            return true
        else   if key = "left" and (m.btnSubmit.hasFocus() or m.inputKeyboard.visible or m.btnNoFav.hasFocus() or m.videosList.hasFocus())
            m.btnSearchN.focusFootprintBitmapUri = "pkg:/images/btnSeaUF.png"
            m.btnSubmit.setFocus(false)
            m.btnNoFav.setFocus(false)
            m.videosList.setFocus(false)
            m.inputKeyboard.setFocus(false)
              m.blurOL.visible=true
                m.NBG.width=658
                                m.NBG.uri="pkg:/images/NBE.png"
            m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoEUF.png"
            m.btnHomeN.focusBitmapUri="pkg:/images/btnHoEF.png"
             m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaS.png"
            m.btnSearchN.focusBitmapUri="pkg:/images/btnSeaEF.png"
             m.btnFavN.focusfootprintbitmapuri="pkg:/images/btnfavEUF.png"
            m.btnFavN.focusBitmapUri="pkg:/images/btnfavEF.png"
             m.btnSubN.focusfootprintbitmapuri="pkg:/images/btnSubEUF.png"
            m.btnSubN.focusBitmapUri="pkg:/images/btnSubEF.png"
             m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetEUF.png"
            m.btnSettingN.focusBitmapUri="pkg:/images/btnSetEF.png"
           
            m.btnSearchN.setFocus(true)
            return true
        else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus())
            m.btnSearchN.focusFootprintBitmapUri = "pkg:/images/btnSeaF.png"
            m.top.setFocus(false)
            if m.inputGroup.visible
                m.inputKeyboard.setFocus(true)
            else
                if m.btnNoFav.visible
                    m.btnNoFav.setFocus(true)
                else
           m.videosList.setFocus(true)
                end if
            end if
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
        end if

    end if

    return result
end function


sub AddToRecents(itemContent as object)
    sec = CreateObject("roRegistrySection", "RecentRegCalmApp")

    ' Create a JSON-safe object with correct keys
    jsonItem = {
        videoTitle: itemContent.videoTitle,
        videoUrl: itemContent.videoUrl,
        videoThumbnail: itemContent.videoThumbnail
    }


    ' Read existing recents from registry
    entries = []
    if sec.Exists("entries")
        storedJson = sec.Read("entries")
        if storedJson <> ""
            entries = ParseJson(storedJson)
        end if
    end if

    ' Remove any existing item with the same videoUrl
    filteredEntries = []
    for each entry in entries
        if entry.videoUrl <> jsonItem.videoUrl
            filteredEntries.Push(entry)
        end if
    end for

    ' Add new item as the most recent
    filteredEntries.Push(jsonItem)

    ' Keep only the last 20
    if filteredEntries.Count() > 20
        filteredEntries = filteredEntries.slice(filteredEntries.Count() - 20)
    end if

    ' Write back to registry
    sec.Write("entries", FormatJson(filteredEntries))
    sec.Flush()
end sub


sub AddToFaves(itemContent as object)
    sec = CreateObject("roRegistrySection", "FaveReg")

    ' Create a JSON-safe object with correct keys
    jsonItem = {
        videoTitle: itemContent.videoTitle,
        videoUrl: itemContent.videoUrl,
        videoThumbnail: itemContent.videoThumbnail
    }


    ' Read existing recents from registry
    entries = []
    if sec.Exists("entries")
        storedJson = sec.Read("entries")
        if storedJson <> ""
            entries = ParseJson(storedJson)
        end if
    end if

    ' Remove any existing item with the same videoUrl
    filteredEntries = []
    for each entry in entries
        if entry.videoUrl <> jsonItem.videoUrl
            filteredEntries.Push(entry)
        end if
    end for

    ' Add new item as the most recent
    filteredEntries.Push(jsonItem)

    ' Keep only the last 20
    if filteredEntries.Count() > 20
        filteredEntries = filteredEntries.slice(filteredEntries.Count() - 20)
    end if

    ' Write back to registry
    sec.Write("entries", FormatJson(filteredEntries))
    sec.Flush()
end sub


