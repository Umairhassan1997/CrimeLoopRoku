sub init()
    m.thumbnailPoster=m.top.findNode("thumbnailPoster")
    m.videoTitle=m.top.findNode("videoTitle")
    m.focus=m.top.findNode("focus")
    m.badge=m.top.findNode("badge")

end sub

sub onItemContent()
    m.itemContent=m.top.itemContent

    
    m.thumbnailPoster.uri=m.itemContent.videoThumbnail
     m.videoTitle.text=m.itemContent.videoTitle
      if m.itemContent.type="Paid"
        m.badge.visible=true
    else
        m.badge.visible=false
    end if


end sub

sub changeFocus()
    if m.top.focusPercent>0.6 and m.top.rowHasFocus
        m.focus.visible=true
    else
        m.focus.visible=false


    end if

end sub