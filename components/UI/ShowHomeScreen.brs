sub ShowHomeScreen()
    m.global.analytics.callFunc("logEvent", "home_screen_opened", {
            "screen_name": "OnboardingScreen"
        })
 m.HomeScreen = CreateObject("roSGNode","HomeScreen")

    ShowScreen(m.HomeScreen)
end sub