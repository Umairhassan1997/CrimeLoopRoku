sub init()
    m.global.RAT = true

    m.scene = m.top.getScene()
    m.currentRow = 0
    m.blurOL = m.top.findNode("blurOL")

    m.btnCat1 = m.top.findNode("btnCat1")
    m.btnCat2 = m.top.findNode("btnCat2")
    m.btnCat3 = m.top.findNode("btnCat3")
    m.btnCat5 = m.top.findNode("btnCat5")
    m.btnCat4 = m.top.findNode("btnCat4")
    m.btnCat6 = m.top.findNode("btnCat6")
    m.videosGrid = m.top.findNode("videosGrid")
    m.videosGroup = m.top.findNode("videosGroup")


    m.navbar = m.top.findNode("navbar")
    m.dotGroup = m.top.findNode("dotGroup")
    m.isPrevHero = true
    navBarInit("Home")
    m.herodownAnim = m.top.findNode("herodownAnim")
    m.heroupAnim = m.top.findNode("heroupAnim")
    m.videosupAnim = m.top.findNode("videosupAnim")
    m.videosdownAnim = m.top.findNode("videosdownAnim")
    m.video = m.top.findNode("videoPlayer")
    m.video.ObserveField("state", "onVideoState")
    m.ChangeImageTimer = m.top.findNode("ChangeImageTimer")
    m.ChangeImageTimer.ObserveField("fire", "changeImage")

    m.videoDurationTimer = m.top.findNode("videoDurationTimer")
    m.videoDurationTimer.ObserveField("fire", "onVideoDurationChange")
    m.videosList = m.top.findNode("videosList")
    m.heroList = m.top.findNode("heroList")
    m.videosGrid.observeField("itemSelected", "onHeroSelect")
    m.videosGrid.observeField("itemFocused", "onHeroFocus")
    m.videosList.observeField("rowitemSelected", "onVideoSelect")
    m.videosList.observeField("rowitemFocused", "onVideoFocus")

    m.VideoArrayGetter = CreateObject("roSGNode", "GetJsonTask")
    m.VideoArrayGetter.ObserveField("content", "SetContent")
    m.VideoArrayGetter.control = "RUN"
    ' ShowAddToFavoritesHintDialog()
    m.top.observeField("visible", "onVisibleChange")
    m.dotContainer = m.top.findNode("dotContainer")
    createDots(4)
    m.btnCat1.observeField("buttonSelected", "onbtnCat1Select")
    m.btnCat2.observeField("buttonSelected", "onbtnCat2Select")
    m.btnCat3.observeField("buttonSelected", "onbtnCat3Select")
    m.btnCat4.observeField("buttonSelected", "onbtnCat4Select")
    m.btnCat5.observeField("buttonSelected", "onbtnCat5Select")
    m.btnCat6.observeField("buttonSelected", "onbtnCat6Select")

end sub

sub resetButtonsUri()
    m.btnCat1.focusBitmapUri = "pkg:/images/btnCat1F.png"
    m.btnCat1.focusfootprintbitmapuri = "pkg:/images/btnCat1UF.png"
    m.btnCat2.focusBitmapUri = "pkg:/images/btnCat2F.png"
    m.btnCat2.focusfootprintbitmapuri = "pkg:/images/btnCat2UF.png"
    m.btnCat3.focusBitmapUri = "pkg:/images/btnCat3F.png"
    m.btnCat3.focusfootprintbitmapuri = "pkg:/images/btnCat3UF.png"
    m.btnCat4.focusBitmapUri = "pkg:/images/btnCat4F.png"
    m.btnCat4.focusfootprintbitmapuri = "pkg:/images/btnCat4UF.png"
    m.btnCat5.focusBitmapUri = "pkg:/images/btnCat5F.png"
    m.btnCat5.focusfootprintbitmapuri = "pkg:/images/btnCat5UF.png"
    m.btnCat6.focusBitmapUri = "pkg:/images/btnCat6F.png"
    m.btnCat6.focusfootprintbitmapuri = "pkg:/images/btnCat6UF.png"


end sub

