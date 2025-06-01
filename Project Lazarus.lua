--[[
Workspace.Interact.UMP45.WallWeaponScript
]]

repeat task.wait() until game:IsLoaded()

wait(2)

local Add = loadstring(game:HttpGet("https://raw.githubusercontent.com/FadedIndividual/main/refs/heads/main/Library.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local Core = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

Lighting.GlobalShadows = false
Lighting.Brightness = 1

local GGName = "@nyu_. made this xoxo"
local sg = Instance.new("ScreenGui") sg.IgnoreGuiInset = true; sg.Name = GGName
local gethui = protectgui or gethui or get_hidden_gui

if gethui then
    if gethui():FindFirstChild(GGName) then
        gethui():FindFirstChild(GGName):Destroy()
    end
    sg.Parent = gethui()
else
    if Core:FindFirstChild(GGName) then
        Core:FindFirstChild(GGName):Destroy()
    end
    sg.Parent = Core
end

local MainSize, TopYSize, Hue, Round, nUm = UDim2.new(0, 500, 0, 400), 25, Color3.fromRGB(0, 120, 255), UDim.new(0, 8), 0

local Main = Add.Frame(sg, MainSize, UDim2.new(.5, -MainSize.X.Offset/2, .5, -MainSize.Y.Offset/2), {["BackgroundTran"] = 0.1, ["Draggable"] = true})
local TopSelec = Add.Frame(Main, UDim2.new(1, 0, 0, TopYSize), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1})
Add:Extra(TopSelec, {"uill", {["HorizonAlign"] = Enum.HorizontalAlignment.Center, ["FillDir"] = Enum.FillDirection.Horizontal}})
Add:Extra(Main, {"corner", {["rad"] = Round}})
Add:Extra(TopSelec, {"corner", {["rad"] = Round}})

local last = nil
local function Create_Category(Text) nUm += 1
    local bFrame = Add.Frame(Main, UDim2.new(1, 0, 1, -TopYSize), UDim2.new(0, 0, 0, TopYSize), {["Name"] = "Category_Frame", ["BackgroundTran"] = 1})
    Add:Extra(bFrame, {"uill", {["HorizonAlign"] = Enum.HorizontalAlignment.Center, ["FillDir"] = Enum.FillDirection.Vertical}})
    local bMain = Add.Button(TopSelec, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), Text, {["BackgroundColor"] = Color3.new(0, 0, 0), ["BackgroundTran"] = 1, ["Font"] = Enum.Font.Code, ["TextSize"] = TopYSize-6, ["LayoutOrder"] = nUm})
    local AMT = 0; for i,v in ipairs(TopSelec:GetChildren()) do if v:IsA("TextButton") then AMT += 1 end end for i,v in ipairs(TopSelec:GetChildren()) do if v:IsA("TextButton") then v.Size = UDim2.new(1/AMT, 0, 1, 0) end end

    if last then
        last = Add.Frame(bMain, UDim2.new(0, 1, 1, 0), UDim2.new(1, 0, 0, 0), {["BackgroundTran"] = .8, ["BackgroundColor"] = Hue})
        bFrame.Visible = false
    else
        last = Add.Frame(bMain, UDim2.new(0, 1, 1, 0), UDim2.new(1, 0, 0, 0), {["BackgroundTran"] = .8, ["BackgroundColor"] = Hue})
        bMain.TextSize = TopYSize-4
    end

    bMain.MouseButton1Click:Connect(function()
        task.spawn(function()
            local tt2 = Add.Frame(bMain, UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0), {["BackgroundTran"] = 1, ["BackgroundColor"] = Hue}) Add:Extra(tt2, {"corner", {["rad"] = Round}})
            TweenService:Create(tt2, TweenInfo.new(.21, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = .7}):Play()
            TweenService:Create(tt2, TweenInfo.new(.19, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = UDim2.new(1, 0, 1, 0)}):Play()
            TweenService:Create(tt2, TweenInfo.new(.19, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            task.wait(.2)
            tt2:Destroy()
        end)
        for i,v in pairs(Main:GetChildren()) do
            if v.Name == "Category_Frame" then
                v.Visible = false
            end
        end
        for i,v in ipairs(TopSelec:GetChildren()) do
            if v:IsA("TextButton") then
                v.TextSize = TopYSize-6
            end
        end
        bMain.TextSize = TopYSize-4
        bFrame.Visible = true
    end)

    return bFrame, bMain
end

local function Button(Parent, Text, Function, Type) nUm += 1
    local bMain = Add.Button(Parent, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), "", {["BackgroundColor"] = Color3.new(0, 0, 0), ["BackgroundTran"] = .75, ["TextSize"] = TopYSize-6, ["LayoutOrder"] = nUm})
    if Type == 1 then
        local line = Add.Text(bMain, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Hue, ["BackgroundTran"] = .8})
        bMain.Text = Text
        bMain["TextXAlignment"] = Enum.TextXAlignment.Center
        bMain.MouseButton1Click:Connect(function()
            task.spawn(function()
                local tt2 = Add.Frame(bMain, UDim2.new(0, 0, 1, 0), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["BackgroundColor"] = Hue}) Add:Extra(tt2, {"corner", {["rad"] = Round}})
                TweenService:Create(tt2, TweenInfo.new(.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = 0.8}):Play()
                TweenService:Create(tt2, TweenInfo.new(.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = UDim2.new(1, 0, 1, 0)}):Play()
                TweenService:Create(tt2, TweenInfo.new(.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                task.wait(.27)
                tt2:Destroy()
            end)
            Function(bMain)
        end)
    elseif Type == 2 then
        local mFrame = Add.Frame(Parent, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["LayoutOrder"] = nUm})
        local mLabe = Add.Text(mFrame, UDim2.new(.8, 0, 1, 0), UDim2.new(0, 0, 0, 0), "", {["BackgroundTran"] = .75, ["BackgroundColor"] = Color3.new(0, 0, 0), ["TextSize"] = TopYSize-6})
        local line = Add.Text(mLabe, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Hue, ["BackgroundTran"] = .8})
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
    local mBox = Add.Box(Parent, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), "", {["BackgroundColor"] = Color3.new(0, 0, 0), ["BackgroundTran"] = .75, ["TextSize"] = TopYSize-6, ["LayoutOrder"] = nUm})
    if Type == 1 then
        local line = Add.Text(mBox, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Hue, ["BackgroundTran"] = .8})
        mBox.PlaceholderText = Text
        mBox.FocusLost:Connect(function()
            Function(mBox)
        end)
    elseif Type == 2 then
        local mFrame = Add.Frame(Parent, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["LayoutOrder"] = nUm})
        mBox.Parent = mFrame
        mBox.Size = UDim2.new(.2, 0, 1, 0)
        mBox.Position = UDim2.new(.8, 0, 0, 0)
        mBox.BackgroundTransparency = .5
        local mBut = Button(mFrame, Text, function()
            Function(mBox, button)
        end, 1)
		if type(Text) ~= "string" then
            mBut.Text = Text[1]
			mBox.PlaceholderText = Text[2]
        else
            mBut.Text = Text
            bMain.Text = "..."
        end
        mBut.Size = UDim2.new(.8, 0, 1, 0)
    elseif Type == 3 then
        local mFrame = Add.Frame(Parent, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["LayoutOrder"] = nUm})
        local mLabe = Add.Text(mFrame, UDim2.new(.8, 0, 1, 0), UDim2.new(0, 0, 0, 0), "", {["BackgroundTran"] = .75, ["BackgroundColor"] = Color3.new(0, 0, 0), ["TextSize"] = TopYSize-6})
        local line = Add.Text(mLabe, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Hue, ["BackgroundTran"] = .8})
        mBox.Parent = mFrame
        mBox.Size = UDim2.new(.2, 0, 1, 0)
        mBox.Position = UDim2.new(.8, 0, 0, 0)
        mBox.BackgroundTransparency = .5
        mBox.FocusLost:Connect(function()
            Function(mBox, mLabe)
        end)
		if type(Text) ~= "string" then
            mLabe.Text = Text[1]
			mBox.PlaceholderText = Text[2]
        else
            mLabe.Text = Text
            bMain.Text = "..."
        end
    end
