local Root    = script.Parent.Parent
local Flipper = require(Root.Packages.Flipper)
local Creator = require(Root.Creator)
local New     = Creator.New

local Tab = {
	Window = nil,
	Tabs = {},
	Containers = {},
	SelectedTab = 0,
	TabCount = 0,
}

function Tab:Init(window)
	Tab.Window = window
	Tab.Tabs = {}
	Tab.Containers = {}
	Tab.SelectedTab = 0
	Tab.TabCount = 0
	return Tab
end

function Tab:GetCurrentTabPos()
	local w = Tab.Window
	local yW = w.TabHolder.AbsolutePosition.Y
	local yT = Tab.Tabs[Tab.SelectedTab].Frame.AbsolutePosition.Y
	return yT - yW
end

function Tab:New(title, iconKey, holder)
	local lib = require(Root)
	Tab.TabCount = Tab.TabCount + 1
	local idx = Tab.TabCount
	local iconData = nil
	if iconKey and iconKey ~= "" then iconData = lib:GetIcon(iconKey) end
	local t = { Selected = false, Name = title, Type = "Tab" }
	local textPos = iconData and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 12, 0.5, 0)
	t.Frame = New("TextButton", {
		Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Parent = holder, Text = "",
		ThemeTag = { BackgroundColor3 = "Tab" },
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 6) }),
		New("TextLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = textPos, Text = title, RichText = true, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -12, 1, 0), BackgroundTransparency = 1, ThemeTag = { TextColor3 = "Text" } }),
		New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(16, 16), Position = UDim2.new(0, 8, 0.5, 0), BackgroundTransparency = 1, Visible = iconData ~= nil, Image = iconData and (type(iconData) == "table" and iconData.Image or iconData) or "", ImageRectOffset = (iconData and type(iconData) == "table") and iconData.ImageRectOffset or Vector2.new(), ImageRectSize = (iconData and type(iconData) == "table") and iconData.ImageRectSize or Vector2.new(), ThemeTag = { ImageColor3 = "Text" } }),
	})
	local layout = New("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
	t.ContainerFrame = New("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = Tab.Window.ContainerHolder, Visible = false,
		ClipsDescendants = true, BottomImage = "rbxassetid://6889812791", MidImage = "rbxassetid://6889812721", TopImage = "rbxassetid://6276641225",
		ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255), ScrollBarImageTransparency = 0.85, ScrollBarThickness = 4,
		BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ScrollingDirection = Enum.ScrollingDirection.Y,
	}, {
		layout,
		New("UIPadding", { PaddingRight = UDim.new(0, 14), PaddingLeft = UDim.new(0, 4), PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4) }),
	})
	Creator.AddSignal(layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		t.ContainerFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 2)
	end)
	local _, setTransp = Creator.SpringMotor(1, t.Frame, "BackgroundTransparency")
	Creator.AddSignal(t.Frame.MouseEnter, function() setTransp(t.Selected and 0.85 or 0.89) end)
	Creator.AddSignal(t.Frame.MouseLeave, function() setTransp(t.Selected and 0.89 or 1) end)
	Creator.AddSignal(t.Frame.MouseButton1Down, function() setTransp(0.92) end)
	Creator.AddSignal(t.Frame.MouseButton1Up, function() setTransp(t.Selected and 0.85 or 0.89) end)
	Creator.AddSignal(t.Frame.MouseButton1Click, function() Tab:SelectTab(idx) end)
	t.SetTransparency = setTransp
	t.Container = t.ContainerFrame
	t.ScrollFrame = t.ContainerFrame
	Tab.Containers[idx] = t.ContainerFrame
	Tab.Tabs[idx] = t
	function t:AddSection(sectionTitle, iconKey)
		local sec = { Type = "Section" }
		local raw = require(Root.Components.Section)(sectionTitle, iconKey, t.ContainerFrame)
		sec.Container = raw.Container
		sec.ScrollFrame = t.ContainerFrame
		setmetatable(sec, lib.Elements)
		return sec
	end
	setmetatable(t, lib.Elements)
	return t
end

function Tab:SelectTab(idx)
	local w = Tab.Window
	Tab.SelectedTab = idx
	for _, tabObj in pairs(Tab.Tabs) do tabObj.SetTransparency(1); tabObj.Selected = false end
	Tab.Tabs[idx].SetTransparency(0.89)
	Tab.Tabs[idx].Selected = true
	w.TabDisplay.Text = Tab.Tabs[idx].Name
	w.SelectorPosMotor:setGoal(Flipper.Spring.new(Tab:GetCurrentTabPos(), { frequency = 6 }))
	task.spawn(function()
		w.ContainerPosMotor:setGoal(Flipper.Spring.new(110, { frequency = 10 }))
		w.ContainerBackMotor:setGoal(Flipper.Spring.new(1, { frequency = 10 }))
		task.wait(0.15)
		for _, cf in pairs(Tab.Containers) do
			cf.Visible = false
			for _, vf in ipairs(cf:GetDescendants()) do
				if vf:IsA("VideoFrame") then pcall(function() vf.Volume = 0 end) end
			end
		end
		Tab.Containers[idx].Visible = true
		w.ContainerPosMotor:setGoal(Flipper.Spring.new(90, { frequency = 10 }))
		w.ContainerBackMotor:setGoal(Flipper.Spring.new(0, { frequency = 10 }))
	end)
end

return Tab
