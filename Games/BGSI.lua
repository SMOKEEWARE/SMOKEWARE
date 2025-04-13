loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
    Name = "SMOKEWARE",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://discord.gg/Zj4Y9FFzyD"
}

local creditTAB = GUI:Tab{
    Name = "Credit TAB",
    Icon = "rbxassetid://18854842235"
}

local mainTab = GUI:Tab{
	Name = "Main TAB",
	Icon = "rbxassetid://133885980203080"
}

local miscTab = GUI:Tab{
    Name = "Misc TAB",
    Icon = "rbxassetid://89279974687939"
}

creditTAB:Button{
	Name = "Made by 5nz and chizomeblade",
	Description = "We are a DUO coding partner!",
}
creditTAB:Button{
    Name = "Join the Discord!",
    Description = "Join our discord for more updates!",
}
creditTAB:Button{
    Name = "https://discord.gg/Zj4Y9FFzyD",
    Description = "Click to copy!",
    Callback = function()
        setclipboard("https://discord.gg/Zj4Y9FFzyD")
        GUI:Notification{
            Title = "Successfully copied!",
            Text = "Invite link is now copied to clipboard!",
            Duration = 3,
            Callback = function() end
        }
    end
}



mainTab:Button{
	Name = "Unlock all islands",
	Description = "unlock all the islands!",
	Callback = function()
		local TweenService = game:GetService("TweenService")
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")

		local islandsFolder = game:GetService("Workspace").Worlds["The Overworld"].Islands

		local function tweenTo(cframe)
			local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear)
			local tween = TweenService:Create(hrp, tweenInfo, {CFrame = cframe})
			tween:Play()
			tween.Completed:Wait()
			task.wait(-0.1)
		end

		for _, island in pairs(islandsFolder:GetChildren()) do
			local islandPart = island:FindFirstChild("Island")
			if islandPart and islandPart:FindFirstChild("UnlockHitbox") then
				local hitbox = islandPart.UnlockHitbox
				tweenTo(hitbox.CFrame)
			end
		end
	end
}

mainTab:Toggle{
    Name = "Auto blow",
    StartingState = false,
    Description = "Automatically blows bubbles",
    Callback = function(state)
        getgenv().BlowBubble = state

        if state then
            spawn(function()
                while getgenv().BlowBubble do
                    local args = {
                        [1] = "BlowBubble"
                    }

                    game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.Event:FireServer(unpack(args))
                    task.wait(-0.1)
                end
            end)
        end
    end
}

local SellMode = "full"
getgenv().sellniggers = false 


local SellDropdown = mainTab:Dropdown{
    Name = "Sell Mode",
    StartingText = "Select sell mode...",
    Description = "Choose how you'd like to auto-sell",
    Items = {
        {"Sell at full", "full"},
        {"Auto sell fast", "fast"},
    },
    Callback = function(selected)
        SellMode = selected
    end
}

mainTab:Toggle{
    Name = "Auto sell",
    StartingState = false,
    Description = "Auto sells bubbles",
    Callback = function(state)
        getgenv().sellniggers = state 

        if state then
            spawn(function()
                while getgenv().sellniggers do
                    if SellMode == "fast" then
                        local args = {
                            [1] = "SellBubble"
                        }
                        game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.Event:FireServer(unpack(args))
                        task.wait(-0)
                    elseif SellMode == "full" then
                        local label = game:GetService("Players").LocalPlayer
                            .PlayerGui.ScreenGui.HUD.Left.Currency.Bubble.Frame.Label

                        if label and label:IsA("TextLabel") then
                            local plainText = label.Text:gsub("<.->", "")
                            local currentStr, maxStr = plainText:match("([%d,]+)%s*/%s*([%d,]+)")

                            if currentStr and maxStr then
                                currentStr = currentStr:gsub(",", ""):match("^%d+$")
                                maxStr = maxStr:gsub(",", ""):match("^%d+$")

                                if currentStr and maxStr then
                                    local current = tonumber(currentStr)
                                    local max = tonumber(maxStr)

                                    if current and max and current == max then
                                        local args = {
                                            [1] = "SellBubble"
                                        }
                                        game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.Event:FireServer(unpack(args))
                                        task.wait(1)
                                    end
                                end
                            end
                        end
                    end

                    task.wait(0.2)
                end
            end)
        end
    end
}


mainTab:Toggle{
    Name = "Auto collect coins/gems",
    Description = "Auto collect coins/gems, Must go to zen island to get gems!",
    s = false,
    Callback = function(state)
        getgenv().collectNiggers = state

        if state then
            spawn(function() 
                while getgenv().collectNiggers do
                    local collectCoins = workspace.Rendered:GetChildren()[12]

                    for _, coin in ipairs(collectCoins:GetChildren()) do
                        local coinId = coin.Name
                        game:GetService("ReplicatedStorage").Remotes.Pickups.CollectPickup:FireServer(coinId)
                    end
                    task.wait(-0.1)
            
                end
            end)
        end
    end
    
}

local Codes = {"Release", "thanks"}

miscTab:Button{
    Name = "Redeem All codes",
	Description = "Redeems all working codes",
    Callback = function()
        for _, code in ipairs(Codes) do
            local args = {
                [1] = "RedeemCode",
                [2] = code
            }

            game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.Function:InvokeServer(unpack(args))
            task.wait(-0.1)
        end
    end
}