end

local function getChars()
	local Table = {}
	
	for i,v in pairs(Players:GetPlayers()) do
		if v.Character then
			table.insert(Table, v)
		end
	end
	
	return Table
end

local function isPartVisible(part)
    local orangee = LocalPlayer.Character:FindFirstChild("Head").Position
    local direct = (part.Position - orangee).unit
    local _dista = (part.Position - orangee).magnitude
    local raycastParams = RaycastParams.new()

	local Chars = getChars()
	table.insert(Chars, Camera)
	
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.RespectCanCollide = false
    raycastParams.FilterDescendantsInstances = Chars

    local result = workspace:Raycast(orangee, direct * _dista, raycastParams)
    if result and result.Instance then
        if result.Instance ~= part and not result.Instance:IsDescendantOf(part.Parent) then
            return false
        end
    else
        print("CANNOT DETECT ANYTHING")
        return false
    end
    return true
end

PositionToScreen = function(Vectorf)
    local Vector, OnScreen = Camera:WorldToScreenPoint(Vectorf)
    return Vector, OnScreen
end

local aimVis = false
GetClosestMouse = function(TBall)
    local Closest
    local MaxDistance = 5e5
    for _,v in next, TBall do
        local ScreenPosition, OnScreen = PositionToScreen(v:FindFirstChild("Head").Position)
        local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
        if OnScreen and Distance <= MaxDistance then
			if (aimVis == true and isPartVisible(v:FindFirstChild("Head"))) or aimVis == false then
				Closest = v
				MaxDistance = Distance
			end
        end
    end
    if Closest then
        return Closest
    else
        return nil
    end
