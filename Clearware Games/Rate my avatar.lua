local Config = {
    WindowName = "Clearware | Version 1.9",
    detailsofgamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color = Color3.fromRGB(0,47,108),
    Keybind = Enum.KeyCode.Z
}


for i, v in pairs(workspace:GetDescendants()) do
  if v.ClassName == "ProximityPrompt" then
    v.HoldDuration = 0
  end
end

-- Teleport Stuff
local tpservice = game:GetService("TeleportService")
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



local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/libarys/main/Bracket%20V3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Misc")
local Tab2 = Window:CreateTab("Animating")

local Section1 = Tab1:CreateSection("Main")
local Section2 = Tab1:CreateSection("Misc")

local Section3 = Tab2:CreateSection("Booth")
local Section4 = Tab2:CreateSection("Signs")




local Dropdown1 = Section1:CreateDropdown("Locations", {"Spawn","Underground Club","Item Shop", "Top Rated Leaderboard","Knight stand"}, function(String)
    locationSelected = String
end)

local Button1 = Section1:CreateButton("tp", function()
    if locationSelected == "Spawn" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8.464311599731445, 3.1999993324279785, 7.044642925262451)
        elseif locationSelected == "Underground Club" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5912.51220703125, -54.00004959106445, 37.771827697753906)
        elseif locationSelected == "Item Shop" then
             game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-61.35231399536133, 2.99999992847442627, 54.361083984375)
        elseif locationSelected == "Top Rated Leaderboard" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-61.438018798828125, 2.9999999523162842, -36.879432678222656)
        elseif locationSelected == "Knight stand" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-246.630634765625, 4, -244.48513693945312)
    end
end)






Section1:CreateLabel("Client")


