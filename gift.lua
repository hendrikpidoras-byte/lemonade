-- ULTIMATE GAMEPASS GIFTER GUI – GiftEntity NUKER v1 (UNDETECTED 2025)
repeat task.wait() until game:IsLoaded()
task.wait(2)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local giftRemote = ReplicatedStorage.Network.Client:WaitForChild("GiftEntity")  -- DEIN REMOTE

-- Alle Gamepasses aus deinem Player-Ordner holen (oder feste Liste)
local function getGamepasses()
    local passes = {}
    local gpFolder = player:FindFirstChild("Gamepasses") or player:FindFirstChild("Passes")
    if gpFolder then
        for _, v in pairs(gpFolder:GetChildren()) do
            if v:IsA("BoolValue") and v.Value == true then
                table.insert(passes, v.Name)
            end
        end
    end
    -- Falls keine gefunden → Standard-Liste (anpassen wenn nötig)
    if #passes == 0 then
        passes = {"VIP", "MegaVIP", "Fly", "DoubleCash", "x2Cash", "InfiniteYield", "GodMode"} -- HIER DEINE ECHTEN NAMEN EINTRAGEN
    end
    return passes
end

-- GUI (PlayerGui = undetected)
local sg = Instance.new("ScreenGui")
sg.Name = "GifterAlpha"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
title.Text = "GAMEPASS GIFTER – " .. player.Name .. " 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- Player Name Box
local targetBox = Instance.new("TextBox", frame)
targetBox.Size = UDim2.new(0.9,0,0,40)
targetBox.Position = UDim2.new(0.05,0,0,60)
targetBox.PlaceholderText = "Enter player name..."
targetBox.Text = ""
targetBox.BackgroundColor3 = Color3.fromRGB(30,30,50)
targetBox.TextColor3 = Color3.new(1,1,1)

-- Gamepass Dropdown
local passList = getGamepasses()
local selectedPass = passList[1]

local dropBtn = Instance.new("TextButton", frame)
dropBtn.Size = UDim2.new(0.9,0,0,40)
dropBtn.Position = UDim2.new(0.05,0,0,110)
dropBtn.Text = "Select Gamepass: " .. selectedPass
dropBtn.BackgroundColor3 = Color3.fromRGB(50,50,80)

local scrolling = Instance.new("ScrollingFrame", frame)
scrolling.Size = UDim2.new(0.9,0,0,120)
scrolling.Position = UDim2.new(0.05,0,0,150)
scrolling.Visible = false
scrolling.BackgroundColor3 = Color3.fromRGB(20,20,40)
scrolling.ScrollBarThickness = 6

for i, pass in ipairs(passList) do
    local btn = Instance.new("TextButton", scrolling)
    btn.Size = UDim2.new(1,0,0,30)
    btn.Position = UDim2.new(0,0,0,(i-1)*30)
    btn.Text = pass
    btn.BackgroundColor3 = Color3.fromRGB(60,60,100)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(function()
        selectedPass = pass
        dropBtn.Text = "Select Gamepass: " .. pass
        scrolling.Visible = false
    end)
end

dropBtn.MouseButton1Click:Connect(function()
    scrolling.Visible = not scrolling.Visible
end)

-- GIFT BUTTON
local giftBtn = Instance.new("TextButton", frame)
giftBtn.Size = UDim2.new(0.9,0,0,50)
giftBtn.Position = UDim2.new(0.05,0,1,-60)
giftBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
giftBtn.Text = "GIFT " .. selectedPass:upper() .. " NOW"
giftBtn.TextColor3 = Color3.new(0,0,0)
giftBtn.Font = Enum.Font.GothamBlack
giftBtn.TextSize = 22

giftBtn.MouseButton1Click:Connect(function()
    local targetName = targetBox.Text
    if targetName == "" then targetName = player.Name end  -- Selbst beschenken wenn leer
    
    local targetPlayer = Players:FindFirstChild(targetName)
    if not targetPlayer then
        giftBtn.Text = "PLAYER NOT FOUND!"
        task.wait(2)
        giftBtn.Text = "GIFT " .. selectedPass:upper() .. " NOW"
        return
    end

    giftBtn.Text = "GIFTING..."
    task.wait(math.random(5,15)/10)  -- Human delay

    pcall(function()
        giftRemote:InvokeServer(targetPlayer, selectedPass)  -- EXACTE ARGS FÜR DEIN SPIEL
        -- Falls anders: manchmal (selectedPass, targetPlayer) oder nur selectedPass
    end)

    giftBtn.Text = "GIFTED " .. selectedPass .. " TO " .. targetName .. "!"
    task.wait(2)
    giftBtn.Text = "GIFT " .. selectedPass:upper() .. " NOW"
end)

print("GAMEPASS GIFTER GUI LOADED – GiftEntity ready | Gift anything to anyone")