end

local too = Create_Category("Weapon")
local map = Create_Category("Map")
local gmo0 = Create_Category("Gun Mods")
local loc = Create_Category("Local")

local isRecording = false

local bbbb = false
local bbowa = Button(too, "Silent Aim: false", function(button)
    bbbb = not bbbb
    button.Text = "Silent Aim: " .. tostring(bbbb)
end, 1)

local hbAim = "Head"
local bbowaHIT = Button(too, "Hitbox: Head", function(button)
    if hbAim == "Head" then
		hbAim = "Torso"
	else
		hbAim = "Head"
	end
    button.Text = "Hitbox: " .. hbAim
end, 1)

local avisBut = Button(too, "Vis-Check: false", function(button)
    aimVis = not aimVis
    button.Text = "Vis-Check: " .. tostring(aimVis)
end, 1)

local ashoot = false
local ashBut = Button(too, "Auto-Shoot Vis: false", function(button)
    ashoot = not ashoot
    button.Text = "Auto-Shoot Vis: " .. tostring(ashoot)
end, 1)

local abarrier = false
local boxwia = Button(map, "Auto-Barricade: false", function(button)
    abarrier = not abarrier
    button.Text = "Auto-Barricade: " .. tostring(abarrier)
end, 1)

task.spawn(function()
	while task.wait() do
		pcall(function()
			local Barricade, Distance = nil, 25
			for i,v in pairs(workspace.Interact:GetChildren()) do
				if v.Name == "Barricade" then task.wait()
					local Part = v:FindFirstChildOfClass("Part")
					local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					local _dist = (hrp.Position - Part.Position).Magnitude
					
					if Part and hrp and _dist <= Distance then
						Barricade = v
						Distance = _dist
					end
				end
			end
			if Barricade and abarrier then
				Barricade:FindFirstChild("Activate"):FireServer()
			end
		end)
	end
end)

local showBox = false
local boxwia = Button(map, "Show MysteryBox: false", function(button)
    showBox = not showBox
    button.Text = "Show MysteryBox: " .. tostring(showBox)
end, 1)

local openBoxKeybind = Enum.KeyCode.Z
local opeboxk = Button(map, {"Open Box:", "Z"}, function(button, text)
    isRecording = true
    task.wait(.3)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        openBoxKeybind = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(.3)
        isRecording = false
    end)
end, 2)

local packaPUNCHBIND = Enum.KeyCode.C
local opeboxk = Button(map, {"Pack-A-Punch Gun:", "C"}, function(button, text)
    isRecording = true
    task.wait(.3)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        packaPUNCHBIND = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(.3)
        isRecording = false
    end)
end, 2)

task.spawn(function()
	while task.wait() do
		pcall(function()
			if not UIS:GetFocusedTextBox() then
				local Interact = workspace:FindFirstChild("Interact")
				if UIS:IsKeyDown(openBoxKeybind) then
					Interact:FindFirstChild('MysteryBox'):FindFirstChild('Activate'):FireServer()
				elseif UIS:IsKeyDown(packaPUNCHBIND) then
					Interact:FindFirstChild("Pack-a-Punch"):FindFirstChild('Activate'):FireServer()
				end
			end
		end)
	end
end)

local function Perks()
	local Table = {}
	
	for i,v in pairs(workspace:FindFirstChild("Interact"):GetChildren()) do
		if v:FindFirstChild("PerkScript") then
			table.insert(Table, v)
		end
	end
	
	return Table
end

