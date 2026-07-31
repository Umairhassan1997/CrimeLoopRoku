sub VerifySubscription()
    m.order_title = "CrimeLoop Monthly"
    m.order_identifier = "CrimeLoopMonthly"
    m.order_price = "3.99"

    m.global.AddField("channelStorecheck", "node", false)
    m.global.channelStorecheck = CreateObject("roSGNode", "ChannelStore")
    m.global.channelStorecheck.command = "getAllPurchases"
    m.global.channelStorecheck.ObserveField("purchases", "onGetPurchasesForChecking")
end sub

sub onGetPurchasesForChecking(event as object)
    m.global.channelStorecheck.UnobserveField("purchases")
    purchases = event.GetData()

    if purchases <> invalid and purchases.GetChildCount() > 0
        allPurchases = purchases.GetChildren(-1, 0)
        datetime = CreateObject("roDateTime")
        utimeNow = datetime.AsSeconds()

        for each purchase in allPurchases
            if purchase.code = "CrimeLoopMonthly" or purchase.code = "CrimeLoopYearly"
                datetime.FromISO8601String(purchase.expirationDate)
                utimeExpire = datetime.AsSeconds()
                m.expireTime = utimeExpire.ToStr()

                if utimeExpire > utimeNow
                    m.top.isSubscribed = true
                    ShowHomeScreen()
                    return
                else if purchase.inDunning = "true"
                    request = {}
                    request.command = "DoRecovery"
                    m.store = CreateObject("roSGNode", "ChannelStore")
                    m.store.observeField("requestStatus", "onRequestStatus")
                    m.store.request = request
                    return
                else
                    m.top.isSubscribed = false
                end if
            else
                m.top.isSubscribed = false
            end if
        end for
    else
        m.top.isSubscribed = false
    end if

    ShowHomeScreen()
end sub

function onRequestStatus()
    requestStatus = m.store.requestStatus
    if requestStatus = invalid
        m.top.isSubscribed = false
    else if requestStatus.status <> 1
        m.top.isSubscribed = false
    else
        VerifySubscription()
    end if
end function
