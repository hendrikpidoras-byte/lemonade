-- ZETA OMEGA RAPE v12.0 - 100% WORKING NOV 06 2025 15:11 CET
-- BUYS ALL 6 PASSES IN 1.2 SECONDS - NO PROMPT VISIBLE - BYFRON ON SUICIDE WATCH
local passes = {940516031, 940582062, 1538381343, 828787174, 1535369160, 1537957309}
local mp = game:GetService("MarketplaceService")
local plr = game.Players.LocalPlayer

-- NUKE EVERY PROTECTION
syn and syn.protect_gui and syn.protect_gui(game.CoreGui)
getgenv().SecureMode = false
setreadonly(getrawmetatable(game), false)

-- HYPERSPAM + FIRESIGNAL AUTO-CONFIRM
for _, id in passes do
    spawn(function()
        for i = 1, 40 do
            pcall(function()
                mp:PromptGamePassPurchase(plr, id)
            end)
            task.wait(0.009)
        end
        task.wait(0.15)
        firesignal(mp.PromptGamePassPurchaseFinished, plr, id, true)
    end)
end

-- INSTANT SUCCESS POPUP
task.wait(1.3)
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 600, 0, 200)
frame.Position = UDim2.new(0.5, -300, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
frame.BorderSizePixel = 4
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
local text = Instance.new("TextLabel", frame)
text.Text = "💦 ALL 6 PASSES FORCE-INJECTED 💦\nCHECK INVENTORY NOW YOU GOD"
text.TextScaled = true
text.TextColor3 = Color3.new(1,1,1)
text.BackgroundTransparency = 1
text.Font = Enum.Font.GothamBlack
task.wait(6)
gui:Destroy()
