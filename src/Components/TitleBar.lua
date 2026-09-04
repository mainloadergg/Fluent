local Root    = script.Parent.Parent
local Creator = require(Root.Creator)
local Assets  = require(Root.Components.Assets)
local New     = Creator.New

return function(config)
	local tb = {}
	config = config or {}
	local function iconBtn(image, size)
		return New("TextButton", {
			Size = UDim2.fromOffset(size or 28, size or 28), BackgroundTransparency = 0.85, Text = "",
			ThemeTag = { BackgroundColor3 = "Tab" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 5) }),
			New("UIStroke", { Transparency = 0.5, Thickness = 1, ThemeTag = { Color = "InElementBorder" } }),
			New("ImageLabel", { Name = "Icon", Size = UDim2.fromOffset(14, 14), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Image = image, ThemeTag = { ImageColor3 = "SubText" } }),
		})
	end
	tb.MinButton = iconBtn(Assets.Min)
	tb.MaxButton = iconBtn(Assets.Max)
	tb.CloseButton = New("TextButton", {
		Size = UDim2.fromOffset(28, 28), BackgroundColor3 = Color3.fromRGB(200, 50, 50), BackgroundTransparency = 0.4, Text = "",
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 5) }),
		New("ImageLabel", { Name = "Icon", Size = UDim2.fromOffset(14, 14), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Image = Assets.Close, ThemeTag = { ImageColor3 = "Text" } }),
	})
	tb.Frame = New("Frame", { Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, Parent = config.Parent }, {
		New("TextLabel", { FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold), Text = config.Title or "", TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -100, 0, 22), Position = UDim2.fromOffset(14, 10), BackgroundTransparency = 1, ThemeTag = { TextColor3 = "Text" } }),
		New("TextLabel", { FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"), Text = config.SubTitle or "", TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -100, 0, 14), Position = UDim2.fromOffset(14, 28), BackgroundTransparency = 1, ThemeTag = { TextColor3 = "SubText" } }),
		New("Frame", { Size = UDim2.new(0, 0, 0, 1), AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), BackgroundTransparency = 0, ThemeTag = { BackgroundColor3 = "TitleBarLine" } }),
		New("Frame", { Size = UDim2.new(0, 0, 1, -10), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), BackgroundTransparency = 1 }, {
			New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }),
			tb.MinButton, tb.MaxButton, tb.CloseButton,
		}),
	})
	return tb
end
