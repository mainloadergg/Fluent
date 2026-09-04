local Root    = script.Parent.Parent
local Creator = require(Root.Creator)
local New     = Creator.New

return function(parent, compact)
	local tb = {}

	tb.Input = New("TextBox", {
		FontFace             = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		TextSize             = 13,
		TextColor3           = Color3.fromRGB(240, 240, 240),
		PlaceholderColor3    = Color3.fromRGB(120, 120, 140),
		TextXAlignment       = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Size                 = UDim2.new(1, -16, 1, 0),
		Position             = UDim2.fromOffset(8, 0),
		ClearTextOnFocus     = false,
		ThemeTag             = { TextColor3 = "Text", PlaceholderColor3 = "SubText" },
	})

	tb.Indicator = New("Frame", {
		Size                 = UDim2.new(1, 0, 0, 1),
		AnchorPoint          = Vector2.new(0, 1),
		Position             = UDim2.fromScale(0, 1),
		BackgroundTransparency = 1,
		ThemeTag             = { BackgroundColor3 = "InputIndicator" },
	})

	tb.Frame = New("Frame", {
		Size                 = UDim2.fromOffset(160, compact and 30 or 36),
		BackgroundTransparency = 0.85,
		Parent               = parent,
		ThemeTag             = { BackgroundColor3 = "Input" },
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 5) }),
		New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Transparency    = 0.6,
			ThemeTag        = { Color = "InElementBorder" },
		}),
		tb.Indicator,
		tb.Input,
	})

	Creator.AddSignal(tb.Input.Focused, function()
		tb.Indicator.BackgroundTransparency = 0
	end)
	Creator.AddSignal(tb.Input.FocusLost, function()
		tb.Indicator.BackgroundTransparency = 1
	end)

	return tb
end
