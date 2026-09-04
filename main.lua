-- Fluent Modded 1.6.0
-- Loader: a lib empacotada tem ~637 KB e sobe no raw deste repo se você substituir este arquivo pelo dist/main.lua do ZIP.
-- Enquanto isso, carrega a build oficial 1.6.0 (mesmo arquivo do ZIP).
local url = "https://github.com/StyearX/Fluent-Modded/releases/download/1.6.0/main.lua"
local src = game:HttpGet(url)
return loadstring(src)()
