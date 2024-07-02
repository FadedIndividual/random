local Players = game:GetService("Players")
local Local = Players.LocalPlayer
local NAME, VERSION = "social_area", 1
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
			["Blox-Fruits"] = {["PID"] = 2753915549; ["On-Teleport"] = false; ["Raw"] = "https://raw.githubusercontent.com/REDzHUB/BloxFruits/main/redz9999"};
			--["LPI"] = {["On-Teleport"] = false; ["Raw"] = nil; ["Extra"] = {}};
			["DH"] = {["On-Teleport"] = false; ["Raw"] = "https://raw.githubusercontent.com/FadedIndividual/MAIN-Serverhopping-Bot/main/Main.lua"};
		};
	}--[[ 2753915549/Blox-Fruits - - 391104146/LPI - - 417267366/DH ]]
	Update()
end setfpscap(tonumber(Main_T.Vars.Client.FPS))

local Add = loadstring(game:HttpGet("https://raw.githubusercontent.com/FadedIndividual/random/main/lib.lua"))()

local b11, b55 = Add.Category_Button("Settings")
local B52, ButtonSS = nil, nil;
for i, v in pairs(Main_T.Settings) do
	if tonumber(v.PID) == tonumber(game.PlaceId) then
		if v["On-Teleport"] then
			loadstring(game:HttpGet(v.Raw))()
		else ButtonSS = Add.b_Button(b11, tostring(i), function(but) loadstring(game:HttpGet(v.Raw))() but:Destroy() end, false)
		end
		B52 = Add.b_Button(b11, tostring(i) .. ": " .. tostring(v["On-Teleport"]), function(button) v["On-Teleport"] = not v["On-Teleport"]; button.Text = tostring(i) .. ": " .. tostring(v["On-Teleport"]) Update() end, false)
		spawn(function()
			while ButtonSS and task.wait(.25) do
				if v["On-Teleport"] then ButtonSS:Destroy() end
			end
		end)
	end
end

local FFPPSS = Add.t_TextBox(b11, "FPS Cap ["..tostring(Main_T.Vars.Client.FPS).."]", function(Tbox) if tonumber(Tbox.Text) and (tonumber(Tbox.Text)>= 10 and tonumber(Tbox.Text) <= 999) then Main_T.Vars.Client.FPS = tonumber(Tbox.Text) Tbox.PlaceholderText = "FPS Cap ["..tostring(Main_T.Vars.Client.FPS).."]"; Update() setfpscap(tonumber(Tbox.Text)) end end, 4)
