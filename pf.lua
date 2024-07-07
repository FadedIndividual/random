repeat task.wait() until game.Loaded; task.wait(2.5)

Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
Mouse = LocalPlayer:GetMouse()
UIS = game:GetService("UserInputService")
RunService = game:GetService("RunService")

local _FOV = 50

local num, CC, _Folders, _Cache, _Locked = 2, workspace.CurrentCamera, {}, {}, nil
local circle = Drawing.new("Circle")
circle.Radius = _FOV
circle.Color = Color3.fromRGB(100, 0, 255)
circle.Filled = false
circle.NumSides = 300
circle.Transparency = 0.4
circle.Visible = true

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
						if v:IsA("BasePart") and #v:GetChildren() == 2 and v:FindFirstChildOfClass("Decal") and v:FindFirstChildOfClass("SpecialMesh") and v:FindFirstChildOfClass("SpecialMesh").MeshId == "rbxassetid://6179256256" then
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
GetClosestMouse = function(TBall)
    local Closest
    local MaxDistance = _FOV
    for _,Head in next, TBall do
		local ScreenPosition, OnScreen = PositionToScreen(Head.Position)
		local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
		if OnScreen and Distance <= MaxDistance then
			Closest = Head
			MaxDistance = Distance
		end
    end
    if Closest then
        return Closest
    else
        return nil
    end
end

while true do pcall(function()
    circle.Position = Vector2.new(Mouse.X, Mouse.Y+30)
    _Folders = GetChars()
    if _Folders then
		pcall(function()
            if not _Locked or _Locked == nil or not (_Locked~=nil) or not pcall(function() _Locked.Transparency = _Locked.Transparency end) or not UIS:IsMouseButtonPressed(0) then
			    _Locked = GetClosestMouse(_Heads())
            end
		end)
        for i, v in pairs(_Folders) do
            if tostring(i) == tostring(LocalPlayer.Team) then
            else
                if #v >= 1 then
                    for _,z in pairs(v) do
                        if not z:FindFirstChild("x_x") then
                            local High = Instance.new("Highlight")
                            High.Parent = z; High.Name = "x_x"; High.Adornee = z; High.OutlineColor = Color3.fromRGB(255, 0, 0) High.OutlineTransparency = .25; High.FillTransparency = 1; High.Enabled = true; High.LineThickness = 3; High.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            table.insert(_Cache, High)
                        end
                    end
                end
            end
        end
    end

    --game:GetService("Players").LocalPlayer.PlayerGui.MenuScreenGui.Pages.PageLoadoutMenu.DisplayWeaponSelection.DisplayWeaponList.Container
    --game:GetService("Players").LocalPlayer.PlayerGui.MenuScreenGui.Pages.PageLoadoutMenu.DisplayWeaponSelection.DisplayWeaponList
    if _Locked and UIS:IsMouseButtonPressed(1) then
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
    if _Cache and #_Cache >= 1 then
        for i, v in pairs(_Cache) do
            v.OutlineColor = Color3.fromHSV(tick()%1, 1, 1)
        end
    end
    local gun = GetGUN() if gun == nil then return end

    if gun:FindFirstChild("LaserDot") then
        gun.LaserDot.BillboardGui.ImageLabel.ImageColor3 = Color3.fromHSV(tick()%1, 1, 1)
    end
    for i, v in pairs(gun:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency <= .99 then
            v.Transparency = .9
            v.Color = Color3.fromHSV(tick()%1, 1, 1)
        end
    end
end) task.wait() end
