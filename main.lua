repeat task.wait() until game.Loaded and game:GetService("Players") and game.Players.LocalPlayer; wait(2.5)

local Players = game:GetService("Players")
local Local = Players.LocalPlayer
local NAME, VERSION = "social_area", 6
local Main_T = {}
local function Update() writefile(NAME..".txt", game:GetService("HttpService"):JSONEncode(Main_T)) end

if isfile(NAME..".txt") and game:GetService("HttpService"):JSONDecode(readfile(NAME..".txt")).Version == VERSION  then
	Main_T = game:GetService("HttpService"):JSONDecode(readfile(NAME..".txt"))
else
	Main_T = {
		["Version"] = VERSION;
		["Vars"] = {
			["Client"] = {["FPS"] = 30};
		};
		["Settings"] = {
			["Blox-Fruits"] = {["PID"] = {"7449423635", "4442272183", "2753915549"}; ["On-Teleport"] = false; ["Raw"] = "https://raw.githubusercontent.com/REDzHUB/BloxFruits/main/redz9999"};
			--["LPI"] = {["On-Teleport"] = false; ["Raw"] = nil; ["Extra"] = {}};
			["DH"] = {["PID"] = {"417267366"}; ["On-Teleport"] = false; ["Raw"] = "https://raw.githubusercontent.com/FadedIndividual/MAIN-Serverhopping-Bot/main/Main.lua"};
		};
	}--[[ 2753915549/Blox-Fruits - - 391104146/LPI - - 417267366/DH ]]
	Update()
end setfpscap(tonumber(Main_T.Vars.Client.FPS))

local Add = loadstring(game:HttpGet("https://raw.githubusercontent.com/FadedIndividual/random/main/lib.lua"))()

local b11, b55 = Add.Category_Button("Settings")
local FFPPSS = Add.t_TextBox(b11, "FPS Cap ["..tostring(Main_T.Vars.Client.FPS).."]", function(Tbox) if tonumber(Tbox.Text) and (tonumber(Tbox.Text)>= 10 and tonumber(Tbox.Text) <= 999) then Main_T.Vars.Client.FPS = tonumber(Tbox.Text) Tbox.PlaceholderText = "FPS Cap ["..tostring(Main_T.Vars.Client.FPS).."]"; Update() setfpscap(tonumber(Tbox.Text)) end end, 4)
local INFY = Add.b_Button(b11, "Infinite Yield", function(but) spawn(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end) but:Destroy() end, false)

local BSS1, BSS2 = nil, nil;
for i, v in pairs(Main_T["Settings"]) do
	if v["PID"] and table.find(v["PID"], tostring(game.PlaceId)) then
		if v["On-Teleport"] then
			loadstring(game:HttpGet(tostring(v.Raw)))()
		else
			spawn(function() BSS2 = Add.b_Button(b11, tostring(i), function(but) spawn(function() loadstring(game:HttpGet(tostring(v.Raw)))() end) but:Destroy() end, false) end)
		end
		spawn(function() BSS1 = Add.b_Button(b11, (tostring(i) .. ": " .. tostring(v["On-Teleport"])), function(button) v["On-Teleport"] = not v["On-Teleport"]; button.Text = (tostring(i) .. ": " .. tostring(v["On-Teleport"])); Update() end, false) end)
	end
end
