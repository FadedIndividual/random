--Gun
--Knife
--Workspace.Hotel.GunDrop.TouchInterest
--Workspace.Hotel.CoinContainer

repeat task.wait() until game:IsLoaded(); wait(2)

if tostring(game.PlaceId) ~= "142823291" then return end

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
Lighting.Brightness = .8

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
local isRecording = false
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

PositionToScreen = function(Vectorf)
    local Vector, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(Vectorf)
    return Vector, OnScreen
end

local function isPartVisible(part)
    local orangee = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
	if not orangee then return false end
	local origin = orangee.Position
    local direction = (part.Position - origin).Unit * (part.Position - origin).Magnitude

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.RespectCanCollide = false

	local ignoreList = {}
	for _, v in pairs(Players:GetPlayers()) do
		if v.Character then
			table.insert(ignoreList, v.Character)
		end
	end
	table.insert(ignoreList, Camera)

    raycastParams.FilterDescendantsInstances = ignoreList

    local result = workspace:Raycast(origin, direction, raycastParams)
    if result and result.Instance then
        if result.Instance ~= part and not result.Instance:IsDescendantOf(part.Parent) then
            return false
        end
    else
        return false
    end
    return true
end

local too = Create_Category("Players")
local map = Create_Category("Map")
local loc = Create_Category("Local")

local a = require(ReplicatedStorage.Modules.CurrentRoundClient)
local Role = ""

local SAim = false
local abas = Button(too, "Silent Aim: false", function(button)
	SAim = not SAim
    button.Text = "Silent Aim: " .. tostring(SAim)
end, 1)

local ESPR = false
local abas = Button(too, "ESP Roles: false", function(button)
	ESPR = not ESPR
    button.Text = "ESP Roles: " .. tostring(ESPR)
end, 1)

local AGrab = false
local abas = Button(map, "Auto-Grab Revolver: false", function(button)
	AGrab = not AGrab
    button.Text = "Auto-Grab Revolver: " .. tostring(AGrab)
end, 1)

local AGrabCOi = false
local abas = Button(map, "Auto-Grab Coins (Near): false", function(button)
	AGrabCOi = not AGrabCOi
    button.Text = "Auto-Grab Coins (Near): " .. tostring(AGrabCOi)
end, 1)

local SB_Frame = Add.Frame(sg, UDim2.new(0, 200, 0, 30), UDim2.new(.5, -100, 1, -200), {})
Add:Extra(SB_Frame, {"UICorner", {}})
local SB_Slide = Add.Frame(SB_Frame, UDim2.new(0, 0, 1, 0), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = .5, ["BackgroundColor"] = Color3.new(0, 1, 0)})
Add:Extra(SB_Slide, {"UICorner", {}})

SB_Frame.Visible = false

local tpBind, dbDela = Enum.KeyCode.Z, tick()
local TPbd2 = Button(loc, {"Speed-Boost:", "Z"}, function(button, text)
    isRecording = true
    task.wait(.3)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        tpBind = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(1)
        isRecording = false
    end)
end, 2)

local spbAMT, deLaAy = 10, 1
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
    task.wait(.3)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        bind = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(.3)
        isRecording = false
    end)
end, 2)

UIS.InputBegan:Connect(function(Key, Proc)
    if Proc or isRecording then return end

    if Key.KeyCode == bind then
        Main.Visible = not Main.Visible
	elseif Key.KeyCode == tpBind then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and (tick()-dbDela)>= deLaAy then
            dbDela = tick()
            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (moveDir.Unit * spbAMT)
            else
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, -spbAMT)
            end
        end
    end
end)

