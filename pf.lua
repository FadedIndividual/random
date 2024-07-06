Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
Mouse = LocalPlayer:GetMouse()
UIS = game:GetService("UserInputService")
RunService = game:GetService("RunService")

if game.PlaceId == 292439477 then
    local CC, _Folders, _Cache = workspace.CurrentCamera, {}, {}

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

    game:GetService("RunService").Stepped:Connect(function()
        _Folders = GetChars()
        if _Folders then
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
        if _Cache and #_Cache >= 1 then
            for i, v in pairs(_Cache) do
                v.OutlineColor = Color3.fromHSV(tick()%1, 1, 1)
            end
        end
        --"SpotLight"
        --gun--
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
    end)
end