nUm += 1
local pkFrame = Add.Frame(map, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["LayoutOrder"] = nUm})
Add:Extra(pkFrame, {"uill", {["HorizonAlign"] = Enum.HorizontalAlignment.Center, ["FillDir"] = Enum.FillDirection.Horizontal}})
local Perks_Table = {}
task.spawn(function()
	repeat task.wait(1) until #Perks() >= 3
	Perks_Table = Perks()
	for i,v in pairs(Perks_Table) do
		local chekk, bPerk = false, false
		local perkBut = Button(pkFrame, v.Name, function(button)
			bPerk = not bPerk
			if chekk == false then
				task.spawn(function()
					while task.wait(.25) do
						if bPerk then
							button.BackgroundColor3 = Color3.new(0, 1, 0)
							pcall(function()
								v:FindFirstChild("Activate"):FireServer()
							end)
						else
							button.BackgroundColor3 = Color3.new(0, 0, 0)
						end
					end
				end)
			end
		end, 1)
	end
	for i,v in pairs(pkFrame:GetChildren()) do
		if v:IsA("TextButton") then
			v.Size = UDim2.new(1/#Perks_Table, 0, 1, 0)
			v.TextScaled = true
		end
	end
end)


local fovNum, changeCameraFOV = 90, nil
local bxFOV = Box(loc, "Camera FOV: ..", function(box)
	fovNum = tonumber(box.Text)
	if fovNum and fovNum >= 5 and fovNum <= 120 then
		box.PlaceholderText = "Camera FOV: " .. box.Text
	else
		fovNum = 90
		box.PlaceholderText = "Camera FOV: 90"
	end
    box.Text = ""
	if changeCameraFOV == nil then
		changeCameraFOV = Camera.Changed:Connect(function()
			Camera.FieldOfView = fovNum
		end)
	end
	LocalPlayer.Character.CamFOV.Value = fovNum
end, 1)

local aspeet, am2eq = false, 35
local spaBut = Button(loc, "Shift-Speed: false", function(button)
    aspeet = not aspeet
    button.Text = "Shift-Speed: " .. tostring(aspeet)
end, 1)

local aspetButton = Box(loc, {"Shift-Speed Amount:", "35"}, function(box, text)
    local nm = tonumber(box.Text)
    if nm then
        box.PlaceholderText = tostring(nm)
        box.Text = ""
        am2eq = nm
    else
        box.PlaceholderText = "35"
        box.Text = ""
        am2eq = 35
    end
end, 3)

local function onChar()
	local hum = LocalPlayer.Character and LocalPlayer.Character:WaitForChild("Humanoid")
	if not hum then
		repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		local hum = LocalPlayer.Character and LocalPlayer.Character:WaitForChild("Humanoid")
	end
	
	hum.Changed:Connect(function()
		if aspeet then
			hum.WalkSpeed = (UIS:IsKeyDown(Enum.KeyCode.LeftShift) and am2eq) or 16
		end
	end)
end
onChar()
LocalPlayer.CharacterAdded:Connect(function()
	onChar()
end)

local SB_Frame = Add.Frame(sg, UDim2.new(0, 200, 0, 30), UDim2.new(.5, -100, 1, -200), {["BackgroundTrans"] = 1})
Add:Extra(SB_Frame, {"UICorner", {}})
local SB_Slide = Add.Frame(SB_Frame, UDim2.new(0, 0, 1, 0), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = .5, ["BackgroundColor"] = Color3.new(0, 1, 0)})
Add:Extra(SB_Slide, {"UICorner", {}})

SB_Frame.Visible = false

local tpBind, dbDela = Enum.KeyCode.LeftControl, tick()
local TPbd2 = Button(loc, {"Speed-Boost:", "LeftControl"}, function(button, text)
    isRecording = true
    task.wait(.3)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        tpBind = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(.3)
        isRecording = false
    end)
end, 2)

local spbAMT = 10
local sbiButton = Box(loc, {"Speed-Boost Amount:", "10"}, function(box, text)
    local nm = tonumber(box.Text)
    if nm then
        box.PlaceholderText = tostring(nm)
        box.Text = ""
        spbAMT = nm
    else
        box.PlaceholderText = "10"
        box.Text = ""
        spbAMT = 10
    end
end, 3)

local abas = Button(loc, "Visualize Speed-Delay: false", function(button)
	SB_Frame.Visible = not SB_Frame.Visible
    button.Text = "Visualize Speed-Delay: " .. tostring(SB_Frame.Visible)
end, 1)

