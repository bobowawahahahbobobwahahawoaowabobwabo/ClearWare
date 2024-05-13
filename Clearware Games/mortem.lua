local Config = {
    WindowName = "Clearware | Version 1.9B",
    detailsofgamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name ,
    Color = Color3.fromRGB(0,47,108),
    Keybind = Enum.KeyCode.Z
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/libarys/main/Bracket%20V3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))
local Tab1 = Window:CreateTab(Config.detailsofgamename)
local Section1 = Tab1:CreateSection("Main")
local Section2 = Tab1:CreateSection("Misc")
local ammo = "80"
print("Made antilag") -- hi

---------------------- Start of script / First Section
Section1:CreateLabel("Duping")
-------------

local Button1 = Section1:CreateButton("Crossbow minigun", function()
	local plr = game.Players.LocalPlayer
local dupe = {}

for i=1,ammo do table.insert(dupe,tonumber(12)) end 

settings().Network.IncomingReplicationLag = math.huge
wait()
for i,v in pairs(dupe) do
   local h = v
   
   local args = {
       [1] = h,
       [2] = "0:0:0:0"
   }game:GetService("ReplicatedStorage").Item:FireServer(unpack(args))
end
wait(0.5)
settings().Network.IncomingReplicationLag = 0
wait(#dupe/19)
for i,v in pairs(plr.Backpack:GetChildren()) do
   if v.Name == "C4" or v.Name == "Fire bomb" or v.Name == "Grenade" or v.Name == "Bear trap" then
       v:Destroy()
   end
end
wait(5)


local plr = game.Players.LocalPlayer
local us = game:GetService("UserInputService")
local m = plr:GetMouse()

local gunning = false
us.InputBegan:Connect(function(key,pro)
   if not pro then
       if key.KeyCode == Enum.KeyCode.T then
           gunning = not gunning
           if gunning then
               for i,v in pairs(plr.Backpack:GetChildren()) do
                   if v:FindFirstChild("Reloaded") and v.Reloaded.Value then
                       if not gunning then return end
                       plr.Character.Humanoid:EquipTool(v)
                       mouse1click()
                       wait()
                   end
               end
           end
       elseif key.KeyCode == Enum.KeyCode.G then
           plr.Character.Humanoid:UnequipTools()
           wait()
           for i,v in pairs(plr.Backpack:GetChildren()) do
               if v:FindFirstChild("Reloaded") and v.Reloaded.Value == false then
                   v.Parent = plr.Character
               end
           end
           wait(0.05)
           mouse1click()
       elseif key.KeyCode == Enum.KeyCode.V then
           plr.Character.Humanoid:UnequipTools()
           wait()
           for i,v in pairs(plr.Backpack:GetChildren()) do
               if v:FindFirstChild("Reloaded") and v.Reloaded.Value then
                   v.Parent = plr.Character
               end
           end
           wait(0.05)
           mouse1click()
       elseif key.KeyCode == Enum.KeyCode.C then
           plr.Character.Humanoid:UnequipTools()
           wait(0.05)
           local h = 0
           for i,v in pairs(plr.Backpack:GetChildren()) do
               if v:FindFirstChild("Reloaded") and v.Reloaded.Value then
                   h = h + 1
                   if h > 3 then
                       break
                   else
                       v.Parent = plr.Character
                       mouse1click()
                   end
               end
           end
       end
   end
end)
end)
Button1:AddToolTip("Dupes crossbow")

local Slider535 = Section1:CreateSlider("Minigun ammo", 80,500,80,true, function(Value)
ammo = Value
end)

Slider535:AddToolTip("Changes duped crossbows")


local Button525 = Section1:CreateButton("One shot bow", function()
	for i = 1, 10 do
        local args = {
            [1] =  27,
            [2] =  "55:55:55:55"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Item"):FireServer(unpack(args))
end

local function onKeyPress(input)
    if input.KeyCode == Enum.KeyCode.G then
        for i = 1, 10 do
             game.Players.LocalPlayer.Backpack["Long bow"].Parent = game.Players.LocalPlayer.Character
       end
    end
end
game:GetService("UserInputService").InputBegan:Connect(onKeyPress)
end)
Button525:AddToolTip("G to equip")

-------------

local TextBox1 = Section1:CreateTextBox("Teleport grenades", "Enter Username", false, function(Value)
	local target = Value
for i = 1, 100 do
    local args = {
        [1] = 0,
        [2] = "0:0:0:0"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Item"):FireServer(unpack(args))
end

wait(5)

local function start()
    local grenade = game.Players.LocalPlayer.Backpack:FindFirstChild("Grenade")
    grenade.Parent = game.Players.LocalPlayer.Character
    grenade.start:FireServer()
    grenade.Handle.Position = game.Players[target].Character.Head.Position 
    grenade.fire.Position = game.Players[target].Character.Head.Position 
    grenade.Part.Position = game.Players[target].Character.Head.Position 
    wait(3)

    local args = {
        [1] = game.Players[target].Character.Head.Position + Vector3.new(0, 1, 0),
        [2] = 1686851243.277296,
        [3] = game.Players[target].Character.Head.Position + Vector3.new(0, 1, 0) 
    }
    grenade.throw:FireServer(unpack(args))
end

for i = 1, 100 do
    coroutine.wrap(start)()
    wait(0.1)
end
end)

-------------
Section1:CreateLabel("Keyblinds")
Section1:CreateLabel("T - Minigun   | G - Reload All")
Section1:CreateLabel("V - Shoot All | C - Shoot 3")

Section1:CreateLabel("Auto-Parry")


local parryDist = 10
local blacklist = {"someone you like", "someone else you like"} 


local Button535357 = Section1:CreateButton("Enable Autoparry", function()
	local parryDist = 10
local blacklist = {"someone you like", "someone else you like"} 

local plr = game.Players.LocalPlayer
local char = plr.Character
local runService = game:GetService("RunService")
local animIds = {
    "rbxassetid://5416575259";
    "rbxassetid://5428578390";
    "rbxassetid://5428613396";
    "rbxassetid://5435382827";
    "rbxassetid://5435969402";
    "rbxassetid://5431979188";
    "rbxassetid://5436083192";
    "rbxassetid://5436059670";
    "rbxassetid://4061495031";
    "rbxassetid://3857610554";
    "rbxassetid://3857630958";
    "rbxassetid://5435928313";
    "rbxassetid://5424166879";
}

function getParryEvent()
    for i, v in next, char:GetDescendants() do
        if v:IsA("RemoteEvent") and v.Name == "ability" then
            return v
        end
    end
    return nil
end

function parry()
    local myParryEvent = getParryEvent()
    if myParryEvent then
        myParryEvent:FireServer()
    end
end

function main()
    while true do
        pcall(function()
            char = plr.Character
            runService.RenderStepped:Wait()
            for i, plrChar in next, workspace.PlayersCharacters:GetChildren() do
                if plrChar ~= char and not table.find(blacklist, plrChar.Name) then
                    local anims = plrChar.Humanoid:GetPlayingAnimationTracks()
                    for _, anim in next, anims do
                        if table.find(animIds, anim.Animation.AnimationId) then
                            if (plrChar.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude <= parryDist and plrChar.Humanoid.Health > 0 and not plrChar.Humanoid.PlatformStand then
                                parry()
                                wait(1) 
                            end
                        end
                    end 
                end 
            end 
        end)
    end 
end
wait(0.1)
main()
end)
Button535357:AddToolTip("Rejoin to disable, works best with low ping (below 100ms) ")


local Slider66461 = Section1:CreateSlider("Parry Trigger Distance", 5,20,12,true, function(Value)
    local parryDist = Value
    local blacklist = {"someone you like", "someone else you like"} 
end)
Slider66461:AddToolTip("Changes Auto parry Trigger distance")

----------------------- Player Movement Section
Section1:CreateLabel("Client Movement")


local Slider1 = Section1:CreateSlider("Walkspeed", 16,25,16,true, function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)
local Slider1 = Section1:CreateSlider("Jumppower", 50,100,50,true, function(Value)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)


local Toggle2 = Section1:CreateToggle("Infinite jump", nil, function(State)
    toggle = State
       local Player = game:GetService("Players").LocalPlayer
        Player:GetMouse().KeyDown:connect(function(k)
        if toggle then
            wait()
           if k:byte() == 32 then
           Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
           Humanoid:ChangeState("Jumping")
           wait(0.1)
           Humanoid:ChangeState("Seated")
                  end
            end
      end)
end)

-------------

_G.ScriptExecuted = false
_G.Settings = {
    Box_Color = Color3.fromRGB(255, 0, 0),
    Box_Thickness = 1,
    Team_Check = false,
    Team_Color = false,
    Autothickness = false,
    enabled = false  -- Initially disabled
}

Section2:CreateLabel("Visuals")

local Toggle55783 = Section2:CreateToggle("Toggle 2D boxes", nil, function(State)
    _G.Settings.enabled = State -- Update enabled state based on toggle

    if State then -- If enabled
            _G.Settings = {
            Box_Color = Color3.fromRGB(255, 0, 0),
            Box_Thickness = 1, -- Set thickness to 0
            Team_Check = false,
            Team_Color = false,
            Autothickness = false, -- Set Autothickness to false
            enabled = false
        }
        if not _G.ScriptExecuted then
            _G.ScriptExecuted = true

            local Space = game:GetService("Workspace")
            local Player = game:GetService("Players").LocalPlayer
            local Camera = Space.CurrentCamera

            local function NewLine(color, thickness)
                local line = Drawing.new("Line")
                line.Visible = false
                line.From = Vector2.new(0, 0)
                line.To = Vector2.new(0, 0)
                line.Color = color
                line.Thickness = thickness
                line.Transparency = 1
                return line
            end

            local function Vis(lib, state)
                for i, v in pairs(lib) do
                    v.Visible = state
                end
            end

            local function Colorize(lib, color)
                for i, v in pairs(lib) do
                    v.Color = color
                end
            end

            local Black = Color3.fromRGB(0, 0, 0)
            local function Rainbow(lib, delay)
                for hue = 0, 1, 1/30 do
                    local color = Color3.fromHSV(hue, 0.6, 1)
                    Colorize(lib, color)
                    wait(delay)
                end
                Rainbow(lib)
            end

            local function Main(plr)
                repeat wait() until plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil
                local R15
                if plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                    R15 = true
                else 
                    R15 = false
                end
                local Library = {
                    TL1 = NewLine(_G.Settings.Box_Color, _G.Settings.Box_Thickness),
                    TL2 = NewLine(_G.Settings.Box_Color, _G.Settings.Box_Thickness),
                    TR1 = NewLine(_G.Settings.Box_Color, _G.Settings.Box_Thickness),
                    TR2 = NewLine(_G.Settings.Box_Color, _G.Settings.Box_Thickness),
                    BL1 = NewLine(_G.Settings.Box_Color, _G.Settings.Box_Thickness),
                    BL2 = NewLine(_G.Settings.Box_Color, _G.Settings.Box_Thickness),
                    BR1 = NewLine(_G.Settings.Box_Color, _G.Settings.Box_Thickness),
                    BR2 = NewLine(_G.Settings.Box_Color, _G.Settings.Box_Thickness)
                }
                coroutine.wrap(Rainbow)(Library, 0.15)
                local oripart = Instance.new("Part")
                oripart.Parent = Space
                oripart.Transparency = 1
                oripart.CanCollide = false
                oripart.Size = Vector3.new(1, 1, 1)
                oripart.Position = Vector3.new(0, 0, 0)
                local function Updater()
                    local c 
                    c = game:GetService("RunService").RenderStepped:Connect(function()
                        if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                            local Hum = plr.Character
                            local HumPos, vis = Camera:WorldToViewportPoint(Hum.HumanoidRootPart.Position)
                            if vis then
                                oripart.Size = Vector3.new(Hum.HumanoidRootPart.Size.X, Hum.HumanoidRootPart.Size.Y*1.5, Hum.HumanoidRootPart.Size.Z)
                                oripart.CFrame = CFrame.new(Hum.HumanoidRootPart.CFrame.Position, Camera.CFrame.Position)
                                local SizeX = oripart.Size.X
                                local SizeY = oripart.Size.Y
                                local TL = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(SizeX, SizeY, 0)).p)
                                local TR = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(-SizeX, SizeY, 0)).p)
                                local BL = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(SizeX, -SizeY, 0)).p)
                                local BR = Camera:WorldToViewportPoint((oripart.CFrame * CFrame.new(-SizeX, -SizeY, 0)).p)
                                if _G.Settings.Team_Check then
                                    if plr.TeamColor == Player.TeamColor then
                                        Colorize(Library, Color3.fromRGB(0, 255, 0))
                                    else 
                                        Colorize(Library, Color3.fromRGB(255, 0, 0))
                                    end
                                end
                                if _G.Settings.Team_Color then
                                    Colorize(Library, plr.TeamColor.Color)
                                end
                                local ratio = (Camera.CFrame.p - Hum.HumanoidRootPart.Position).magnitude
                                local offset = math.clamp(1/ratio*750, 2, 300)
                                Library.TL1.From = Vector2.new(TL.X, TL.Y)
                                Library.TL1.To = Vector2.new(TL.X + offset, TL.Y)
                                Library.TL2.From = Vector2.new(TL.X, TL.Y)
                                Library.TL2.To = Vector2.new(TL.X, TL.Y + offset)
                                Library.TR1.From = Vector2.new(TR.X, TR.Y)
                                Library.TR1.To = Vector2.new(TR.X - offset, TR.Y)
                                Library.TR2.From = Vector2.new(TR.X, TR.Y)
                                Library.TR2.To = Vector2.new(TR.X, TR.Y + offset)
                                Library.BL1.From = Vector2.new(BL.X, BL.Y)
                                Library.BL1.To = Vector2.new(BL.X + offset, BL.Y)
                                Library.BL2.From = Vector2.new(BL.X, BL.Y)
                                Library.BL2.To = Vector2.new(BL.X, BL.Y - offset)
                                Library.BR1.From = Vector2.new(BR.X, BR.Y)
                                Library.BR1.To = Vector2.new(BR.X - offset, BR.Y)
                                Library.BR2.From = Vector2.new(BR.X, BR.Y)
                                Library.BR2.To = Vector2.new(BR.X, BR.Y - offset)
                                Vis(Library, true)
                                if _G.Settings.Autothickness then
                                    local distance = (Player.Character.HumanoidRootPart.Position - oripart.Position).magnitude
                                    local value = math.clamp(1/distance*100, 1, 4) --0.1 is min thickness, 6 is max
                                    for u, x in pairs(Library) do
                                        x.Thickness = value
                                    end
                                else 
                                    for u, x in pairs(Library) do
                                        x.Thickness = _G.Settings.Box_Thickness
                                    end
                                end
                            else 
                                Vis(Library, false)
                            end
                        else 
                            Vis(Library, false)
                            if game:GetService("Players"):FindFirstChild(plr.Name) == nil then
                                for i, v in pairs(Library) do
                                    v:Remove()
                                    oripart:Destroy()
                                end
                                c:Disconnect()
                            end
                        end
                    end)
                end
                coroutine.wrap(Updater)()
            end
            for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v.Name ~= Player.Name then
                  coroutine.wrap(Main)(v)
                end
            end
            game:GetService("Players").PlayerAdded:Connect(function(newplr)
                coroutine.wrap(Main)(newplr)
            end)
        end
    else
        -- Disable script
        _G.ScriptExecuted = false

        -- Update settings when disabled
        _G.Settings = {
            Box_Color = Color3.fromRGB(255, 0, 0),
            Box_Thickness = 0, -- Set thickness to 0
            Team_Check = false,
            Team_Color = false,
            Autothickness = false, -- Set Autothickness to false
            enabled = false
        }
    end
