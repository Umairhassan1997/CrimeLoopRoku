sub navBarInit(screenName as String)

    m.screenName=screenName
    M.Nbg=m.top.findNode("NBG")
   m.scene= m.top.getScene()
    ?"Screen Name"m.screenName
    m.btnSubN=m.top.findNode("btnSubN")
    m.btnHomeN=m.top.findNode("btnHomeN")
    m.btnFavN=m.top.findNode("btnFavN")
    m.btnSettingN=m.top.findNode("btnSettingN")
    m.btnSearchN=m.top.findNode("btnSearchN")
     m.AppLockPopup=m.top.findNode("AppLockPopup")
    m.AppLockPopup.observeField("buttonSelected","ShowSubscriptionScreen")
    ' m.btnSubN=m.top.findNode("btnSubN")
   if m.screenName<>"Sub"
    ?"NB1"
    m.btnSubN.observeField("buttonSelected","ShowSubscriptionScreenByPress")
   else
     ?"subn"m.btnSubN
    m.btnSubN.focusfootprintbitmapuri="pkg:/images/btnSubF.png"

   end if
   if  m.screenName<>"Home"
    ?"NB2"
    m.btnHomeN.observeField("buttonSelected","ShowHomeScreen")
     else
    m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoF.png"

   end if

   if m.screenName<>"Search"
    ?"NB3"
    m.btnSearchN.observeField("buttonSelected","ShowSearchScreen")
   else
        m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaF.png"

   end if
  

   if m.screenName<>"Favorite"
    ?"NB5"
    m.btnFavN.observeField("buttonSelected","ShowFavoriteScreen")
   else
        m.btnFavN.focusfootprintbitmapuri="pkg:/images/btnFavF.png"

   end if

   if m.screenName<>"Setting"
    ?"NB5"
    m.btnSettingN.observeField("buttonSelected","ShowSettingScreen")

   else
        m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetF.png"


   end if

'    m.scene=m.top.getScene()


end sub

sub EndUserTrial()
        sec = CreateObject("roRegistrySection", "RecentRegCalmApp")
        sec.Write("trialEnded","true")
        sec.Flush()


end sub

function isTrialEnded()

            sec = CreateObject("roRegistrySection", "RecentRegCalmApp")
            if sec.Exists("trialEnded")
                return true

            end if
            return false



end function

sub ShowHomeScreen()
    ' if m.global.appDuration>=  m.global.audioDurationLimit and m.scene.isSubscribed=false
    '             ShowDialogToUser()

    '         else
     m.btnHomeN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowHomeScreen")


            ' end if

           
        

end sub


sub ShowSearchScreen()
 
    ' if m.global.appDuration>=  m.global.audioDurationLimit and m.scene.isSubscribed=false
    '            ShowDialogToUser()

    '         else
        m.btnSearchN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowSearchScreen")


            ' end if

          
end sub

sub ShowFavoriteScreen()
    ' if m.global.appDuration>=  m.global.audioDurationLimit and m.scene.isSubscribed=false
    '            ShowDialogToUser()

    '         else
    m.scene.callFunc("ShowFavoriteScreen")
            ' end if
    m.btnFavN.unobserveField("buttonSelected")

end sub

sub ShowSettingScreen()
    m.scene.callFunc("ShowSettingScreen")
    m.btnSettingN.unobserveField("buttonSelected")

end sub



' sub ShowInputScreen()
'     if m.scene.isSubscribed=false and m.global.appLaunchCount>m.scene.AppLimit
'                 ShowDialogToUser()

'             else
    
'     m.scene.callFunc("ShowAggregatorScreen")

'             end if
'     m.btnInputN.unobserveField("buttonSelected")

' end sub

sub ShowSubscriptionScreenByPress()
        m.scene.isSubScreenSelected=true
 
        ShowSubscriptionScreen()


end sub


sub ShowSubscriptionScreen()
 if m.subscriptionDialog<>invalid and m.subscriptionDialog.buttonSelected=0

        m.subscriptionDialog.close=true
        end if
    m.scene.callFunc("ShowSubscriptionScreen")
    m.btnSubN.unobserveField("buttonSelected")




end sub

sub ShowDialogToUser()
      m.AppLockPopup.visible=true
         m.AppLockPopup.setFocus(true)
end sub

' sub ShowEmptyDialogToUser()
'     if m.emptyDialog=invalid
'     m.emptyDialog = createObject("roSGNode", "StandardMessageDialog")
'     end if
'     m.emptyDialog.title = "Add A Playlist"
'     m.emptyDialog.message = ["There are no playlists added right now. Please Add atleast 1 Playlist to Continue."]
'     m.emptyDialog.buttons = ["OK"]

'     ' observe the dialog's buttonSelected field to handle button selections
'     m.emptyDialog.observeField("buttonSelected", "onEmptyDialog")
    
'     m.scene.dialog = m.emptyDialog


' end sub

' sub onEmptyDialog()
'     m.emptyDialog.close=true
   

' end sub

' function hasPlaylists() as Boolean
'     sec = CreateObject("roRegistrySection", "PlaylistReg")
    
'     if sec.Exists("playlistNames")
'         storedNames = sec.Read("playlistNames")
'         if storedNames <> ""
'             playlistList = ParseJson(storedNames)
'             if playlistList.Count() > 0
'                 return true
'             end if
'         end if
'     end if

'     return false
' end function
