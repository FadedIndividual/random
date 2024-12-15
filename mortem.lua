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

local amt = 50

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
				task.wait(1)
				for i = 1, amt do
					game:GetService("ReplicatedStorage").Item:FireServer(num, "0:0:0:0")
				end
				task.wait(1)
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
    elseif sCmd({";amount", ";amt"}, args[1], true) then
        if tonumber(args[2]) then
            amt = tonumber(args[2])
        end
    elseif sCmd({";change", {";bool"}}, args[1], true) then
        if sCmd({"true", "+", "pos"}, args[2], true) then
            BOOL = true
        elseif sCmd({"false", "-", "neg"}, args[2], true) then
            BOOL = false
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
