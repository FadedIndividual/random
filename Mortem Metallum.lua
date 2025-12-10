repeat task.wait() until game:IsLoaded(); task.wait(1); if tostring(game.PlaceId) ~= "8986335348" then return end

local library, Add = loadstring(game:HttpGet("https://raw.githubusercontent.com/FadedIndividual/random/refs/heads/main/NM2Library.lua"))(), loadstring(game:HttpGet("https://raw.githubusercontent.com/FadedIndividual/main/refs/heads/main/Library.lua"))()
local Players, UIS, RunService, ReplicatedStorage, Lighting, Core = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("ReplicatedStorage"), game:GetService("Lighting"), game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local gethui = protectgui or gethui or get_hidden_gui

local sg = Instance.new("ScreenGui") sg.IgnoreGuiInset = true; sg.Name = "<@1090016043235283094> made this xoxo"
if gethui then sg.Parent = gethui() else sg.Parent = Core end

getDirection = function(Origin, Position) return (Position - Origin).Unit * 9e9 end
PositionToScreen = function(Vectorf) return workspace.CurrentCamera:WorldToScreenPoint(Vectorf) end

GetClosestMouse = function(TBall)
    local Closest, MaxDistance = nil, 5e5
    for _,v in next, TBall do
		if v~=LocalPlayer then
			if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") then
				local ScreenPosition, OnScreen = PositionToScreen(v.Character:FindFirstChild("HumanoidRootPart").Position)
				local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
				if OnScreen and Distance <= MaxDistance then
					Closest = v
					MaxDistance = Distance
				end
			end
		end
    end
    if Closest then return Closest else return nil end
end

local function isAnimationPlaying(animationId)
    local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
    local animator = humanoid:WaitForChild("Animator")
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        if track.Animation.AnimationId == animationId then
            return true
        end
    end
    return false
end

local SB_Frame = Add.Frame(sg, UDim2.new(0, 200, 0, 30), UDim2.new(.5, -100, 1, -200), {})
Add:Extra(SB_Frame, {"UICorner", {}})
local SB_Slide = Add.Frame(SB_Frame, UDim2.new(0, 0, 1, 0), UDim2.new(0, 0, 0, 0), {["BackgroundTran"] = .5, ["BackgroundColor"] = Color3.new(0, 1, 0)})
Add:Extra(SB_Slide, {"UICorner", {}})
local CV_Text = Add.Text(sg, UDim2.new(0, 200, 0, 30), UDim2.new(.5, -100, 1, -230), '...', {["BackgroundTran"] = 1, ["TextScaled"] = true, ["TextColor"] = Color3.new(1,1,1)})
CV_Text.RichText = true
Add:Extra(CV_Text, {"UICorner", {}})
local c4Vis = Instance.new("Part") c4Vis.Size = Vector3.new(82, 82, 82) c4Vis.Color = Color3.new(0, 1, 0) c4Vis.Anchored = true; c4Vis.CanCollide = false; c4Vis.CanQuery = false; c4Vis.CanTouch = false; c4Vis.Material = Enum.Material.ForceField; c4Vis.Name = "sphere"; c4Vis.Shape = Enum.PartType.Ball; c4Vis.Parent = workspace
local ladder = Instance.new("TrussPart") ladder.Anchored = true; ladder.CanCollide = true; ladder.CanQuery = false; ladder.CanTouch = false; ladder.Transparency = 1; ladder.Size = Vector3.new(1, 500, 1) ladder.CFrame = CFrame.new(0, 9e9, 0) ladder.Parent = workspace
local crPart = Instance.new("Part")crPart.Size = Vector3.new(2, 9e9, 2)crPart.Material = Enum.Material.Neon; crPart.Color = Color3.new(0,1,0)crPart.CanCollide = false; crPart.Anchored = true; crPart.CanQuery = false; crPart.CanTouch = false; crPart.Parent = workspace; 
local btPart = Instance.new("Part") btPart.Size = Vector3.new(2.5, .1, 2.5) btPart.Color = Color3.new(1, 0, 0); btPart.CanCollide = false; btPart.CanTouch = false; btPart.CanQuery = false; btPart.Anchored = true; btPart.Material = Enum.Material.Neon; btPart.CFrame = CFrame.new(0, 9e9, 0) btPart.Parent = workspace
local Highhhh = Instance.new("Highlight") Highhhh.Parent = btPart; Highhhh.Adornee = btPart; Highhhh.OutlineColor = Color3.new(1, 0, 0); Highhhh.OutlineTransparency = 0; Highhhh.FillTransparency = 1; Highhhh.Enabled = false; Highhhh.LineThickness = 5; Highhhh.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
local HitPart, bowEquipped, bowCharged, tickHeld, mainTool, coolDown, cdTick, omni_Tick, crate_Tick, selected_Players, lAnim, jorking = nil, false, false, false, nil, 0, tick(), tick(), tick(), {}, nil, false
local jorkAnim = Instance.new("Animation"); jorkAnim.AnimationId = "rbxassetid://72042024"

