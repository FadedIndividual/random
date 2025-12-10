repeat task.wait() until game:IsLoaded()
if game.PlaceId ~= 258258996 then return end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FadedIndividual/random/refs/heads/main/NM2Library.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MoneyLibrary = ReplicatedStorage:WaitForChild("MoneyLib") and require(ReplicatedStorage.MoneyLib)
local Notifs = LocalPlayer.PlayerGui:WaitForChild("GUI") and LocalPlayer.PlayerGui.GUI:WaitForChild("Notifications")

if not Notifs then
	repeat task.wait()
		Notifs = LocalPlayer.PlayerGui:FindFirstChild("GUI") and LocalPlayer.PlayerGui.GUI:FindFirstChild("Notifications")
	until Notifs
end

local Texts = {}
local function Create_Text(String, Color)
	local Text = Drawing.new("Text")
	Text.Text = String
	Text.Visible = true
	Text.Color = Color; Text.Transparency = 1; Text.Size = 50

	table.insert(Texts, Text)
	
	Text.Visible = false
	
	return Text
end

local function getHumanoidRootPart()
	return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end

local function GetTycoon()
	local Tycoon;
	
	for i,v in pairs(workspace.Tycoons:GetChildren()) do
		if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer.Name then
			Tycoon = v
		end
	end
	
	return Tycoon
end

local function GetDroppedParts()
	local Table = {}

	pcall(function()
		local Tycoon = GetTycoon()
	
		for i,v in pairs(workspace.DroppedParts[Tycoon.Name]:GetChildren()) do
			if v:FindFirstChild("Cash") then
				table.insert(Table, v)
			end
		end
	end)
	
	return Table
end

local function GetDroppedCash(Part)
	local Cash = 0
	
	pcall(function()
		Cash = tonumber(Part.Cash.Value)
	end)
	
	return Cash == 0 and nil or Cash
end

local function GetProximities()
	local Table = {}
	local Tycoon = GetTycoon()
	
	if Tycoon then
		for _, Models in pairs(Tycoon:GetChildren()) do
			if Models:IsA("Model") then
				local Model = Models:FindFirstChild("Model")
				if Model and Model:FindFirstChild("DropScript") then
					for i,v in pairs(Models:GetChildren()) do
						local Prox = v:FindFirstChild("Internal") and v.Internal:FindFirstChild("ProximityPrompt")
						if Prox then
							table.insert(Table, Prox)
						end
					end
				end
			end
		end
	end
	
	return Table
end

local function getCrates()
	local Table = {}
	
	for i,v in pairs(workspace.Boxes:GetChildren()) do
		if v:FindFirstChild("Open") and not v:FindFirstChild("Open").IsPlaying and v:FindFirstChild("TouchInterest") then
			table.insert(Table, v)
		end
	end
	
	return Table
end

local function OpenableCrates()
	local Table = {}
	
	for i,v in pairs(LocalPlayer.Crates:GetChildren()) do
		if v.Value > 0 then
			table.insert(Table, v.Name)
		end
	end
	
	return Table
end

local function LoadLayout(Number)
	local LayoutRemote = ReplicatedStorage:FindFirstChild("Layouts")
	
	if LayoutRemote then
		LayoutRemote:InvokeServer("Load", "Layout" .. tostring(Number))
		
		return true
	end
	
	return false
end

local function Rebirth()
	local RebirthRemote = ReplicatedStorage:FindFirstChild("Rebirth")
	
	if RebirthRemote then
		RebirthRemote:InvokeServer(26)
		
		return true
	end
	
	return false
end

local function GetRebirthPrice()
	local Number = ""
	
	pcall(function()
		local RebornUi = LocalPlayer.PlayerGui.Rebirth.Frame.Rebirth_Content.Content.Rebirth.Frame.Bottom.Reborn
		
		local Money = RebornUi.Text:gsub("BE REBORN: ", ""):sub(2)
		
		Number = Money
	end)
	
	return Number == "" and nil or Number
end