local bind = Enum.KeyCode.LeftAlt
local bt2 = Button(loc, {"Close Menu:", "LeftAlt"}, function(button, text)
    isRecording = true
    task.wait(.2)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        bind = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(.3)
        isRecording = false
    end)
end, 2)

nUm += 1
local gmoFrame = Add.Frame(gmo0, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 0, ["LayoutOrder"] = nUm})
Add:Extra(gmoFrame, {"uill", {["HorizonAlign"] = Enum.HorizontalAlignment.Center, ["FillDir"] = Enum.FillDirection.Horizontal}})
local GunMods_Array = {
	["Weapon1"] = {["Enabled"] = false},
	["Weapon2"] = {["Enabled"] = false},
	["Weapon3"] = {["Enabled"] = false}
}
local GunMods = {
	["Infinite-Ammo"] = false,
	["Instant-Kill"] = false,
	["No-Recoil"] = false,
	["No-Spread"] = false,
	["FireRate"] = 0.1,
	["Bullet-Pen"] = 2,
	["Instant-Aim"] = false
}

for i,v in pairs(GunMods_Array) do
	local wpbut = Button(gmoFrame, tostring(i), function(button)
		v.Enabled = not v.Enabled
		if v.Enabled then
			button.BackgroundColor3 = Color3.new(0, 1, 0)
		else
			button.BackgroundColor3 = Color3.new(0, 0, 0)
		end
	end, 1)
	wpbut.TextScaled = true
	wpbut.Size = UDim2.new(1/3, 0, 1, 0)
end

local iaBut = Button(gmo0, "Infinite-Ammo: false", function(button)
    GunMods["Infinite-Ammo"] = not GunMods["Infinite-Ammo"]
    button.Text = "Infinite-Ammo: " .. tostring(GunMods["Infinite-Ammo"])
end, 1)

local nreBut = Button(gmo0, "No-Recoil: false", function(button)
    GunMods["No-Recoil"] = not GunMods["No-Recoil"]
    button.Text = "No-Recoil: " .. tostring(GunMods["No-Recoil"])
end, 1)

local nospBut = Button(gmo0, "No-Spread: false", function(button)
    GunMods["No-Spread"] = not GunMods["No-Spread"]
    button.Text = "No-Spread: " .. tostring(GunMods["No-Spread"])
end, 1)

local iaBut = Button(gmo0, "Instant-Aim: false", function(button)
    GunMods["Instant-Aim"] = not GunMods["Instant-Aim"]
    button.Text = "Instant-Aim: " .. tostring(GunMods["Instant-Aim"])
end, 1)

local iaBut = Button(gmo0, "Instant-Kill: false", function(button)
    GunMods["Instant-Kill"] = not GunMods["Instant-Kill"]
    button.Text = "Instant-Kill: " .. tostring(GunMods["Instant-Kill"])
end, 1)

local bx = Box(gmo0, "FireRate: .01", function(box)
	local nuuum = tonumber(box.Text)
	if nuuum and nuuum>= .0000001 then
		GunMods.FireRate = nuuum
	else
		GunMods.FireRate = .01
	end
	box.PlaceholderText = "FireRate: " .. tostring(GunMods.FireRate)
    box.Text = ""
end, 1)

local bx = Box(gmo0, "Bullet-Pen: 2", function(box)
	local nuuum = tonumber(box.Text)
	if nuuum and nuuum>= 1 then
		GunMods["Bullet-Pen"] = nuuum
	else
		GunMods["Bullet-Pen"] = 2
	end
	box.PlaceholderText = "Bullet-Pen: " .. tostring(GunMods["Bullet-Pen"])
    box.Text = ""
end, 1)

task.spawn(function()
	while task.wait(.5) do
		for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
			local n2bModded = false
			for a,z in pairs(GunMods_Array) do
				if a == v.Name and z.Enabled then
					n2bModded = true
				end
			end
			if n2bModded then
				local a = require(v)
				
				if GunMods["Instant-Kill"] then
					if a.Splash then
						a.Splash.Damage.Min = 1e5
						a.Splash.Damage.Max = 9e9
					else
						a.Damage.Min = 1e5
						a.Damage.Max = 9e9
					end
				end
				if GunMods["Infinite-Ammo"] then
					a.MaxAmmo = 9e9
					a.StoredAmmo = 9e9
					a.Ammo = 9e9
				end
				if GunMods["No-Recoil"] then
					a.ViewKick.Yaw.Min = 0
					a.ViewKick.Yaw.Max = 0
					a.ViewKick.Pitch.Min = 0
					a.ViewKick.Pitch.Max = 0
					a.GunKick = 0
				end
				if GunMods["No-Spread"] then
					a.Spread.Min = 0
					a.Spread.Max = 0
				end
				if GunMods["Instant-Aim"] then
					a.AimTime = .01
				end
				a.FireTime = GunMods.FireRate
				a.BulletPenetration = GunMods["Bullet-Pen"]
			end
		end
	end
end)

