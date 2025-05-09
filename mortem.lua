local Add = loadstring(game:HttpGet("https://raw.githubusercontent.com/FadedIndividual/main/refs/heads/main/Library.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local Lighting = game:GetService("Lighting")
local Core = game:GetService("CoreGui")

Lighting.GlobalShadows = false
Lighting.Brightness = .8

--local sg = gethui(Instance.new("ScreenGui"))
local PATH = LocalPlayer.PlayerGui.SelectScreen.Frame.Frame
local SCRIPT = PATH:FindFirstChildOfClass("LocalScript")
local VFrame = PATH.Parent.ViewportFrame
local CSCRIPT = VFrame:FindFirstChildOfClass("LocalScript")
local CModel = VFrame.CopyMan
local CBackground = VFrame.Model
local LIST = PATH.ScrollingFrame
local EXIT = PATH.button0
local SELECTED = nil

SCRIPT.Enabled = false
CSCRIPT.Enabled = false

EXIT:ClearAllChildren()
EXIT.Position = UDim2.new(.029, 0, .004, 0)
EXIT.Size = UDim2.new(.208, 0, .076, 0)
EXIT.Text = "FISTS"

VFrame.Ambient = Color3.new(1, 0, 1)

for i,v in pairs(CBackground:GetChildren()) do
	v.Transparency = 1 
end

local function getButtons()
	local list = {}
	
	for i,v in pairs(LIST:GetChildren()) do
		if not v:IsA("UIGridLayout") then
			table.insert(list, v)
		end
	end
	
	return list
end

local function sTween(Objs, Size, Position, Time)
	if type(Objs) == "table" then
		for i,v in pairs(Objs) do
			v:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.Linear, Enum.EasingStyle.In, Time, true)
		end
	else
		Objs:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.Linear, Enum.EasingStyle.In, Time, true)
	end
end

local amt, amt2Dupe = 50, nil

local function AddSD(f)
	if f then
		local std = Add.Frame(f, UDim2.new(.92, 0, .92, 0), UDim2.new(.04, 0, .04, 0), {["name"] = "ssSSssSS", ["BackgroundTransparency"] = .88, ["BorderSizePixel"] = 0, ["BackgroundColor3"] = Color3.fromRGB(0, 125, 255), ["ZIndex"] = 7, ["Visible"] = false})
		Add:Extra(std, {"UICorner", {["Name"] = "corner", ["Size"] = UDim.new(1, 0)}})
		
		f.MouseEnter:Connect(function()
			std.Visible = true
		end)
		f.MouseLeave:Connect(function()
			if SELECTED ~= f then
				std.Visible = false
			end
		end)
		f.MouseButton2Click:Connect(function()
			if SELECTED and not SELECTED:FindFirstChild("ssSSssSS"):FindFirstChild("corner") then
				SELECTED:FindFirstChild("ssSSssSS").Visible = false
				Add:Extra(SELECTED:FindFirstChild("ssSSssSS"), {"UICorner", {["Name"] = "corner", ["Size"] = UDim.new(1, 0)}})
			end
			std:FindFirstChildOfClass("UICorner"):Destroy()
			SELECTED = f
			std.Visible = true
		end)
		f.MouseButton1Click:Connect(function()
			local num = string.gsub(f.Name, "button", "", 1)
			num = tonumber(num)
			if SELECTED == f then
				settings().Network.IncomingReplicationLag = math.huge
				task.wait(2)
				for i = 1, amt do
					game:GetService("ReplicatedStorage").Item:FireServer(num, "0:0:0:0")
				end
				settings().Network.IncomingReplicationLag = 0
			else
				game:GetService("ReplicatedStorage").Item:FireServer(num, "0:0:0:0")
			end
		end)
		task.spawn(function()
			while task.wait(.2) and PATH do
				local bool = PATH.Parent.Parent
				if bool.Enabled==false and SELECTED~=f then
					std.Visible = false
				end
			end
		end)
	end
end

AddSD(EXIT)
for i,v in pairs(getButtons()) do
	AddSD(v)
end

local sg = Instance.new("ScreenGui")
sg.Parent = Core
sg.IgnoreGuiInset = true
sg.Name = "XIXI"

local Main = Add.Frame(sg, UDim2.new(0, 300, 0, 350), UDim2.new(0, 0, 1, -350), {["BackgroundTran"] = .5})
local uil = Instance.new("UIListLayout", Main) uil.HorizontalAlignment = Enum.HorizontalAlignment.Center uil.SortOrder = Enum.SortOrder.LayoutOrder

