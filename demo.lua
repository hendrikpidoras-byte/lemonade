-- Universelle Version (funktioniert mit den meisten Executors)
local success, err = pcall(function()
    request({
        Url = "https://nexusrec.netlify.app/",
        Method = "GET"
    })
end)

if not success then
    warn("Fehler beim Öffnen der Website: " .. err)
end