local Tools = library:CreateWindow("< Tools >")
local bowSect = Tools:Section("Bow")
local melSect = Tools:Section("Melee")

local Map = library:CreateWindow("< Map >")
local mapVisuals = Map:Section("Visuals")

local Local = library:CreateWindow("< Local >")
local client = Local:Section("Client")
local visuals = Local:Section("Visuals")

bowSect:Toggle("Silent-Aimbot", {flag = "aim", Default = false}, function() end)
bowSect:Dropdown("Hitboxes", {flag = "hits", list = {"Head", "Torso"}, Default = "Head"})
bowSect:Toggle("Auto-Charge", {flag = "bcharge", Default = false}, function() end)

melSect:Toggle("TP-Player (Close & Highlighted)", {flag = "meleetp", Default = false}, function() end)
melSect:Toggle("Auto-Equip", {flag = "autoequip", Default = false}, function() end)
melSect:Toggle("Auto-Swing", {flag = "autoswing", Default = false}, function() end)

mapVisuals:Bind("Feed-Pig (Close)", {flag = "piggy"}, function()
	local PP1 = workspace:WaitForChild("CurrentMap").Crossroads:WaitForChild("Bull").Cow.Entrance.ProximityPrompt
	if PP1 then fireproximityprompt(PP1) end
end)
mapVisuals:Toggle("Visualize Crate", {flag = "viscrate", Default = false}, function() end)
mapVisuals:Toggle("Walk Over Beartraps", {flag = "beartrp", Default = false}, function() end)
mapVisuals:Toggle("Closest C4 Radius", {flag = "visc4", Default = false}, function() end)

client:Dropdown("Sort-Inventory", {flag = "sorter", Type = "Toggle", list = {"Weapon", "C4", "Remote explosive", "Firework", "Grenade", "Fire bomb", "Tar urn", "Bandage", "Water flask", "Pepper spray", "Bear trap", "Caltrops", "Landmine", "None1", "None2", "None3", "None4", "None5", "None6", "None 7", "None 8"}}, function() end)
client:Toggle("No-Ragdoll", {flag = "ragdoll", Default = false}, function() end)
client:Bind("Ideal Tick", {flag = "itick"}, function() end)
client:Dropdown("Ideal Tick Methods", {flag = "tickMethod", list = {"Hold", "Toggle"}, Default = "Hold"})
client:Bind("Claim Crate", {flag = "cratetp"}, function() end)
client:Bind("Omni-Dash (TP)", {flag = "omni"}, function()
	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp and humanoid and LocalPlayer.Character.Parent ~= ReplicatedStorage.PlayerHold and (tick()-omni_Tick)>= 1 then
		omni_Tick = tick()
		local moveDir = humanoid.MoveDirection
		if moveDir.Magnitude > 0 then
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				hrp.CFrame = hrp.CFrame * CFrame.new(0, 5, 0) + (moveDir.Unit * 15)
			else
				hrp.CFrame = hrp.CFrame + (moveDir.Unit * 15)
			end
		else
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 15, -5)
			else
				hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, -15)
			end
		end
	end
end)
client:Bind("Ladder-Climb", {flag = "climb"}, function()end)
client:Bind("Reset-Bind", {flag = "resetBind"}, function()
	local Humanoid = LocalPlayer.Character and not LocalPlayer.Character.Parent~=ReplicatedStorage.PlayerHold and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		for i = 1,20 do
			Humanoid.Health = 0
			task.wait()
		end
	end
end)