local nUm = 0
local function Button(Parent, Text, Function, Type) nUm += 1
    local bMain = Add.Button(Parent, UDim2.new(1, 0, 0, 27), UDim2.new(0, 0, 0, 0), "", {["BackgroundColor"] = Color3.new(0, 0, 0), ["BackgroundTran"] = .75, ["TextSize"] = 20, ["LayoutOrder"] = nUm})
    if Type == 1 then
        local line = Add.Text(bMain, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Color3.new(1,1,1)})
        bMain.Text = Text
        bMain["TextXAlignment"] = Enum.TextXAlignment.Center
        bMain.MouseButton1Click:Connect(function()
            Function(bMain)
        end)
    elseif Type == 2 then
        local mFrame = Add.Frame(Parent, UDim2.new(1, 0, 0, 27), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["LayoutOrder"] = nUm})
        local mLabe = Add.Text(mFrame, UDim2.new(.8, 0, 1, 0), UDim2.new(0, 0, 0, 0), "", {["BackgroundTran"] = .75, ["BackgroundColor"] = Color3.new(0, 0, 0), ["TextSize"] = 20})
        local line = Add.Text(mLabe, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Color3.new(1,1,1)})
        bMain.Parent = mFrame
        bMain.Size = UDim2.new(.2, 0, 1, 0)
        bMain.Position = UDim2.new(.8, 0, 0, 0)
        if type(Text) ~= "string" then
            mLabe.Text = Text[1]
            bMain.Text = Text[2]
        else
            mLabe.Text = Text
            bMain.Text = "..."
        end
        bMain.BackgroundTransparency = .5
        bMain.MouseButton1Click:Connect(function()
            Function(bMain, mLabe)
        end)
    end

    return bMain
end

local function Box(Parent, Text, Function, Type) nUm += 1
    local mBox = Add.Box(Parent, UDim2.new(1, 0, 0, 27), UDim2.new(0, 0, 0, 0), "", {["BackgroundColor"] = Color3.new(0, 0, 0), ["BackgroundTran"] = .75, ["TextSize"] = 20, ["LayoutOrder"] = nUm})
    if Type == 1 then
        local line = Add.Text(mBox, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Color3.new(1,1,1)})
        mBox.PlaceholderText = Text
        mBox.FocusLost:Connect(function()
            Function(mBox)
        end)
    elseif Type == 2 then
        local mFrame = Add.Frame(Parent, UDim2.new(1, 0, 0, 27), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["LayoutOrder"] = nUm})
        mBox.Parent = mFrame
        mBox.Size = UDim2.new(.2, 0, 1, 0)
        mBox.Position = UDim2.new(.8, 0, 0, 0)
        mBox.BackgroundTransparency = .5
        mBox.PlaceholderText = "..."
        local mBut = Button(mFrame, Text, function()
            Function(mBox, button)
        end, 1)
        mBut.Size = UDim2.new(.8, 0, 1, 0)
    elseif Type == 3 then
        local mFrame = Add.Frame(Parent, UDim2.new(1, 0, 0, 27), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["LayoutOrder"] = nUm})
        local mLabe = Add.Text(mFrame, UDim2.new(.8, 0, 1, 0), UDim2.new(0, 0, 0, 0), Text, {["BackgroundTran"] = .75, ["BackgroundColor"] = Color3.new(0, 0, 0), ["TextSize"] = 20})
        local line = Add.Text(mLabe, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Color3.new(1,1,1)})
        mBox.Parent = mFrame
        mBox.Size = UDim2.new(.2, 0, 1, 0)
        mBox.Position = UDim2.new(.8, 0, 0, 0)
        mBox.BackgroundTransparency = .5
        mBox.PlaceholderText = "..."
        mBox.FocusLost:Connect(function()
            Function(mBox, mLabe)
        end)
    end

    return mBox
end

-- T: minigun
-- G: reload all
-- V: shoot all
-- C: shoot 3 at once (insta-kill bodyshot)

local gunning = false

