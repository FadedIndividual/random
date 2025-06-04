repeat task.wait() until game:IsLoaded(); wait(2)

if tostring(game.PlaceId) ~= "391104146" then return end

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
        mBox.PlaceholderText = "..."
        local mBut = Button(mFrame, Text, function()
            Function(mBox, button)
        end, 1)
        mBut.Size = UDim2.new(.8, 0, 1, 0)
    elseif Type == 3 then
        local mFrame = Add.Frame(Parent, UDim2.new(1, 0, 0, TopYSize-3), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = 1, ["LayoutOrder"] = nUm})
        local mLabe = Add.Text(mFrame, UDim2.new(.8, 0, 1, 0), UDim2.new(0, 0, 0, 0), Text, {["BackgroundTran"] = .75, ["BackgroundColor"] = Color3.new(0, 0, 0), ["TextSize"] = TopYSize-6})
        local line = Add.Text(mLabe, UDim2.new(1, 0, 0, 1), UDim2.new(0, 0, 1, -1), "", {["BackgroundColor"] = Hue, ["BackgroundTran"] = .8})
        mBox.Parent = mFrame
        mBox.Size = UDim2.new(.2, 0, 1, 0)
        mBox.Position = UDim2.new(.8, 0, 0, 0)
        mBox.BackgroundTransparency = .5
        mBox.PlaceholderText = "..."
        mBox.FocusLost:Connect(function()
            Function(mBox, mLabe)
        end)
    end
end

PositionToScreen = function(Vectorf)
    local Vector, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(Vectorf)
    return Vector, OnScreen
end

GetClosestMouse = function(TBall)
    local Closest
    local MaxDistance = 5e5
    for _,v in next, TBall do
        local ScreenPosition, OnScreen = PositionToScreen(v.Character:FindFirstChild("HumanoidRootPart").Position)
        local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
        if OnScreen and Distance <= MaxDistance then
            Closest = v
            MaxDistance = Distance
        end
    end
    if Closest then
        return Closest
    else
        return nil
    end
end

local function isPartVisible(part)
    local orangee = LocalPlayer.Character:FindFirstChild("Head").Position
    local direct = (part.Position - orangee).unit
    local _dista = (part.Position - orangee).magnitude
    local raycastParams = RaycastParams.new()

    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {Camera, LocalPlayer.Character}

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

local NormalGravity = workspace.Gravity
local Raw = getrawmetatable(game)
local Caller = checkcaller or is_protosmasher_caller or Cer.isCerus
local CallingScript = getcallingscript or get_calling_script
local Closure = newcclosure or read_me or function(Func)
    return Func
end
local CallingMethod = getnamecallmethod or get_namecall_method

setreadonly(Raw, false)
local NewIndex = Raw.__newindex
Raw.__newindex = Closure(function(self, Property, Value)
    if Caller() then
        return NewIndex(self, Property, Value)
    end
    if Property == 'WalkSpeed' then
        return 16
    end
    if Property == 'JumpPower' then
        return 37.5
    end
    if Property == 'HipHeight' then
        return 0
    end
    if self == workspace and Property == 'Gravity' then
        return NormalGravity
    end
    if Property == 'CFrame' and self:IsDescendantOf(LocalPlayer.Character) then
        return
    end
    return NewIndex(self, Property, Value)
end)

local Namecall = Raw.__namecall
Raw.__namecall = Closure(function(self, ...)
    local Args = { ... }
    if Caller() then
        if CallingMethod() == 'FindFirstChild' and Args[1] == 'HumanoidRootPart' then
            Args[1] = 'HumanoidRootPart'
            return Namecall(self, unpack(Args))
        end
        return Namecall(self, ...)
    end
    if CallingMethod() == 'Destroy' or CallingMethod() == 'Kick' then
        if self == lp then
            return wait(9e9)
        end
        if tostring(self) == 'BodyGyro' or tostring(self) == 'BodyVelocity' then
            return wait(9e9)
        end
    end
    if CallingMethod() == 'BreakJoints' and self == LocalPlayer.Character then
        return wait(9e9)
    end
    return Namecall(self, ...)
end)
setreadonly(Raw, true)

local too = Create_Category("Tools")
local loc = Create_Category("Local")

local fTool = Button(too, "Grab Fling Tool", function(button)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local Saved = hrp.CFrame
		
		hrp.CFrame = CFrame.new(-214.904175, 3.20000005, -125.358391)
		
		task.wait(.8)
		
		hrp.Anchored = true
		
		
		for _, z in pairs(workspace['made byFoxBin MK2']['Made by orinrino']['GearDispenser']['Dispenser']['Buttons']['Powerup']['Button_Burrito']:GetChildren()) do
			fireclickdetector(z, 1)
		end
		
		repeat task.wait() until LocalPlayer.Backpack:FindFirstChild("FoxBin's Magic Hand") or LocalPlayer.Backpack:FindFirstChild("OctopusCannon") or LocalPlayer.Backpack:FindFirstChild("PortableJustice")
		
		hrp.Anchored = false
		hrp.CFrame = Saved
	end
end, 1)

