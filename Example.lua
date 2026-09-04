local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/mainloadergg/Fluent/main/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fluent",
    SubTitle = "mainloadergg",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl,
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

Tabs.Main:AddParagraph({
    Title = "Lib carregada",
    Content = "Use este Example como base dos seus scripts.",
})

SaveManager:SetLibrary(Fluent)
SaveManager:SetFolder("Fluent/Config")
SaveManager:IgnoreThemeSettings()
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("Fluent")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
InterfaceManager:LoadSettings()
