sub init()
  m.top.functionName = "fixPlaylist"
end sub

sub fixPlaylist()
  url = m.top.url

  xfer = CreateObject("roURLTransfer")
  xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
  xfer.SetURL(url)
  rsp = xfer.GetToString()

  if rsp = invalid or rsp = "" then
    print "Failed to fetch playlist"
     m.global.analytics.callFunc("logEvent", "video_loading_failed", {
        "screen_name": "OnboardingScreen"})
    return
  end if

  lines = rsp.tokenize(chr(10))
  fixedLines = []
  baseUrl = GetBaseUrl(url)

  for each line in lines
    line = line.trim()
    if line.len() = 0 then
      fixedLines.push("")
    else if line.left(1) = "#" then
      fixedLines.push(line)
    else
      encodedLine = EncodeUri(line)
      fixedLines.push(baseUrl + encodedLine)
    end if
  end for

  fixedM3U8 = fixedLines.join(chr(10))
  ba = CreateObject("roByteArray")
  ba.FromAsciiString(fixedM3U8)
  fs = CreateObject("roFileSystem")
 fixedPath = WriteFixedM3U8(fixedM3U8)


  ' Return path to the modified playlist
  m.top.fixedUrl = "tmp:/fixed.m3u8"
end sub

function GetBaseUrl(url as String) as String
    for i = len(url) to 1 step -1
        if mid(url, i, 1) = "/" then
            return left(url, i)
        end if
    end for
    return url
end function

function EncodeUri(str as String) as String
  return str.replace(" ", "%20").replace(",", "%2C")
end function

function WriteFixedM3U8(content as String) as String
    filePath = "tmp:/fixed.m3u8"

    result = WriteAsciiFile(filePath, content)
    if result then
        return filePath
    else
        print "ERROR: Failed to write file"
        return ""
    end if
end function