local jTool = Button(too, "Grab Jail Tool", function(button)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local Saved = hrp.CFrame
		
		hrp.CFrame = CFrame.new(-214.904175, 3.20000005, -125.358391)
		
		task.wait(.8)
		
		hrp.Anchored = true
		
		for _, v in pairs(workspace['made byFoxBin MK2']['Made by orinrino']['GearDispenser']['Dispenser']['Buttons']['Ranged']['Button_Flashbang']:GetChildren()) do
			fireclickdetector(v, 1)
		end
		
        repeat task.wait() until LocalPlayer.Backpack:FindFirstChild("FoxBin's Magic Hand") or LocalPlayer.Backpack:FindFirstChild("OctopusCannon") or LocalPlayer.Backpack:FindFirstChild("PortableJustice")
		
		hrp.Anchored = false
		hrp.CFrame = Saved
	end
end, 1)

local f3xTool = Button(too, "Grab F3x Tool", function(button)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local Saved = hrp.CFrame
		
		hrp.CFrame = CFrame.new(9.3266716, 3.19999909, -120.593842)
		
		task.wait()
		
		TweenService:Create(hrp, TweenInfo.new(.15), {CFrame = CFrame.new(9.3266716, 3.19999909, -112.593842)}):Play()
		task.wait(.15)
		TweenService:Create(hrp, TweenInfo.new(.15), {CFrame = CFrame.new(9.3266716, 3.19999909, -120.593842)}):Play()
		
		task.wait(.3)
		
		hrp.CFrame = Saved
	end
end, 1)

local lfesp = false
local lfESP = Button(too, "Loop Fling: false", function(button)
    lfesp = not lfesp
	button.Text = "Loop Fling: " .. tostring(lfesp)
end, 1)

local ljesp = false
local ljESP = Button(too, "Loop Jail: false", function(button)
    ljesp = not ljesp
	button.Text = "Loop Jail: " .. tostring(ljesp)
end, 1)

local hdkill = false
local lfESP = Button(too, "Handle Kill: false", function(button)
    hdkill = not hdkill
	button.Text = "Handle Kill: " .. tostring(hdkill)
end, 1)

local lcJump = false
local jpButton = Button(loc, "Inf-Jump: false", function(button)
    lcJump = not lcJump
	button.Text = "Inf-Jump: " .. tostring(lcJump)
end, 1)

local shPeed = false
local noButton = Button(loc, "Shift-Speed: false", function(button)
    shPeed = not shPeed
	button.Text = "Shift-Speed: " .. tostring(shPeed)
end, 1)

local shSpeed = 1
local bx = Box(loc, "Speed: 1", function(box)
	shSpeed = tonumber(box.Text) or 1
    box.PlaceholderText = "Speed: " .. tostring(shSpeed)
    box.Text = ""
end, 1)

local chNoclip = false
local noButton = Button(loc, "Noclip: false", function(button)
    chNoclip = not chNoclip
	button.Text = "Noclip: " .. tostring(chNoclip)
	
	if chNoclip == false then
		pcall(function()
			local torso, head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Torso"), LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
			if torso and head then
				torso.CanCollide = true
				head.CanCollide = true
			end
		end)
	end
end, 1)

local miButton1 = Button(loc, "Goto Main Island", function(button)
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(-200.904175, 3.20000005, -100.358391)
	end
end, 1)

local bind2, cache = Enum.KeyCode.R, {}
local bd2 = Button(loc, {"ESP Mouse:", "R"}, function(button, text)
    isRecording = true
    task.wait(.3)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        bind2 = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(1)
        isRecording = false
    end)
end, 2)

local bind5 = Enum.KeyCode.V
local bdaa = Button(loc, {"UNESP Mouse:", "V"}, function(button, text)
    isRecording = true
    task.wait(.3)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        bind5 = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(.3)
        isRecording = false
    end)
end, 2)

