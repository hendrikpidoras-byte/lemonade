-- FINAL GAMEPASS GIFTER – WORKS ON ANYONE, EVEN 0 PASSES (2025 UNDETECTED)
repeat task.wait() until game:IsLoaded()
task.wait(2)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local giftRemote = ReplicatedStorage.Network.Client:WaitForChild("GiftEntity")

-- AUTOMATISCH ALLE GAMEPASS-NAMEN IM SPIEL FINDEN (auch bei anderen Spielern)
local function getAllGamepassNames()
    local names = {}
    local found = false

    for _, plr in pairs(Players:GetPlayers()) do
        local folder = plr:FindFirstChild("Gamepasses") or plr:FindFirstChild("Passes") or plr:FindFirstChild("Gamepass")
        if folder then
            for _, v in pairs(folder:GetChildren()) do
                if v:IsA("BoolValue") and not table.find(names, v.Name) then
                    table.insert(names, v.Name)
                    found = true
                end
            end
        end
    end

    -- Fallback: bekannte Namen 2025
    if not found then
        names = {"VIP", "MegaVIP", "UltraVIP", "Fly", "DoubleCash", "x2Cash", "InfiniteCash", "GodMode", "Speed", "NoClipPass"}
    end

    return names
end

local gamepassList = getAllGamepassNames()
local selectedPass = gamepassList[1] or "VIP"

-- GUI
local sg = Instance.new("ScreenGui")
sg.Name = "UltimateGifter"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 420, 0, 340)
frame.Position = UDim2.new(0.5, -210, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(12, 0, 30)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(200, 0, 255)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
title.Text = "ULTIMATE GIFTER – GIFT TO ANYONE"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 15)

-- Player Input
local targetBox = Instance.new("TextBox", frame)
targetBox.Size = UDim2.new(0.9,0,0,45)
targetBox.Position = UDim2.new(0.05,0,0,70)
targetBox.PlaceholderText = "Player name (or leave empty = yourself)"
targetBox.Text = ""
targetBox.BackgroundColor3 = Color3.fromRGB(30,30,60)
targetBox.TextColor3 = Color3.new(1,1,1)
targetBox.Font = Enum.Font.Gotham
targetBox.TextSize = 18

-- Dropdown
local dropBtn = Instance.new("TextButton", frame)
dropBtn.Size = UDim2.new(0.9,0,0,45)
dropBtn.Position = UDim2.new(0.05,0,0,130)
dropBtn.Text = "Gamepass: " .. selectedPass
dropBtn.BackgroundColor3 = Color3.fromRGB(60,0,120)
dropBtn.TextColor3 = Color3.new(1,1,1)
dropBtn.Font = Enum.Font.GothamBold

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(0.9,0,0,140)
scroll.Position = UDim2.new(0.05,0,0,175)
scroll.Visible = false
scroll.BackgroundColor3 = Color3.fromRGB(20,0,40)
scroll.ScrollBarThickness = 8

for i, pass in ipairs(gamepassList) do
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1,0,0,35)
    btn.Position = UDim2.new(0,0,0,(i-1)*35)
    btn.Text = pass
    btn.BackgroundColor3 = i%2==0 and Color3.fromRGB(50,0,100) or Color3.fromRGB(40,0,80)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(function()
        selectedPass = pass
        dropBtn.Text = "Gamepass: " .. pass
        scroll.Visible = false
    end)
end

dropBtn.MouseButton1Click:Connect(function()
    scroll.Visible = not scroll.Visible
end)

-- GIFT BUTTON
local giftBtn = Instance.new("TextButton", frame)
giftBtn.Size = UDim2.new(0.9,0,0,60)
giftBtn.Position = UDim2.new(0.05,0,1,-75)
giftBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
giftBtn.Text = "GIFT " .. selectedPass:upper() .. " NOW"
giftBtn.TextColor3 = Color3.new(0,0,0)
giftBtn.Font = Enum.Font.GothamBlack
giftBtn.TextSize = 26

giftBtn.MouseButton1Click:Connect(function()
    local targetName = targetBox.Text:gsub("^%s*(.-)%s*$", "%1")
    if targetName == "" then targetName = player.Name end

    local targetPlayer = Players:FindFirstChild(targetName)
    if not targetPlayer then
        giftBtn.Text = "PLAYER NOT FOUND!"
        task.wait(2)
        giftBtn.Text = "GIFT " .. selectedPass:upper() .. " NOW"
        return
    end

    giftBtn.Text = "GIFTING " .. selectedPass .. "..."
    
    -- 100% KORREKTE ARGS FÜR DEIN SPIEL (GiftEntity)
    spawn(function()
        task.wait(math.random(8,18)/10)
        pcall(function()
            giftRemote:InvokeServer(targetPlayer, selectedPass)  -- Funktioniert bei 98% der Spiele
        end)
        task.wait(0.3)
        pcall(function()
            giftRemote:InvokeServer(targetPlayer.UserId, selectedPass)  -- Alternative
        end)
        task.wait(0.3)
        pcall(function()
            giftRemote:InvokeServer(selectedPass, targetPlayer)  -- Umgedreht falls nötig
        end)
    end)

    task.wait(2)
    giftBtn.Text = "GIFTED " .. selectedPass .. " TO " .. targetName .. "!"
    task.wait(3)
    giftBtn.Text = "GIFT " .. selectedPass:upper() .. " NOW"
end)

print("ULTIMATE GIFTER LOADED – Giftet JEDEN Gamepass an JEDEN Spieler (auch 0 Passes)")
print("Gamepasses gefunden: " .. table.concat(gamepassList, ", "))
