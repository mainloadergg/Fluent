local Root    = script.Parent.Parent
local Flipper = require(Root.Packages.Flipper)
local Creator = require(Root.Creator)
local New     = Creator.New

local Notification = { Holder = nil }

function Notification:Init(gui)
	Notification.Holder = New("Frame", {
		AnchorPoint = Vector2.new(1, 1),
		Size = UDim2.new(0, 300, 1, -20),
		Position = UDim2.new(1, -20, 1, -20),
		BackgroundTransparency = 1,
		Parent = gui,
	}, {
		New("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }),
	})
	return Notification
end

local TypeColor = {
	Info = Color3.fromRGB(76, 194, 255),
	Success = Color3.fromRGB(50, 205, 80),
	Warning = Color3.fromRGB(255, 185, 30),
	Error = Color3.fromRGB(220, 55, 55),
}

function Notification:New(config)
	config = config or {}
	config.Title = config.Title or "Notification"
	config.Content = config.Content or ""
	config.SubContent = config.SubContent or ""
	config.Duration = config.Duration or nil
	local lib = require(Root)
	local n = { Closed = false }
	local stripeCol = TypeColor[config.Type or "Info"] or TypeColor.Info
	local stripe = New("Frame", { Size = UDim2.new(0, 3, 1, -16), Position = UDim2.new(0, 6, 0, 8), BackgroundColor3 = stripeCol, BorderSizePixel = 0, ZIndex = 10 })
	New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = stripe })
	local iconOffset = 14
	if config.Icon and lib and lib.GetIcon then
		local ic = lib:GetIcon(config.Icon)
		if ic then
			local iconImg = New("ImageLabel", { Size = UDim2.fromOffset(20, 20), Position = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, ZIndex = 10, ThemeTag = { ImageColor3 = "SubText" } })
			if type(ic) == "table" then
				iconImg.Image = ic.Image or ""; iconImg.ImageRectOffset = ic.ImageRectOffset or Vector2.new(); iconImg.ImageRectSize = ic.ImageRectSize or Vector2.new()
			else iconImg.Image = tostring(ic) end
			iconOffset = 40; n._iconImg = iconImg
		end
	end
	n.Title = New("TextLabel", { Position = UDim2.fromOffset(iconOffset, 17), Text = config.Title, RichText = true, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, Size = UDim2.new(1, -iconOffset - 12, 0, 12), TextWrapped = true, BackgroundTransparency = 1, ThemeTag = { TextColor3 = "Text" } })
	n.ContentLabel = New("TextLabel", { FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"), Text = config.Content, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, TextWrapped = true, ThemeTag = { TextColor3 = "Text" } })
	n.SubContentLabel = New("TextLabel", { FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"), Text = config.SubContent, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, TextWrapped = true, Visible = config.SubContent ~= "", ThemeTag = { TextColor3 = "SubText" } })
	n.LabelHolder = New("Frame", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 40), Size = UDim2.new(1, -28, 0, 0) }, {
		New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 3) }),
		n.ContentLabel, n.SubContentLabel,
	})
	n.CloseButton = New("TextButton", { Text = "", Position = UDim2.new(1, -14, 0, 13), Size = UDim2.fromOffset(20, 20), AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1 }, {
		New("ImageLabel", { Image = require(Root.Components.Assets).Close, Size = UDim2.fromOffset(16, 16), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ThemeTag = { ImageColor3 = "Text" } }),
	})
	local copyBtn = New("TextButton", { Text = "", Position = UDim2.new(1, -38, 0, 13), Size = UDim2.fromOffset(20, 20), AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1 }, {
		New("ImageLabel", { Image = "rbxassetid://10709798574", Size = UDim2.fromOffset(14, 14), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ThemeTag = { ImageColor3 = "SubText" } }),
	})
	Creator.AddSignal(copyBtn.MouseButton1Click, function()
		pcall(function()
			local txt = tostring(config.Content or "")
			if config.SubContent and config.SubContent ~= "" then txt = txt .. "\n" .. config.SubContent end
			toclipboard(txt)
		end)
	end)
	local bgFrame = New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(20, 20, 28), BackgroundTransparency = 0.1 }, {
		New("UICorner", { CornerRadius = UDim.new(0, 8) }),
		New("UIStroke", { Transparency = 0.6, ThemeTag = { Color = "InElementBorder" } }),
	})
	local rootChildren = { bgFrame, stripe, n.Title, n.CloseButton, copyBtn, n.LabelHolder }
	if n._iconImg then table.insert(rootChildren, n._iconImg) end
	n.Root = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Position = UDim2.fromScale(1, 0) }, rootChildren)
	n.Holder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 200), Parent = Notification.Holder }, { n.Root })
	local motor = Flipper.GroupMotor.new({ Scale = 1, Offset = 60 })
	motor:onStep(function(val) n.Root.Position = UDim2.new(val.Scale, val.Offset, 0, 0) end)
	Creator.AddSignal(n.CloseButton.MouseButton1Click, function() n:Close() end)
	function n:Open()
		local contentH = n.LabelHolder.AbsoluteSize.Y
		n.Holder.Size = UDim2.new(1, 0, 0, 58 + contentH)
		motor:setGoal({ Scale = Flipper.Spring.new(0, { frequency = 5 }), Offset = Flipper.Spring.new(0, { frequency = 5 }) })
	end
	function n:Close()
		if n.Closed then return end
		n.Closed = true
		task.spawn(function()
			motor:setGoal({ Scale = Flipper.Spring.new(1, { frequency = 5 }), Offset = Flipper.Spring.new(60, { frequency = 5 }) })
			task.wait(0.4)
			n.Holder:Destroy()
		end)
	end
	n:Open()
	if config.Duration then task.delay(config.Duration, function() n:Close() end) end
	return n
end

return Notification