local function GetCash()
	local Number = ""
	
	pcall(function()
		local Money = LocalPlayer.leaderstats.Cash.Value
		
		Money = Money:sub(2)
		
		Number = Money
	end)
	
	return Number == "" and nil or Number
end

local function compareStrings(One, Two)
	local Bool = false
	local Suffixes = MoneyLibrary.Suffixes
	
	if Suffixes then
		local R, RNum = "", 0
		local C, CNum = "", 0
		
		for i,v in ipairs(Suffixes) do
			if Two:match(v) then
				R = v
				RNum = i
			end
			if One:match(v) then
				C = v
				CNum = i
			end
		end
		
		if R ~= "" and C ~= "" then
			Two = Two:gsub(R, "")
			One = One:gsub(C, "")
		else
			return
		end
		
		if tonumber(CNum) > tonumber(RNum) then
			Bool = true
		elseif tonumber(Two) <= tonumber(One) and tonumber(CNum) == tonumber(RNum) then
			Bool = true
		end
	end
	
	return Bool
end

local function canRebirth()
	local Bool = false

	pcall(function()
		local RPrice = GetRebirthPrice()
		local Cash = GetCash()
		
		if RPrice and Cash then
			Bool = compareStrings(Cash, RPrice)
		end
	end)
	
	return Bool
end

local function DropMines()
	local Remote = LocalPlayer.PlayerGui:FindFirstChild("GUI") and LocalPlayer.PlayerGui.GUI:FindFirstChild("Radio")
	
	if Remote.Visible then
		ReplicatedStorage:FindFirstChild("RemoteDrop"):FireServer()
	end
end

local autoWindow = library:CreateWindow("< Auto >")
local selfSect = autoWindow:Section("Self")
local mapSect = autoWindow:Section("Map")

local Local = library:CreateWindow("< Local >")
local client = Local:Section("Client")

selfSect:Toggle("Auto-Farm", {flag = "farm"}, function(bool)
	if bool == false then
		Rebirthed = false
		shouldReload = false
	end
end)
selfSect:Label("")
selfSect:Label("Choose only 1 Layout!")
selfSect:Dropdown("Layout Loader", {flag = "laynum", Default = "1", list = {"1", "2", "3"}}, function() end)
selfSect:Slider("Delay Load Time", {flag = "DelayedFirst", Default = 1.5, Min = .5, Max = 10, Precise = true}, function() end)
selfSect:Label("")
selfSect:Label("If Load-Layout Costs $$$?")
selfSect:Slider("Money", {flag = "layPrice", Min = 1, Max = 999, Default = 200}, function() end)
selfSect:Dropdown("Suffix", {flag = "suffix", Default = "qd", list = MoneyLibrary.Suffixes}, function() end)
selfSect:Slider("Delay Load Time #2", {flag = "DelayedSecond", Default = 2, Min = .5, Max = 10, Precise = true}, function() end)

mapSect:Toggle("Grab-Crates", {flag = "crate"}, function() end)
mapSect:Toggle("Auto-Mine Click", {flag = "miner"}, function() end)
mapSect:Toggle("Show Ore-Values", {flag = "ores"}, function() end)

client:Toggle("Auto-Open Crates", {flag = "openCrates"}, function() end)
client:Button("Open Fusions", function()
	local Map = workspace:FindFirstChild("Map")
	local Prox;
	
	for i,v in pairs(Map:GetChildren()) do
		if table.find({"WizardDude", "Cauldron"}, v.Name) and v:FindFirstChild("Internal") and v.Internal:FindFirstChild("ProximityPrompt") then
			Prox = v.Internal.ProximityPrompt
		end
	end
	
	fireproximityprompt(Prox, 9e9)
end)

local shouldReload = false
Notifs.ChildAdded:Connect(function(guiObject)
	local Label = guiObject:WaitForChild("Label")

	if Label and Label.Text:split(" ")[1] == "Unable" and shouldReload == false then
		shouldReload = true
	end
end)