local HitPart = nil
RunService.Stepped:Connect(function()
	local numm = math.clamp(tick()-dbDela, 0, deLaAy)
    SB_Slide.Size = UDim2.new(numm*(1/deLaAy), 0, 1, 0)
    if numm == deLaAy then
        SB_Slide.BackgroundTransparency = 0
		SB_Slide.BackgroundColor3 = Color3.new(0, 1, 0)
    else
        SB_Slide.BackgroundTransparency = .55
		SB_Slide.BackgroundColor3 = Color3.new(1, 0, 0)
    end
	
	a = require(ReplicatedStorage.Modules.CurrentRoundClient)
	
	local LocalData = a.PlayerData[LocalPlayer.Name]
	if LocalData then
		Role = LocalData.Role
	end
	
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	
	local Coins = nil
	for i,v in pairs(workspace:GetChildren()) do
		if v:FindFirstChild("CoinContainer") then
			Coins = v:FindFirstChild("CoinContainer")
		end
	end
	
	if Coins and AGrabCOi then
		for i,v in pairs(Coins:GetChildren()) do
			if hrp and v:IsA("BasePart") and (v.Position-hrp.Position).Magnitude <= 15 then
				firetouchinterest(v, hrp, true)
				firetouchinterest(v, hrp, false)
			end
		end
	end
	
	local Dropped_Part = nil
	for i,v in pairs(workspace:GetChildren()) do
		if v:FindFirstChild("GunDrop") then
			Dropped_Part = v:FindFirstChild("GunDrop")
		end
	end

	if AGrab and Dropped_Part and LocalData and LocalData.Dead == false and Role == "Innocent" and hrp then
		firetouchinterest(Dropped_Part, hrp, true)
		firetouchinterest(Dropped_Part, hrp, false)
	end
	
	local _Dist, Closest = 5e5, nil
	for i,v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then
			local data = a.PlayerData[tostring(v)]
			if data then
				--print(v.Name, data.Role, data.Dead)
				if v.Character then
					if not v.Character:FindFirstChild("Highh") and data.Dead == false then
						local High = Instance.new("Highlight")
						High.Name = "Highh"
						High.OutlineTransparency = 1
						High.FillTransparency = .25
						High.LineThickness = 0
						High.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						High.FillColor = Color3.new(0, 1, 0)
						
						High.Enabled = true
						High.Adornee = v.Character
						
						High.Parent = v.Character
					elseif v.Character:FindFirstChild("Highh") and data.Dead == true then
						v.Character:FindFirstChild("Highh"):Destroy()
					end
					if data.Role == "Sheriff" and v.Character and v.Character:FindFirstChild("Highh") then
						v.Character:FindFirstChild("Highh").FillColor = Color3.new(0, 0, 1)
					elseif data.Role == "Murderer" and v.Character and v.Character:FindFirstChild("Highh") then
						v.Character:FindFirstChild("Highh").FillColor = Color3.new(1, 0, 0)
					end
				end
			end
			if Role == "Sheriff" or Role == "Innocent" then
				local High = v.Character and v.Character:FindFirstChild("Highh")
				if High and High.FillColor == Color3.new(1, 0, 0) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
					HitPart = v.Character:FindFirstChild("HumanoidRootPart")
				end
			elseif Role == "Murderer" then
				local ScreenPosition, OnScreen = PositionToScreen(v.Character:FindFirstChild("HumanoidRootPart").Position)
				local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
				if OnScreen and Distance <= _Dist then
					Closest = v
					_Dist = Distance
				end
			end
			local High = v.Character and v.Character:FindFirstChild("Highh")
			if High then
				High.Enabled = ESPR
			end
		end
	end
	
	if Role == "Murderer" and Closest and Closest.Character and Closest.Character:FindFirstChild("HumanoidRootPart") then
		HitPart = Closest.Character:FindFirstChild("HumanoidRootPart")
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
	
    if SAim and self == workspace and not checkcaller() then
        if ValidateArguments(Arguments, RaycastEX) then
            local A_Origin = Arguments[2]

            if HitPart then
                Arguments[3] = getDirection(A_Origin, HitPart.Position)

                return oldNamecall(unpack(Arguments))
            end
        end
    end
    return oldNamecall(...)
end))