end)

Toggle55783:AddToolTip("Toggles 2D esp boxes")


local Slider3 = Section2:CreateSlider("Box Thickness",1,6,nil,false, function(Value)
        _G.Settings = {
        Box_Color = Color3.fromRGB(255, 0, 0),
        Box_Thickness = Value,
        Team_Check = false,
        Team_Color = false,
        Autothickness = false,
        enabled = State
    }
end)

----------------------- Other Section
Section2:CreateLabel("Map")
local Toggle6346 = Section2:CreateToggle("Anti-Lag", nil, function(State)
   while State == true do
    for _, explosion in ipairs(workspace.Explosions:GetChildren()) do
        if explosion.Name == "BombProp" or explosion.Name == "WaterFlask" or explosion.Name == "Molotovprop" then
            explosion:Destroy()
        end
    end
    wait(5)
end
end)
Toggle6346:AddToolTip("Basically anti frozen explosives, (anti lonelynuker) ")

-------------------------------- UI Settings Section
Section2:CreateLabel("UI Settings")

local Toggle4 = Section2:CreateToggle("UI Toggle", nil, function(State)
    Window:Toggle(State)
end)

-- credits to jan for patterns
local Dropdown3 = Section2:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Cats","Floral"}, function(Name)
	if Name == "Default" then
		Window:SetBackground("2151741365")
	elseif Name == "Hearts" then
		Window:SetBackground("6073763717")
	elseif Name == "Abstract" then
		Window:SetBackground("6073743871")
	elseif Name == "Hexagon" then
		Window:SetBackground("6073628839")
	elseif Name == "Circles" then
		Window:SetBackground("6071579801")
	elseif Name == "Lace With Flowers" then
		Window:SetBackground("6071575925")
	elseif Name == "Cats" then
		Window:SetBackground("13976195638")
	elseif Name == "Floral" then
		Window:SetBackground("5553946656")
	end
end)
Dropdown3:SetOption("Default")

local Colorpicker3 = Section2:CreateColorpicker("UI Theme Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)


local Slider3 = Section2:CreateSlider("Decal Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section2:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)


----------------------- Credits // End of UI
Section2:CreateLabel("Credits")
Section2:CreateLabel("xyzzr: Owner")
Section2:CreateLabel("Pantheon: Co-Owner")


Toggle4:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
    Config.Keybind = Enum.KeyCode[Key]
end)    
Toggle4:SetState(true) 
