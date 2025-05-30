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

local aimbor = Create_Category("Main")
local sett = Create_Category("Settings")

local Cork = Instance.new("Folder")
Cork.Name = "fld"
Cork.Parent = gethui()

local aimEnabled, aimVisOnly, fovVis = false, true, false
local espEnabled = false
local _FOV = 50

local num, CC, _Folders, _Locked = 2, workspace.CurrentCamera, {}, nil
local circle = Drawing.new("Circle")
circle.Radius = _FOV
circle.Color = Color3.fromRGB(100, 0, 255)
circle.Filled = false
circle.NumSides = 300
circle.Transparency = 0.4
circle.Visible = false
circle.Thickness = 1

local function GetTeam(Part) 
    for i,Vest in pairs(Part:GetDescendants()) do
        if Vest.ClassName == "MeshPart" and Vest.MeshId == "rbxassetid://11232478007" and Vest.BrickColor == BrickColor.new("Earth blue") then
            return game:GetService("Teams").Phantoms;
        end
    end

    return game:GetService("Teams").Ghosts;
end

local function GetChars()
    local Teams, num = {["Ghosts"] = {};["Phantoms"] = {}}, 0
    
    if workspace:FindFirstChild("Players") and #workspace.Players:GetChildren() >= 2 then
        pcall(function()
            for _,z in pairs(workspace.Players:GetChildren()) do
                if tostring(GetTeam(z:GetChildren()[1])) == "Ghosts" then
                    Teams.Ghosts = z:GetChildren()
                else
                    Teams.Phantoms = z:GetChildren()
                end
            end
        end)
    end

    return Teams
end
function GetGUN()
    local gun;

    if #CC:GetChildren() >= 2 then
        for _,z in pairs(CC:GetChildren()) do
            if not z:FindFirstChild("Arms") and z:IsA("Model") then
                gun = z
            end
        end
    end

    return gun
end
function _Heads()
    local TBLL = {}
    if _Folders then
        for iii, zz in pairs(_Folders) do
            if tostring(iii) ~= tostring(LocalPlayer.Team) then
                for ii, vv in pairs(zz) do
					for _, v in pairs(vv:GetDescendants()) do
						if v:IsA("BasePart") and v:FindFirstChildOfClass("SpecialMesh") and v:FindFirstChildOfClass("SpecialMesh").MeshId == "rbxassetid://6179256256" then
							table.insert(TBLL, v)
						end
					end
                end
            end
        end
    end
    if #TBLL == 0 then return end
    return TBLL
end

PositionToScreen = function(Vectorf)
    local Vector, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(Vectorf)
    return Vector, OnScreen
end

local function isPartVisible(part)
    local origin = CC.CFrame.Position
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {CC,tostring(LocalPlayer.Team) == "Phantoms" and _Folders["Ghosts"] or _Folders["Phantoms"]}

    local size = part.Size / 2
    local cf = part.CFrame
    local offsets = {
        Vector3.new(0, 0, 0),
        Vector3.new( size.X,  size.Y,  size.Z),
        Vector3.new(-size.X,  size.Y,  size.Z),
        Vector3.new( size.X, -size.Y,  size.Z),
        Vector3.new(-size.X, -size.Y,  size.Z),
        Vector3.new( size.X,  size.Y, -size.Z),
        Vector3.new(-size.X,  size.Y, -size.Z),
        Vector3.new( size.X, -size.Y, -size.Z),
        Vector3.new(-size.X, -size.Y, -size.Z),
    }

    for _, offset in ipairs(offsets) do
        local point = cf.Position + cf:VectorToWorldSpace(offset)
        local direction = (point - origin).Unit
        local distance = (point - origin).Magnitude

        local result = workspace:Raycast(origin, direction * distance, raycastParams)
        if not result or result.Instance == part then
            return true
        end
    end

    return false
end

GetClosestMouse = function(TBall)
    local Closest
    local MaxDistance = _FOV
    for _,Head in next, TBall do
        if (aimVisOnly and isPartVisible(Head)) or aimVisOnly==false then
            local ScreenPosition, OnScreen = PositionToScreen(Head.Position)
            local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
            if OnScreen and Distance <= MaxDistance then
                Closest = Head
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