local bind3 = Enum.KeyCode.X
local bt4 = Button(loc, {"Delete ESP:", "X"}, function(button, text)
    isRecording = true
    task.wait(.3)
    UIS.InputBegan:Once(function(Key, Proc)
        if Proc then return end

        bind3 = Key.KeyCode
        button.Text = string.gsub(tostring(Key.KeyCode), "Enum.KeyCode.", "")

        task.wait(.3)
        isRecording = false
    end)
end, 2)

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
    elseif Key.KeyCode == bind2 then
        local chars = {}
        for i,v in pairs(Players:GetPlayers()) do
            if v~=LocalPlayer then
                if v.Character and v.Character:FindFirstChildOfClass("Humanoid") then
                    table.insert(chars, v)
                end
            end
        end
        local clost, isThere = GetClosestMouse(chars), false
        for i,v in pairs(cache) do
            if v.Name == clost.Name then
                isThere = true
            end
        end
        if isThere == false then
            local randx, randy, randz = math.random(1, 255), math.random(1, 255), math.random(1, 255)
            cache[#cache+1] = {["Name"] = clost.Name, ["Player"] = clost, ["Color"] = Color3.fromRGB(randx, randy, randz)}
        end
    elseif Key.KeyCode == bind5 then
        local chars = {}
        for i,v in pairs(Players:GetPlayers()) do
            if v~=LocalPlayer then
                if v.Character and v.Character:FindFirstChildOfClass("Humanoid") then
                    table.insert(chars, v)
                end
            end
        end
        local clost, isThere, intt = GetClosestMouse(chars), false, 0
        for i,v in pairs(cache) do
            if v.Name == clost.Name then
                isThere = true
                intt = i
            end
        end
        if isThere == true then
            pcall(function()
                clost.Character:FindFirstChild("Highh"):Destroy()
            end)
            table.remove(cache, intt)
        end
    elseif Key.KeyCode == bind3 then
        for i,v in pairs(cache) do
            cache = {}
            pcall(function()
                v.Player.Character:FindFirstChild("Highh"):Destroy()
            end)
        end
    end
end)

Players.PlayerRemoving:Connect(function(Playa)
    local it, ia = 0, false
    for i,v in pairs(cache) do
        if v.Name == Playa.Name then
            it = i
            ia = true
        end
    end
    if ia and it ~= 0 then
        table.remove(cache, it)
    end
end)

task.spawn(function()
    while task.wait(.25) do
        pcall(function()
            for i,v in pairs(cache) do
                if v.Player.Character then
                    if not v.Player.Character:FindFirstChild("Highh") then
                        local High = Instance.new("Highlight") High.Parent = v.Player.Character; High.Name = "Highh"; High.Adornee = v.Character; High.OutlineColor = v.Color High.OutlineTransparency = .25; High.FillTransparency = 1; High.Enabled = true; High.LineThickness = 3; High.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
	while task.wait() do
		pcall(function()
			if hdkill then
				local toolh = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool") and LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Handle")
				if toolh and toolh.Parent.Name ~= "FoxBin's Magic Hand" and toolh.Parent.Name ~= "PortableJustice" and #cache>=1 then
					for i,v in pairs(cache) do
						if v.Player.Character and v.Player.Character:FindFirstChildOfClass("Humanoid") and not v.Player.Character:FindFirstChildOfClass("ForceField") and v.Player.Character:FindFirstChildOfClass("Humanoid").Health >= 1 and v.Player.Character:FindFirstChild("HumanoidRootPart") then task.wait(.15)
							firetouchinterest(toolh, v.Player.Character:FindFirstChild("HumanoidRootPart"), 1)
							firetouchinterest(toolh, v.Player.Character:FindFirstChild("HumanoidRootPart"), 0)
						end
					end
				end
			end
		end)
	end
end)

RunService.Stepped:Connect(function()
	pcall(function()
		local ftool1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("FoxBin's Magic Hand")
		if lfesp and ftool1 and #cache>=1 then
			for i,v in pairs(cache) do
				if v.Player.Character and v.Player.Character:FindFirstChildOfClass("Humanoid") and v.Player.Character:FindFirstChild("Head") then
					ftool1.Update:InvokeServer(Vector3.new(-math.huge, -math.huge, -math.huge),v.Player.Character.Head)
				end
			end
		end
		local jtool1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("PortableJustice")
		if ljesp and jtool1 and #cache>=1 then
			for i,v in pairs(cache) do
				if v.Player.Character and v.Player.Character:FindFirstChildOfClass("Humanoid") and v.Player.Character:FindFirstChild("Head") then
					jtool1.MouseClick:FireServer(v.Player.Character)
				end
			end
		end
		if chNoclip and LocalPlayer.Character then
			for i,v in pairs(LocalPlayer.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
		if shPeed then
			local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			
			if hum and hrp and UIS:IsKeyDown(Enum.KeyCode.LeftShift) and not UIS:GetFocusedTextBox() then
				hrp.CFrame = hrp.CFrame + (hum.MoveDirection * shSpeed)
			end
		end
		if lcJump then
			local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			
			if hum and UIS:IsKeyDown(Enum.KeyCode.Space) and not UIS:GetFocusedTextBox() then
				hum:ChangeState("Jumping")
			end
		end
	end)
end)

last:Destroy()
