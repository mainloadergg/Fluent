local Root    = script.Parent.Parent
local Creator = require(Root.Creator)
local New     = Creator.New

return function(title, iconKey, container)
	if type(iconKey) ~= "string" then container = iconKey; iconKey = nil end
	local m = {}
	m.Layout = New("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
	m.Container = New("Frame", { Size = UDim2.new(1, 0, 0, 26), Position = UDim2.fromOffset(0, 24), BackgroundTransparency = 1 }, { m.Layout })
	local headerChildren = {}
	if iconKey then
		local lib = require(Root)
		local ic = lib and lib:GetIcon(iconKey)
		if ic then
			local ico = New("ImageLabel", {
				Size = UDim2.fromOffset(16, 16), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(0, 11),
				BackgroundTransparency = 1, ThemeTag = { ImageColor3 = "SubText" },
			})
			if type(ic) == "table" then
				ico.Image = ic.Image or ""; ico.ImageRectOffset = ic.ImageRectOffset or Vector2.new(); ico.ImageRectSize = ic.ImageRectSize or Vector2.new()
			else ico.Image = tostring(ic) end
			table.insert(headerChildren, ico)
		end
	end
	local titleOffset = iconKey and 22 or 0
	local titleLabel = New("TextLabel", {
		RichText = true, Text = title or "", FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold),
		TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
		Size = UDim2.new(1, -(16 + titleOffset), 0, 18), Position = UDim2.fromOffset(titleOffset, 2),
		BackgroundTransparency = 1, ThemeTag = { TextColor3 = "Text" },
	})
	table.insert(headerChildren, titleLabel); table.insert(headerChildren, m.Container)
	m.Root = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26), LayoutOrder = 7, Parent = container }, headerChildren)
	Creator.AddSignal(m.Layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		m.Container.Size = UDim2.new(1, 0, 0, m.Layout.AbsoluteContentSize.Y)
		m.Root.Size = UDim2.new(1, 0, 0, m.Layout.AbsoluteContentSize.Y + 25)
	end)
	return m
end