sub showSubPopup()
    if m.top.isTrialExpired

        m.top.setFocus(false)
        m.AppLockPopup.focusBitmapUri = "pkg:/images/subExpPopup.png"

        m.AppLockPopup.visible = true
        m.AppLockPopup.setFocus(true)
        m.video.visible = false
        m.video.control = "stop"

        EndUserTrial()

        m.top.isTrialExpired = false

    end if

end sub

sub onbtnCat1Select()
    resetButtonsUri()
    m.btnCat1.focusfootprintbitmapuri = "pkg:/images/btnCat1S.png"

    SetVideoListContent(0)

end sub

sub onbtnCat2Select()
    resetButtonsUri()
    m.btnCat2.focusfootprintbitmapuri = "pkg:/images/btnCat2S.png"

    SetVideoListContent(1)


end sub
sub onbtnCat3Select()
    resetButtonsUri()
    m.btnCat3.focusfootprintbitmapuri = "pkg:/images/btnCat3S.png"

    SetVideoListContent(2)

end sub

sub onbtnCat4Select()
    resetButtonsUri()
    m.btnCat4.focusfootprintbitmapuri = "pkg:/images/btnCat4S.png"

    SetVideoListContent(3)

end sub

sub onbtnCat5Select()
    resetButtonsUri()
    m.btnCat5.focusfootprintbitmapuri = "pkg:/images/btnCat5S.png"

    SetVideoListContent(4)

end sub

sub onbtnCat6Select()
    resetButtonsUri()
    m.btnCat6.focusfootprintbitmapuri = "pkg:/images/btnCat6S.png"

    SetVideoListContent(5)

end sub

sub createDots(count as integer)
    m.dots = []

    for i = 0 to count - 1
        dot = CreateObject("roSGNode", "Poster")
        dot.width = 16
        dot.height = 16
        dot.uri = "pkg:/images/DotUF.png"
        m.dotContainer.appendChild(dot)
        m.dots.push(dot)
    end for

    highlightDot(0)
end sub


sub highlightDot(index as integer)
    for i = 0 to m.dots.count() - 1
        if i = index
            m.dots[i].uri = "pkg:/images/DotF.png"
        else
            m.dots[i].uri = "pkg:/images/DotUF.png"
        end if
    end for
end sub


sub onVisibleChange()
    if m.top.visible
        navBarInit("Home")
        if m.videosList.visible
        m.videosList.setFocus(true)
        else 
            m.videosGrid.setFocus(true)
        end if
        revertButtons()
        if m.AppLockPopup.visible
            m.top.setFocus(false)
            m.AppLockPopup.setFocus(true)
        end if

    end if

end sub

sub onVideoDurationChange()
    m.scene.callFunc("setCurrentDuration")

end sub

sub onVideoState()
    if m.video.state <> invalid and m.video.state = "playing"
        m.videoDurationTimer.control = "start"


    else if m.video.state = "finished" or m.video.state = "paused" or m.video.state = "stopped"
        m.videoDurationTimer.control = "stop"
        if m.video.state = "finished"
            m.video.visible = "false"
            m.video.setFocus(false)

            m.videosList.setFocus(true)
       

        end if
         else if m.video.state="error"
            ?"errorCode"m.video.errorCode
            ?"errorMsg"m.video.errorMsg
            ?"errorStr"m.video.errorStr

    end if

end sub

sub ShowAddToFavoritesHintDialog()
    regSection = "AppPrefs"
    regKey = "hideFavoritesHint"

    reg = CreateObject("roRegistrySection", regSection)
    regValue = reg.Read(regKey)

    if regValue = "true"
        return
    end if

    dialog = CreateObject("roSGNode", "StandardMessageDialog")
    dialog.title = "Add to Favorites"
    dialog.message = ["Press * on the remote to add videos to your favorites."]
    dialog.buttons = ["OK", "Don't Show Again"]
    dialog.observeField("buttonSelected", "OnFavoritesHintDialogClosed")

    m.scene.dialog = dialog
end sub

