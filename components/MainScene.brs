sub init()
      m.global.AddField("videoDurationLimit","integer",false)

              m.global.AddField("audioDurationLimit","integer",false)
          m.global.audioDurationLimit= 240
        m.AppTimer=m.top.findNode("appTimer")
           m.appTimer.observeField("fire","onAppTimerFire")
           m.appTimer.control="start"

        m.global.AddField("RAT","boolean",false)
    m.global.RAT=true
            m.global.AddField("appDuration","integer",false)
    m.global.AddField("appName","string",false)
    m.global.appName="CalmBlue"
         m.global.observeField("appDuration","checkAppDuration")


    m.global.videoDurationLimit=240
    m.global.AddField("duration","integer",false)
    m.global.AddField("videoArray","assocarray",false)
        m.global.videoArray={}
 m.global.duration=(getCurrentDuration()).toInt()
    m.global.observeField("duration","checkCurrentDuration")
InitScreenStack()
SetupGoogleAnalytics4()

  reg = CreateObject("roRegistrySection", m.global.appName)
         
          if reg.Exists("optionSelected")=false
             ShowTrialScreen()
          else
            VerifySubscription()
           


          end if
end sub

sub SetupGoogleAnalytics4()
    m.global.AddField("analytics", "node", false)
    m.global.analytics = CreateObject("roSGNode", "GoogleAnalytics")
    m.global.analytics.callFunc("initialize", {

        measurementId: "G-Q2GJ9M6Q5R"
        appName: "ngkApp"
        docLocation: "https://www.google.com"
        customArgs: {}
    })
    m.global.analytics.callFunc("start")
end sub

sub checkCurrentDuration()
    if m.global.duration>=m.global.videoDurationLimit and m.top.isSubscribed=false
        m.screenStack=[]
         ShowSubscriptionScreen()
        m.global.UnobserveField("duration")

        

    end if

end sub

sub ResetScreen()
m.screenStack=[]
ShowHomeScreen()

end sub

function getCurrentDuration()
    today=GetTodayShortDate()
    sec=CreateObject("roregistrySection","SR"+today)
    if sec.Exists("duration")
        currentDuration=sec.Read("duration")
        return currentDuration
    else return "1"

    end if

end function

sub startCountDown()
    ?"called 2"
     

     m.appTimer.control="start"
     m.global.observeField("RAT","restartAppTimer")
   
end sub



sub checkAppDuration()

        if m.global.appDuration=100 and m.top.isSubscribed=false and isUserFirst()
            

            ShowSettingScreen()
            m.SettingScreen.isRateUs=true
        end if

end sub

function isUserFirst()
        sec=CreateObject("roregistrySection","SR")
        if sec.Exists("First")
            return false
        else
            sec.Write("First","First")
            return true
        end if

  

end function


sub onAppTimerFire()

    
     m.global.appDuration+=1



end sub
 


function GetTodayShortDate() as String
    dt = CreateObject("roDateTime")
    dt.ToLocalTime()  ' Optional: only if you want local date instead of UTC

    year = dt.GetYear().ToStr()
    month = dt.GetMonth().ToStr()
    day = dt.GetDayOfMonth().ToStr()

    ' Pad month and day to two digits
    if month.Len() = 1 then month = "0" + month
    if day.Len() = 1 then day = "0" + day

    return year  + month +  day
end function

sub setCurrentDuration()
    today=GetTodayShortDate()
    sec=CreateObject("roregistrySection","SR"+today)
    if sec.Exists("duration")
        currentDuration=sec.Read("duration")
        updatedDuration=currentDuration.toInt()+1
        m.global.duration=updatedDuration
        ?"duration"updatedDuration
        sec.Write("duration",updatedDuration.toStr())
    else 
         sec.Write("duration","1")

    end if

end sub

function OnKeyEvent(key as string, press as boolean) as boolean
   result = false
   if press
       ' handle "back" key press
       if key = "back"
           ?"Back Pressed Event in MainScene"
           numberOfScreens = m.screenStack.Count()
           ?"number of screens"numberOfScreens
           ' close top screen if there are two or more screens in the screen stack
           if numberOfScreens > 1
           

               CloseScreen(invalid)
               result = true
           

           end if



       end if
   end if
 
   return result
end function