visuals:Slider("Brightness", {flag = "bright", Default = .8, Min = 0, Max = 2, Precise = true}, function() end)
visuals:Toggle("Global Shadows", {flag = "shadows", Default = false}, function() end)
visuals:Slider("FOV", {flag = "fov", Default = 90, Min = 10, Max = 120}, function() end)
visuals:Toggle("Visualize Omni-Delay", {flag = "visomni", Default = false}, function() end)
visuals:Bind("Highlight (Close)", {flag = "hClose"}, function()
	local chars = {}
	for i,v in pairs(Players:GetPlayers()) do
		if v~=LocalPlayer then
			if v.Character and v.Character.Parent ~= ReplicatedStorage.PlayerHold and v.Character:FindFirstChildOfClass("Humanoid") then
				table.insert(chars, v)
			end
		end
	end
	local clost, isThere = GetClosestMouse(chars), false
	for i,v in pairs(selected_Players) do
		if v.Name == clost.Name then
			isThere = true
		end
	end
	if isThere == false then
		local randx, randy, randz = math.random(1, 255), math.random(1, 255), math.random(1, 255)
		selected_Players[#selected_Players+1] = {["Name"] = clost.Name, ["Player"] = clost, ["Color"] = Color3.fromRGB(randx, randy, randz)}
	end
end)
visuals:Bind("Unhighlight (Close)", {flag = "unhClose"}, function()
	local chars = {}
	for i,v in pairs(Players:GetPlayers()) do
		if v~=LocalPlayer then
			if v.Character and v.Character.Parent ~= ReplicatedStorage.PlayerHold and v.Character:FindFirstChildOfClass("Humanoid") then
				table.insert(chars, v)
			end
		end
	end
	local clost, isThere, intt = GetClosestMouse(chars), false, 0
	for i,v in pairs(selected_Players) do
		if v.Name == clost.Name then
			v.Line:Remove()
			isThere = true
			intt = i
		end
	end
	if isThere == true then
		pcall(function()
			clost.Character:FindFirstChild("High"):Destroy()
		end)
		table.remove(selected_Players, intt)
	end
end)
visuals:Bind("Jerk It", {flag = "jorkBind"}, function()
	jorking = not jorking
	if jorking then
		task.spawn(function()
			while jorking do
				lAnim = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(jorkAnim)
				lAnim:Play()
				lAnim:AdjustSpeed(.66)
				lAnim.TimePosition = .6
				task.wait(.1)
			end
			lAnim:Stop()
		end)
	end
end)

Mouse.Button1Down:Connect(function()
	if mainTool and mainTool.Name ~= "Longbow" and library.flags["meleetp"] then
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local Character, Closest = nil, 25
		for i,v in pairs(selected_Players) do
			if hrp and v.Player.Character and v.Player.Character.Parent ~= ReplicatedStorage.PlayerHold and not v.Player.Character:FindFirstChild("ForceField") and v.Player.Character:FindFirstChild("Head") and v.Player.Character:FindFirstChild("HumanoidRootPart") and v.Player.Character:FindFirstChildOfClass("Humanoid") and v.Player.Character.Humanoid.Health >= 1.5 then
				local thrp = v.Player.Character:FindFirstChild("HumanoidRootPart")
				local Magp = (thrp.Position - hrp.Position).Magnitude
				
				if thrp and hrp and Magp <= Closest then
					Character = v.Player.Character
					Closest = Magp
				end
			end
		end
		
		if hrp and Character then
			local TimeTill = tick()
			repeat task.wait()
				pcall(function()
					Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, -2)
				end)
			until tick()-TimeTill >= .26
		end
	end
end)

UIS.InputBegan:Connect(function(Key, Proc)
	if Proc then return end
	local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if tostring(library.flags["climb"]) ~= "Enum.UserInputType.None" and Key.KeyCode == library.flags["climb"].KeyCode then
		if hrp then
			ladder.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, (ladder.Size.Y/2)-3, -1.25)
		end
	elseif tostring(library.flags["itick"]) ~= "Enum.UserInputType.None" and Key.KeyCode == library.flags["itick"].KeyCode then
		if library.flags["tickMethod"] == "Hold" then
			tickHeld = true
		else
			if (not tickHeld) == false and hrp then
				hrp.CFrame = btPart.CFrame + Vector3.new(0, 3, 0)
			end
			tickHeld = not tickHeld
		end
	end