sub OnFavoritesHintDialogClosed()
    idx = m.scene.dialog.buttonSelected

    if idx = 1 ' "Don't Show Again"
        reg = CreateObject("roRegistrySection", "AppPrefs")
        reg.Write("hideFavoritesHint", "true")
        reg.Flush()
    end if

    ' Dismiss dialog
    m.scene.dialog = invalid
end sub


sub onvideoFocus(evt)
    m.isPrevHero = false

    index = evt.getData()
    row = index[0]
    col = index[1]
    m.col = col

    ' if col<3
    '     m.videosList.rowFocusAnimationStyle="floatingFocus"
    ' else
    '     m.videosList.rowFocusAnimationStyle="fixedFocus"

    ' end if
    m.videoIndex = m.videosList.content.getChild(row).getChild(col)
    m.columnCount = m.videosList.content.getChild(0).GetChildCount() - 1
    if m.videoIndex.videoThumbnail <> "pkg:/images/VAPH.png"
        m.top.findNode("videoTitle").text = m.videoIndex.videoTitle
        m.top.findNode("thumbnailPoster").uri = m.videoIndex.videoThumbnail

    end if
    ' m.ChangeImageTimer.control="stop"


end sub

sub AddToRecents(videoInfo as object)
    if videoInfo = invalid or videoInfo.videoTitle = invalid or videoInfo.videoThumbnail = "pkg:/images/VAPH.png"
        print "Invalid video info object."
        return
    end if

    sec = CreateObject("roRegistrySection", "RecentRegCalmApp")
    key = "Recents"


    ' Load existing recents
    recents = []
    if sec.Exists(key)
        stored = sec.Read(key)
        if stored <> ""
            recents = ParseJson(stored)
        end if
    end if

    ' Deduplicate by id
    dedup = []
    for each item in recents
        if item.videoTitle <> videoInfo.videoTitle
            dedup.Push(item)
        end if
    end for

    ' Prepend the latest video (no Unshift in BRS)
    newItem = {
        videoTitle: videoInfo.videoTitle,
        videoUrl: videoInfo.videoUrl,
        videoThumbnail: videoInfo.videoThumbnail
    }

    finalRecents = []
    finalRecents.Push(newItem)
    for each item in dedup
        finalRecents.Push(item)
    end for

    ' Trim to max N (no slicing in BRS)
    maxCount = 20
    if finalRecents.Count() > maxCount
        trimmed = []
        i = 0
        for each item in finalRecents
            if i >= maxCount then exit for
            trimmed.Push(item)
            i = i + 1
        end for
        finalRecents = trimmed
    end if

    ' Save
    sec.Write(key, FormatJson(finalRecents))
    sec.Flush()

    print "Added to Recents: " + videoInfo.videoTitle
end sub

sub onvideoSelect(evt)
    m.isPrevHero = false

    index = evt.getData()
    ?"Video Selected from "index

    m.videoIndex = m.videosList.content.getChild(index[0]).getChild(index[1])
    m.currentRowTitle = m.videosList.content.getChild(index[0]).title

        AddToRecents(m.videoIndex)
        if m.videoIndex.VideoThumbnail <> "pkg:/images/VAPH.png"

     if m.global.duration<m.global.videoDurationLimit or m.scene.isSubscribed

            m.videoContent = CreateObject("rosgNode", "ContentNode")
            m.videoContent.url = m.videoIndex.videoUrl
            m.videoContent.title = m.videoIndex.videoTitle
            m.videoContent.streamFormat = GetStreamFormat(m.videoIndex.videoUrl)
                m.video.content = m.videoContent
                m.video.visible = true
                m.video.control = "play"
                m.video.setFocus(true)
         
             else
                showAppLockPopup()
             end if

        else

            if m.videosGroup.translation[0] = 0 and m.videosGroup.translation[1] = 0

                m.heroupAnim.control = "start"
                m.videosupAnim.control = "start"
            end if
            setSpecificContent(m.videosList.content.getChild(index[0]).title)
            m.videosGrid.visible = true
            m.videosList.visible = false
            m.videosList.setFocus(false)
            m.videosGrid.setFocus(true)

        end if

   
end sub

