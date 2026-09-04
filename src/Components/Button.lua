local Root = script.Parent.Parent
local Flipper = require(Root.Packages.Flipper)
local Creator = require(Root.Creator)
local New = Creator.New

return function(title, parent, isDialog)
	local btn = {}

	btn.Title = New("TextLabel", {
		FontFace             = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		Text                 = title or "",
		TextColor3           = Color3.fromRGB(200, 200, 200),
		TextSize             = 14,
		TextWrapped          = true,
		TextXAlignment       = Enum.TextXAlignment.Center,
		TextYAlignment       = Enum.TextYAlignment.Center,
		BackgroundTransparency = 1,
		AutomaticSize        = Enum.AutomaticSize.Y,
		Size                 = UDim2.fromScale(1, 1),
		ThemeTag             = { TextColor3 = "Text" },
	})

	btn.HoverFrame = New("Frame", {
		Size                 = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ThemeTag             = { BackgroundColor3 = "Hover" },
	}, { New("UICorner", { CornerRadius = UDim.new(0, 4) }) })

	btn.Frame = New("TextButton", {
		Size    = UDim2.new(0, 0, 0, 32),
		Parent  = parent,
		Text    = "",
		ThemeTag = { BackgroundColor3 = "DialogButton" },
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 4) }),
		New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Transparency    = 0.65,
			ThemeTag        = { Color = "DialogButtonBorder" },
		}),
		btn.HoverFrame,
		btn.Title,
	})

	local _, setHover = Creator.SpringMotor(1, btn.HoverFrame, "BackgroundTransparency", isDialog)
	Creator.AddSignal(btn.Frame.MouseEnter,        function() setHover(0.97) end)
	Creator.AddSignal(btn.Frame.MouseLeave,        function() setHover(1)    end)
	Creator.AddSignal(btn.Frame.MouseButton1Down,  function() setHover(1)    end)
	Creator.AddSignal(btn.Frame.MouseButton1Up,    function() setHover(0.97) end)

	return btn
end
