local Config = {
    WindowName = "< Clearware | Version 1.0 >",
    detailsofgamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " | " .. game.PlaceId,
    Color = Color3.fromRGB(0,47,108),
    Keybind = Enum.KeyCode.Z
}

getgenv().silentaim_settings = {
   mastersilenttoggle = false,
   fov = 125,
   fovthickness = 4,
   hitbox = "Torso",
   fovcircle = false,
   fovcolor = 0,0,0,
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local CurrentCamera = workspace.CurrentCamera

local function GetClosest(Fov)
   local Target, Closest = nil, Fov or math.huge
   for i,v in pairs(Players:GetPlayers()) do
      if getgenv().silentaim_settings.mastersilenttoggle == true then
       if (v.Character and v ~= Player and v.Character:FindFirstChild(getgenv().silentaim_settings.hitbox)) then
           local Position, OnScreen = CurrentCamera:WorldToScreenPoint(v.Character[getgenv().silentaim_settings.hitbox].Position)
           local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
           if (Distance < Closest and OnScreen) then
               Closest = Distance
               Target = v
           end
       end
   end
end
   return Target
end

local Target
local CircleInline = Drawing.new("Circle")
local CircleOutline = Drawing.new("Circle")
RunService.Stepped:Connect(function()
   CircleInline.Radius = getgenv().silentaim_settings.fov
   CircleInline.Thickness = getgenv().silentaim_settings.fovthickness
   CircleInline.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
   CircleInline.Transparency = 1
   CircleInline.Color = Color3.fromRGB(getgenv().silentaim_settings.fovcolor)
   CircleInline.Visible = getgenv().silentaim_settings.fovcircle
   CircleInline.ZIndex = 2
   CircleOutline.Radius = getgenv().silentaim_settings.fov
   CircleOutline.Thickness = getgenv().silentaim_settings.fovthickness
   CircleOutline.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
   CircleOutline.Transparency = 1
   CircleOutline.Color = Color3.fromRGB(getgenv().silentaim_settings.fovcolor)
   CircleOutline.Visible = getgenv().silentaim_settings.fovcircle
   CircleOutline.ZIndex = 1
   Target = GetClosest(getgenv().silentaim_settings.fov)
end)

local Old; Old = hookmetamethod(game, "__namecall", function(Self, ...)
   local Args = {...}
   if (not checkcaller() and getnamecallmethod() == "FindPartOnRayWithIgnoreList") then
   if getgenv().silentaim_settings.mastersilenttoggle == true then
       if (table.find(Args[2], workspace.WorldIgnore.Ignore) and Target and Target.Character) then
           local Origin = Args[1].Origin
           Args[1] = Ray.new(Origin, Target.Character[getgenv().silentaim_settings.hitbox].Position - Origin)
       end
   end
end
   return Old(Self, unpack(Args))
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/libarys/main/Bracket%20V3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))
local Tab1 = Window:CreateTab(Config.detailsofgamename)
local Section1 = Tab1:CreateSection("Main")
local Section2 = Tab1:CreateSection("Misc")

---------------------- Start of script / First Section
Section1:CreateLabel("Silent-aim")

-------------
local Toggle1 = Section1:CreateToggle("Master silentaim toggle", false, function(State)
	getgenv().silentaim_settings.mastersilenttoggle = State
end)
Toggle1:AddToolTip("Silentaim toggle")

---------------------- A functioning dropdown

local Dropdown1 = Section1:CreateDropdown("Hitpart", {"Torso","Head"}, function(String)
    locationSelected = String
end)

local Button1 = Section1:CreateButton("Click this after selecting", function()
    if locationSelected == "Torso" then
            getgenv().silentaim_settings.hitbox = "Torso"
        elseif locationSelected == "Head" then
            getgenv().silentaim_settings.hitbox = "Head"
--        elseif locationSelected == "Random" then
--             print("Whale is gay 3")
    end
end)

Section1:CreateLabel("Fov Settings")

local Toggle10 = Section1:CreateToggle("Fov toggle", false, function(State)
	getgenv().silentaim_settings.fovcircle = State
end)
Toggle10:AddToolTip("Fov toggle")

local Slider10 = Section1:CreateSlider("Fov Size", 0,300,nil,true, function(Value)
	getgenv().silentaim_settings.fov = Value
end)
Slider10:AddToolTip("Changes size of fov")
Slider10:SetValue(125)

local Slider11 = Section1:CreateSlider("Fov Thickness", 1,50,nil,true, function(Value)
	getgenv().silentaim_settings.fovthickness = Value
end)
Slider11:SetValue(3)

--[[
local Dropdown10 = Section1:CreateDropdown("Fov Color", {"Black","White","Red","Green","Orange","Blue"}, function(String)
    locationSelected = String
end)

local Button1 = Section1:CreateButton("Set Color", function()
    if locationSelected == "Black" then
            getgenv().silentaim_settings.hitbox = "0,0,0"
        elseif locationSelected == "White" then
            getgenv().silentaim_settings.fovcolor = "255,255,255"
        elseif locationSelected == "Red" then
             getgenv().silentaim_settings.fovcolor = "255, 0, 0"
        elseif locationSelected == "Green" then
             getgenv().silentaim_settings.fovcolor = "0,128,0"
        elseif locationSelected == "Orange" then
             getgenv().silentaim_settings.fovcolor = "255, 165, 0"
        elseif locationSelected == "Blue" then
             getgenv().silentaim_settings.fovcolor = "0, 0, 255"
          end
end)--]]

local MarketplaceService = game:GetService("MarketplaceService")
local passId = 10200768
local player = game.Players.LocalPlayer
if MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId) then

Section1:CreateLabel("Boombox/Radio")
Section1:CreateLabel("You can only see this feature since \n you have the boombox gamepass.")
local radio_settings = {
    assetid = 0,
    pitch = 1,
}


local TextBox22 = Section1:CreateTextBox("Audio Player", "Enter AssetID", true, function(Value)
    radio_settings.assetid = tonumber(Value)
end)


local TextBox20 = Section1:CreateTextBox("Audio Pitch Changer", "Enter Numbers", true, function(Value)
    radio_settings.pitch = tonumber(Value)
end)

Section1:CreateLabel("Audio Player")
local Button20 = Section1:CreateButton("Play Audio", function()
    local args = {
        [1] = {
            [1] = radio_settings.assetid,
            [2] = radio_settings.pitch,
        }
    }
    game:GetService("ReplicatedStorage").GameEvents.Gameplay.PlayRadio:FireServer(unpack(args))
   end)
end

----------------------- Server Tab
Section2:CreateLabel("Server")

local Button4 = Section2:CreateButton("Rejoin", function()
   game:GetService"TeleportService":TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService"Players".LocalPlayer)
end)

local Button5 = Section2:CreateButton("Server hop", function()
   local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/bobowawahahahbobobwahahawoaowabobwabo/Script-Stuff/main/Serverhop")()
   module:Teleport(game.PlaceId)
end)   

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


-- UI Keyblind setter
Toggle4:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
    Config.Keybind = Enum.KeyCode[Key]
end)    
Toggle4:SetState(true) 
