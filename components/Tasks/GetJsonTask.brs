sub init()
m.top.functionname="JsontoContent"
end sub

sub jsontoContent()
     xfer = CreateObject("roURLTransfer")
  xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
  xfer.SetURL("https://cdn.jsdelivr.net/gh/shahzain888/JsonCDN@main/123.json")
  ' xfer.SetURL("https://devtest-storage.b-cdn.net/Roku/KT/Jsons/as.json")
  rsp = xfer.GetToString()
  json = ParseJson(rsp)
  if json<>invalid
    m.top.content=json
  end if

end sub