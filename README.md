# Fluent

Fluent Modded pronta para usar nos scripts.

## Loadstring

```lua
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/mainloadergg/Fluent/main/main.lua"))()
```

Addons (SaveManager, InterfaceManager, MediaManager, FloatingButtonManager) ja vem dentro do `main.lua`.

### Addons separados (opcional)

```lua
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/mainloadergg/Fluent/main/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/mainloadergg/Fluent/main/Addons/InterfaceManager.lua"))()
local MediaManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/mainloadergg/Fluent/main/Addons/MediaManager.lua"))()
local FloatingButtonManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/mainloadergg/Fluent/main/Addons/FloatingButtonManager.lua"))()
```

Fonte: [StyearX/Fluent-modded](https://github.com/StyearX/Fluent-modded) — MIT