local Rebirthed, LoadSecond, delayPrice, Crates, Proxims, Time = false, false, "200qd", {}, {}, tick()
task.spawn(function()
	local dropTick = tick()
	while task.wait(.15) do
		if tick()-Time >= 1.5 then
			Time = tick()
			Proxims = GetProximities()
		end
		
		Crates = OpenableCrates()
		CanRebirth = canRebirth()
		delayPrice = tostring(library.flags.layPrice) .. tostring(library.flags.suffix)
		
		if #Crates > 0 and library.flags.openCrates then
			for i,v in pairs(Crates) do
				game:GetService("ReplicatedStorage"):WaitForChild("MysteryBox"):InvokeServer(v)
			end
		end
		
		if library.flags.miner and tick()-dropTick >= .3 then
			dropTick = tick()
			task.spawn(function()
				DropMines()
				if #Proxims>0 then
					for i,v in pairs(Proxims) do
						fireproximityprompt(v, 9e9)
					end
				end
			end)
		end

		if CanRebirth and Rebirthed == false and library.flags.farm then
			Rebirth()
			Rebirthed = true
		end
		
		if Rebirthed and library.flags.farm then
			Rebirthed = false
			task.spawn(function()
				task.wait(library.flags["DelayedFirst"])
				LoadLayout(1)
				LoadSecond = true
			end)
		elseif library.flags.farm and shouldReload and LoadSecond then
			if not delayPrice or delayPrice == "" then
				LoadSecond = false
				return
			end
			
			Cash = GetCash()
			shouldRebirth = compareStrings(Cash, delayPrice)
			
			if shouldRebirth then
				LoadSecond = false
				shouldReload = false
				task.spawn(function()
					task.wait(library.flags["DelayedSecond"])
					LoadLayout(1)
				end)
			end
		end
	end
end)

-- See - Ore - Values --
task.spawn(function()
	if not GetTycoon() then
		repeat task.wait() until GetTycoon()
	end
	
	local Tycoon = GetTycoon()
	
	local Dropped = workspace:WaitForChild("DroppedParts") and workspace.DroppedParts:WaitForChild(Tycoon.Name)

	Dropped.ChildAdded:Connect(function(v)
		if not v:FindFirstChild("Default") and library.flags.ores then
			local Bill = Instance.new("BillboardGui")
			Bill.Size = UDim2.new(2.5, 0, .85, 0)
			Bill.AlwaysOnTop = true
			Bill.ExtentsOffset = Vector3.new(0, 2.5, 0)
			Bill.Name = "Default"
			Bill.Parent = v

			local Text = Instance.new("TextLabel")						
			Text.Size = UDim2.new(1, 0, 1, 0)
			Text.BackgroundTransparency = 1
			Text.TextColor3 = Color3.new(1, 1, 0)
			Text.TextScaled = true
			Text.Text = ""
			Text.Name = "Text"
			Text.Parent = Bill
			
			v:WaitForChild("Cash", 2)
			
			Text.Text = MoneyLibrary.LongToShort(v.Cash.Value)
			
			local Connect;
			Connect = v.Cash.Changed:Connect(function()
				local Cash = GetDroppedCash(v)
				
				if Cash then
					Text.Text = MoneyLibrary.LongToShort(Cash)
				end
			end)
			
			v.Destroying:Once(function()
				pcall(function()
					Connect:Disconnect()
				end)
				Connect = nil
			end)
		end
	end)
end)

-- Auto - Grab - Crates --
task.spawn(function()
	while task.wait() do
		local Crates = getCrates()
		local hrp, hum = getHumanoidRootPart()		

		if #Crates > 0 and hrp and hum and library.flags.crate then
			local Saved = hrp.CFrame
			hum.PlatformStand = true
			for i,v in pairs(Crates) do
				if library.flags.crate then
					hum:ChangeState("GettingUp")
					hrp.CFrame = v.CFrame
					task.wait(.2)
					hum:ChangeState("GettingUp")
				else
					break
				end
			end
			hum.PlatformStand = false
			task.wait(.1)
			hrp.CFrame = Saved
			for i = 1,40 do
				hum:ChangeState("GettingUp"); task.wait()
			end
			hrp.CFrame = Saved
		else
			task.wait(.5)
		end
	end
end)