local Slider1 = Section1:CreateSlider("Walkspeed", 16,500,16,true, function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)
local Slider1 = Section1:CreateSlider("Jumppower", 50,500,50,true, function(Value)
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

local Toggle13 = Section1:CreateToggle("Anti-Blacklist", nil, function(State)
toggle = State

spawn(function()
         while toggle do
            wait()
            for i,v in pairs(workspace:GetChildren()) do
            if v.Name:match("Barrier") and v:IsA("Part") then
                  if toggle then
                 v:Destroy()
                 end
             end
          end
       end
    end)
end)
Toggle13:AddToolTip("Anti Booth Blacklist")


local Toggle14 = Section2:CreateToggle("Enable Chat", nil, function(State)
    toggle = State
        if toggle then
        local chatFrame = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame
       chatFrame.ChatChannelParentFrame.Visible = true
       chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
        end
        if toggle == false then
        local chatFrame = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame
       chatFrame.ChatChannelParentFrame.Visible = false
       chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
    end
end)
Toggle14:AddToolTip("Enables Chat")

local Button2 = Section2:CreateButton("Anti-Afk", function()
	game:GetService("Players").LocalPlayer.Idled:connect(function()
   game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
  wait(1)
   game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
     end)
end)
Button2:AddToolTip("Prevents roblox from kicking you when you are afk")

local Button4 = Section2:CreateButton("Rejoin", function()
tpservice:Teleport(game.PlaceId, plr)
end) 
local Button5 = Section2:CreateButton("Server hop", function()
switchServer()
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

Toggle4:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
    Config.Keybind = Enum.KeyCode[Key]
end)    
Toggle4:SetState(true) 



-- animating tab thingie thingie tabt hingie yes


local Toggle6 = Section3:CreateToggle("Pug dancing", nil, function(State)
	toggle = State
      if toggle then
	pugCond = true
	wait(0.2)
	while pugCond == true do
		local pugTab = {
			"9837094480",
			"9837094488",
			"9837094535",
			"9837094521",
			"9837094517",
			"9837094510",
			"9837094538",
			"9837094557",
			"9837094537",
			"9837094522",
			"9837094520",
			"9837094514",
			"9837094506",
			"9837094513",
			"9837094530",
			"9837094534",
			"9837094518",
			"9837094527",
			"9837094528",
			"9837094524",
			"9837094550",
			"9837094516",
			"9837094525",
		}
		for _,v in pairs(pugTab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if pugCond==false then
				break
			end
			wait(.1)
		end
	end

    else
    pugCond = false
        wait(1)
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}
game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
           end
end)


-------------

local Toggle7 = Section3:CreateToggle("Cat", nil, function(State)
	toggle = State

    if State then
	ripCatCond = true
	wait(0.2)
	while ripCatCond==true do
		local ripCatTab = {
			"9835316720",
			"9835316733",
			"9835316781",
			"9835316773",
			"9835316740",
			"9835316736",
			"9835316743",
			"9835316749",
			"9835316754",
			"9835316761",
			"9835316780",
			"9835316785",
			"9835316787",
			"9835316775",
		}
		for _,v in pairs(ripCatTab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if ripCatCond==false then
				break
			end
			wait(.1)	
		end
	end
    else
    ripCatCond = false
    wait(1)
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
    end
end)


-------------


local Toggle8 = Section3:CreateToggle("Skull becomes 1", nil, function(State)
	toggle = State

    if State then
	skullImploadCond = true
	wait(0.2)
	while skullImploadCond==true do
		local skullImploadTab = {
			"9835255683",
			"9835255685",
			"9835255688",
			"9835255686",
			"9835255675",
			"9835255657",
			"9835255659",
			"9835255646",
			"9835255720",
		}
		for _,v in pairs(skullImploadTab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if skullImploadCond==false then
				break
			end
			wait(.1)
		end
	end

    else
    skullImploadCond = false
    wait(1)
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
    end
end)


-------------


local Toggle8 = Section3:CreateToggle("Skull exploding", nil, function(State)
	toggle = State

    if State then
skullExplodeCond = true
	wait(0.2)
	while skullExplodeCond==true do
		local skullExplodeTab = {
			"9835255720",
            "9835255646",
            "9835255659",
            "9835255657",
            "9835255675",
            "9835255686",
            "9835255688",
            "9835255685",
            "9835255683",
		}
		for _,v in pairs(skullExplodeTab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if skullExplodeCond==false then
				break
			end
			wait(.1)
		end

	end
    else
    skullExplodeCond = false
    wait(1)
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
    end
end)


-------------

local Toggle9 = Section3:CreateToggle("Cabybara pulls up", nil, function(State)
	toggle = State

   if State then
capybaraCarCond = true
	wait(0.2)
	while capybaraCarCond==true do
		local capybaraCarTab = {
			"9835192311",
			"9835192318",
			"9835192328",
			"9835192332",
			"9835192342",
			"9835192343",
			"9835192356",
			"9835192354",
			"9835192340",
			"9835192409",
			"9835192407",
		}

		for _,v in pairs(capybaraCarTab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if capybaraCarCond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    capybaraCarCond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
    end
end)


-------------

local Toggle10 = Section3:CreateToggle("Rat Spinning", nil, function(State)
	toggle = State

   if State then
spinningRatCond = true
	wait(0.2)
	while spinningRatCond == true do
		local spinningRatTab = {
			"9835143999",
			"9835144007",
			"9835144021",
			"9835144008",
			"9835144032",
			"9835144027",
			"9835144015",
			"9835144038",
			"9835144026",
			"9835144019",
			"9835144033",
			"9835144035",
			"9835144036",
			"9835144031",
			"9835144061",
			"9835144037",

		}
		for _,v in pairs(spinningRatTab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if spinningRatCond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    spinningRatCond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
    end
end)


-------------

local Toggle11 = Section3:CreateToggle("Cat Dancing", nil, function(State)
	toggle = State

   if State then
    happyCatCond = true
	wait(0.1)
	while happyCatCond==true do
		local happyCatTab = {
			"9835002079",
			"9835002136",
			"9835002131",
			"9835002084",
			"9835002080",
			"9835002086",
			"9835002078",
			"9835002086",
			"9835002115",
			"9835002120",
			"9835002096",
			"9835002129",
			"9835002100",
			"9835002112",
			"9835002098",

		}
		for _,v in pairs(happyCatTab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if happyCatCond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    happyCatCond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

    game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
    end
end)


-------------

local Toggle12 = Section3:CreateToggle("Yipeee", nil, function(State)
	toggle = State

   if State then
        yipeeCond = true
       while yipeeCond==true do
		local yipeeTab = {
			"9834224327",
			"9834224367",
			"9834224378",
			"9834224390",
			"9834224358",
			"9834224395",
			"9834224420",
			"9834224394",
			"9834224333",
			"9834224348",
			"9834224386",
			"9834224368",
			"9834224407",

		}
		for _,v in pairs(yipeeTab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if yipeeCond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    yipeeCond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
    end
end)




local Toggle18 = Section3:CreateToggle("Spongebob fish", nil, function(State)
	toggle = State
        if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"9888816960",
			"9888816536",
			"9888816224",
			"9888810253",
			"9888810067",
			"9888809922",
			"9888809764",
			"9888809324",
			"9888803341",
			"9888802915",
			"9888802721",
			"9888802431",
			"9888795511",
			"9888795328",
		}
		for _,v in pairs(Tab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if Cond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    Cond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
end
end)





----- SIGNS




local Toggle15 = Section4:CreateToggle("Skeleton Running", nil, function(State)
	toggle = State
   if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"9888761068",
			"9888760854",
			"9888754640",
			"9888754491",
			"9888754373",
			"9888754246",
			"9888754109",
			"9888753970",
			"9888753820",
		}
		for _,v in pairs(Tab) do
			game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','rbxassetid://'..tostring(v))
			if Cond==false then
				break
			end
			task.wait(.1)
		end
	end
    else
        Cond = false
		task.wait(.1)
		game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','')
    end
end)


local Toggle1255 = Section4:CreateToggle("Andrew tate Bottom G", nil, function(State)
	toggle = State
   if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"18189726393", -- 17
			"18189727782",
			"18189730607",
			"18189732709", -- 21
            "18189734203",
            "18189745351", --24
            "18189746310",
            "18189746310",
            "18189748932",
            "18189750467",
            "18189750467",
            "18189752231", --29
            "18189753355",
            "18189755414",
            "18189756571",
            "18189758282",--33
            "18189759386",
            "18189760865",
            "18189763458",--36
            "18189764539",
            "18189765673",
            "18189767070",
            "18189768306",
            "18189769892", --41
            "18189771708",
            "18189772990",
            "18189774784",
            "18189776397",
            "18189777829",
            "18189779115",
            "18189780333",
            "18189782085",
            "18189785077", -- 50
            "18189787454",
            "18189786251",
            "18189795259",
            "18189792333",
		}
		for _,v in pairs(Tab) do
			game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','rbxassetid://'..tostring(v))
			if Cond==false then
				break
			end
			task.wait(.1)
		end
	end
    else
        Cond = false
		task.wait(.1)
		game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','')
    end
end)

local Toggle17 = Section4:CreateToggle("Happy monkey circle", nil, function(State)
	toggle = State
        if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"9888794477",
			"9888788087",
			"9888787850",
			"9888787557",
			"9888787334",
			"9888787028",
			"9888786790",
			"9888786611",
			"9888786410",
		}
		for _,v in pairs(Tab) do
			game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','rbxassetid://'..tostring(v))
			if Cond==false then
				break
			end
			task.wait(.1)
		end
	end
    else
        Cond = false
		task.wait(.1)
		game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','')
    end
end)



local Toggle16 = Section4:CreateToggle("Rock rising his eyebrow", nil, function(State)
	toggle = State
        if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"9888770515",
			"9888770296",
			"9888769916",
			"9888769634",
			"9888769284",
			"9888769008",
			"9888768794",
			"9888768523",
			"9888763095",
			"9888762892",
			"9888762699",
			"9888762367",
			"9888762114",
			"9888761941",
			"9888761689",
			"9888761246",
		}
		for _,v in pairs(Tab) do
			game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','rbxassetid://'..tostring(v))
			if Cond==false then
				break
			end
			task.wait(.1)
		end
	end
    else
        Cond = false
		task.wait(.1)
		game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','')
    end
end)


--done
local Toggle5357474747 = Section4:CreateToggle("Spongebob fish", nil, function(State)
	toggle = State
        if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"9888816960",
			"9888816536",
			"9888816224",
			"9888810253",
			"9888810067",
			"9888809922",
			"9888809764",
			"9888809324",
			"9888803341",
			"9888802915",
			"9888802721",
			"9888802431",
			"9888795511",
			"9888795328",
		}
		for _,v in pairs(Tab) do
			game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','rbxassetid://'..tostring(v))
			if Cond==false then
				break
			end
			task.wait(.1)
		end
	end
    else
        Cond = false
		task.wait(.1)
		game:GetService("ReplicatedStorage").UpdateSign:FireServer('Decal','')
    end
end)



-- sign to booth

local Toggle315 = Section3:CreateToggle("Skeleton Running", nil, function(State)
	toggle = State
   if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"9888761068",
			"9888760854",
			"9888754640",
			"9888754491",
			"9888754373",
			"9888754246",
			"9888754109",
			"9888753970",
			"9888753820",
		}
		for _,v in pairs(Tab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if Cond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    Cond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
end
end)


local Toggle13255 = Section3:CreateToggle("Andrew tate Bottom G", nil, function(State)
	toggle = State
   if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"18189726393", -- 17
			"18189727782",
			"18189730607",
			"18189732709", -- 21
            "18189734203",
            "18189745351", --24
            "18189746310",
            "18189746310",
            "18189748932",
            "18189750467",
            "18189750467",
            "18189752231", --29
            "18189753355",
            "18189755414",
            "18189756571",
            "18189758282",--33
            "18189759386",
            "18189760865",
            "18189763458",--36
            "18189764539",
            "18189765673",
            "18189767070",
            "18189768306",
            "18189769892", --41
            "18189771708",
            "18189772990",
            "18189774784",
            "18189776397",
            "18189777829",
            "18189779115",
            "18189780333",
            "18189782085",
            "18189785077", -- 50
            "18189787454",
            "18189786251",
            "18189795259",
            "18189792333",
		}
		for _,v in pairs(Tab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if Cond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    Cond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
end
end)


local Toggle117 = Section3:CreateToggle("Happy monkey circle", nil, function(State)
	toggle = State
        if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"9888794477",
			"9888788087",
			"9888787850",
			"9888787557",
			"9888787334",
			"9888787028",
			"9888786790",
			"9888786611",
			"9888786410",
		}
		for _,v in pairs(Tab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if Cond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    Cond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
end
end)




local Toggle316 = Section3:CreateToggle("Rock rising his eyebrow", nil, function(State)
	toggle = State
        if State then
        	Cond = true
	task.wait(.1)
	while Cond==true do
		local Tab = {
			"9888770515",
			"9888770296",
			"9888769916",
			"9888769634",
			"9888769284",
			"9888769008",
			"9888768794",
			"9888768523",
			"9888763095",
			"9888762892",
			"9888762699",
			"9888762367",
			"9888762114",
			"9888761941",
			"9888761689",
			"9888761246",
		}
		for _,v in pairs(Tab) do
			local k={[1]="Update",[2]={["DescriptionText"]="",["ImageId"]=v}}
			game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(k))
			if Cond==false then
				break
			end
			wait(.1)
		end
	end
    else
    wait(2)
    Cond = false
        local args = {
    [1] = "Update",
    [2] = {
        ["DescriptionText"] = "",
        ["ImageId"] = 13976194703,
    },
}

game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
end
end)

local TextBox1 = Section3:CreateTextBox("Text Wrap", "Enter text", false, function(Value)
    local s = Value.." "

local updater = game:GetService("ReplicatedStorage").CustomiseBooth
local function update(text)
    local args = {
        [1] = "Update",
        [2] = {
            ["DescriptionText"] = text.." ",
            ["ImageId"] = 0
        }
    }
    
    updater:FireServer(unpack(args))
end

local ls = ""
for i=1, #s, 1 do
    local m = i % #s
    ls = ls .. s:sub(m, m)
    if i > 50 then
        ls = ls:sub(2)
    end
    coroutine.wrap(update)(ls)
    task.wait(.1)
end
end)
TextBox1:AddToolTip("Does NOT work with booth animations on!")