UIS.InputBegan:Connect(function(Key, Processed)
	if Processed then return end
	
	if Key.KeyCode == Enum.KeyCode.T then
		gunning = not gunning
		if gunning then
			LocalPlayer.Character.Humanoid:UnequipTools()
			for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
				if v:FindFirstChild("Reloaded") and v.Reloaded.Value then
					if not gunning then break end
					if v.Reloaded.Value then
						LocalPlayer.Character.Humanoid:EquipTool(v)
						wait(.05)
						mouse1click(Mouse.X, Mouse.Y)
					end
					if not gunning then break end
				end
			end
            gunning = false
		end
	elseif Key.KeyCode == Enum.KeyCode.G then
		if gunning == false then
			LocalPlayer.Character.Humanoid:UnequipTools()
			for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
				if v:FindFirstChild("Reloaded") and not v.Reloaded.Value then
					v.Parent = LocalPlayer.Character
				end
			end
			wait(.05)
			mouse1click(Mouse.X, Mouse.Y)
		end
	elseif Key.KeyCode == Enum.KeyCode.V then
		LocalPlayer.Character.Humanoid:UnequipTools()
		for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
			if v:FindFirstChild("Reloaded") and v.Reloaded.Value then
				v.Parent = LocalPlayer.Character
				break
			end
		end
		wait(.05)
		mouse1click(Mouse.X, Mouse.Y)
	elseif Key.KeyCode == Enum.KeyCode.C then
		LocalPlayer.Character.Humanoid:UnequipTools()
		local nn = 0
		for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
			if v:FindFirstChild("Reloaded") and v.Reloaded.Value then nn+= 1
				if nn == 3 then break end
				v.Parent = LocalPlayer.Character
				mouse1click(Mouse.X, Mouse.Y)
			end
		end
	end
end)

local function sCmd(Table, String, Loose)
	local booll = false
	
	for i,v in pairs(Table) do
		if string.lower(String) == Table or Loose and string.lower(string.sub(String, 1, string.len(String))) == string.sub(v, 1, string.len(String)) then
			booll = true
		end
	end
	
	return booll
end

local function plrFromString(String)
	local Plr = nil
	
	for i,v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then
			if string.sub(tostring(v.Name):lower(), 1, string.len(String)) == string.lower(String) then
				Plr = v
			end
		end
	end
	
	return Plr
end

local Cache, BOOL = {}, true

LocalPlayer.Chatted:Connect(function(msg)
	local args = string.split(msg, " ")
	
	if sCmd({';perm'}, args[1], true) then
		if args[2] == "all" then
			for i,v in pairs(Players:GetPlayers()) do
				if v~=LocalPlayer then
					table.insert(Cache, v.Name)
				end
			end
		else
			local Plr = plrFromString(args[2])
			if Plr then
				table.insert(Cache, Plr.Name)
			end
		end
	elseif sCmd({';unperm'}, args[1], true) then
		if args[2] == "all" then
			Cache = {}
		elseif args[2] then
			local Plr = plrFromString(args[2])
			if Plr then
				for i,v in pairs(Cache) do
					if v == Plr.Name then
						table.remove(Cache, i)
					end
				end
			end
		end
    elseif sCmd({";spawn"}, args[1], true) then
        if LocalPlayer.PlayerGui.SelectScreen.Enabled then
            if args[2] and tonumber(args[2]) then
                if SELECTED then
                    local num = string.gsub(SELECTED.Name, "button", "", 1)
                    num = tonumber(num)
                    settings().Network.IncomingReplicationLag = math.huge
                    task.wait(1)
                    for i = 1, tonumber(args[2]) do
                        game:GetService("ReplicatedStorage").Item:FireServer(num, "0:0:0:0")
                    end
                    settings().Network.IncomingReplicationLag = 0
                else
                    settings().Network.IncomingReplicationLag = math.huge
                    task.wait(1)
                    for i = 1, tonumber(args[2]) do
                        game:GetService("ReplicatedStorage").Item:FireServer(1, "0:0:0:0")
                    end
                    settings().Network.IncomingReplicationLag = 0
                end
            else
                if SELECTED then
                    local num = string.gsub(SELECTED.Name, "button", "", 1)
                    num = tonumber(num)
                    settings().Network.IncomingReplicationLag = math.huge
                    task.wait(1)
                    for i = 1, amt do
                        game:GetService("ReplicatedStorage").Item:FireServer(num, "0:0:0:0")
                    end
                    settings().Network.IncomingReplicationLag = 0
                else
                    settings().Network.IncomingReplicationLag = math.huge
                    task.wait(1)
                    for i = 1, tonumber(args[2]) do
                        game:GetService("ReplicatedStorage").Item:FireServer(1, "0:0:0:0")
                    end
                    settings().Network.IncomingReplicationLag = 0
                end
            end
        end
    elseif sCmd({";amount", ";amt"}, args[1], true) then
        if tonumber(args[2]) then
            amt = tonumber(args[2])
            amt2Dupe.PlaceholderText = "Amount-2-Dupe: " .. tostring(amt)
        end
    elseif sCmd({";change", ";bool"}, args[1], true) then
        if sCmd({"true", "+", "pos"}, args[2], true) then
            BOOL = true
        elseif sCmd({"false", "-", "neg"}, args[2], true) then
            BOOL = false
        end
	end
end)

