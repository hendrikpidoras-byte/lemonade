-- ULTIMATIVER FREE GAMEPASS GIFTER – ALLES KOSTENLOS AN JEDEN (2025 BYFRON-SAFE)
repeat task.wait() until game:IsLoaded()
task.wait(3)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local MonetizationConfig = require(game.ReplicatedStorage.Config.MonetizationConfig)

-- HOOK DEN KAUF-PROMPT → immer kostenlos + immer erlaubt
local oldPrompt = _G.Prompt and _G.Prompt.PromptProduct or function() end
if _G.Prompt then
    _G.Prompt.PromptProduct = newcclosure(function(ProductId, isGift)
        print("FREE GIFT GEFORCED → ProductId:", ProductId)
        -- Roblox denkt, du hast gekauft → Gamepass wird sofort gegeben
        game:GetService("MarketplaceService"):SignalPromptProductPurchaseFinished(player.UserId, ProductId, true)
        return true
    end)
end

-- GUI: WÄHLE SPIELER + GAMEPASS → KOSTENLOS SCHENKEN
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "FreeGifter"
sg.ResetOnSpawn = false

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 500, 0, 400)
frame.Position = UDim2.new(0.5, -250, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(10, 0, 30)
frame.BorderSizePixel = 6
frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,60)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
title.Text = "FREE GAMEPASS GIFTER – ALLES KOSTENLOS"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 28
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 20)

local playerBox = Instance.new("TextBox", frame)
playerBox.Position = UDim2.new(0.1,0,0,80)
playerBox.Size = UDim2.new(0.8,0,0,50)
playerBox.PlaceholderText = "Spielername eingeben"
playerBox.Text = ""
playerBox.BackgroundColor3 = Color3.fromRGB(30,30,60)

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0.1,0,0,150)
scroll.Size = UDim2.new(0.8,0,0,200)
scroll.ScrollBarThickness = 10
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,10)

-- Alle Gamepasses aus der Config laden
local y = 1
for name, data in pairs(MonetizationConfig.Gamepasses) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,50)
    btn.Position = UDim2.new(0,0,0,(y-1)*60)
    btn.BackgroundColor3 = Color3.fromRGB(80, 0, 150)
    btn.Text = name .. " → GIFTEN"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)
    btn.Parent = scroll
    
    btn.MouseButton1Click:Connect(function()
        local targetName = playerBox.Text:gsub("^%s*(.-)%s*$", "%1")
        if targetName == "" then targetName = player.Name end
        local target = Players:FindFirstChild(targetName)
        if not target then
            btn.Text = "SPIELER NICHT GEFUNDEN!"
            task.wait(2)
            btn.Text = name .. " → GIFTEN"
            return
        end
        
        -- TempData setzen (wie im Original)
        player.TempData.GiftingItem.Value = name
        
        -- Fake Prompt triggern
        local giftId = data.GiftId or data.Id
        if giftId then
            _G.Prompt:PromptProduct(giftId, true)
            btn.Text = name .. " GESCHENKT AN " .. target.Name .. "!"
            task.wait(3)
            btn.Text = name .. " → GIFTEN"
        end
    end)
    y = y + 1
end

print("FREE GIFTER GELADEN – Wähle Spieler + Gamepass → kostenlos schenken, auch wenn er es schon hat!")
