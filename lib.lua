local Add = {}

local Color_Table = {
	["Background"] = Color3.fromRGB(50, 50, 50),
	["Active"] = Color3.fromRGB(35, 35, 35),
	["Border"] = Color3.fromRGB(102, 48, 106),
	["Text"] = Color3.fromRGB(255, 255, 255) 
}

function String_Table(String, Table)
	local bool = false
	for _, z in next, Table do
		if z == string.sub(string.lower(String), 1, #z) then
			bool = true
		end
	end
	return bool
end

function Add:Extra(Obj, v)
	local TANG, ifSO = nil, {}
	if String_Table(v[1], {"uic", "cor", "rou"}) then
		TANG = Instance.new("UICorner", Obj)

		for ii,vv in pairs(v[2]) do
			if String_Table(ii, {"co", "ra", "va", "si", "ve"}) then
				TANG.CornerRadius = vv
				table.insert(ifSO, "corner")
			elseif String_Table(ii, {"en", "vis", "on"}) then
				TANG.Enabled = vv
			end
		end
		
		if not table.find(ifSO, "corner") then TANG.CornerRadius = UDim.new(0, 12) end
	elseif String_Table(v[1], {"uig", "gra"}) then
		TANG = Instance.new("UIGradient", Obj)

		for ii,vv in pairs(v[2]) do
			if String_Table(ii, {"co"}) then
				TANG.Color = vv
			elseif String_Table(ii, {"of"}) then
				TANG.Offset = vv
			elseif String_Table(ii, {"re"}) then
				TANG.Reverses = vv
			elseif String_Table(ii, {"ro"}) then
				TANG.Rotation = vv
			elseif String_Table(ii, {"tr"}) then
				TANG.Transparency = vv
			elseif String_Table(ii, {"en", "vis", "on"}) then
				TANG.Enabled = vv
			end
		end
	elseif String_Table(v[1], {"uis", "str"}) then
		TANG = Instance.new("UIStroke", Obj)

		for ii,vv in pairs(v[2]) do
			if String_Table(ii, {"ap", "st", "modes"}) then
				TANG.ApplyStrokeMode = vv
				table.insert(ifSO, "smod")
			elseif String_Table(ii, {"co"}) then
				TANG.Color = vv
			elseif String_Table(ii, {"li", "jo", "me", "model", "modej"}) then
				TANG.LineJoinMode = vv
			elseif String_Table(ii, {"th", "si"}) then
				TANG.Thickness = vv
			elseif String_Table(ii, {"tr"}) then
				TANG.Transparency = vv
			elseif String_Table(ii, {"en", "vis", "on"}) then
				TANG.Enabled = vv
			end
		end
		
		if not table.find(ifSO, "smod") then TANG.ApplyStrokeMode = Enum.ApplyStrokeMode.Border end
	end
	
	return TANG
end

Add.Frame = function(Pp, Size, Position, extra)
	local frame, ifSO = Instance.new("Frame", Pp), {}

	for i, v in pairs(extra) do
		if String_Table(i, {"tr", "btr", "backgroundtr", "background_tr"}) then
			frame.BackgroundTransparency = v
		elseif String_Table(i, {"bp", "bsp", "borders", "borderp", "pix"}) then
			frame.BorderSizePixel = v
			table.insert(ifSO, "bpixel")
		elseif String_Table(i, {"clr_ba", "color_ba", "backgroundc", "background_c", "colorba"}) then
			frame.BackgroundColor3 = v
			table.insert(ifSO, "bcolor")
		elseif String_Table(i, {"border_c", "borderc", "clr_bo", "color_bo", "colorbo"}) then
			frame.BorderColor3 = v
			table.insert(ifSO, "borderc")
		elseif String_Table(i, {"ac", "isa"}) then
			frame.Active = i
			table.insert(ifSO, "active")
		elseif String_Table(i, {"drag", "isdrag"}) then
			frame.Draggable = i
			table.insert(ifSO, "draggable")
		elseif String_Table(i, {"onme", "me", "mousee", "onmousee", "foc", "onfoc"}) then
			frame.MouseEnter:Connect(function()
				v(frame)
			end)
		elseif String_Table(i, {"bm", "borderm"}) then
			frame.BorderMode = v
			table.insert(ifSO, "borderm")
		elseif String_Table(i, {"onml", "ml", "mousel", "onmousel", "unfoc", "onunfoc"}) then
			frame.MouseLeave:Connect(function()
				v(frame)
			end)
		elseif String_Table(i, {"zin", "index"}) then
			frame.ZIndex = v
		elseif String_Table(i, {"vis", "isvis"}) then
			frame.Visible = v
		end
	end

	if not table.find(ifSO, "bpixel") then frame.BorderSizePixel = 0 end
	if not table.find(ifSO, "bcolor") then frame.BackgroundColor3 = Color_Table.Background end
	if not table.find(ifSO, "borderc") then frame.BorderColor3 = Color_Table.Border end
	if not table.find(ifSO, "active") then frame.Active = true end
	if not table.find(ifSO, "draggable") then frame.Draggable = false end
	if not table.find(ifSO, "borderm") then frame.BorderMode = Enum.BorderMode.Inset end

	frame.Size = Size
	frame.Position = Position

	return frame
end

Add.Button = function(Pp, Size, Position, Text, extra)
	local button, ifSO = Instance.new("TextButton", Pp), {}

	for i, v in pairs(extra) do
		if String_Table(i, {"tr", "btr", "backgroundtr", "background_tr"}) then
			button.BackgroundTransparency = v
		elseif String_Table(i, {"bp", "bsp", "borders", "borderp", "pix"}) then
			button.BorderSizePixel = v
			table.insert(ifSO, "bpixel")
		elseif String_Table(i, {"clr_ba", "color_ba", "backgroundc", "background_c", "colorba"}) then
			button.BackgroundColor3 = v
			table.insert(ifSO, "bcolor")
		elseif String_Table(i, {"border_c", "borderc", "clr_bo", "color_bo", "colorbo"}) then
			button.BorderColor3 = v
			table.insert(ifSO, "borderc")
		elseif String_Table(i, {"bm", "borderm"}) then
			button.BorderMode = v
			table.insert(ifSO, "borderm")
		elseif String_Table(i, {"ac", "isa"}) then
			button.Active = i
			table.insert(ifSO, "active")
		elseif String_Table(i, {"drag", "isdrag"}) then
			button.Draggable = i
			table.insert(ifSO, "draggable")
		elseif String_Table(i, {"zin", "index"}) then
			button.ZIndex = v
		elseif String_Table(i, {"vis", "isvis"}) then
			button.Visible = v
		elseif String_Table(i, {"auto"}) then
			button.AutoButtonColor = v
		elseif String_Table(i, {"text_c", "color_t", "clr_t", "textc", "txtc", "txt_c"}) then
			button.TextColor3 = v
			table.insert(ifSO, "txtclr")
		elseif String_Table(i, {"font", "text_f", "txt_f", "textf", "txtf"}) then
			button.Font = v
			table.insert(ifSO, "font")
		elseif String_Table(i, {"textsc", "scaledt", "textau", "autote", "tas"}) then
			button.TextScaled = v
		elseif String_Table(i, {"texts", "sizet", "tsi"}) then
			button.TextSize = v
		elseif String_Table(i, {"hor", "alignmenth", "alignh", "hal", "xal", "textxal", "textalignmentx", "alignx"}) then
			button.TextXAlignment = v
		elseif String_Table(i, {"ver", "alignmentv", "alignv", "val", "yal", "textyal", "textalignmenty", "aligny"}) then
			button.TextYAlignment = v
		elseif String_Table(i, {"m1c", "mb1c", "mouse1c", "mousebutton1c", "onm1c", "onmb1c", "onmousebutton1c", "b1c", "button1c", "onb1c", "onbutton1c"}) then
			button.MouseButton1Click:Connect(function()
				v(button)
			end)
		elseif String_Table(i, {"tap", "tou", "mobi"}) then
			button.TouchTap:Connect(function()
				v(button)
			end)
		elseif String_Table(i, {"m1d", "mb1d", "mouse1d", "mousebutton1d", "onm1d", "onmb1d", "onmousebutton1d", "b1d", "button1d", "onb1d", "onbutton1d"}) then
			button.MouseButton1Down:Connect(function()
				v(button)
			end)
		elseif String_Table(i, {"m1u", "mb1u", "mouse1u", "mousebutton1u", "onm1u", "onmb1u", "onmousebutton1u", "b1u", "button1u", "onb1u", "onbutton1u"}) then
			button.MouseButton1Up:Connect(function()
				v(button)
			end)
		elseif String_Table(i, {"m2c", "mb2c", "mouse2c", "mousebutton2c", "onm2c", "onmb2c", "onmousebutton2c", "b2c", "button2c", "onb2c", "onbutton2c"}) then
			button.MouseButton2Click:Connect(function()
				v(button)
			end)
		elseif String_Table(i, {"m2d", "mb2d", "mouse2d", "mousebutton2d", "onm2d", "onmb2d", "onmousebutton2d", "b2d", "button2d", "onb2d", "onbutton2d"}) then
			button.MouseButton2Down:Connect(function()
				v(button)
			end)
		elseif String_Table(i, {"m2u", "mb2u", "mouse2u", "mousebutton2u", "onm2u", "onmb2u", "onmousebutton2u", "b2u", "button2u", "onb2u", "onbutton2u"}) then
			button.MouseButton2Up:Connect(function()
				v(button)
			end)
		end
	end

	if not table.find(ifSO, "bpixel") then button.BorderSizePixel = 0 end
	if not table.find(ifSO, "bcolor") then button.BackgroundColor3 = Color_Table.Background end
	if not table.find(ifSO, "borderc") then button.BorderColor3 = Color_Table.Border end
	if not table.find(ifSO, "active") then button.Active = false end
	if not table.find(ifSO, "draggable") then button.Draggable = false end
	if not table.find(ifSO, "txtclr") then button.TextColor3 = Color_Table.Text end
	if not table.find(ifSO, "font") then button.Font = Enum.Font.ArimoBold end
	if not table.find(ifSO, "borderm") then button.BorderMode = Enum.BorderMode.Inset end

	button.Size = Size
	button.Position = Position
	button.Text = Text

	return button
end

Add.Text = function(Pp, Size, Position, extra)
	local tlabel, ifSO = Instance.new("TextLabel", Pp), {}

	for i, v in pairs(extra) do
		if String_Table(i, {"tr", "btr", "backgroundtr", "background_tr"}) then
			tlabel.BackgroundTransparency = v
		elseif String_Table(i, {"bp", "bsp", "borders", "borderp", "pix"}) then
			tlabel.BorderSizePixel = v
			table.insert(ifSO, "bpixel")
		elseif String_Table(i, {"clr_ba", "color_ba", "backgroundc", "background_c", "colorba"}) then
			tlabel.BackgroundColor3 = v
			table.insert(ifSO, "bcolor")
		elseif String_Table(i, {"border_c", "borderc", "clr_bo", "color_bo", "colorbo"}) then
			tlabel.BorderColor3 = v
			table.insert(ifSO, "borderc")
		elseif String_Table(i, {"bm", "borderm"}) then
			tlabel.BorderMode = v
			table.insert(ifSO, "borderm")
		elseif String_Table(i, {"ac", "isa"}) then
			tlabel.Active = i
			table.insert(ifSO, "active")
		elseif String_Table(i, {"drag", "isdrag"}) then
			tlabel.Draggable = i
			table.insert(ifSO, "draggable")
		elseif String_Table(i, {"zin", "index"}) then
			tlabel.ZIndex = v
		elseif String_Table(i, {"vis", "isvis"}) then
			tlabel.Visible = v
		elseif String_Table(i, {"text_c", "color_t", "clr_t", "textc", "txtc", "txt_c"}) then
			tlabel.TextColor3 = v
			table.insert(ifSO, "txtclr")
		elseif String_Table(i, {"font", "text_f", "txt_f", "textf", "txtf"}) then
			tlabel.Font = v
			table.insert(ifSO, "font")
		elseif string.lower(i) == "text" then
			tlabel.Text = v
			table.insert(ifSO, "text")
		elseif String_Table(i, {"textsc", "scaledt", "textau", "autote", "tas"}) then
			tlabel.TextScaled = v
		elseif String_Table(i, {"texts", "sizet", "tsi"}) then
			tlabel.TextSize = v
		elseif String_Table(i, {"hor", "alignmenth", "alignh", "hal", "xal", "textxal", "textalignmentx", "alignx"}) then
			tlabel.TextXAlignment = v
		elseif String_Table(i, {"ver", "alignmentv", "alignv", "val", "yal", "textyal", "textalignmenty", "aligny"}) then
			tlabel.TextYAlignment = v
		elseif String_Table(i, {"onme", "me", "mousee", "onmousee", "foc", "onfoc"}) then
			tlabel.MouseEnter:Connect(function()
				v(tlabel)
			end)
		elseif String_Table(i, {"onml", "ml", "mousel", "onmousel", "unfoc", "onunfoc"}) then
			tlabel.MouseLeave:Connect(function()
				v(tlabel)
			end)
		end
	end

	if not table.find(ifSO, "bpixel") then tlabel.BorderSizePixel = 0 end
	if not table.find(ifSO, "bcolor") then tlabel.BackgroundColor3 = Color_Table.Background end
	if not table.find(ifSO, "borderc") then tlabel.BorderColor3 = Color_Table.Border end
	if not table.find(ifSO, "active") then tlabel.Active = false end
	if not table.find(ifSO, "draggable") then tlabel.Draggable = false end
	if not table.find(ifSO, "txtclr") then tlabel.TextColor3 = Color_Table.Text end
	if not table.find(ifSO, "font") then tlabel.Font = Enum.Font.ArimoBold end
	if not table.find(ifSO, "text") then tlabel.Text = "" end
	if not table.find(ifSO, "borderm") then tlabel.BorderMode = Enum.BorderMode.Inset end

	tlabel.Size = Size
	tlabel.Position = Position

	return tlabel
end

Add.Box = function(Pp, Size, Position, extra)
	local tbox, ifSO = Instance.new("TextBox", Pp), {}

	for i, v in pairs(extra) do
		if String_Table(i, {"tr", "btr", "backgroundtr", "background_tr"}) then
			tbox.BackgroundTransparency = v
		elseif String_Table(i, {"bp", "bsp", "borders", "borderp", "pix"}) then
			tbox.BorderSizePixel = v
			table.insert(ifSO, "bpixel")
		elseif String_Table(i, {"clr_ba", "color_ba", "backgroundc", "background_c", "colorba"}) then
			tbox.BackgroundColor3 = v
			table.insert(ifSO, "bcolor")
		elseif String_Table(i, {"border_c", "borderc", "clr_bo", "color_bo", "colorbo"}) then
			tbox.BorderColor3 = v
			table.insert(ifSO, "borderc")
		elseif String_Table(i, {"bm", "borderm"}) then
			tbox.BorderMode = v
			table.insert(ifSO, "borderm")
		elseif String_Table(i, {"ac", "isa"}) then
			tbox.Active = i
			table.insert(ifSO, "active")
		elseif String_Table(i, {"drag", "isdrag"}) then
			tbox.Draggable = i
			table.insert(ifSO, "draggable")
		elseif String_Table(i, {"zin", "index"}) then
			tbox.ZIndex = v
		elseif String_Table(i, {"vis", "isvis"}) then
			tbox.Visible = v
		elseif String_Table(i, {"text_c", "color_t", "clr_t", "textc", "txtc", "txt_c"}) then
			tbox.TextColor3 = v
			table.insert(ifSO, "txtclr")
		elseif String_Table(i, {"font", "text_f", "txt_f", "textf", "txtf"}) then
			tbox.Font = v
			table.insert(ifSO, "font")
		elseif string.lower(i) == "text" then
			tbox.Text = v
			table.insert(ifSO, "text")
		elseif String_Table(i, {"textsc", "scaledt", "textau", "autote", "tas"}) then
			tbox.TextScaled = v
		elseif String_Table(i, {"texts", "sizet", "tsi"}) then
			tbox.TextSize = v
		elseif String_Table(i, {"plac", "txt_pl", "text_pl", "ptex", "ptx", "placeh", "plc", "plh", "pho"}) then
			tbox.PlaceholderText = v
			table.insert(ifSO, "plcholder")
		elseif String_Table(i, {"hor", "alignmenth", "alignh", "hal", "xal", "textxal", "textalignmentx", "alignx"}) then
			tbox.TextXAlignment = v
		elseif String_Table(i, {"ver", "alignmentv", "alignv", "val", "yal", "textyal", "textalignmenty", "aligny"}) then
			tbox.TextYAlignment = v
		elseif String_Table(i, {"focusedl", "unfoc", "onunfoc", "oninpute", "inpute", "stop", "end"}) then
			tbox.FocusedLost:Connect(function()
				v(tbox)
			end)
		elseif String_Table(i, {"focused", "onfoc", "oninputb", "inputb", "oned", "ty", "onty", "start"}) then
			tbox.Focused:Connect(function()
				v(tbox)
			end)
		elseif String_Table(i, {"clear", "textclear", "delete"}) then
			tbox.ClearTextOnFocus = v
			table.insert(ifSO, "clear")
		end
	end

	if not table.find(ifSO, "bpixel") then tbox.BorderSizePixel = 0 end
	if not table.find(ifSO, "bcolor") then tbox.BackgroundColor3 = Color_Table.Background end
	if not table.find(ifSO, "borderc") then tbox.BorderColor3 = Color_Table.Border end
	if not table.find(ifSO, "active") then tbox.Active = false end
	if not table.find(ifSO, "draggable") then tbox.Draggable = false end
	if not table.find(ifSO, "txtclr") then tbox.TextColor3 = Color_Table.Text end
	if not table.find(ifSO, "font") then tbox.Font = Enum.Font.ArimoBold end
	if not table.find(ifSO, "text") then tbox.Text = "" end
	if not table.find(ifSO, "plcholder") then tbox.PlaceholderText = "" end
	if not table.find(ifSO, "borderm") then tbox.BorderMode = Enum.BorderMode.Inset end
	if not table.find(ifSO, "clear") then tbox.ClearTextOnFocus = false end

	tbox.Size = Size
	tbox.Position = Position

	return tbox
end

Add.Scroll = function(Pp, Size, Position, extra)
	local scrlf, ifSO = Instance.new("ScrollingFrame", Pp), {}

	for i, v in pairs(extra) do
		if String_Table(i, {"tr", "btr", "backgroundtr", "background_tr"}) then
			scrlf.BackgroundTransparency = v
		elseif String_Table(i, {"bp", "bsp", "borders", "borderp", "pix"}) then
			scrlf.BorderSizePixel = v
			table.insert(ifSO, "bpixel")
		elseif String_Table(i, {"clr_ba", "color_ba", "backgroundc", "background_c", "colorba"}) then
			scrlf.BackgroundColor3 = v
			table.insert(ifSO, "bcolor")
		elseif String_Table(i, {"bm", "borderm"}) then
			scrlf.BorderMode = v
			table.insert(ifSO, "borderm")
		elseif String_Table(i, {"border_c", "borderc", "clr_bo", "color_bo", "colorbo"}) then
			scrlf.BorderColor3 = v
			table.insert(ifSO, "borderc")
		elseif String_Table(i, {"ac", "isa"}) then
			scrlf.Active = i
			table.insert(ifSO, "active")
		elseif String_Table(i, {"drag", "isdrag"}) then
			scrlf.Draggable = i
			table.insert(ifSO, "draggable")
		elseif String_Table(i, {"onme", "me", "mousee", "onmousee", "foc", "onfoc"}) then
			scrlf.MouseEnter:Connect(function()
				v(scrlf)
			end)
		elseif String_Table(i, {"onml", "ml", "mousel", "onmousel", "unfoc", "onunfoc"}) then
			scrlf.MouseLeave:Connect(function()
				v(scrlf)
			end)
		elseif String_Table(i, {"zin", "index"}) then
			scrlf.ZIndex = v
		elseif String_Table(i, {"vis", "isvis"}) then
			scrlf.Visible = v
		elseif String_Table(i, {"bar", "scrollb", "scrollingb", "thic"}) then
			scrlf.ScrollBarThickness = v
			table.insert(ifSO, "thick")
		elseif String_Table(i, {"canvass", "scrolls", "scrollings"}) then
			scrlf.CanvasSize = v
			table.insert(ifSO, "canvas")
		elseif String_Table(i, {"auto", "canvasa"}) then
			scrlf.AutomaticSize = v
			table.insert(ifSO, "auto")
		elseif String_Table(i, {"dir", "scrolld", "scrollingd"}) then
			scrlf.ScrollingDirection = v
			table.insert(ifSO, "direct")
		end
	end

	if not table.find(ifSO, "bpixel") then scrlf.BorderSizePixel = 0 end
	if not table.find(ifSO, "bcolor") then scrlf.BackgroundColor3 = Color_Table.Background end
	if not table.find(ifSO, "borderc") then scrlf.BorderColor3 = Color_Table.Border end
	if not table.find(ifSO, "active") then scrlf.Active = true end
	if not table.find(ifSO, "draggable") then scrlf.Draggable = false end
	if not table.find(ifSO, "canvas") then scrlf.CanvasSize = UDim2.new(0, 0, 1, 0) end
	if not table.find(ifSO, "auto") then scrlf.AutomaticSize = Enum.AutomaticSize.XY end
	if not table.find(ifSO, "borderm") then scrlf.BorderMode = Enum.BorderMode.Inset end
	
	scrlf.Size = Size
	scrlf.Position = Position

	return scrlf
end

Add.Layout = function(Pp, extra)
	local uill, ifSO = Instance.new("UIListLayout", Pp), {}

	for i, v in pairs(extra) do
		if String_Table(i, {"layoutd", "fill", "sortdir", "dir"}) then
			uill.FillDirection = v
			table.insert(ifSO, "fill")
		elseif String_Table(i, {"sorto", "layouto"}) then
			uill.SortOrder = v
			table.insert(ifSO, "sort")
		elseif String_Table(i, {"pad", "off", "scale"}) then
			uill.Padding = v
		elseif String_Table(i, {"hor", "alignmenth", "alignh", "hal"}) then
			uill.HorizontalAlignment = v
		elseif String_Table(i, {"ver", "alignmentv", "alignv", "val"}) then
			uill.VerticalAlignment = v
		end
	end

	if not table.find(ifSO, "sort") then uill.SortOrder = Enum.SortOrder.LayoutOrder end
	if not table.find(ifSO, "fill") then uill.FillDirection = Enum.FillDirection.Horizontal end

	return uill
end

local sg = Instance.new("ScreenGui")
sg.Parent = gethui()

local Back = Add.Frame(sg, UDim2.new(0, 450, 0, 400), UDim2.new(.5, -175, .5, -150), {["BackgroundTr"] = 1; ["drag"] = true})
local Actual = Add.Frame(Back, UDim2.new(1, 0, .865, 0), UDim2.new(0, 0, .135, 0), {["BackgroundTr"] = .05})
local Crn = Add:Extra(Actual, {"Corner", {["Size"] = UDim.new(0, 6)}})
local Strk = Add:Extra(Actual, {"Stroke", {["Trans"] = 0.4; ["Thickness"] = 6; ["Color"] = Back.BorderColor3}})
local LLIINNEE = Add.Frame(Back, UDim2.new(1, 0, 0, 3), UDim2.new(0, 0, .15, -1.5), {["BackgroundC"] = Back.BorderColor3; ["Zin"] = 2})
local Top = Add.Frame(Back, UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0, 0), {})
local LL1 = Add.Layout(Top, {["hal"] = Enum.HorizontalAlignment.Center})