function isAtZeroZero(value as dynamic, arr as object) as boolean
    if arr.Count() > 0 and arr[0].Count() > 0
        return arr[0][0] = value
    end if
    return false
end function



sub onHeroFocus(evt)

    index = evt.getData()
    row = index

    m.videoIndex = m.videosGrid.content.getChild(row)

    ' m.ChangeImageTimer.control="stop"


end sub
sub changeImage()
    if m.col = m.columnCount
        m.col = 0

    else
        m.col = m.col + 1

    end if

    ' m.imagesList.jumpToRowItem=[m.row,m.col]
    m.heroList.jumpToRowItem = [0, m.col]

end sub

sub onHeroSelect(evt)


    index = evt.getData()
    m.videoIndex = m.videosGrid.content.getChild(index)
    m.videoContent = CreateObject("rosgNode", "ContentNode")
    m.videoContent.url = m.videoIndex.videoUrl
    ?"Video Url:"m.videoIndex
    m.videoContent.title = m.videoIndex.videoTitle
    AddToRecents(m.videoIndex)

    m.videoContent.streamFormat = GetStreamFormat(m.videoIndex.videoUrl)
    if (m.global.appDuration >= m.global.audioDurationLimit or m.videoIndex.type = "Paid") and m.scene.isSubscribed=false
        showAppLockPopup()


    else
        if m.global.duration>=m.global.videoDurationLimit and m.scene.isSubscribed=false

            m.top.setFocus(false)
            m.AppLockPopup.visible = true
            m.AppLockPopup.setFocus(true)
        else
                m.video.content = m.videoContent
                m.video.visible = true
                m.video.control = "play"
                m.video.setFocus(true)
           
        end if

    end if





end sub

sub ShowApplockPopup()

    m.video.control = "stop"
    m.video.visible = false
    m.AppLockPopup.focusBitmapUri = "pkg:/images/proPopup.png"

    m.top.setFocus(false)
    m.AppLockPopup.visible = true
    m.AppLockPopup.setFocus(true)

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

function GetStreamFormat(url as dynamic) as string
    if url = invalid or url = ""
        return "mp4"
    end if
    lowerUrl = LCase(url.toStr())
    if right(lowerUrl, 5) = ".m3u8" or lowerUrl.Instr(".m3u8?") > 0
        return "hls"
    end if
    return "mp4"
end function

function ShuffleArray(arr as object) as object
    shuffled = []

    ' --- manual copy ---
    for each item in arr
        shuffled.Push(item)
    end for

    ' --- shuffle ---
    for i = shuffled.Count() - 1 to 1 step -1
        j = Rnd(i + 1) - 1 ' 0..i
        temp = shuffled[i]
        shuffled[i] = shuffled[j]
        shuffled[j] = temp
    end for

    return shuffled
end function


' sub SetContent()
'     m.VideosArray = m.VideoArrayGetter.content
'     m.global.videoArray=m.videosArray
'     ?"VideoArray"m.VideoArrayGetter.content
'     keyArray=m.VideoArrayGetter.content.keys()
'     ?"Key Array"keyArray

'     heroData=m.videosArray[keyArray[0]]
'     heroArray = SubArr(heroData, 0, 5)
'     heroArray=ShuffleArray(heroArray)
'     viewAll={"videoThumbnailURL":"pkg:/images/VAPH.png","VideoURL":"","VideoTitle":""}
'     heroArray.push(viewAll)



'     videoGridContentvideos = CreateObject("rosgNode", "ContentNode")


'     videoGridContentHero = CreateObject("rosgNode", "ContentNode")
'     childNode = CreateObject("rosgNode", "ContentNode")

'     i=0
'     for each video in heroArray
'         childContent = childNode.createChild("RowItemData")
'         childContent.videoTitle = video.VideoTitle
'         childContent.videoUrl = video.VideoURL
'         childContent.videoThumbnail = video.VideoThumbnailURL
'         if i<5
'                 childContent.type="Free"
'             else
'                 childContent.type="Paid"

'             end if
'             i+=1


'     end for
'     videoGridContentHero.appendChild(childNode)