end)

UIS.InputEnded:Connect(function(Key, Proc)
	if Proc then return end
	local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if tostring(library.flags["climb"]) ~= "Enum.UserInputType.None" and Key.KeyCode == library.flags["climb"].KeyCode then
		ladder.CFrame = CFrame.new(0, 9e9, 0)
	elseif tostring(library.flags["itick"]) ~= "Enum.UserInputType.None" and Key.KeyCode == library.flags["itick"].KeyCode and library.flags["tickMethod"] == "Hold" then
		tickHeld = false
		if hrp then
			hrp.CFrame = btPart.CFrame + Vector3.new(0, 3, 0)
		end
	end
end)

local function Sort()
	if #library.flags["sorter"] == 0 then return end
	local Cache = {}
	local otherCache = {}
	for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(Cache, v)
			v.Parent = LocalPlayer
		end
	end
	for i,v in ipairs(library.flags["sorter"]) do
		if v == "Weapon" then
			local Weapon;
			for _,vv in pairs(Cache) do
				if not table.find({"C4", "Remote explosive", "Firework", "Grenade", "Fire bomb", "Tar urn", "Bandage", "Water flask", "Pepper spray", "Bear trap", "Caltrops", "Landmine"}, vv.Name) then
					Weapon = vv
				end
			end
			if Weapon then
				Weapon.Parent = LocalPlayer.Backpack
			end
		elseif v:sub(1,4) == "None" then
			table.insert(otherCache, Instance.new("Tool", LocalPlayer.Backpack))
		else
			pcall(function() LocalPlayer[v].Parent = LocalPlayer.Backpack end)
		end
	end
	for i = 1,11 do
		table.insert(otherCache, Instance.new("Tool", LocalPlayer.Backpack))
	end
	for i,v in pairs(Cache) do
		if v.Parent == LocalPlayer then
			v.Parent = LocalPlayer.Backpack
		end
	end
	for i,v in pairs(otherCache) do
		v:Destroy()
	end
end

LocalPlayer.CharacterAdded:Connect(function()
	repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character.Parent.Parent == workspace and not LocalPlayer.Character:FindFirstChild("ForceField"); task.wait(1)
	Sort()
end)

task.spawn(function() task.wait(4)
	repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character.Parent.Parent == workspace and not LocalPlayer.Character:FindFirstChild("ForceField"); task.wait(1)
	Sort()
end)

Players.PlayerRemoving:Connect(function(Player)
	for i,v in ipairs(selected_Players) do
		if v.Name == Player.Name then
			pcall(function() v.Line:Remove() end)
			table.remove(selected_Players, i)
			break
		end
	end
end)

task.spawn(function()
	while task.wait() do
		if library.flags["bcharge"] then
			local equippedTool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
			if equippedTool and equippedTool.Name == "Longbow" and not isAnimationPlaying("rbxassetid://15432284641") then
				equippedTool:Activate()
			end
		end
		if library.flags["autoequip"] then
			local Character = LocalPlayer.Character
			local hum = Character:FindFirstChildOfClass("Humanoid")
			local eTool = Character:FindFirstChildOfClass("Tool")
			for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
				if v:FindFirstChild("Cooldowntime") then
					mainTool = v
				end
			end
			if not eTool and mainTool and mainTool.Parent ~= Character then
				hum:UnequipTools()
				mainTool.Parent = Character
			end
		end
	end
end)

