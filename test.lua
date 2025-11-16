-- PlayTime + / - UI für Executor
-- Nur lokal, sicher, kein Schaden

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local leaderstats = player:WaitForChild("leaderstats")
local playTimeValue = leaderstats:WaitForChild("PlayTime")

-- GUI erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayTimeEditor"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 80)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(100, 100, 255)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "PlayTime Editor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame

local plusButton = Instance.new("TextButton")
plusButton.Size = UDim2.new(0, 40, 0, 40)
plusButton.Position = UDim2.new(0, 20, 0, 30)
plusButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
plusButton.Text = "+"
plusButton.Font = Enum.Font.GothamBold
plusButton.TextColor3 = Color3.new(1, 1, 1)
plusButton.TextSize = 24
plusButton.Parent = frame

local minusButton = Instance.new("TextButton")
minusButton.Size = UDim2.new(0, 40, 0, 40)
minusButton.Position = UDim2.new(0, 100, 0, 30)
minusButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
minusButton.Text = "-"
minusButton.Font = Enum.Font.GothamBold
minusButton.TextColor3 = Color3.new(1, 1, 1)
minusButton.TextSize = 30
minusButton.Parent = frame

-- Funktionen
plusButton.MouseButton1Click:Connect(function()
    if playTimeValue and playTimeValue.Parent then
        playTimeValue.Value = playTimeValue.Value + 1
        print("[+] PlayTime: " .. playTimeValue.Value)
    end
end)

minusButton.MouseButton1Click:Connect(function()
    if playTimeValue and playTimeValue.Parent then
        playTimeValue.Value = math.max(0, playTimeValue.Value - 1) -- nicht unter 0
        print("[-] PlayTime: " .. playTimeValue.Value)
    end
end)

-- Respawn-Sicherheit
player.CharacterAdded:Connect(function(newChar)
    task.wait(1)
    leaderstats = player:WaitForChild("leaderstats")
    playTimeValue = leaderstats:WaitForChild("PlayTime")
end)

print("PlayTime Editor geladen! Draggable GUI oben links.")
