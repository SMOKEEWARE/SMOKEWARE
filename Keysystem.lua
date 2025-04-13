_G.Key = "5XWM-7NKP-DLYQ-2VOT"
_G.KeyInput = "string"

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "HUB HAVEN", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local plr = game.Players.LocalPlayer

OrionLib:MakeNotification({
	Name = "Welcome "..plr.Name.."!",
	Content = "To continue to HUB HAVEN please enter key in key tab",
	Image = "rbxassetid://4483345998",
	Time = 5
})


function CorrectKey() 
    OrionLib:MakeNotification({
        Name = "Correct Key",
        Content = "You have successfully entered the correct key!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end
function IncorrectKey()
    OrionLib:MakeNotification({
        Name = "Incorrect Key!",
        Content = "You have entered the wrong key!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

function Hub()
    OrionLib:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SMOKEEWARE/SMOKEWARE/refs/heads/main/check.lua", true))()
end

local Tab = Window:MakeTab({
	Name = "Key",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddTextbox({
	Name = "Enter key",
	Default = "",
	TextDisappear = false,
	Callback = function(Value)
		_G.KeyInput = Value
	end
})

Tab:AddButton({
	Name = "Check Key",
	Callback = function()
      		if _G.KeyInput == _G.Key then
                Hub()
                CorrectKey()
                else
                    IncorrectKey()
            end
        end
})
Tab:AddButton({
	Name = "Get Key",
	Callback = function()
        setclipboard("https://discord.gg/Zj4Y9FFzyD")
    end
})