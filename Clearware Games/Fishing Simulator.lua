local Config = {
    WindowName = "< Clearware | Version 2.0 >",
    detailsofgamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " | " .. game.PlaceId,
    Color = Color3.fromRGB(0,47,108),
    Keybind = Enum.KeyCode.Z
}


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/libarys/main/Bracket%20V3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))
local Tab1 = Window:CreateTab(Config.detailsofgamename)

local Section1 = Tab1:CreateSection("Main")
local Section2 = Tab1:CreateSection("Misc")

local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local hum = player.Character.HumanoidRootPart
local mouse = player:GetMouse() 
local tpservice= game:GetService("TeleportService")
local VirtualUser= game:service"VirtualUser"
local ToolsCache = game:GetService("ReplicatedStorage").ToolsCache[player.UserId]
local plrTools
local bLocation
local fuckMonster
local fuckMobby
local seacreatureSelectionned
local locationSelected
local eggs

-- Teleport Stuff
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end -- End of teleport stuff


function TPReturner() -- Serverhop
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function switchServer()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

-- End of serverhop

function teleport(loc)
    bLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    if game.Players.LocalPlayer.Character.Humanoid.Sit then
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = loc
end

for i, getTools in pairs(player.Character:GetChildren()) do
    if getTools:IsA("Tool") and  getTools:FindFirstChild("GripC1") then
        plrTools = getTools.Name
    end
end

function EquipTool()
    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.SetEquippedItem:InvokeServer(2)
    local args = {
     [1] = game:GetService("ReplicatedStorage").ToolsCache:FindFirstChild(player.UserId)[plrTools]
    }
    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EquipTool:FireServer(unpack(args))
end

game:service"Players".LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

----------------------- Start of Tabs


----------------------- Farming Tab
Section1:CreateLabel("Farming")

local Toggle2 = Section1:CreateToggle("Auto Sell", nil, function(State)
toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.processGameItemSold:InvokeServer("SellEverything")
    end
end)


local Toggle11 = Section1:CreateToggle("Fish anywhere", nil, function(State)

toggle = State
  while toggle do
      wait()
     game:GetService("ReplicatedStorage"):WaitForChild("CloudFrameShared"):WaitForChild("DataStreams"):WaitForChild("FishBiting"):InvokeServer()
     game:GetService("ReplicatedStorage"):WaitForChild("CloudFrameShared"):WaitForChild("DataStreams"):WaitForChild("FishCaught"):FireServer()
    end
end)

Section1:CreateLabel("Auto Chest")

local Toggle4 = Section1:CreateToggle("Daily Chest", nil, function(State)
    toggle = State
        while toggle do
                for i, v in pairs(game.Workspace.Islands:GetDescendants()) do
                    if v:IsA("Model") and string.match(v.Name, "Chest") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        wait(3.5)
                        fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
                    end
                end            
        end
end)

local Toggle9 = Section1:CreateToggle("Random Chest", nil, function(State)
    toggle = State
        while toggle do
                for i, v in pairs(game.Workspace.RandomChests:GetDescendants()) do
                    if v:IsA("Model") and string.match(v.Name, "Chest") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        wait(3.5)
                        fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
                    end
                end            
        end
end)

local Toggle5 = Section1:CreateToggle("Sinken Ship Chest / Suken Chest", nil, function(State)
    toggle = State
        while toggle do
            wait(5)
             for i, v in pairs(game.Workspace:GetChildren()) do
                if string.find(v.Name, "ShipModel") then
                        teleport(v.HitBox.CFrame)
                        for i, x in pairs(v:GetChildren()) do
                            if string.match(x.Name, "Chest_") then
                                teleport(x.HumanoidRootPart.CFrame)
                                wait(1.5)
                                fireproximityprompt(x.HumanoidRootPart.ProximityPrompt)    
                            end                                
                        end
                    break
                 end
              end
        end
end)

local Toggle11 = Section1:CreateToggle("Lost Chest", nil, function(State)
for i,v in pairs(game.workspace.RandomChests:GetChildren()) do
    while State do
        wait()
      local tp = game.Players.LocalPlayer.Character.HumanoidRootPart
    local chest = v
    wait(3.5)
    if chest then
        tp.CFrame = chest.Bottom.CFrame
        fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
        else
        warn("No chests")
          end
       end
    end
end)


----------------------- Teleport Tab
Section1:CreateLabel("Teleport")

local Dropdown2 = Section1:CreateDropdown("Store", {"Boat Store","Raygan's Tavern","Finn's Supplies Shop", "Petricia's Pets"}, function(String)
    locationSelected = String
end)

local Button1 = Section1:CreateButton("Teleport", function()
    if locationSelected == "Boat Store" then
            game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EnterDoor:InvokeServer("BoatShopInterior", "Inside")
        elseif locationSelected == "Raygan's Tavern" then
            game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EnterDoor:InvokeServer("TavernInterior", "Inside")
        elseif locationSelected == "Finn's Supplies Shop" then
            game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EnterDoor:InvokeServer("SuppliesStoreInterior", "Inside")  
        elseif locationSelected == "Petricia's Pets" then
            game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EnterDoor:InvokeServer("PetShop", "MainEntrance")
    end
end)