UIS.InputBegan:Connect(function(Key, Proc)
    if Proc or isRecording then return end

    if Key.KeyCode == tpBind then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and (tick()-dbDela)>= .1 then
            dbDela = tick()
            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (moveDir.Unit * spbAMT)
            else
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, -spbAMT)
            end
        end
	elseif Key.KeyCode == bind then
		Main.Visible = not Main.Visible
	end
end)

task.spawn(function()
    while task.wait(.25) do
        pcall(function()
            for i,v in pairs(workspace.Baddies:GetChildren()) do
                if v:FindFirstChildOfClass("Humanoid") then
                    if not v:FindFirstChild("Highh") then
                        local High = Instance.new("Highlight") High.Parent = v; High.Name = "Highh"; High.Adornee = v; High.OutlineColor = v.Color High.OutlineTransparency = .25; High.FillTransparency = 1; High.Enabled = true; High.LineThickness = 3; High.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
	while task.wait(1) do
		for ii,zz in pairs(workspace.Interact:GetChildren()) do
			if zz.Name == "Barricade" then
				for i,v in pairs(zz:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanQuery = false
					end
				end
			end
		end
	end
end)

local HitPart, highBox = nil, Instance.new("Highlight"); highBox.Adornee = nil; highBox.Parent = workspace; highBox.Enabled = false; highBox.Name = "showBox"; highBox.OutlineColor = Color3.new(0, 1, 0) highBox.OutlineTransparency = 0; highBox.FillTransparency = 1; highBox.LineThickness = 3; highBox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

RunService.Stepped:Connect(function()
    local numm = math.clamp(tick()-dbDela, 0, .1)
    SB_Slide.Size = UDim2.new(numm*10, 0, 1, 0)
    if numm == .1 then
        SB_Slide.BackgroundTransparency = .7
		SB_Slide.BackgroundColor3 = Color3.new(0, 1, 0)
    else
        SB_Slide.BackgroundTransparency = .9
		SB_Slide.BackgroundColor3 = Color3.new(1, 0, 0)
    end

    local tbll = {}
    for i,v in pairs(workspace.Baddies:GetChildren()) do
        if v:FindFirstChildOfClass("Humanoid") then
            table.insert(tbll, v)
        end
    end
	
	local box = workspace:FindFirstChild("Interact") and workspace:FindFirstChild("Interact"):FindFirstChild("MysteryBox")
	
	if box then
		if showBox then
			highBox.Adornee = box
			highBox.Enabled = true
		else
			highBox.Adornee = nil
			highBox.Enabled = false
		end
	else
		highBox.Adornee = nil
		highBox.Enabled = false
	end

    local ss = GetClosestMouse(tbll)
    if ss then
        HitPart = ss:FindFirstChild(hbAim)
		if bbbb and Main.Visible == false and not UIS:GetFocusedTextBox() and iswindowactive() and ashoot and HitPart and HitPart.Parent and HitPart.Parent:FindFirstChildOfClass("Humanoid") and HitPart.Parent.Humanoid.Health >= .1 and tonumber(LocalPlayer.PlayerGui.HUD.Ammo.Mag.Text) > 0 then
			if isPartVisible(HitPart) then
				mouse1click()
			end
		end
    else
        HitPart = nil
    end
end)

last:Destroy()

RaycastEX = {
    ArgCountRequired = 3,
    Args = {
        "Instance", "Vector3", "Vector3", "RaycastParams"
    }
}

local function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then
        return false
    end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then
            Matches = Matches + 1
        end
    end
    return Matches >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
	
    if bbbb and self == workspace and not checkcaller() then
        if ValidateArguments(Arguments, RaycastEX) then
            local A_Origin = Arguments[2]

            if HitPart then
                Arguments[3] = getDirection(A_Origin, HitPart.Position)

                return oldNamecall(unpack(Arguments))
            end
        end
    elseif not checkcaller() and Method == "FireServer" and tostring(self) == "SendData" then
        return nil
    end
    return oldNamecall(...)
end))