local CBL,CBC=1,{}
Add.Category_Button = function(Text)
	local Frame = Add.Frame(Back, UDim2.new(1, 0, .85, 0), UDim2.new(0, 0, .15, 0), {["btr"] = 1; ["vis"] = ((CBL == 1) and true or false)})
	Add.Layout(Frame, {["FillDirection"] = Enum.FillDirection.Vertical})
	local Button = Add.Button(Top, UDim2.new(0.25, 0, 1, 0), UDim2.new(0, 0, 0, 0), Text, {["borders"]=((CBL == 1) and 2 or 1); ["auto"]=false; ["BackgroundTra"] = 1; ["m1c"] = function(button)
		for i,v in pairs(CBC) do
			v.Frame.Visible = false
			v.Button.BorderSizePixel = 1
			v.Stroke.Enabled = false
		end
		Frame.Visible = true
		button.BorderSizePixel = 2
		button:FindFirstChildOfClass("UIStroke").Enabled = true
	end; ["textsc"] = true})
	local Strokk = Add:Extra(Button, {"Stroke", {["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Contextual; ["Color"] = Back.BorderColor3; ["Transparency"] = 0; ["Thick"] = 4; ["Enabled"] = (CBL == 1) and true or false}})
	table.insert(CBC, {["Frame"] = Frame, ["Button"] = Button, ["Stroke"] = Strokk}) Button.LayoutOrder = CBL; for i,v in pairs(CBC) do v.Button.Size = UDim2.new(1/CBL, 0, 1, 0) end CBL=CBL+1
	return Frame, Button
end

spawn(function()
	while task.wait() do
		local CL = Color3.fromHSV(tick()%.338, 0.3, .3)
		for i,v in pairs(CBC) do v.Stroke.Color = CL; Strk.Color = CL end
	end
end)

Add.b_Button = function(PAR, Text, funk, BrazilianButtLift)
	local Bool, Button, Bnorm, LINEE = false, nil, nil, nil;
	if BrazilianButtLift then
		Button = Add.Button(PAR, UDim2.new(1, 0, 0.12, 0), UDim2.new(0, 0, 0, 0), Text, {["TextSc"] = true; ["Horiz"] = Enum.TextXAlignment.Left; ["M1Click"] = function(Button1)
			Bool = not Bool; if not Bool then Bnorm.Visible = false end if Bool then
				spawn(function()
					local Frame = Add.Frame(Button, UDim2.new(0, 0, 1, 0), UDim2.new(1, 0, 0, 0), {["bTrans"] = .7; ["BackgroundColor"] = Back.BorderColor3})
					Frame:TweenSizeAndPosition(UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, .3, true)
					task.wait(.3)
					Frame:Destroy(); Bnorm.Visible = Bool
				end)
			else
				spawn(function()
					local Frame = Add.Frame(Button, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), {["bTrans"] = .7; ["BackgroundColor"] = Back.BorderColor3})
					Frame:TweenSizeAndPosition(UDim2.new(0, 0, 1, 0), UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, .3, true)
					task.wait(.3)
					Frame:Destroy()
				end)
			end
			LINEE.Visible = not Bool
			funk(Button1, Bool)
		end})
		Bnorm = Add.Frame(Button, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), {["bTrans"] = .7; ["BackgroundColor"] = Back.BorderColor3; ["Vis"] = false})
		if Button.Parent:FindFirstChild("AlLlLLll") then
			Button.Size = UDim2.new(.75, 0, 1, 0)
		end
	else
		Button = Add.Button(PAR, UDim2.new(1, 0, 0.12, 0), UDim2.new(0, 0, 0, 0), Text, {["TextSc"] = true; ["Horiz"] = Enum.TextXAlignment.Left; ["M1Click"] = function(Button1)
			Bool = not Bool
			funk(Button1, Bool)
		end})
		if Button.Parent:FindFirstChild("AlLlLLll") then
			Button.Size = UDim2.new(.75, 0, 1, 0)
		end
	end

	LINEE = Add.Frame(Button, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), {["BackgroundC"] = Back.BorderColor3; ["Zin"] = 2})

	return Button
end

Add.t_TextBox = function(Par, Text, funk, Type)
	local Frame = Add.Frame(Par, UDim2.new(1, 0, 0.12, 0), UDim2.new(0, 0, 0, 0), {["btr"] = 1})
	local LINEE = Add.Frame(Frame, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), {["BackgroundC"] = Back.BorderColor3; ["Zin"] = 2})
	local Tbox = Add.Box(Frame, UDim2.new(.25, 0, 1, 0), UDim2.new(.75, 0, 0, 0), {["Placeh"] = (Type == 4 and Text) or "..."; ["TextSca"] = true}) Tbox.Name = "AlLlLLll"
	local BB;
	if Type == 4 then
		Tbox.Size = UDim2.new(1, 0, 1, 0)
		Tbox.Position = UDim2.new(0, 0, 0, 0)
		Tbox.FocusLost:Connect(function()
			if Tbox.Text == "" then return end
			spawn(function()
				funk(Tbox)
			end)
			task.wait(.5)
			Tbox.Text = ""
		end)
	else
		BB = (Type == 1) and Add.Text(Frame, UDim2.new(.75, 0, 1, 0), UDim2.new(0, 0, 0, 0), {["Text"] = Text; ["Horiz"] = Enum.TextXAlignment.Left; ["TextSca"] = true}) or (Type == 2) and Add.b_Button(Frame, Text, function() funk(Tbox) end, false) or Add.b_Button(Frame, Text, function(TBB, Boolll) funk(Tbox, Boolll) end, true)
		if Type == 1 then Tbox.FocusLost:Connect(function() if Tbox.Text == "" then return end funk(Tbox) end) end
	end

	return Tbox, BB
end

return Add
