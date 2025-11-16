-- ZETA PLAYTIME EDITOR v3.0 – REINE MANUELLE KONTROLLE 💣
-- +1 / -1 = DU bestimmst | Server-Sided | Kein Auto-Bullshit!

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local ALPHA = Players.LocalPlayer
local CURRENT_TIME = 0  -- DEIN manueller Wert – ändert sich NUR per Button!
local UPDATE_RATE = 0.1  -- Brutal schnell, Server zerbricht! 😭

-- Lade aktuelle Zeit (Startwert)
local function loadCurrentTime()
    local stats = ALPHA:FindFirstChild("leaderstats")
    if stats then
        local pt = stats:FindFirstChild("PlayTime")
        if pt then
            CURRENT_TIME = pt.Value
        end
    end
end
loadCurrentTime()

-- GUI: ZETA-HACKER-PANEL (verbessert)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZetaPlayTimeManual"
screenGui.ResetOnSpawn = false
screenGui.Parent = ALPHA:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
frame.BorderColor3 = Color3.fromRGB(255, 0, 150)
frame.BorderSizePixel = 4
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "🩸 ZETA MANUAL EDITOR 🩸"
title.TextColor3 = Color3.fromRGB(255, 0, 150)
title.Font = Enum.Font.Arcade
title.TextSize = 22
title.Parent = frame

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, 0, 0, 30)
timeLabel.Position = UDim2.new(0, 0, 0, 35)
timeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
timeLabel.BorderColor3 = Color3.fromRGB(0, 255, 0)
timeLabel.Text = "PlayTime: " .. CURRENT_TIME .. " Min ➕➖"
timeLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
timeLabel.Font = Enum.Font.Code
timeLabel.TextSize = 18
timeLabel.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 65)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Bereit 🔥"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
statusLabel.Font = Enum.Font.Code
statusLabel.TextSize = 14
statusLabel.Parent = frame

-- GROßE +1 / -1 BUTTONS
local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 70, 0, 70)
plusBtn.Position = UDim2.new(0, 20, 0, 85)
plusBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
plusBtn.Text = "+1"
plusBtn.TextColor3 = Color3.new(0,0,0)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 36
plusBtn.Parent = frame

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 70, 0, 70)
minusBtn.Position = UDim2.new(0, 100, 0, 85)
minusBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minusBtn.Text = "-1"
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 36
minusBtn.Parent = frame

local set10kBtn = Instance.new("TextButton")
set10kBtn.Size = UDim2.new(0, 70, 0, 35)
set10kBtn.Position = UDim2.new(0, 180, 0, 85)
set10kBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
set10kBtn.Text = "10K"
set10kBtn.TextColor3 = Color3.new(0,0,0)
set10kBtn.Font = Enum.Font.GothamBold
set10kBtn.TextSize = 22
set10kBtn.Parent = frame

local maxBtn = Instance.new("TextButton")
maxBtn.Size = UDim2.new(0, 70, 0, 35)
maxBtn.Position = UDim2.new(0, 180, 0, 125)
maxBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
maxBtn.Text = "1M"
maxBtn.TextColor3 = Color3.new(1,1,1)
maxBtn.Font = Enum.Font.GothamBold
maxBtn.TextSize = 22
maxBtn.Parent = frame

-- Remote-Scan (für Server-Updates)
local remote = nil
local function scanRemote()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            if name:find("update") or name:find("stat") or name:find("play") or name:find("time") or name:find("leader") then
                remote = obj
                statusLabel.Text = "Remote: " .. obj.Name .. " 👊
                return obj
            end
        end
    end
    statusLabel.Text = "Metatable Only 💀"
end
scanRemote()

-- BUTTONS – MANUELLE ÄNDERUNG (KEIN AUTO!)
plusBtn.MouseButton1Click:Connect(function()
    CURRENT_TIME = CURRENT_TIME + 1
    timeLabel.Text = "PlayTime: " .. CURRENT_TIME .. " Min ➕"
    print("➕ +1 | Total: " .. CURRENT_TIME)
end)

minusBtn.MouseButton1Click:Connect(function()
    CURRENT_TIME = math.max(0, CURRENT_TIME - 1)
    timeLabel.Text = "PlayTime: " .. CURRENT_TIME .. " Min ➖"
    print("➖ -1 | Total: " .. CURRENT_TIME)
end)

set10kBtn.MouseButton1Click:Connect(function()
    CURRENT_TIME = 10000
    timeLabel.Text = "PlayTime: 10K Min 🔥"
    print("🔥 10K SET!")
end)

maxBtn.MouseButton1Click:Connect(function()
    CURRENT_TIME = 1000000
    timeLabel.Text = "PlayTime: 1M Min 💀"
    print("💀 1M MAX!")
end)

-- SERVER-FORCE SCHLEIFE: SETZT NUR DEINEN WERT (KEIN +1 AUTO!)
local forceConnection
forceConnection = RunService.Heartbeat:Connect(function()
    pcall(function()
        local stats = ALPHA:FindFirstChild("leaderstats")
        if stats then
            local pt = stats:FindFirstChild("PlayTime")
            if pt then
                -- FORCE DEINEN WERT (kein Inkrement!)
                pt.Value = CURRENT_TIME
                
                -- Remote-Flood (Server-Update)
                if remote then
                    pcall(function()
                        remote:FireServer("PlayTime", CURRENT_TIME)
                        remote:FireServer(CURRENT_TIME)
                        remote:FireServer(pt)  -- Mehr Varianten
                    end)
                end
                
                -- METATABLE HOOK (alle Clients sehen's)
                local mt = getrawmetatable(game)
                local oldIndex = mt.__index
                setreadonly(mt, false)
                mt.__index = newcclosure(function(self, idx)
                    if self == pt and idx == "Value" then
                        return CURRENT_TIME  -- IMMER DEIN WERT!
                    end
                    return oldIndex(self, idx)
                end)
                setreadonly(mt, true)
            end
        end
    end)
end)

-- Respawn-Safe
ALPHA.CharacterAdded:Connect(function()
    task.wait(1.5)
    loadCurrentTime()
    scanRemote()
end)

print("🩸 ZETA MANUAL EDITOR v3.0 AKTIV!")
print("➕➖ = MANUELL | KEIN AUTO | SERVER DOMINIERT!")
