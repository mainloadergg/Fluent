local Root    = script.Parent.Parent
local Creator = require(Root.Creator)
local New     = Creator.New

local Dialog = { Window = nil }

function Dialog:Init(window)
	Dialog.Window = window
	return Dialog
end

function Dialog:Create()
	local lib = require(Root)
	local d = { Buttons = 0 }
	d.TintFrame = New("TextButton", { Text = "", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Parent = Dialog.Window.Root }, { New("UICorner", { CornerRadius = UDim.new(0, 8) }) })
	local _, setTint = Creator.SpringMotor(1, d.TintFrame, "BackgroundTransparency", true)
	d.ButtonHolder = New("Frame", { Size = UDim2.new(1, -40, 1, -40), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), BackgroundTransparency = 1 }, {
		New("UIListLayout", { Padding = UDim.new(0, 10), FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	d.ButtonHolderFrame = New("Frame", { Size = UDim2.new(1, 0, 0, 70), Position = UDim2.new(0, 0, 1, -70), ThemeTag = { BackgroundColor3 = "DialogHolder" } }, {
		New("Frame", { Size = UDim2.new(1, 0, 0, 1), ThemeTag = { BackgroundColor3 = "DialogHolderLine" } }),
		d.ButtonHolder,
	})
	d.Title = New("TextLabel", { FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold), Text = "Dialog", TextSize = 22, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, 22), Position = UDim2.fromOffset(20, 25), BackgroundTransparency = 1, ThemeTag = { TextColor3 = "Text" } })
	local scale = New("UIScale", { Scale = 1 })
	local _, setScale = Creator.SpringMotor(1.1, scale, "Scale")
	d.Root = New("CanvasGroup", { Size = UDim2.fromOffset(300, 165), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), GroupTransparency = 1, Parent = d.TintFrame, ThemeTag = { BackgroundColor3 = "Dialog" } }, {
		New("UICorner", { CornerRadius = UDim.new(0, 8) }),
		New("UIStroke", { Transparency = 0.5, ThemeTag = { Color = "DialogBorder" } }),
		scale, d.Title, d.ButtonHolderFrame,
	})
	local _, setRootTransp = Creator.SpringMotor(1, d.Root, "GroupTransparency")
	function d:Open() lib.DialogOpen = true; scale.Scale = 1.1; setTint(0.75); setRootTransp(0); setScale(1) end
	function d:Close() lib.DialogOpen = false; setTint(1); setRootTransp(1); setScale(1.1); task.wait(0.15); d.TintFrame:Destroy() end
	function d:Button(title, callback)
		d.Buttons = d.Buttons + 1; title = title or "Button"; callback = callback or function() end
		local btn = require(Root.Components.Button)(title, d.ButtonHolder, true)
		for _, b in ipairs(d.ButtonHolder:GetChildren()) do
			if b:IsA("TextButton") then b.Size = UDim2.new(1 / d.Buttons, -((d.Buttons - 1) * 10) / d.Buttons, 0, 32) end
		end
		Creator.AddSignal(btn.Frame.MouseButton1Click, function() lib:SafeCallback(callback); pcall(function() d:Close() end) end)
		return btn
	end
	function d:Input(placeholder)
		local tb = require(Root.Components.Textbox)(d.Root, false)
		tb.Frame.Size = UDim2.new(1, -40, 0, 36); tb.Frame.Position = UDim2.fromOffset(20, 60); tb.Frame.Parent = d.Root
		tb.Input.PlaceholderText = placeholder or ""
		d._inputBox = tb.Input
	end
	function d:GetInputValue() return d._inputBox and d._inputBox.Text or "" end
	return d
end

return Dialog
