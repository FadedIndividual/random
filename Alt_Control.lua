repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local TextChatService = game:GetService("TextChatService")
local LegacyChat = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local VoiceChatService = game:GetService("VoiceChatService")
local iswa = iswindowactive or isrbxactive

local config = {
	["Folder"] = "Dwaynes_Bot/";
};
config = {
	["Prefix"] = ".";
	["Folder"] = config["Folder"];
	["File_Names"] = {
		["Settings"] = config["Folder"] .. "settings.json";
		["Number"] = config["Folder"] .. "Seperator.json";
		["Animation"] = config["Folder"] .. "Animations.json";
	};
	["Indexed"] = {};
	["SelfIndex"] = 0;
	["Seperator"] = 1;
	["Animations"] = {};
	["Settings"] = {
		["VC_Accounts"] = {};
		["Accounts"] = {};
		["Main_Account"] = 0;
		["Whitelist"] = {};
		["Include_VC"] = false;
		["Offset"] = 5;
		["YOffset"] = 5;
		["Speed"] = 1;
		["NoSit"] = true;
		["Noclip"] = false;
		["Prediction"] = false;
		["Following"] = {["Method"] = 1, ["UID"] = 0};
		["LTP"] = {["Method"] = 1, ["UID"] = 0};
		["Mimic"] = 0;
		["Spamming"] = nil;
		["Flinging"] = false;
		["BFPS"] = 20;
		["MFPS"] = 144;
		["Annoy"] = false;
		["NRender"] = {};
	};
}

local function File(Load, FileName, ...)
	local arg = {...}
	if Load then
		if isfile(FileName) then
			return HttpService:JSONDecode(readfile(FileName))
		else
			return false
		end
	else
		writefile(FileName, HttpService:JSONEncode(arg[1]))
		return true
	end
	
	return false
end

if not isfolder(config["Folder"]) then
	makefolder(config["Folder"])
	
	File(false, config["File_Names"]["Settings"], config["Settings"])
	File(false, config["File_Names"]["Number"], 1)
	File(false, config["File_Names"]["Animation"], {})
end

local Settings = File(true, config["File_Names"]["Settings"])

if not File(true, config["File_Names"]["Settings"]) then
	File(false, config["File_Names"]["Settings"], config["Settings"])
end

local function ChangeSetting(Funk)
	local Settings = File(true, config["File_Names"]["Settings"])

	Funk(Settings)

	File(false, config["File_Names"]["Settings"], Settings)
end

local General = nil
local function chat_Message(String: string)
	local String = tostring(String)

	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService or game.PlaceId == 5913858916 then
		if General == nil then
			for i,v in pairs(TextChatService:GetChildren()) do
				if v.Name == "TextChannels" and v:FindFirstChild("RBXGeneral") then
					General = v:FindFirstChild("RBXGeneral")
				end
			end
		end
		General:SendAsync(String)
	else
		TextChatService:FindFirstChild("DefaultChatSystemChatEvents").SayMessageRequest:FireServer(String, "All")
	end
end

local function GetPlayer(String)
	local Player = nil
	
	for i,v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then
			if Player then
				break
			end
			if string.sub(tostring(v.Name):lower(), 1, string.len(String)) == string.lower(String) or string.sub(tostring(v.DisplayName):lower(), 1, string.len(String)) == string.lower(String) then
				Player = v
			end
		end
	end
	
	return Player
end

local function CheckVC()
	local Bool = false
	
	if game:GetEngineFeature("VoiceChatSupported") and VoiceChatService:IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId) then
		Bool = true
	end
	
	return Bool
end

local Commands = {}