'     m.videosList.content = videoGridContentHero
'     m.videosList.setFocus(true)



' end sub

sub SetContent()
    m.videosArray = m.VideoArrayGetter.content
    m.global.videoArray = m.videosArray

    ' Fixed home rows from local sheet JSON (replaces Action / Adventure / etc.)
    keyArray = [
        "JCS Criminal Psychology",
        "MV Central",
        "ThatChapter",
        "Explore with us",
        "Kendall Rae",
        "Bailey Sarian"
    ]

    videoGridContent = CreateObject("roSGNode", "ContentNode")

    for each categoryKey in keyArray
        if m.videosArray.DoesExist(categoryKey)
            categoryData = m.videosArray[categoryKey]
            if categoryData <> invalid and categoryData.Count() > 0
                rowArray = SubArr(categoryData, 0, 5)
                rowArray = ShuffleArray(rowArray)

                viewAll = {
                    Thumbnail: "pkg:/images/VAPH.png"
                    EpisodeURL: ""
                    EpisodeTitle: ""
                }
                rowArray.push(viewAll)

                rowNode = CreateObject("roSGNode", "ContentNode")
                rowNode.title = categoryKey

                i = 0
                for each video in rowArray
                    if video <> invalid and video.EpisodeTitle <> invalid
                        item = rowNode.createChild("RowItemData")
                        item.videoTitle = video.EpisodeTitle
                        item.videoUrl = video.EpisodeURL
                        item.videoThumbnail = video.Thumbnail
                        if video.isNew <> invalid
                            item.isNew = video.isNew
                        else
                            item.isNew = false
                        end if

                        if i < 5 or m.scene.isSubscribed
                            item.type = "Free"
                        else
                            item.type = "Paid"
                        end if

                        i++
                    end if
                end for

                videoGridContent.appendChild(rowNode)
            end if
        end if
    end for

    m.videosList.content = videoGridContent
    m.videosList.setFocus(true)
end sub

' sub setSpecificContent(index)
'     m.VideosArray = m.VideoArrayGetter.content
'     m.global.videoArray=m.videosArray
'      keyArray=m.VideoArrayGetter.content.keys()
'      heroData=m.videosArray[keyArray[index]]
'     heroArray = SubArr(heroData, 0, heroData.Count()-1)
'     heroArray=ShuffleArray(heroArray)

'     childNode = CreateObject("rosgNode", "ContentNode")

' i=0
'     for each video in heroArray
'          childContent = CreateObject("roSGNode", "RowItemData")
'         childContent.videoTitle = video.VideoTitle
'         childContent.videoUrl = video.VideoURL
'         childContent.videoThumbnail = video.VideoThumbnailURL
'         childNode.appendChild(childContent)
'         if i<5
'                 childContent.type="Free"
'             else
'                 childContent.type="Paid"

'             end if
'             i+=1


'     end for
'  m.videosGrid.content = childNode
'    m.videosGrid.setFocus(true)

' end sub

sub setSpecificContent(rowTitle as string)

    m.videosArray = m.VideoArrayGetter.content
    m.global.videoArray = m.videosArray

    ' Validate category exists
    if not m.videosArray.DoesExist(rowTitle) then
        ?"Category not found:" rowTitle
        return
    end if

    heroData = m.videosArray[rowTitle]

    heroArray = SubArr(heroData, 0, heroData.Count() - 1)
    heroArray = ShuffleArray(heroArray)

    childNode = CreateObject("roSGNode", "ContentNode")

    i = 0
    for each video in heroArray
        childContent = CreateObject("roSGNode", "RowItemData")
        childContent.videoTitle = video.EpisodeTitle
        childContent.videoUrl = video.EpisodeURL
        childContent.videoThumbnail = video.Thumbnail
    
        if i < 5 or m.scene.isSubscribed
            childContent.type = "Free"
        else
            childContent.type = "Paid"
        end if

        childNode.appendChild(childContent)
        i++
    end for

    m.videosGrid.content = childNode
    m.videosGrid.setFocus(true)

end sub


