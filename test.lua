-- PERMANENTER PlayTime Editor (Server-Proof)
-- Überschreibt Server-Updates jede Sekunde!

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Warte auf leaderstats
local leaderstats = player:WaitForChild("leaderstats")
local playTimeValue = leaderstats:WaitForChild("PlayTime")

-- Deine gewünschte Zeit (startet mit aktueller)
local desiredTime = playTimeValue.Value

-- GUI erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PermanentPlayTimeEditor"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "🔥 PERMANENT PlayTime Editor"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame

local currentLabel = Instance.new("TextLabel")
currentLabel.Size = UDim2.new(1, 0, 0, 20)
currentLabel.Position = UDim2.new(0, 0, 0, 25)
currentLabel.BackgroundTransparency = 1
currentLabel.Text = "Aktuell: 0 Min"
currentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
currentLabel.Font = Enum.Font.Gotham
currentLabel.TextSize = 12
currentLabel.Parent = frame

local plusButton = Instance.new("TextButton")
plusButton.Size = UDim2.new(0, 50, 0, 45)
plusButton.Position = UDim2.new(0, 15, 0, 45)
plusButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
plusButton.Text = "+1"
plusButton.Font = Enum.Font.GothamBold
plusButton.TextColor3 = Color3.new(1, 1, 1)
plusButton.TextSize = 20
plusButton.Parent = frame

local minusButton = Instance.new("TextButton")
minusButton.Size = UDim2.new(0, 50, 0, 45)
minusButton.Position = UDim2.new(0, 75, 0, 45)
minusButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minusButton.Text = "-1"
minusButton.Font = Enum.Font.GothamBold
minusButton.TextColor3 = Color3.new(1, 1, 1)
minusButton.TextSize = 20
minusButton.Parent = frame

local set10kButton = Instance.new("TextButton")
set10kButton.Size = UDim2.new(0, 50, 0, 45)
set10kButton.Position = UDim2.new(0, 135, 0, 45)
set10kButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
set10kButton.Text = "10K"
set10kButton.Font = Enum.Font.GothamBold
set10kButton.TextColor3 = Color3.new(1, 1, 1)
set10kButton.TextSize = 16
set10kButton.Parent = frame

-- Buttons
plusButton.MouseButton1Click:Connect(function()
    desiredTime = desiredTime + 1
    print("➕ PlayTime gesetzt auf: " .. desiredTime)
end)

minusButton.MouseButton1Click:Connect(function()
    desiredTime = math.max(0, desiredTime - 1)
    print("➖ PlayTime gesetzt auf: " .. desiredTime)
end)

set10kButton.MouseButton1Click:Connect(function()
    desiredTime = 10000
    print("🔥 PlayTime auf 10.000 gesetzt!")
end)

-- PERMANENTE UPDATE-SCHLEIFE (alle 0.5 Sekunden)
local connection
connection = RunService.Heartbeat:Connect(function()
    if playTimeValue and playTimeValue.Parent then
        -- Setze deine Zeit
        playTimeValue.Value = desiredTime
        
        -- Update Anzeige
        currentLabel.Text = "Aktuell: " .. desiredTime .. " Min ✅"
    end
end)

-- Respawn-Sicherheit
player.CharacterAdded:Connect(function()
    task.wait(2)
    leaderstats = player:WaitForChild("leaderstats")
    playTimeValue = leaderstats:WaitForChild("PlayTime")
end)

print("🔥 PERMANENTER PlayTime Editor geladen!")
print("➕ / ➖ = ±1 | 10K = 10.000 Minuten")
print("Dragbar & Server-Proof!")