local function AddCmd(CmdName, Aliases, Desc, Func)
    Commands[#Commands + 1] = {["Name"] = CmdName, ['Other'] = Aliases, ["Description"] = Desc, ["Function"] = Func}
end
 
local function Search(CmdName)
    for _, v in next, Commands do 
        if v.Name == CmdName or table.find(v.Other, CmdName) then 
            return v.Function 
        end
    end
end

local function CheckCmd(Player, Message)
	if Message:sub(1, string.len(config.Prefix)) == config.Prefix and config["SelfIndex"] ~= 0 then
		if Message ~= "" and Message ~= config.Prefix and Message ~= " " then else return end
		local Cmd = string.lower(Message)
		if Cmd:sub(1, #config.Prefix) == config.Prefix then
			local Args = string.split(Cmd:sub(#config.Prefix + 1), " ")
			local CmdName = Search(table.remove(Args, 1))
			if CmdName and Args then
				return CmdName(Player, Args, Message)
			end
		end
	else
		if config["Settings"]["Mimic"] == Player.UserId and Player.UserId ~= LocalPlayer.UserId and config["SelfIndex"] ~= 0 then
			chat_Message(Message)
		end
	end
end

local function CheckSelf()
	local Settings = File(true, config["File_Names"]["Settings"])

	if Settings then
		local Bool = false
		
		if table.find(Settings["VC_Accounts"], LocalPlayer.UserId) or table.find(Settings["Accounts"], LocalPlayer.UserId) then
			Bool = true
		end
		
		return Bool
	end
	
	return error("FILE -"..config["File_Names"]["Settings"].. "-")
end

if not CheckSelf() then
	if CheckVC() then
		local Settings = File(true, config["File_Names"]["Settings"])
		
		if table.find(Settings["Accounts"], LocalPlayer.UserId) then
			for i, v in ipairs(Settings["Accounts"]) do
				if v == LocalPlayer.UserId then
					table.remove(Settings["Accounts"], i)
				end
			end
			File(false, config["File_Names"]["Settings"], Settings)
		end
		ChangeSetting(function(Settings)
			Settings["VC_Accounts"][#Settings["VC_Accounts"] + 1] = LocalPlayer.UserId
		end)
	else
		ChangeSetting(function(Settings)
			Settings["Accounts"][#Settings["Accounts"] + 1] = LocalPlayer.UserId
		end)
	end
end

local function IndexAccounts()
	local Table = {}
	
	if config["Settings"]["Include_VC"] then
		local NewTable = {}
		
		for i,v in ipairs(config["Settings"]["Accounts"]) do
			table.insert(NewTable, v)
		end
		
		for i,v in ipairs(config["Settings"]["VC_Accounts"]) do
			table.insert(NewTable, v)
		end
		
		for i,v in ipairs(NewTable) do
			local Player = Players:GetPlayerByUserId(v)
			
			if Player and Player.UserId ~= config["Settings"]["Main_Account"] then
				table.insert(Table, v)
			end
		end
	else
		for i,v in ipairs(config["Settings"]["VC_Accounts"]) do
			local Player = Players:GetPlayerByUserId(v)
			
			if Player and Player == LocalPlayer then
				config["SelfIndex"] = 0
			end
		end
		
		for i,v in ipairs(config["Settings"]["Accounts"]) do
			local Player = Players:GetPlayerByUserId(v)
			
			if Player and Player.UserId ~= config["Settings"]["Main_Account"] then
				table.insert(Table, v)
			end
		end
	end
	
	return Table
end

local function Remove_Velocity()
	task.spawn(function()
		for i,v in pairs(LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.Velocity = Vector3.zero
				v.RotVelocity = Vector3.zero
			end
		end
	end)
end

local function StopAnimations()
	local User = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if User then
		for i,v in pairs(User:GetPlayingAnimationTracks()) do
			v:Stop()
		end
	end
end

local Bang;
local Animation = Instance.new("Animation")
local Anim_Tick = tick()
local function LoadBang()
	local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	
	if (Humanoid and Bang == nil) or tick()-Anim_Tick>= 2.5 then
		Anim_Tick = tick()
		Animation.AnimationId = Humanoid.RigType == Enum.HumanoidRigType.R6 and "rbxassetid://148840371" or "rbxassetid://5918726674"
		Bang = Humanoid:LoadAnimation(Animation)
		
		if Bang then
			Bang.Looped = true
		end
	elseif not Humanoid then
		Bang = nil
	end
end

local function CheckMain(Player)
	return Player.UserId == config["Settings"]["Main_Account"]
end

local function CheckWhitelist(Player)
	Bool = false
	
	for i,v in pairs(config["Settings"]["Whitelist"]) do
		if Player.UserId == v.UID then
			Bool = true
		end
	end
	
	return Bool
end

local function isVC(Player)
	return table.find(config["Settings"]["VC_Accounts"], Player.UserId)
end

local function CheckString(String)
	return (String and String ~= "" and String ~= " " and string.len(String) > 0) and true or false 
end

local function BotCheck()
	return config["SelfIndex"] == 1
end

local function ListCheck(Player)
	return CheckWhitelist(Player) or CheckMain(Player)
end

AddCmd("wl", {"whitelist"}, "Whitelists Player!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		local Player = CheckString(args[1]) and GetPlayer(args[1])
		
		if Player then
			ChangeSetting(function(Settings)
				Settings["Whitelist"][#Settings["Whitelist"]+1] = {["UID"] = Player.UserId, ["Name"] = Player.Name}
			end)
		elseif args[1] == "clear" then
			ChangeSetting(function(Settings)
				Settings["Whitelist"] = {}
			end)
		elseif args[1] == "remove" then
			local Whitelisted = config["Settings"]["Whitelist"]
			local Remove = 0
			for i,v in ipairs(Whitelisted) do
				if string.sub(tostring(v.Name):lower(), 1, string.len(args[2])) == string.lower(args[2]) then
					Remove = i
				end
			end
			table.remove(Whitelisted, Remove)
			ChangeSetting(function(Settings)
				Settings["Whitelist"] = Whitelisted
			end)
		end
	end
end)

AddCmd("cmds", {"commands", "help"}, "Chats the commands!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) then
		local Start = 1
		for i,v in ipairs(Commands) do
			if config["SelfIndex"] == Start then
				local CommandNames = {v.Name}
				for _,z in pairs(v.Other) do
					table.insert(CommandNames, z)
				end
				chat_Message(table.concat(CommandNames, ", ") .. " | " .. v.Description)
				task.wait(3)
			end
			Start = ((#config["Indexed"]-1)<Start) and 1 or Start + 1
		end
	end
end)

AddCmd("fps", {"setfps", "capfps", "fpscap", "cfps"}, "Changes FPS Cap", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		local Number = tonumber(args[1])
		
		if Number then
			ChangeSetting(function(Settings)
				Settings["BFPS"] = Number
			end)
		else
			Number = tonumber(args[2])
			if Number then
				ChangeSetting(function(Settings)
					Settings["MFPS"] = Number
				end)
			end
		end
	end
end)

AddCmd("say", {"chat", "text"}, "Bots say something!", function(Player, args, Raw)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and config["SelfIndex"] ~= 0 then
		if CheckString(args[1]) then
			if table.find({"-i", "-index"}, args[1]) then
				task.wait(.1*config["SelfIndex"])
				chat_Message(tostring(config["SelfIndex"]))
			elseif table.find({"-w", "-wl", "-whitelist"}, args[1]) then
				local Table = {}
				--[[
				for i,v in pairs(config["Settings"]["Whitelist"]) do
					local Player;
					pcall(function()
						Player = Players:GetNameFromUserIdAsync(v)
					end)
					
					if Player then
						table.insert(Table, Player)
					end
				end]]
				for i,v in pairs(Players:GetPlayers()) do
					for ii,z in pairs(config["Settings"]["Whitelist"]) do
						if v.UserId == z.UID then
							table.insert(Table, v.DisplayName)
						end
					end
				end
				if BotCheck() then
					chat_Message("Whitelisted in game: " .. table.concat(Table, ", "))
				elseif config["SelfIndex"] == 2 then
					local Table = {}
					for i,v in pairs(config["Settings"]["Whitelist"]) do
						table.insert(Table, v.Name)
					end
					chat_Message("Whitelisted: " .. table.concat(Table, ", "))
				end
			else
				Raw = Raw:sub(#config["Prefix"]+4)
				chat_Message(Raw)
			end
		end
	end
end)

AddCmd("copy", {"mimic"}, "Copy cat!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		if CheckString(args[1]) then
			local Player = GetPlayer(args[1])
			
			if Player then
				ChangeSetting(function(Settings)
					Settings["Mimic"] = Player.UserId
				end)
			end
		else
			ChangeSetting(function(Settings)
				Settings["Mimic"] = 0
			end)
		end
	end
end)

local Spam_Tick = tick()
local Spam_Num = 1
AddCmd("spam", {"raid", "loopchat", "lchat", "lsay", "loopsay"}, "Spams Chat!", function(Player, args, Raw)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		if CheckString(args[1]) then
			local String = string.split(Raw, " ")
			table.remove(String, 1)
			String = table.concat(String, " ")
		
			if string.find(String, ", ") then
				String = String:split(", ")
				Spam_Num = 1
			end
			
			ChangeSetting(function(Settings)
				Settings["Spamming"] = String
			end)
		else
			ChangeSetting(function(Settings)
				Settings["Spamming"] = nil
			end)
		end
	else
		Spam_Num = 1
	end
end)

task.spawn(function()
	while task.wait() do
		local Spam = config["Settings"]["Spamming"] or nil
		if Spam ~= nil and config["SelfIndex"] ~= 0 then
			if tick()-Spam_Tick>=3 then
				Spam_Tick = tick()
				if type(Spam) == "table" then
					chat_Message(Spam[Spam_Num])
					
					Spam_Num=(#Spam<Spam_Num) and 1 or Spam_Num+1
					if Spam_Num >= #Spam+1 then
						Spam_Num = 1
					end
				else
					chat_Message(Spam)
				end
			end
		else
			task.wait(1)
		end	
	end
end)

AddCmd("rj", {"rejoin", "restart", "rej"}, "Rejoins the Server!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) then
		local Number = args[1] and tonumber(args[1])
		
		task.wait(config["SelfIndex"]/5*.125)
		
		if Number then
			if Number == config["SelfIndex"] then
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
			end
		else
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		end
	end
end)

AddCmd("re", {"reset", "die"}, "Resets the bots!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and config["SelfIndex"] ~= 0 then
		local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		
		if Humanoid then
			Humanoid.Health = 0
		end
	end
end)

AddCmd("vc", {"includevc", "ivc", "vcinclude"}, "Includes VC Accounts as Bots", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		if CheckString(args[1]) and table.find({"y", "t", "+", "p"}, args[1]:sub(1,1)) then
			ChangeSetting(function(Settings)
				Settings["Include_VC"] = true
			end)
		else
			ChangeSetting(function(Settings)
				Settings["Include_VC"] = false
			end)
		end
	end
end)

AddCmd("mute", {"volume", "vol"}, "Changes Volume!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) then
		if CheckString(args[1]) and table.find({"t", "p", "+", "u", "y"}, args[1]:sub(1,1)) then
			UserSettings().GameSettings.MasterVolume = 1
		else
			UserSettings().GameSettings.MasterVolume = 0
		end
	end
end)

local Noclip_C;
local function Noclip()
	Noclip_C = RunService.Stepped:Connect(function()
		if iswa() then
			pcall(function()
				Noclip_C:Disconnect()
			end)
			Noclip_C = nil
		end
		local User = LocalPlayer and LocalPlayer.Character
		
		for i,v in pairs(User:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end)
end

AddCmd("noclip", {"clip", "collision", "collide"}, "Noclip", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) then
		Noclip()
	end
end)

AddCmd("to", {"goto", "tp", "teleport"}, "Tps to Player!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) then
		if CheckString(args[1]) then
			local Player = GetPlayer(args[1])
			local Mine = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			
			if Player then
				local Theirs = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
				if Mine and Theirs then
					if (CheckString(args[2]) and table.find({"v", "m"}, args[2]:sub(1,1))) and isVC(LocalPlayer) then
						Mine.CFrame = Theirs.CFrame
					elseif not CheckString(args[2]) then
						Mine.CFrame = Theirs.CFrame
					end
				end
			end
		else
			local Mine = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			
			if Player then
				local Theirs = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
				if Mine and Theirs then
					if (CheckString(args[2]) and table.find({"v", "m"}, args[2]:sub(1,1))) and isVC(LocalPlayer) then
						Mine.CFrame = Theirs.CFrame
					elseif not CheckString(args[2]) then
						Mine.CFrame = Theirs.CFrame
					end
				end
			end
		end
	end
end)

AddCmd("walkto", {"walk", "follow"}, "Follows player!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		if CheckString(args[1]) then
			local Player = GetPlayer(args[1])
			if CheckString(args[2]) then
				local Number = tonumber(args[2])
				if Number then
					ChangeSetting(function(Settings)
						Settings["Following"]["Method"] = Number
					end)
				end
			end
			if Player then
				ChangeSetting(function(Settings)
					Settings["Following"]["UID"] = Player.UserId
				end)
			end
		else
			ChangeSetting(function(Settings)
				Settings["Following"]["UID"] = 0
			end)
		end
	end
end)

task.spawn(function()
	while task.wait() do
		local Player = Players:GetPlayerByUserId(config["Settings"]["Following"]["UID"])
		local Method = tonumber(config["Settings"]["Following"]["Method"])
		
		if Player and Method ~= 0 and config["SelfIndex"] ~= 0 and not config["Settings"]["Flinging"] then
			local User = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			Player = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
			local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			
			if Player and User and hrp and config["Settings"]["LTP"]["UID"] ==	 0 then
				local Index, Main_Index = config["Indexed"], config["SelfIndex"]
				local Offset, YOffset = config["Settings"]["Offset"], config["Settings"]["YOffset"]
				local Angles = {
					["45"] = 45/#Index,
					["90"] = 90/#Index,
					["180"] = 180/#Index,
					["360"] = 360/#Index,
				}
				
				if User and Player then
					if (Vector3.new(hrp.Position.X, 0, hrp.Position.Z) - Vector3.new(Player.Position.X, 0, Player.Position.Z)).Magnitude >= (config["SelfIndex"]*(Offset==0 and 3.5 or math.abs(Offset))+5) then
						hrp.CFrame = Player.CFrame
					else
						if Method == 1 then
							User:MoveTo((Player.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, (Main_Index*Offset))).Position)
						elseif Method == 2 then
							local toGo = (Player.CFrame * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, (Main_Index*Offset)))
							User:MoveTo(toGo.Position)
							if (Vector3.new(toGo.Position.X, 0, toGo.Position.Z)-Vector3.new(hrp.Position.X, 0, hrp.Position.Z)).Magnitude <= 1.25 then
								hrp.CFrame = CFrame.new(hrp.Position, (Vector3.new(Player.Position.X, hrp.Position.Y, Player.Position.Z)))
							end
						elseif Method == 3 then
							local toGo = Player.CFrame * CFrame.Angles(0, math.rad((Angles["360"])*Main_Index), 0) * CFrame.new(0, 0, Offset)
							User:MoveTo(toGo.Position)
							if (Vector3.new(toGo.Position.X, 0, toGo.Position.Z)-Vector3.new(hrp.Position.X, 0, hrp.Position.Z)).Magnitude <= 1.25 then
								hrp.CFrame = CFrame.new(hrp.Position, (Vector3.new(Player.Position.X, hrp.Position.Y, Player.Position.Z)))
							end
						elseif Method == 4 then
							local toGo = Player.CFrame * CFrame.Angles(0, math.rad(98-Angles["180"]*Main_Index), 0) * CFrame.new(0, 0, Offset)
							User:MoveTo(toGo.Position)
							if (Vector3.new(toGo.Position.X, 0, toGo.Position.Z)-Vector3.new(hrp.Position.X, 0, hrp.Position.Z)).Magnitude <= 1.25 then
								hrp.CFrame = CFrame.new(hrp.Position, (Vector3.new(Player.Position.X, hrp.Position.Y, Player.Position.Z)))
							end
						end
					end
				end
			end
		end
	end
end)

AddCmd("canimpack", {"copyanimationpack", "capack", "copyanimpack"}, "Copies Player animation pack!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) then
		local Player = CheckString(args[1]) and GetPlayer(args[1])
		
		if Player then
			local Hum1;
			local Hum2;
			Hum1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			Hum2 = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")

			if Hum1 and Hum2 then
				local Script1;
				local Script2;
				Script1 = Hum1.Parent:FindFirstChild("Animate")
				Script2 = Hum2.Parent:FindFirstChild("Animate")
				
				if Script1 and Script2 then
					Script1.Disabled = true
					local Clone = Script2:Clone()
					Clone.Disabled = true
					
					Script1.Name = ""
					Script1.Parent = workspace.CurrentCamera
					
					Clone.Disabled = false
					Clone.Parent = Hum1.Parent
				end
			end
		end
	end
end)

AddCmd("canim", {"copyanimation"}, "Copies Animations!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and config["SelfIndex"] ~= 0 then
		local Player = CheckString(args[1]) and GetPlayer(args[1])
		
		if Player then
			local User = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			local Player = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
			local Animate = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Animate")
			
			if User then
				if Animate then
					pcall(function()
						Animate.Disabled = true
					end)
				end
				task.wait()
				StopAnimations()
				local Animation
				
				for i,v in pairs(Player:GetPlayingAnimationTracks()) do
					if not string.find(v.Animation.AnimationId, "507768375") then
						Animation = User:LoadAnimation(v.Animation)
						Animation.Looped = true
						Animation.TimePosition = v.TimePosition
						Animation:Play(.1, 1, v.Speed)
					end
				end
				
				if Animation then
					local AnimFile = File(true, config["File_Names"]["Animation"])
					
					if AnimFile and BotCheck() and not table.find(AnimFile, Animation.Animation.AnimationId) then
						AnimFile[#AnimFile+1] = Animation.Animation.AnimationId
						
						File(false, config["File_Names"]["Animation"], AnimFile)
					end
				else
					pcall(function()
						Animate.Enabled = true
					end)
				end
			end
		end
	end
end)

AddCmd("animspeed", {"aspeed", "animationspeed", "speedanim"}, "Changes Animation Speed", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and config["SelfIndex"] ~= 0 then
		local Number = CheckString(args[1]) and tonumber(args[1])
		
		if Number then
			local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			
			if Humanoid then
				for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
					v:AdjustSpeed(Number)
				end
			end
		end
	end
end)

AddCmd("stopanim", {"stopanimation", "animstop", "stopanimations"}, "Stops Animations!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and config["SelfIndex"] ~= 0 then
		StopAnimations()
		task.wait()
		local Animate = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Animate")
		if Animate then
			Animate.Enabled = true
		end
	end
end)

AddCmd("baseplate", {"ground"}, "Adds a Baseplate for the bots!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and config["SelfIndex"] ~= 0 then
		local BasePlate = workspace:FindFirstChild("MBP")
		local hrp
		local hum
		hrp = Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
		hum = Player and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
		
		if not hrp or not hum then return end
		
		if CheckString(args[1]) and table.find({"f", "-", "n"}, args[1]:sub(1,1)) then
			if BasePlate then
				BasePlate:Destroy()
			end
		else
			if BasePlate then
				BasePlate:Destroy()
			end
			
			BasePlate = Instance.new("Part")
			BasePlate.Size = Vector3.new(9e9, 1, 9e9)
			if hum.RigType == Enum.HumanoidRigType.R6 then
				BasePlate.CFrame = hrp.CFrame * CFrame.new(0,-4,0)
			else
				BasePlate.CFrame = hrp.CFrame * CFrame.new(0,-2-hum.HipHeight,0)
			end
			BasePlate.Name = "MBP"
			BasePlate.Parent = workspace
		end
	end
end)

AddCmd("norender", {"antilag", "boostfps", "morefps"}, "Renders Nothing on the map!", function(Player, args)
	if ListCheck(Player) and BotCheck() then
		if CheckString(args[1]) and table.find({"t", "p", "+"}, args[1]:sub(1,1)) then
			if not table.find(config["Settings"]["NRender"], game.PlaceId) then
				ChangeSetting(function(Settings)
					Settings["NRender"][#Settings["NRender"]+1] = game.PlaceId
				end)
			end
		else
			ChangeSetting(function(Setting)
				local t, Num = false, 0
				for i,v in ipairs(Settings["NRender"]) do
					if v == game.PlaceId then
						t = true
						Num = i
					end
				end
				
				if t then
					table.remove(Settings["NRender"], Num)
				end
			end)
		end
	end
end)

local function FlingPlayer(Player: Player)
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local hrp2 = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") and Player.Character:FindFirstChildOfClass("Humanoid").Health >= 1.5 and Player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp or not hrp2 then return end
	local Saveddd = hrp2.Position
	local Timing22 = tick()
	
	pcall(Massless)
	
	local bg = nil
	
	repeat task.wait()
		bg = hrp:FindFirstChild("BodyThrust")
		local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
		local H2 = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		
		if bg and H2 then
			H2.PlatformStand = true
			H2:ChangeState("GettingUp")
			if Humanoid.MoveDirection.Magnitude > 0 then
				bg.Location = hrp.Position
				hrp.CFrame = hrp2.CFrame + Humanoid.MoveDirection * 11.5
			else
				bg.Location = hrp.Position
				hrp.CFrame = hrp2.CFrame
			end
			H2:ChangeState("GettingUp")
			bg.Force = Vector3.new(9e5, 9e7, 9e5)
		else
			bg = Instance.new("BodyThrust")
			bg.Parent = hrp
		end
	until not hrp2 or not hrp or (hrp2.Position-Saveddd).Magnitude >= 50 or (tick()-Timing22)>=15
	pcall(function() bg:Destroy() end)
	pcall(function()
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
	end)
end

AddCmd("flingall", {"loopflingall", "lflingall", "lfall"}, "Loop flings players!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		ChangeSetting(function(Settings)
			Settings["Flinging"] = not Settings["Flinging"]
		end)
	end
end)

task.spawn(function()
	while task.wait(.5) do
		if config["SelfIndex"] ~= 0 and config["Settings"]["Flinging"] then
			for i,v in pairs(Players:GetPlayers()) do
				if v~=LocalPlayer and not CheckMain(v) and not CheckWhitelist(v) then
					Noclip()
					local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
					if hrp and hum then
						local Saved = hrp.CFrame
						FlingPlayer(v)
						for i = 1,50 do
							Remove_Velocity()
							hrp.CFrame = Saved
							Remove_Velocity()
							task.wait()
						end
					end
				end
			end
		end
	end
end)

AddCmd("speed", {"rots", "rotationalspeed", "speedr", "tpspeed"}, "Changes Speed", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		local Number = CheckString(args[1]) and tonumber(args[1])
		
		if Number then
			ChangeSetting(function(Settings)
				Settings["Speed"] = Number
			end)
		end
	end
end)

AddCmd("anchor", {"freeze"}, "Anchors HumanoidRootPart", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and config["SelfIndex"] ~= 0 then
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if CheckString(args[1]) and table.find({"t", "p", "+"}, args[1]:sub(1,1)) then
			if CheckString(args[2]) and tonumber(args[2]) == config["SelfIndex"] then
				if hrp then
					hrp.Anchored = true
				end
			elseif not CheckString(args[2]) and not tonumber(args[2]) then
				if hrp then
					hrp.Anchored = true
				end
			end
		else
			if hrp then
				hrp.Anchored = false
			end
		end
	end
end)

AddCmd("unfreeze", {}, "Unfreezes Bots", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) then
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.Anchored = false
		end
	end
end)

AddCmd("pred", {"prediction", "predict"}, "Changes LTP to Predict Players movement!", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		if CheckString(args[1]) and table.find({"t", "p", "+"}, args[1]:sub(1,1)) then
			ChangeSetting(function(Settings)
				Settings["Prediction"] = true
			end)
		else
			ChangeSetting(function(Settings)
				Settings["Prediction"] = false
			end)
		end
	end
end)

AddCmd("offset", {"offs", "off", "otp"}, "Changes Offset", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		local Number = CheckString(args[1]) and tonumber(args[1])
		
		if Number then
			ChangeSetting(function(Settings)
				Settings["Offset"] = Number
			end)
		end
	end
end)

AddCmd("yoffset", {"yoffs", "yoff", "yotp", "height"}, "Changes Y-Offset", function(Player, args)
	if ListCheck(Player) and not CheckMain(LocalPlayer) and BotCheck() then
		local Number = CheckString(args[1]) and tonumber(args[1])
		
		if Number then
			ChangeSetting(function(Settings)
				Settings["YOffset"] = Number
			end)
		end
	end
end)

local num, numNew = 0, 1
AddCmd("ltp", {"masstp", "looptp", "loopgoto", "lgoto", "mtp", "tploop"}, "Mass Teleports with Methods!", function(Player, args)
	if ListCheck(Player) then
		if BotCheck() then
			if CheckString(args[1]) and args[1] ~= "all" then
				local Player = GetPlayer(args[1])
				if CheckString(args[2]) then
					local Number = tonumber(args[2])
					if Number then
						ChangeSetting(function(Settings)
							Settings["LTP"]["Method"] = Number
							Settings["Annoy"] = false
						end)
						num = 0
						numNew = 0
					end
				end
				if Player then
					ChangeSetting(function(Settings)
						Settings["LTP"]["UID"] = Player.UserId
						Settings["Annoy"] = false
					end)
					num = 0
					numNew = 0
				end
			elseif args[1] == "all" then
				local Number = CheckString(args[2]) and tonumber(args[2]) or 5
				ChangeSetting(function(Settings)
					Settings["LTP"]["Method"] = Number
					Settings["LTP"]["UID"] = 0
					Settings["Annoy"] = true
				end)
			else
				ChangeSetting(function(Settings)
					Settings["LTP"]["UID"] = 0
					Settings["Annoy"] = false
				end)
				
				task.wait(.7)
				
				local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				
				if Humanoid then
					Humanoid.PlatformStand = false
				end
			end
		else
			num = 0
			numNew = 0
		end
	end
end)
task.spawn(function()
	while task.wait() do
		local Player;
		Player = Players:GetPlayerByUserId(config["Settings"]["LTP"]["UID"])
		local Method = tonumber(config["Settings"]["LTP"]["Method"])
		
		local User = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	
		if Method ~= 0 and config["SelfIndex"] ~= 0 and Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not config["Settings"]["Flinging"] then
			if User then
				if Humanoid then
					Humanoid.PlatformStand = true
				end
				Remove_Velocity()
				local Index, Main_Index = config["Indexed"], config["SelfIndex"]
				local Offset, YOffset, Speed = config["Settings"]["Offset"], config["Settings"]["YOffset"], config["Settings"]["Speed"]
				local Angles = {
					["45"] = 45/#Index,
					["90"] = 90/#Index,
					["180"] = 180/#Index,
					["360"] = 360/#Index,
				}
				if not table.find({23, 24}, Method) then
					pcall(function()
						Bang:Stop()
					end)
				end
				num = (num<361 and num+(1*config["Settings"]["Speed"]) or 1)
				
				if not User then return end
				
				local Pos;
				local hrp2;
				local hum2;
				local Torso;
				hrp2 = Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
				hum2 = Player and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
				Torso = Player and Player.Character and Player.Character:FindFirstChild("Torso") or Player.Character:FindFirstChild("UpperTorso") 
				
				if not hrp2 or not Torso or not hum2 then return end
				
				if config["Settings"]["Prediction"] then
					if hum2 and hum2.MoveDirection.Magnitude > 0 then
						if table.find({23, 24}, Method) then
							Pos = Torso.CFrame + Vector3.new(hrp2.Velocity.X*.575, hrp2.Velocity.Y/7.5, hrp2.Velocity.Z*.575)
						else
							Pos = hrp2.CFrame + Vector3.new(hrp2.Velocity.X*.575, hrp2.Velocity.Y/7.5, hrp2.Velocity.Z*.575)
						end
					else
						Pos = Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart").CFrame
					end
				else
					Pos = Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart").CFrame
				end
				
				if not Pos then return end
				
				if Method == 1 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, (Main_Index*Offset))
				elseif Method == 2 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, (Main_Index*4), 0)
				elseif Method == 3 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad(num), 0) * CFrame.new(0, 0, Main_Index*Offset)
				elseif Method == 4 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad(num), 0) * CFrame.new(0, 0, Offset)
				elseif Method == 5 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad((Angles["360"])*Main_Index), 0) * CFrame.new(0, 0, Offset)
				elseif Method == 6 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad(num+(Angles["360"]*Main_Index)), 0) * CFrame.new(0, 0, Offset)
				elseif Method == 7 then 
					User.CFrame = Pos * CFrame.Angles(math.sin(tick()), math.rad(num+(Angles["360"]*Main_Index)), math.cos(tick())) * CFrame.new(0, 0, Offset)
				elseif Method == 8 then
					User.CFrame = Pos * CFrame.Angles(math.rad(num), math.rad(num+(Angles["360"]*Main_Index)), math.rad(num)) * CFrame.new(0, 0, Offset)
				elseif Method == 9 then
					User.CFrame = Pos * CFrame.Angles(math.rad(180), math.rad((Angles["360"]*Main_Index)), 0) * CFrame.new(0, 0, Offset)
				elseif Method == 10 then
					User.CFrame = Pos * CFrame.Angles(math.sin(tick()), math.rad((Angles["360"]*Main_Index)), math.cos(tick())) * CFrame.new(0, 0, Offset)
				elseif Method == 11 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad((Angles["360"]*Main_Index)), math.rad(num)) * CFrame.new(0, 0, Offset)
				elseif Method == 12 then
					User.CFrame = Pos * CFrame.Angles(math.rad(num+Angles["45"]*Main_Index), math.rad(num+Angles["180"]*Main_Index), 0) * CFrame.new(0, 0, (Main_Index*Offset))
				elseif Method == 13 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad(98-Angles["180"]*Main_Index), 0) * CFrame.new(0, 0, Offset)
				elseif Method == 14 then
					User.CFrame = Pos * CFrame.Angles(0, math.rad(90+Angles["180"]*Main_Index), 0) * CFrame.new(0, 0, Offset)
				elseif Method == 15 then
					if Main_Index == 1 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, YOffset, 0)
					elseif Main_Index == 2 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, 5+YOffset, 0)
					elseif Main_Index == 3 then
						User.CFrame = Pos * CFrame.Angles(math.rad(90), math.rad(0), math.rad(90)) * CFrame.new(-Offset, -2.5, -2.5-YOffset)
					elseif Main_Index == 4 then
						User.CFrame = Pos * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-90)) * CFrame.new(-Offset, -2.5, 2.5+YOffset)
					elseif Main_Index == 5 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, 5+YOffset, 4.5)
					elseif Main_Index == 6 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, YOffset, -4.5)
					elseif Main_Index == 7 then
						User.CFrame = Pos * CFrame.Angles(math.rad(90), math.rad(0), math.rad(90)) * CFrame.new(-Offset, -2.5, 3-YOffset)
					elseif Main_Index == 8 then
						User.CFrame = Pos * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-90)) * CFrame.new(-Offset, -2.5, 8+YOffset)
					else
						User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, 5)
					end
				elseif Method == 16 then
					if Main_Index == 1 then
						User.CFrame = (Pos * CFrame.Angles(0,math.rad(0), math.rad(45)) * CFrame.new(YOffset, -3+YOffset, 0)) * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, 0, 0)
					elseif Main_Index == 2 then
						User.CFrame = (Pos * CFrame.Angles(0,math.rad(0), math.rad(45)) * CFrame.new(YOffset, -3+YOffset, 0)) * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, 5, 0)
					elseif Main_Index == 3 then
						User.CFrame = (Pos * CFrame.Angles(0,math.rad(0), math.rad(45)) * CFrame.new(YOffset, -3+YOffset, 0)) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(90)) * CFrame.new(-Offset, -2.5, -2.5)
					elseif Main_Index == 4 then
						User.CFrame = (Pos * CFrame.Angles(0,math.rad(0), math.rad(45)) * CFrame.new(YOffset, -3+YOffset, 0)) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-90)) * CFrame.new(-Offset, -2.5, 2.5)
					elseif Main_Index == 5 then
						User.CFrame = (Pos * CFrame.Angles(0,math.rad(0), math.rad(45)) * CFrame.new(YOffset, -3+YOffset, 0)) * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, 5, 5)
					elseif Main_Index == 6 then
						User.CFrame = (Pos * CFrame.Angles(0,math.rad(0), math.rad(45)) * CFrame.new(YOffset, -3+YOffset, 0)) * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, 0, -4.5)
					elseif Main_Index == 7 then
						User.CFrame = (Pos * CFrame.Angles(0,math.rad(0), math.rad(45)) * CFrame.new(YOffset, -3+YOffset, 0)) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(90)) * CFrame.new(-Offset, -2.5, 3)
					elseif Main_Index == 8 then
						User.CFrame = (Pos * CFrame.Angles(0,math.rad(0), math.rad(45)) * CFrame.new(YOffset, -3+YOffset, 0)) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-90)) * CFrame.new(-Offset, -2.5, 7.5)
					else
						User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, 5)
					end
				elseif Method == 17 then
					User.CFrame = (Pos * CFrame.Angles(math.rad(Angles["360"]*Main_Index+num+4), math.rad(0), math.rad(0)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)) * CFrame.new(0, 0, -Offset)
				elseif Method == 18 then
					User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(Angles["360"]*Main_Index), math.rad(num)) * CFrame.new(0, 0, 0)) * CFrame.Angles(0, math.rad(num+Angles["360"]*Main_Index), 0) * CFrame.new(0, 0, -Offset)
				elseif Method == 19 then
					User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(num+Angles["360"]*Main_Index), math.rad(num+Angles["360"]*Main_Index), math.rad(-num-Angles["360"]*Main_Index)) * CFrame.new(0, 0, -Offset)
				elseif Method == 20 then
					User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(num+(Main_Index*40)), math.rad(num), math.rad(-num)) * CFrame.new(0, 0, -Offset)
				elseif Method == 21 then
					User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(num+(Main_Index*40)), math.rad(num), math.rad(-num)) * CFrame.new(0, 0, -Offset)
				elseif Method == 22 then
					if Main_Index == 1 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(35)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(Offset, 0, -2)
					elseif Main_Index == 2 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(35)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(Offset, 4, -2)
					elseif Main_Index == 3 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-25)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(Offset, 4, -7)
					elseif Main_Index == 4 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-120)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(Offset, -6, -6)
					elseif Main_Index == 5 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-35)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(Offset, 0, 2)
					elseif Main_Index == 6 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-35)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(Offset, 4, 2)
					elseif Main_Index == 7 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(25)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.new(-Offset, 4, -7)
					elseif Main_Index == 8 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(120)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.new(-Offset, -6, -6)
					else
						User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, 5)
					end
				elseif Method == 23 then
					local Number = config["Seperator"]
					
					if Main_Index == Number then
						if Bang and Bang.IsPlaying == false then
							Bang:Play(0.1,1,1)
						end
						
						User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, 1)
					else
						pcall(function()
							Bang:Stop()
						end)
						User.CFrame = Pos * CFrame.Angles(0, math.rad((Angles["360"])*Main_Index), 0) * CFrame.new(0, 0, Offset)
					end
				elseif Method == 24 then
					local Number = config["Seperator"]
					
					if Main_Index == Number then
						if Bang and Bang.IsPlaying == false then
							Bang:Play(0.1,1,1)
						end

						User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, 1)
					else
						pcall(function()
							Bang:Stop()
						end)
						User.CFrame = (Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, Offset+2)) * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, (Main_Index*1.75))
					end
				elseif Method == 25 then
					if Main_Index == 1 then
						User.CFrame = Pos * CFrame.Angles(math.rad(90), math.rad(30), math.rad(-90)) * CFrame.new(0,-4,0)
					elseif Main_Index == 2 then
						User.CFrame = Pos * CFrame.Angles(math.rad(90), math.rad(-30), math.rad(-90)) * CFrame.new(0,-4,0)
					elseif Main_Index == 3 then
						User.CFrame = Pos * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-90)) * CFrame.new(0,-4,0)
					else
						User.CFrame = Pos * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-90)) * CFrame.new(0,-8,0)
					end
				elseif Method == 26 then
					if Main_Index == 1 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(35)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(0, 0, -2) + Vector3.new(0, YOffset, 0)
					elseif Main_Index == 2 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(35)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(0, 4, -2) + Vector3.new(0, YOffset, 0)
					elseif Main_Index == 3 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-35)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(0, 0, 2) + Vector3.new(0, YOffset, 0)
					elseif Main_Index == 4 then
						User.CFrame = (Pos * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-35)) * CFrame.new(0, 0, 0)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.new(0, 4, 2) + Vector3.new(0, YOffset, 0)
					elseif Main_Index == 5 then	
						User.CFrame = Pos * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(0, 2+YOffset, 0)
					else
						User.CFrame = Pos * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(0, -18+YOffset+(Main_Index*4), 0)
					end
				elseif Method == 27 then
					if Main_Index == 1 then
						User.CFrame = Pos * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-90)) * CFrame.new(Offset, 0, -YOffset)
					elseif Main_Index == 2 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, YOffset+8, 2.5)
					elseif Main_Index == 3 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(90), 0) * CFrame.new(Offset, YOffset+3, 2.5)
					else
						User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, 5)
					end
				elseif Method == 28 then
					if Main_Index == 1 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(65), 0) * CFrame.new(-4, 0, 4)
					elseif Main_Index == 2 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(65), 0) * CFrame.new(1, 0, 4)
					elseif Main_Index == 3 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(-55), 0) * CFrame.new(-1, 0, -6)
					elseif Main_Index == 4 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(25), 0) * CFrame.new(4, 0, -5)
					elseif Main_Index == 5 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(-65), 0) * CFrame.new(4, 0, 4)
					elseif Main_Index == 6 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(-65), 0) * CFrame.new(-1, 0, 4)
					elseif Main_Index == 7 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(55), 0) * CFrame.new(1, 0, -6)
					elseif Main_Index == 8 then
						User.CFrame = Pos * CFrame.Angles(0, math.rad(-25), 0) * CFrame.new(-4, 0, -5)
					else
						User.CFrame = Pos * CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0, 7)
					end
				end
				Remove_Velocity()
			end
		else
			local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if Humanoid then
				Humanoid.PlatformStand = false
				pcall(function()
					Bang:Stop()
				end)
			end
			task.wait(1)
		end
	end