RunService.Stepped:Connect(function()
	Character, crateMap, closestC4, _Dist, tbll, numm = LocalPlayer.Character, false, nil, 5e5, {}, math.clamp(tick()-omni_Tick, 0, 1)
	cInfo, hrp, hum, equippedTool = Character:FindFirstChild("CharacterInformation"), Character:FindFirstChild("HumanoidRootPart"), Character:FindFirstChildOfClass("Humanoid"), Character:FindFirstChildOfClass("Tool")
	Lighting.Brightness = library.flags.bright
	Lighting.GlobalShadows = library.flags.shadows
	if cInfo then
		if hum then
			bowCharged = isAnimationPlaying("rbxassetid://15432284641") and true or false
			if hrp then
				pcall(function() workspace.CurrentCamera.FieldOfView = library.flags["fov"]; LocalPlayer.Character.Ragdoll.LocalRagdoll.Enabled = not library.flags["ragdoll"] end)
				if tickHeld and (hrp.Position - btPart.Position).Magnitude >= 20 then
					hrp.CFrame = btPart.CFrame + Vector3.new(0, 3, 0)
					hum:ChangeState("GettingUp")
					hrp.Velocity = Vector3.zero
					tickHeld = false
				end
				if tickHeld then
					btPart.Transparency = 0
					Highhhh.Enabled = true
				else
					btPart.CFrame = hrp.CFrame + Vector3.new(0, -3, 0)
					btPart.Transparency = 1
				end
				for i,v in pairs(workspace.Explosions:GetChildren()) do
					if v.Name == "c4model" and v:FindFirstChild("Part1") and v.Part1.Transparency ~= 1 then
						if (hrp.Position - v.Part1.Position).Magnitude < _Dist then --workspace.Explosions.c4model.PlrWhoThrew.Value
							closestC4 = v
							_Dist = (hrp.Position - v.Part1.Position).Magnitude
						end
					end
					if v.Name == "BEARTRAP" and v:FindFirstChild("detect") and not v.detect:FindFirstChild("Walk") and library.flags["beartrp"] then
						local WalkOver = Instance.new("Part")WalkOver.Name = "Walk"; WalkOver.Size = Vector3.new(6, 2.89, 6)WalkOver.CFrame = v:FindFirstChild("detect").CFrame; WalkOver.Anchored = true; WalkOver.CanCollide = true; WalkOver.CanQuery = false; WalkOver.CanTouch = false; WalkOver.Transparency = 1; 
						WalkOver.Parent = v:FindFirstChild("detect")
					elseif v.Name == "BEARTRAP" and v:FindFirstChild("detect") and v.detect:FindFirstChild("Walk") and not library.flags["beartrp"] then
						v:FindFirstChild("detect"):FindFirstChild("Walk"):Destroy()
					end
					if v.Name == "CrateModel" then
						if v:FindFirstChild("Model"):FindFirstChild("Parachute") then
							crateMap = true
						elseif not v:FindFirstChild("Model"):FindFirstChild("Parachute") and v:FindFirstChild("Flare") and v.Flare:FindFirstChild("On") and v.Flare.On:FindFirstChild("Attachment") and v.Flare.On.Attachment:FindFirstChild("sizzling") and v.Flare.On.Attachment.sizzling.IsPlaying == true then
							crateMap = true
						else
							crateMap = false
						end
						if library.flags["viscrate"] and v then
							local pos = v:GetPivot().Position
							crPart.CFrame = CFrame.new(pos.X, 100, pos.Z) * CFrame.Angles(0, math.rad(0), 0)
						else
							crPart.CFrame = CFrame.new(9e9, 9e9, 9e9)
						end
						if not UIS:GetFocusedTextBox() and tostring(library.flags["cratetp"]) ~= "Enum.UserInputType.None" and UIS:IsKeyDown(library.flags["cratetp"].KeyCode) then
							local prox = workspace.Explosions:FindFirstChild("CrateModel") and workspace.Explosions.CrateModel:FindFirstChild("Model") and workspace.Explosions.CrateModel.Model:FindFirstChild("Click") and workspace.Explosions.CrateModel.Model.Click:FindFirstChild("ProximityPrompt")
							if prox then
								fireproximityprompt(prox)
							end
						end
					end
				end
				if closestC4 and library.flags["visc4"] then
					c4Vis.Transparency = 0.7
					c4Vis.CFrame = CFrame.new(closestC4:GetPivot().Position)
					if _Dist >= 40 then
						c4Vis.Color = Color3.new(0, 1, 0)
						c4Vis.Size = Vector3.new(82, 82, 82)
					else
						_Dist = _Dist * 2
						c4Vis.Color = Color3.new(1, 0, 0)
						c4Vis.Size = Vector3.new(_Dist, _Dist, _Dist)
					end
				else
					c4Vis.Transparency = 1
				end
			else
				c4Vis.Transparency = 1
			end
		else
			c4Vis.Transparency = 1
		end
	else
		c4Vis.Transparency = 1
	end
	if equippedTool then
		local cdTime = equippedTool:FindFirstChild("Cooldowntime") and equippedTool:FindFirstChild("Cooldowntime").Value
		if cdTime then
			mainTool = equippedTool
			coolDown = cdTime 
			if library.flags["autoswing"] and tick()-cdTick>=coolDown then
				cdTick = tick()
				equippedTool:Activate()
			end
		end
		if equippedTool.Name == "Longbow" then
			bowEquipped = true
		else
			bowEquipped = false
		end
	else
		mainTool = nil
		bowEquipped = false
	end
    for i,v in pairs(selected_Players) do
        if v.Player.Character and v.Player.Character.Parent ~= ReplicatedStorage.PlayerHold and not v.Player.Character:FindFirstChild("ForceField") and v.Player.Character:FindFirstChild("Head") and v.Player.Character:FindFirstChild("HumanoidRootPart") and v.Player.Character:FindFirstChildOfClass("Humanoid") and v.Player.Character.Humanoid.Health >= 1.5 then
            if not v.Player.Character:FindFirstChild("High") then
				local High = Instance.new("Highlight") High.Parent = v.Player.Character; High.Name = "High"; High.Adornee = v.Character; High.OutlineColor = v.Color; High.FillColor = v.Color; High.OutlineTransparency = 0; High.FillTransparency = .8; High.Enabled = true; High.LineThickness = 5; High.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			end
			if v.Line then
				local Torso = v.Player.Character:FindFirstChild("Torso")
				if Torso then
					local spos, ivis = PositionToScreen(Torso.Position)
					
					v.Line.From = Vector2.new(Mouse.X, Mouse.Y+60)
					v.Line.To = Vector2.new(spos.X, spos.Y+60)
				
					v.Line.Visible = ivis
				else
					v.Line.Visible = false
				end
			else
				local Line = Drawing.new("Line")
				v.Line = Line
				v.Line.Color = Color3.new(1, 0, 0)
				v.Line.Visible = false
				v.Line.Thickness = 1
			end
			table.insert(tbll, v.Player)
		else
			if v.Line then
				v.Line.Visible = false
			end
		end
    end
	ss = GetClosestMouse(tbll)
	if ss then
		if library.flags["hits"][1] then
			HitPart = ss.Character:FindFirstChild(library.flags["hits"][1])
		else
			HitPart = ss.Character:FindFirstChild("Head")
		end
	else
		HitPart = nil
	end
	SB_Frame.Visible = library.flags["visomni"]
	CV_Text.Visible = library.flags["viscrate"]
    SB_Slide.Size = UDim2.new(numm, 0, 1, 0)
    if numm == 1 then
        SB_Slide.BackgroundTransparency = 0
		SB_Slide.BackgroundColor3 = Color3.new(0, 1, 0)
    else
        SB_Slide.BackgroundTransparency = .55
		SB_Slide.BackgroundColor3 = Color3.new(1, 0, 0)
    end
	if crateMap then
		CV_Text.Text = 'Crate: <font color="#2FFF00">true</font>'
	else
		CV_Text.Text = 'Crate: <font color="#FF0000">false</font>'
		crPart.CFrame = CFrame.new(9e9, 9e9, 9e9)
	end
end)

FixedTypes = {"Instance", "Vector3", "Vector3", "RaycastParams"}
local function ValidateArguments(Args)
    local Matches = 0
    if #Args < 3 then
        return false
    end
    for Pos, Argument in next, Args do
        if typeof(Argument) == FixedTypes[Pos] then
            Matches = Matches + 1
        end
    end
    return Matches >= 3
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method, Arguments = getnamecallmethod(), {...}
    local self = Arguments[1]
    if self == workspace and not checkcaller() and library.flags["aim"] and bowEquipped then
		if ValidateArguments(Arguments) and type(Arguments[3]) == "vector" and (Arguments[3].Y < -.9 and Arguments[3].Y < .9) then
            local A_Origin = Arguments[2]
            if HitPart then
                Arguments[3] = getDirection(A_Origin, (HitPart.CFrame + Vector3.new(0, .1, 0)).Position)
                return oldNamecall(unpack(Arguments))
            end
			return oldNamecall(unpack(Arguments))
        end
    end
    return oldNamecall(...)
end))
