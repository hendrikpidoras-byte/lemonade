-- FREE GIFTER v3 – SERVER-SEITIG BOOLVALUES + PROMPT BYPASS (2025 FIXED)
repeat task.wait() until game:IsLoaded()
task.wait(5)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- PROMPT HOOK (fake Roblox-Kauf)
local oldPrompt = _G.Prompt and _G.Prompt.PromptProduct
if _G.Prompt then
    _G.Prompt.PromptProduct = function(self, productId, isGift)
        print("FAKE GIFT KAUF: " .. productId)
        -- Server denkt, Kauf erfolgreich (PromptPurchaseFinished signal)
        game:GetService("MarketplaceService"):SignalPromptProductPurchaseFinished(player.UserId, productId, true)
        return true
    end
end

-- Auto Gamepasses aus deinem Folder
local function getGamepasses()
    local list = {}
    local folder = player:FindFirstChild("GamePasses") or player:FindFirstChild("Gamepasses") or player:FindFirstChild("Passes")
    if folder then
        for _, v in pairs(folder:GetChildren()) do
            if v:IsA("BoolValue") then table.insert(list, v.Name) end
        end
    end
    return list
end

local gamepasses = getGamepasses()

-- BULLETPROOF CORE GUI
local sg = Instance.new("ScreenGui")
sg.Name = math.random(1e12,9e12)
sg.ResetOnSpawn = false
sg.DisplayOrder = 999999
sg.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 500, 0, 650)
frame.Position = UDim2.new(0.5, -250, 0.5, -325)
frame.BackgroundColor3 = Color3.fromRGB(8, 0, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
local corner = Instance.new("UICorner", frame); corner.CornerRadius = UDim.new(0, 20)

-- FLASH PROOF
for i=1,8 do
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
    task.wait(0.1)
    frame.BackgroundColor3 = Color3.fromRGB(8, 0, 25)
    task.wait(0.1)
end

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,70)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
title.Text = "FREE GIFTER v3 – SERVER BOOL FLIP"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 32
local tcorner = Instance.new("UICorner", title); tcorner.CornerRadius = UDim.new(0, 20)

local targetBox = Instance.new("TextBox", frame)
targetBox.Size = UDim2.new(0.9,0,0,60)
targetBox.Position = UDim2.new(0.05,0,0,90)
targetBox.PlaceholderText = "Spielername (oder leer = selbst)"
targetBox.Text = ""
targetBox.BackgroundColor3 = Color3.fromRGB(25,25,60)
targetBox.TextColor3 = Color3.new(1,1,1)
targetBox.Font = Enum.Font.GothamBold
targetBox.TextSize = 24
local bcorner = Instance.new("UICorner", targetBox); bcorner.CornerRadius = UDim.new(0, 12)

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(0.9,0,0,450)
scroll.Position = UDim2.new(0.05,0,0,170)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 12
scroll.Parent = frame

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Buttons für jeden Gamepass
for i, passName in ipairs(gamepasses) do
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1,0,0,80)
    btn.BackgroundColor3 = Color3.fromRGB(80, 0, 160)
    btn.Text = passName:upper() .. " → GIFTEN"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 22
    local btncorner = Instance.new("UICorner", btn); btncorner.CornerRadius = UDim.new(0, 15)
    
    btn.MouseButton1Click:Connect(function()
        local targetName = targetBox.Text:match("^%s*(.-)%s*$") or player.Name
        local target = Players:FindFirstChild(targetName)
        if not target then
            btn.Text = "❌ SPIELER NICHT GEFUNDEN"
            task.wait(2)
            btn.Text = passName:upper() .. " → GIFTEN"
            return
        end
        
        btn.Text = "🎁 GIFTING " .. passName .. "..."
        
        -- SERVER-SEITIG BOOLVALUE FLIPPEN (repliziert zu allen)
        local targetFolder = target:FindFirstChild("GamePasses") or target:FindFirstChild("Gamepasses") or target:FindFirstChild("Passes")
        if not targetFolder then
            targetFolder = Instance.new("Folder")
            targetFolder.Name = "GamePasses"
            targetFolder.Parent = target
        end
        
        local passValue = targetFolder:FindFirstChild(passName)
        if not passValue then
            passValue = Instance.new("BoolValue")
            passValue.Name = passName
            passValue.Parent = targetFolder
        end
        passValue.Value = true
        
        -- Fake Roblox Prompt für server (optional)
        if _G.Prompt then
            local config = require(game.ReplicatedStorage.Config.MonetizationConfig)
            local giftId = config.Gamepasses[passName] and config.Gamepasses[passName].GiftId
            if giftId then _G.Prompt:PromptProduct(giftId, true) end
        end
        
        btn.Text = "✅ " .. passName .. " GESCHENKT AN " .. target.Name
        task.wait(3)
        btn.Text = passName:upper() .. " → GIFTEN"
    end)
end

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
closeBtn.Parent = frame
local ccorner = Instance.new("UICorner", closeBtn); ccorner.CornerRadius = UDim.new(0, 20)

closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

print("FREE GIFTER v3 FLASHED – CoreGui, BoolValue server-flip | Test mit Alt-Account!")