end)

local ReloadTime, LTick, NTick, Sound, NewPlayer = tick(), tick(), tick(), tick(), tick()
task.spawn(function() -- no errors please
	while task.wait() do
		if tick()-LTick>=2.5 then
			LTick = tick()
			local Loaded = File(true, "gameIDs.json")
			if Loaded then
				LTick = 0
				task.spawn(function()
					if tostring(game.JobId) ~= tostring(Loaded.JobId) or tonumber(game.PlaceId) ~= tonumber(Loaded.PlaceId) then
						for i = 1,1e9 do
							TeleportService:TeleportToPlaceInstance(Loaded.PlaceId, Loaded.JobId, LocalPlayer)
							task.wait(1)
						end
					end
				end)
			end
		end
		
		if tick()-NewPlayer>=8 and BotCheck() then
			Bang = nil
			NewPlayer = tick()
			if config["Settings"]["Annoy"] then
				local Table = {}
				for i,v in pairs(Players:GetPlayers()) do
					if not table.find(config["Settings"]["Accounts"], v.UserId) and not table.find(config["Settings"]["VC_Accounts"], v.UserId) and not table.find(config["Settings"]["Whitelist"], v.UserId) and v.UserId ~= config["Settings"]["Main_Account"] then
						table.insert(Table, v.UserId)
					end
				end
				
				ChangeSetting(function(Settings)
					Settings["LTP"]["UID"] = Table[math.random(1, #Table)]
				end)
			end
		end
		
		local Number_Sep;
		if tick()-NTick>=5 and BotCheck() then
			NTick = tick()
			pcall(function()
				Number_Sep = File(true, config["File_Names"]["Number"])
			end)
			local Number = tonumber(Number_Sep)
			
			if Number then
				Number = (#config["Indexed"]-1)>Number and Number + 1 or 1
				pcall(function()
					File(false, config["File_Names"]["Number"], Number)
				end)
				
				config["Seperator"] = Number
			end
		elseif not BotCheck() and config["Settings"]["Main_Account"]~=LocalPlayer.UserId and tick()-NTick>=.6 then
			NTick = tick()
			pcall(function()
				Number_Sep = File(true, config["File_Names"]["Number"])
			end)
			local Number = tonumber(Number_Sep)
			
			if Number then
				config["Seperator"] = Number
			end
		end
		
		--if tick()-ReloadTime>=((config["SelfIndex"]/6.5)+.25) then
		if tick()-ReloadTime>=((config["SelfIndex"]*.1)+.1) then
			ReloadTime = tick()
			
			local Settings;
			local Whitelist;
			pcall(function()
				Settings = File(true, config["File_Names"]["Settings"])
			end)
			
			if Settings then
				config["Settings"] = Settings
				if iswa() then
					if not CheckMain(LocalPlayer) then
						ChangeSetting(function(Settings)
							Settings["Main_Account"] = LocalPlayer.UserId
						end)
					end
				end
			end
			
			local Indexed = IndexAccounts()
			config["Indexed"] = Indexed
			for i, v in ipairs(Indexed) do
				if v == LocalPlayer.UserId then
					config["SelfIndex"] = i
				end
			end
			if Settings and Settings["Main_Account"] == LocalPlayer.UserId then
				config["SelfIndex"] = 0
			end
		end
		
		local Humanoid = LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		local cam = workspace.CurrentCamera
		if CheckMain(LocalPlayer) then
			setfpscap(config["Settings"]["MFPS"])
			--settings().Rendering.QualityLevel = 4
            --UserSettings().GameSettings.GraphicsQualityLevel = 17
			if config["Settings"] and config["Settings"]["NRender"] and table.find(config["Settings"]["NRender"], game.PlaceId) then
				cam.CameraType = Enum.CameraType.Custom
				pcall(function()
					cam.CameraSubject = Humanoid or nil
				end)
			end
			RunService:Set3dRenderingEnabled(true)
			if Humanoid then
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			end
		else -- Max GraphicsLevel is 21 lowest is 1
			setfpscap(config["Settings"]["BFPS"])
			RunService:Set3dRenderingEnabled(false)
			settings().Rendering.QualityLevel = 1
            UserSettings().GameSettings.GraphicsQualityLevel = 1
			if config["Settings"] and config["Settings"]["NRender"] and table.find(config["Settings"]["NRender"], game.PlaceId) then
				cam.CameraSubject = nil
				cam.CameraType = Enum.CameraType.Scriptable
				cam.CFrame = CFrame.new(Vector3.new(0, 5e9, 0))
			end
			if Humanoid then
				Humanoid:UnequipTools()
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
				LoadBang()
			end
		end
	end
end)

for _, Player in pairs(Players:GetPlayers()) do
	if LegacyChat then
		Player.Chatted:Connect(function(Message)
			CheckCmd(Player, Message)
		end)
	end
end

Players.PlayerAdded:Connect(function(Player)
	if LegacyChat then
		Player.Chatted:Connect(function(Message)
			CheckCmd(Player, Message)
		end)
	end
end)

if not LegacyChat then
	TextChatService.MessageReceived:Connect(function(message)
        if message.TextSource then
            local Player = Players:GetPlayerByUserId(message.TextSource.UserId)
            
			if not Player then return end
			
			CheckCmd(Player, message.Text)
        end
    end)
end