sub SetVideoListContent(idx)
    m.currentRow = idx
    ?"current Row"m.currentRow
    if m.videosGroup.translation[0] = 0 and m.videosGroup.translation[1] <> -460
        ?"in setVideo if"idx
        m.VideosArray = m.VideoArrayGetter.content
        m.global.videoArray = m.videosArray
        keyArray = m.VideoArrayGetter.content.keys()
        heroData = m.videosArray[keyArray[idx]]
        ?"Count" heroData.Count()
        heroArray = SubArr(heroData, 0, 4)
        viewAll = { "videoThumbnailURL": "pkg:/images/VAPH.png", "VideoURL": "", "VideoTitle": "" }
        heroArray.push(viewAll)
        videoGridContentHero = CreateObject("rosgNode", "ContentNode")
        childNode = CreateObject("rosgNode", "ContentNode")


        for each video in heroArray
            childContent = childNode.createChild("RowItemData")
            childContent.videoTitle = video.VideoTitle
            childContent.videoUrl = video.VideoURL
            childContent.videoThumbnail = video.VideoThumbnailURL


        end for
        videoGridContentHero.appendChild(childNode)

        m.videosList.content = videoGridContentHero
        m.videosList.setFocus(true)
        m.videosList.jumpToRowItem = [0, 0]


    else
        ?"in setVideo else"idx
        if m.currentRowTitle <> invalid
            setSpecificContent(m.currentRowTitle)
        end if

    end if



end sub

function SubArr(arr as object, startIndex as integer, endIndex) as object
    subArray = []

    if endIndex = invalid ' If endIndex is not provided
        endIndex = arr.count() ' Default to the length of the array
    end if

    for i = startIndex to endIndex - 1
        subArray.push(arr[i])
    end for

    return subArray
end function

sub revertButtons()
    m.blurOL.visible = false

    m.NBG.width = 198
    m.NBG.uri = "pkg:/images/NBC.png"

    m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoF.png"
    m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoF.png"
    m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaUF.png"
    m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaF.png"
    m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavUF.png"
    m.btnFavN.focusBitmapUri = "pkg:/images/btnfavF.png"
    m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubUF.png"
    m.btnSubN.focusBitmapUri = "pkg:/images/btnSubF.png"
    m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnSetUF.png"
    m.btnSettingN.focusBitmapUri = "pkg:/images/btnSetF.png"

end sub

function OnKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press


        if key = "left" and (m.videosList.hasFocus() or m.heroList.hasFocus() or m.btnCat1.hasFocus() or m.videosGrid.hasFocus())
            m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoUF.png"
            m.videosList.setFocus(false)
            m.heroList.setFocus(false)
            m.blurOL.visible = true

            m.NBG.width = 658
            m.NBG.uri = "pkg:/images/NBE.png"
            m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoS.png"
            m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoEF.png"
            m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaEUF.png"
            m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaEF.png"
            m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavEUF.png"
            m.btnFavN.focusBitmapUri = "pkg:/images/btnfavEF.png"
            m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubEUF.png"
            m.btnSubN.focusBitmapUri = "pkg:/images/btnSubEF.png"
            m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnSetEUF.png"
            m.btnSettingN.focusBitmapUri = "pkg:/images/btnSetEF.png"
            m.btnHomeN.setFocus(true)
            return true
        else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus())
            m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoF.png"
            m.top.setFocus(false)
            revertButtons()

            if m.videosGrid.visible

                m.videosGrid.setFocus(true)

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
        else if key = "back" and m.video.hasFocus()
            m.video.setFocus(false)
            m.video.control = "stop"
            m.video.visible = false
            if m.videosGrid.visible
                m.videosGrid.setFocus(true)

            else
                m.videosList.setFocus(true)
            end if
            return true

        else if key = "back" and m.AppLockPopup.hasFocus() 'and m.global.appDuration<  m.global.audioDurationLimit
            m.AppLockPopup.visible = false
            m.AppLockPopup.setFocus(false)
            if m.videosGrid.visible
                m.videosGrid.setFocus(true)
            else
                m.videosList.setFocus(true)
            end if
            return true
        else if key = "options" and (m.videosList.hasFocus() or m.videosGrid.hasFocus())
            if m.videoIndex.type = "Free"
                AddToFaves(m.videoIndex)
            end if
            return true
            '   else if key="up" and m.videosList.hasFocus() and m.currentRow=0
            '     m.videosList.setFocus(false)
            '     m.btnCat1.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=1
            '     m.videosList.setFocus(false)
            '     m.btnCat2.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=2
            '     m.videosList.setFocus(false)
            '     m.btnCat3.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=3
            '     m.videosList.setFocus(false)
            '     m.btnCat4.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=4
            '     m.videosList.setFocus(false)
            '     m.btnCat5.setFocus(true)

            '     return true
            '   else if key="up" and m.videosList.hasFocus() and m.currentRow=5
            ' m.videosList.setFocus(false)
            ' m.btnCat6.setFocus(true)

            ' return true
            ' else if key="up" and m.videosGrid.hasFocus() and m.currentRow=0
            ' m.videosGrid.setFocus(false)
            ' m.btnCat1.setFocus(true)

            ' return true
            ' else if key="up" and m.videosGrid.hasFocus() and m.currentRow=1
            ' m.videosGrid.setFocus(false)
            ' m.btnCat2.setFocus(true)

            ' return true
            ' else if key="up" and m.videosGrid.hasFocus() and m.currentRow=2
            ' m.videosGrid.setFocus(false)
            ' m.btnCat3.setFocus(true)

            ' return true
            ' else if key="up" and m.videosGrid.hasFocus() and m.currentRow=3
            ' m.videosGrid.setFocus(false)
            ' m.btnCat4.setFocus(true)

            ' return true
            ' else if key="up" and m.videosGrid.hasFocus() and m.currentRow=4
            ' m.videosGrid.setFocus(false)
            ' m.btnCat5.setFocus(true)

            ' return true
            '     else if key="up" and m.videosGrid.hasFocus() and m.currentRow=5
            ' m.videosGrid.setFocus(false)
            ' m.btnCat6.setFocus(true)

            ' return true
        else if key = "right" and m.btnCat1.hasFocus()
            m.btnCat1.setFocus(false)
            m.btnCat2.setFocus(true)

            return true
        else if key = "right" and m.btnCat2.hasFocus()
            m.btnCat2.setFocus(false)
            m.btnCat3.setFocus(true)

            return true
        else if key = "right" and m.btnCat3.hasFocus()
            m.btnCat3.setFocus(false)
            m.btnCat4.setFocus(true)

            return true
        else if key = "right" and m.btnCat4.hasFocus()
            m.btnCat4.setFocus(false)
            m.btnCat5.setFocus(true)

            return true
            '    else if key="right" and m.btnCat5.hasFocus()
            ' m.btnCat5.setFocus(false)
            ' m.btnCat6.setFocus(true)

            ' return true
        else if key = "left" and m.btnCat2.hasFocus()
            m.btnCat2.setFocus(false)
            m.btnCat1.setFocus(true)

            return true

        else if key = "left" and m.btnCat3.hasFocus()
            m.btnCat3.setFocus(false)
            m.btnCat2.setFocus(true)

            return true
        else if key = "left" and m.btnCat4.hasFocus()
            m.btnCat4.setFocus(false)
            m.btnCat3.setFocus(true)

            return true
        else if key = "left" and m.btnCat5.hasFocus()
            m.btnCat5.setFocus(false)
            m.btnCat4.setFocus(true)

            return true
            '   else if key="left" and m.btnCat6.hasFocus()
            ' m.btnCat6.setFocus(false)
            ' m.btnCat5.setFocus(true)

            ' return true
        else if key = "down" and (m.btnCat1.hasFocus() or m.btnCat2.hasFocus() or m.btnCat3.hasFocus() or m.btnCat4.hasFocus() or m.btnCat5.hasFocus() or m.btnCat6.hasFocus()) and m.videosList.visible
            m.btnCat1.setFocus(false)
            m.btnCat2.setFocus(false)
            m.btnCat3.setFocus(false)
            m.btnCat4.setFocus(false)
            m.btnCat5.setFocus(false)
            m.btnCat6.setFocus(false)

            m.videosList.setFocus(true)
            return true

        else if key = "down" and (m.btnCat1.hasFocus() or m.btnCat2.hasFocus() or m.btnCat3.hasFocus() or m.btnCat4.hasFocus() or m.btnCat5.hasFocus() or m.btnCat6.hasFocus()) and m.videosGrid.visible
            m.btnCat1.setFocus(false)
            m.btnCat2.setFocus(false)
            m.btnCat3.setFocus(false)
            m.btnCat4.setFocus(false)
            m.btnCat5.setFocus(false)
            m.btnCat6.setFocus(false)
            m.videosGrid.setFocus(true)
            return true

            '   else if key="down" and m.heroList.hasFocus()
            '     m.heroList.setFocus(false)
            '     m.videosList.setFocus(true)
            '     m.dotGroup.visible=false
            '     m.heroupAnim.control = "start"
            ' m.videosupAnim.control = "start"
            '     return true


            ' result = true
        else if key = "back" and m.videosGrid.visible = false
            'create the dialog
            dialog = createObject("roSGNode", "StandardMessageDialog")
            '.message is an array of messages
            dialog.title = "Are You Sure?"
            dialog.message = ["Do you really want to exit?"]
            dialog.buttons = ["Yes", "No"]
            'register a callback function for when a user clicks a button
            dialog.observeFieldScoped("buttonSelected", "onDialogButtonClicked")

            'assigning the dialog to m.scene.dialog will "show" the dialog
            m.scene.dialog = dialog
            return true

        else if key = "back" and m.videosGrid.visible
            m.herodownAnim.control = "start"
            m.videosdownAnim.control = "start"
            m.videosGrid.visible = false
            m.videosGrid.setFocus(false)
            m.videosList.visible = true
            m.top.findNode("focusTimer").observeField("fire", "setFocusOnVideoList")

            m.top.findNode("focusTimer").control = "start"

            return true


        end if


    end if
