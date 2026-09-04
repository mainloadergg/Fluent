local Root    = script.Parent.Parent
local Creator = require(Root.Creator)
local New     = Creator.New

return function(title, description, container, clickable)
	local el = {}
	local class = clickable and "TextButton" or "Frame"
	el.Border = New("UIStroke", { Transparency = 0.7, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, ThemeTag = { Color = "InElementBorder" } })
	el.Frame = New(class, {
		Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 0.85, Parent = container, Text = "",
		ThemeTag = { BackgroundColor3 = "Element" },
	}, { New("UICorner", { CornerRadius = UDim.new(0, 5) }), el.Border })
	el.Title = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
		Text = title or "", TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -10, 0, 14), Position = UDim2.fromOffset(10, 8),
		BackgroundTransparency = 1, Parent = el.Frame, ThemeTag = { TextColor3 = "Text" },
	})
	el.DescLabel = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		Text = description or "", TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
		Size = UDim2.new(1, -10, 0, 14), Position = UDim2.fromOffset(10, 22),
		BackgroundTransparency = 1, Visible = description ~= nil and description ~= "",
		Parent = el.Frame, ThemeTag = { TextColor3 = "SubText" },
	})
	if description and description ~= "" then el.Frame.Size = UDim2.new(1, 0, 0, 52) end
	el.LabelHolder = el.Title
	function el:SetTitle(text) el.Title.Text = text or "" end
	function el:SetDesc(text) el.DescLabel.Text = text or ""; el.DescLabel.Visible = text ~= nil and text ~= "" end
	function el:Destroy() el.Frame:Destroy() end
	return el
end
