sub init()
    m.top.functionName = "JsontoContent"
end sub

sub JsontoContent()
    jsonText = ReadAsciiFile("pkg:/json/home.json")
    if jsonText = invalid or jsonText = ""
        ?"GetJsonTask: failed to read pkg:/json/home.json"
        return
    end if

    json = ParseJson(jsonText)
    if json <> invalid
        m.top.content = json
    else
        ?"GetJsonTask: failed to parse home.json"
    end if
end sub