local bt2 = Button(aimbor, "Aimbot: false", function(button)
    aimEnabled = not aimEnabled
	button.Text = "Aimbot: " .. tostring(aimEnabled)
end, 1)

local bt2 = Button(aimbor, "Aim Visible: true", function(button)
    aimVisOnly = not aimVisOnly
	button.Text = "Aim Visible: " .. tostring(aimVisOnly)
end, 1)

local bt3 = Button(aimbor, "FOV Circle: false", function(button)
    fovVis = not fovVis
	button.Text = "FOV Circle: " .. tostring(fovVis)
end, 1)

local bx2 = Box(aimbor, "FOV: 50", function(box)
	local nuum = tonumber(box.Text)
	if nuum then
		_FOV = nuum
		box.PlaceholderText = "FOV: " .. box.Text
	else
		_FOV = 50
		box.PlaceholderText = "FOV: 50"
	end
    box.Text = ""
end, 1)

local bt4 = Button(aimbor, "ESP: false", function(button)
    espEnabled = not espEnabled
	button.Text = "ESP: " .. tostring(espEnabled)
end, 1)

local bind = Enum.KeyCode.LeftAlt
local bt2 = Button(sett, {"Close Menu:", "LeftAlt"}, function(button, text)
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

UIS.InputBegan:Connect(function(Key, Proc)
    if Proc or isRecording then return end

    if Key.KeyCode == bind then
		Main.Visible = not Main.Visible
	end
end)

last:Destroy()

local aimCon = RunService.Stepped:Connect(function()
	circle.Position = Vector2.new(Mouse.X, Mouse.Y+60)
	circle.Visible = fovVis
	circle.Radius = _FOV
	
	_Folders = GetChars()
    if _Folders then
        pcall(function()
            if not _Locked or _Locked == nil or not (_Locked~=nil) or not pcall(function() _Locked.Transparency = _Locked.Transparency end) or not UIS:IsMouseButtonPressed(0) or not UIS:IsMouseButtonPressed(1) then
			    _Locked = GetClosestMouse(_Heads())
            end
		end)
    end
	
	if _Locked and UIS:IsMouseButtonPressed(1) and aimEnabled then
        pcall(function()
            local vec, _fp = nil, CC:FindFirstChildOfClass("Part")
            local _Dist = (_fp.Position - _Locked.Position).Magnitude
            if _Dist >= 100 then
                vec = PositionToScreen((UIS:IsMouseButtonPressed(0) and (_Locked.Position + Vector3.new(0, .45*_Dist/100, 0)) or (_Locked.Position + Vector3.new(0, (.35*_Dist/100), 0))))
            else
                vec = PositionToScreen((UIS:IsMouseButtonPressed(0) and (_Locked.Position + Vector3.new(0, -(.1*(_Dist/100)), 0)) or (_Locked.Position + Vector3.new(0, -.12, 0))))
            end
            mousemoverel(((vec.X-Mouse.X)/1.25), ((vec.Y-Mouse.Y)/1.25))
        end)
    end
end)

local tk = tick()
task.spawn(function() while task.wait() do
    _Folders = GetChars()
    if _Folders and espEnabled then
        for i, v in pairs(_Folders) do
            if tostring(i) == tostring(LocalPlayer.Team) then
            else task.wait()
                if #v >= 2 then
                    for _,z in pairs(v) do
                        if not Cork:FindFirstChild("_"..z.Name) then
                            local High = Instance.new("Highlight")
                            High.Parent = Cork; High.Name = "_"..z.Name; High.Adornee = z; High.OutlineColor = Color3.fromRGB(255, 0, 0) High.OutlineTransparency = .25; High.FillTransparency = 1; High.Enabled = true; High.LineThickness = 3; High.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        end
                    end
                end
            end
        end
    end

    if Cork and #Cork:GetChildren() >= 1 then
        if espEnabled == true then
            if (tick()-tk) <= 60 then
                for i, v in pairs(Cork:GetChildren()) do task.wait()
                    if v.Adornee then
                        v.OutlineColor = Color3.fromRGB(255, 0, 0)
                    else
                        v:Destroy()
                    end
                end
            else
                tk = tick()
                for i, v in pairs(Cork:GetChildren()) do
                    v:Destroy()
                end
            end
        else
            for i, v in pairs(Cork:GetChildren()) do
                v:Destroy()
            end
        end
    end
end end)