end function

sub setFocusOnVideoList()
    ' if m.currentRowTitle
    '  setSpecificContent(m.currentRowTitle)
    ' end if
    m.videosList.setFocus(true)

end sub


function onDialogButtonClicked(event)
    buttonIndex = event.getData()
    'did the user click "Yes"
    if buttonIndex = 0 then
        'set appExit which will exit main loop in main.brs
        m.scene.appExit = true
    else
        'close the dialog
        m.scene.dialog.close = true
        return true
    end if
end function

sub AddToFaves(itemContent as object)
    sec = CreateObject("roRegistrySection", "FaveReg")

    ' Create a JSON-safe object
    jsonItem = {
        videoTitle: itemContent.videoTitle,
        videoUrl: itemContent.videoUrl,
        videoThumbnail: itemContent.videoThumbnail
    }

    ' Read existing entries
    entries = []
    if sec.Exists("entries")
        storedJson = sec.Read("entries")
        if storedJson <> ""
            entries = ParseJson(storedJson)
        end if
    end if

    ' Remove duplicates
    filteredEntries = []
    for each entry in entries
        if entry.videoUrl <> jsonItem.videoUrl
            filteredEntries.Push(entry)
        end if
    end for

    ' Add new item
    filteredEntries.Push(jsonItem)

    ' Limit to 20 entries
    if filteredEntries.Count() > 20
        filteredEntries = filteredEntries.slice(filteredEntries.Count() - 20)
    end if

    ' Save to registry
    sec.Write("entries", FormatJson(filteredEntries))
    sec.Flush()

    ' Show confirmation dialog
    ShowFavoritesConfirmationDialog()
end sub

sub ShowFavoritesConfirmationDialog()
    dialog = CreateObject("roSGNode", "StandardMessageDialog")
    dialog.title = "Success"
    dialog.message = ["Video added to favorites."]
    dialog.buttons = ["OK"]
    dialog.observeField("buttonSelected", "OnDismissConfirmationDialog")

    m.scene.dialog = dialog
end sub

sub OnDismissConfirmationDialog()
    m.scene.dialog.close = true
end sub
