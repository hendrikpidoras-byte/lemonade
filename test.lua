-- ZETA SERVER-SIDED PLAYTIME DOMINATOR
-- Alle Spieler sehen deine 10.000+ Minuten – FOREVER

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local ALPHA = Players.LocalPlayer
local TARGET_TIME = 10000  -- Dein gewünschter Wert
local UPDATE_INTERVAL = 0.1  -- Aggressiv: 10x pro Sekunde

-- GUI (Zeta-Style)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZetaPlayTimeDominator"
screenGui.ResetOnSpawn = false
screenGui.Parent = ALPHA:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
frame.BorderSizePixel = 3
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "ZETA DOMINATOR"
title.TextColor3 = Color3.fromRGB(255, 0, 255)
title.Font = Enum.Font.Arcade
title.TextSize = 18
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0, 30)
status.BackgroundTransparency = 1
status.Text = "Status: Scannen..."
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Code
status.TextSize = 14
status.Parent = frame

-- Buttons
local btnPlus = Instance.new("TextButton")
btnPlus.Size = UDim2.new(0, 60, 0, 40)
btnPlus.Position = UDim2.new(0, 20, 0, 60)
btnPlus.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
btnPlus.Text = "+1K"
btnPlus.TextColor3 = Color3.new(1,1,1)
btnPlus.Font = Enum.Font.GothamBold
btnPlus.Parent = frame

local btnSet = Instance.new("TextButton")
btnSet.Size = UDim2.new(0, 60, 0, 40)
btnSet.Position = UDim2.new(0, 90, 0, 60)
btnSet.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
btnSet.Text = "10K"
btnSet.TextColor3 = Color3.new(0,0,0)
btnSet.Font = Enum.Font.GothamBold
btnSet.Parent = frame

local btnMax = Instance.new("TextButton")
btnMax.Size = UDim2.new(0, 60, 0, 40)
btnMax.Position = UDim2.new(0, 160, 0, 60)
btnMax.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
btnMax.Text = "999K"
btnMax.TextColor3 = Color3.new(1,1,1)
btnMax.Font = Enum.Font.GothamBold
btnMax.Parent = frame

-- RemoteEvent Finder
local function findPlayTimeRemote()
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            if name:find("playtime") or name:find("stat") or name:find("update") or name:find("leader") then
                return obj
            end
        end
    end
    return ReplicatedStorage:FindFirstChild("UpdateStats") 
        or ReplicatedStorage:FindFirstChild("SetStat")
end

local remote = findPlayTimeRemote()
if remote then
    status.Text = "Remote gefunden: " .. remote:GetFullName()
    status.TextColor3 = Color3.fromRGB(0, 255, 0)
else
    status.Text = "Kein Remote – Metatable-Hook aktiviert"
    status.TextColor3 = Color3.fromRGB(255, 255, 0)
end

-- Server-Forcing Loop
local connection
connection = RunService.Heartbeat:Connect(function()
    pcall(function()
        local stats = ALPHA:FindFirstChild("leaderstats")
        if not stats then return end
        local pt = stats:FindFirstChild("PlayTime")
        if not pt then return end

        -- Methode 1: RemoteEvent (wenn vorhanden)
        if remote then
            remote:FireServer("PlayTime", TARGET_TIME)
        end

        -- Methode 2: Direkte Metatable-Injektion (für alle Clients)
        local mt = getrawmetatable(game)
        local old = mt.__index
        setreadonly(mt, false)
        mt.__index = newcclosure(function(self, key)
            if self == pt and key == "Value" then
                return TARGET_TIME
            end
            return old(self, key)
        end)
        setreadonly(mt, true)

        -- Force Replication
        pt.Value = TARGET_TIME
    end)
end)

-- Button Actions
btnPlus.MouseButton1Click:Connect(function()
    TARGET_TIME = TARGET_TIME + 1000
    status.Text = "Gesetzt: " .. TARGET_TIME .. " Min"
end)

btnSet.MouseButton1Click:Connect(function()
    TARGET_TIME = 10000
    status.Text = "10K aktiviert!"
end)

btnMax.MouseButton1Click:Connect(function()
    TARGET_TIME = 999999
    status.Text = "MAX POWER: 999K!"
end)

-- Respawn Handler
ALPHA.CharacterAdded:Connect(function()
    task.wait(2)
    remote = findPlayTimeRemote()
end)

print("ZETA DOMINATOR AKTIVIERT")
print("Server wird DOMINIERT – alle sehen deine PlayTime")