local Dropdown3 = Section1:CreateDropdown("Location", {"Port Jackson (Spawn)","Ancient Shores","Shadow Isles", "Pharaoh's Dunes", "Eruption Island", "Monster's Borough", "Suken Ship / Sinken Ship"}, function(String)
    locationSelected = String
end)

local Button2 = Section1:CreateButton("Teleport", function()
    if locationSelected == "Port Jackson (Spawn)" then
        teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))           
        elseif locationSelected == "Ancient Shores" then
        teleport(CFrame.new(-2436.431640625, 43.564971923828, -1683.4526367188))    
        elseif locationSelected == "Shadow Isles" then
        teleport(CFrame.new(2196.9926757812, 43.491630554199, -2216.4543457031))    
        elseif locationSelected == "Pharaoh's Dunes" then
        teleport(CFrame.new(-4142.74609375, 46.71378326416, 262.05679321289))
        elseif locationSelected == "Eruption Island" then
        teleport(CFrame.new(3022.9311523438, 52.347640991211, 1323.74609375))
        elseif locationSelected == "Monster's Borough" then
        teleport(CFrame.new(-3211.9047851562, 41.850345611572, 2735.306640625))  
        elseif locationSelected == "Suken Ship / Sinken Ship" then
             for i, v in pairs(game.Workspace:GetChildren()) do
                if string.find(v.Name, "ShipModel") then
                        teleport(v.HitBox.CFrame)
                    break
                 end
              end                               
       end
end)

----------------------- Player Movement
Section1:CreateLabel("Client Movement")

local Slider1 = Section1:CreateSlider("Walkspeed", 16,500,16,true, function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)
local Slider1 = Section1:CreateSlider("Jumppower", 50,500,50,true, function(Value)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)


local Toggle5 = Section1:CreateToggle("Infinite jump", nil, function(State)
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

local Toggle5 = Section1:CreateToggle("Always run", nil, function(State)
toggle = State
while toggle do
      wait()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 23
     end
     if not toggle then
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
     end
end)


----------------------- SECTION 2 START
----------------------- Also boats Tab


Section2:CreateLabel("Boats")

local Slider1 = Section2:CreateSlider("Boat Speed", 10,150,10,true, function(Value)
 for i, v in pairs(game.Workspace:GetChildren()) do
        if v.Name == (game.Players.LocalPlayer.Name .. "'s Boat") then
             v.Controller.VehicleSeat.MaxSpeed = tonumber(Value)
         end
    end   
end)

local Button3 = Section2:CreateButton("Tp to Boat", function()
    for i, v in pairs(game.Workspace:GetChildren()) do
        if v.Name == (game.Players.LocalPlayer.Name .. "'s Boat") then
             teleport(v.Controller.VehicleSeat.CFrame + Vector3.new(0, 3, 0))
        end
    end
end)
local Button4 = Section2:CreateButton("Remove Borders", function()
    for i, v in pairs(game.Workspace.IgnoredByMouse.BoatBorders:GetChildren()) do
        v:Destroy()
    end
end)   

----------------------- Others Tab
Section2:CreateLabel("Other")


local Toggle7 = Section2:CreateToggle("Reduce Lag", nil, function(State)
    toggle = State
     if toggle then
        while toggle do 
            wait(30)
            for i, v in pairs(game.Workspace.DroppedItems:GetChildren()) do
                if v:IsA("Model") then
                    v:Destroy()
                end
            end
        end
      end
end)

local Button5 = Section2:CreateButton("Anti-Afk", function()
game:GetService("Players").LocalPlayer.Idled:connect(function()
   game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
  wait(1)
   game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
     end)
end) 

local Button8 = Section2:CreateButton("Instant ProximityPrompt", function()
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
   prompt.HoldDuration = 0
    end)
end) 

local Button6 = Section2:CreateButton("No fog/water effect", function()
local function Remove()
for _, v in pairs(game.Lighting:GetChildren()) do
   if v:IsA("ColorCorrectionEffect") then
      v:Remove()
   end
end
for _, z in pairs(game.Lighting:GetChildren()) do
   if z:IsA("BlurEffect") then
      z:Remove()
   end
end
game.Lighting.Atmosphere.Name = "NewAtmosphere"
end

local function Create()
local CoolLight = Instance.new("ColorCorrectionEffect", game.Lighting)
CoolLight.Name = "NoBlur"
CoolLight.Brightness = 0
CoolLight.Contrast = 0.1
CoolLight.Saturation = 0.1
end

Remove()
wait(1)
Create()
end)

local Button5 = Section2:CreateButton("Realistic Graphics", function()
loadstring(game:HttpGet("https://pastebin.com/raw/XjZ7N9zg"))()
end) 


----------------------- Server Tab
Section2:CreateLabel("Server")

local Button5 = Section2:CreateButton("Rejoin", function()
tpservice:Teleport(game.PlaceId, plr)
end) 
local Button6 = Section2:CreateButton("Server hop", function()
switchServer()
end)   

----------------------- UI Tab
Section2:CreateLabel("UI")

local Toggle7 = Section2:CreateToggle("UI Toggle", nil, function(State)
    Window:Toggle(State)
end)

local Colorpicker3 = Section2:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)

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

local Slider3 = Section2:CreateSlider("Imagine Transparency",0,1,nil,false, function(Value)
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
Section2:CreateLabel("Lonelywhale: Contribution")


Toggle7:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
    Config.Keybind = Enum.KeyCode[Key]
end)    
Toggle7:SetState(true) 