local ToolName, acMethod, am2eq, bind, ijump, iroll, istC = nil, 1, 5, Enum.KeyCode.R, false, false, nil

amt2Dupe = Box(Main, "Amount-2-Dupe: 50", function(box)
    if box.Text ~= "" or box.Text ~= nil or box.Text ~= " " and tonumber(box.Text) then
        amt = tonumber(box.Text)
        box.PlaceholderText = "Amount-2-Dupe: " .. tostring(amt)
        box.Text = ""
    else
        amt = 50
        box.PlaceholderText = "Amount-2-Dupe: 50"
        box.Text = ""
    end
end, 1)

local Tool2Equip = Box(Main, "Tool-2-Equip: ...", function(box)
    if box.Text ~= "" or box.Text ~= nil or box.Text ~= " " then
        if not LocalPlayer.PlayerGui.SelectScreen.Enabled then
            for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") and string.lower(string.sub(v.Name, 1, #box.Text)) == string.lower(box.Text) then
                    box.Text = v.Name
                    ToolName = v.Name
                    break
                end
            end

            box.PlaceholderText = "Tool-2-Equip: " .. box.Text
            box.Text = ""
        else
            box.PlaceholderText = "Tool-2-Equip: ..."
            box.Text = "PLEASE SPAWN IN"
            task.spawn(function()
                task.wait(1.5)
                if LocalPlayer.PlayerGui.SelectScreen.Enabled then
                    box.Text = ""
                end
            end)
        end
    else
        ToolName = nil
        box.PlaceholderText = "Tool-2-Equip: ..."
        box.Text = ""
    end
end, 1)

local ActivateMethod = Button(Main, "Use Method: Activate", function(button)
    if button.Text == "Use Method: Activate" then
        button.Text = "Use Method: Click"
        acMethod = 2
    else
        button.Text = "Use Method: Activate"
        acMethod = 1
    end
end, 1)

local Amount2Equip = Box(Main, "Equip Amount:", function(box, text)
    local nm = tonumber(box.Text)
    if nm then
        box.PlaceholderText = tostring(nm)
        box.Text = ""
        am2eq = nm
    else
        box.PlaceholderText = "5"
        box.Text = ""
        am2eq = 5
    end
end, 3)

local bt2 = Button(Main, {"Bind Equip:", "R"}, function(button, text)
    button.Text = "..."
    wait(.5)
    local keyBind = nil
    keyBind = UIS.InputBegan:Connect(function(Key, Proc)
        if Proc then return end

        bind = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")--Enum.KeyCode.

        pcall(function()
            keyBind:Disconnect()
            keyBind = nil
        end)
    end)
end, 2)

local infJmp = Button(Main, "Inf-Jump: false", function(button)
    if button.Text == "Inf-Jump: false" then
        button.Text = "Inf-Jump: true"
        ijump = true
    else
        button.Text = "Inf-Jump: false"
        ijump = false
    end
end, 1)

local infRool = Button(Main, "Inf-Roll: false", function(button)
    if button.Text == "Inf-Roll: false" then
        button.Text = "Inf-Roll: true"
        iroll = true
        istC = RunService.Stepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("IST") then
                local ist = LocalPlayer.Character:FindFirstChild("IST")
                local cd1 = ist:FindFirstChild("cooldown")
                local cd2 = ist:FindFirstChild("cooldown2")
                if ist and cd1 and cd2 then
                    cd1.Value = false
                    cd2.Value = false
                end
            end
        end)
    else
        button.Text = "Inf-Roll: false"
        iroll = false
        pcall(function()
            istC:Disconnect()
            istC = nil
        end)
    end
end, 1)							
							
local bbbb = UIS.JumpRequest:Connect(function()
    if ijump then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local bbb = UIS.InputBegan:Connect(function(Key, Proc)
    if Proc then return end
    if Key.KeyCode == bind and ToolName ~= "" then
        local num = 0
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v.Name == ToolName then
                num = num+1 if (num + 1) >= am2eq then break end

                v.Parent = LocalPlayer.Character
                if acMethod == 1 then
                    v:Activate()
                else
                    mouse1click(Mouse.X, Mouse.Y)
                end
            end
        end
    end
end)

task.spawn(function()
	while task.wait() do
		wait(.2)
		for i,vv in pairs(Players:GetPlayers()) do
			for i,v in pairs(Cache) do
				if vv.Name == v then
					local Char = vv.Character or nil
					if Char and Char:FindFirstChildOfClass("Humanoid") and Char:FindFirstChild("Runscript") then
						Char.Runscript.run:FireServer(BOOL)
					end
				end
			end
		end
	end
end)
