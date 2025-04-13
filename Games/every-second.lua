getgenv().teleportLoop = false
getgenv().selectedPart = "Earth" 

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Every Second You Get +1 WalkSpeed", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local CreditTab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})



local Main = Tab:AddSection({
	Name = "Farm"
})

local Credits = CreditTab:AddSection({
	Name = "Credits"
})


CreditTab:AddLabel("Script made by 5nz")
CreditTab:AddLabel("Join the Discord server!")
CreditTab:AddLabel("discord.gg/TzGuBeRSBp")
CreditTab:AddButton({
	Name = "Copy!",
	Callback = function()
        OrionLib:MakeNotification({
            Name = "Copied to clipboard!!",
            Content = "Copied!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
        setclipboard("discord.gg/TzGuBeRSBp")
    end
})

Main:AddDropdown({
    Name = "Select World to Farm (Must be unlocked)",
    Default = "Earth",
    Options = {"Candy", "Dark", "Desert", "Earth", "Flower", "Forest", "Heaven", "Hell", "Ice", "Lava", "Moon", "Snow", "Steampunk", "Void"},
    Callback = function(Value)
        getgenv().selectedPart = Value
        OrionLib:MakeNotification({
            Name = "Selection Changed",
            Content = "Now teleporting to " .. Value,
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

Main:AddToggle({
    Name = "Enable Auto Farm",
    Default = false,
    Callback = function(Value)
        getgenv().teleportLoop = Value
        
        OrionLib:MakeNotification({
            Name = "Auto Farm",
            Content = Value and "AutoFarm enabled" or "AutoFarm disabled",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
        
        if Value then
            spawn(function()
                OrionLib:MakeNotification({
                    Name = "Now Farming!",
                    Content = "Farming in world " .. getgenv().selectedPart,
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
                while getgenv().teleportLoop do
                    local plr = game:GetService("Players").LocalPlayer
                    local winsFolder = workspace:FindFirstChild("Wins")
                    
                    if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and winsFolder then
                        for _, part in pairs(winsFolder:GetChildren()) do
                            if part:IsA("BasePart") and part.Name == getgenv().selectedPart then
                                plr.Character.HumanoidRootPart.CFrame = part.CFrame
                                wait(0.5)
                            end
                        end
                    end
                    wait(0.1) 
                end
            end)
        end
    end    
})
