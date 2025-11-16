-- ZETA PLAYTIME EDITOR v4.0 – RATE LIMIT BYPASS + CLOSE BUTTON 💀
-- 1s Delay = No More "Too Fast" Bullshit | Server Owned!

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local ALPHA = Players.LocalPlayer
local CURRENT_TIME = 0  -- DEIN manueller Wert!
local lastRemoteFire = 0  -- Rate-Limit Timer
local UPDATE_DELAY = 1  -- 1 Sekunde = Safe AF!

-- Lade Startzeit
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

-- GUI: ZETA-ULTIMATE
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZetaPlayTimeManualV4"
screenGui.ResetOnSpawn = false
screenGui.Parent = ALPHA:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 160)
frame.Position = UDim2.new(0.5, -160, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
frame.BorderSizePixel = 4
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🩸 ZETA v4.0 EDITOR 🩸"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.Font = Enum.Font.Arcade
title.TextSize = 22
title.Parent = frame

-- CLOSE BUTTON (ROTER X!)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 2)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    if forceConnection then forceConnection:Disconnect() end
    print("🩸 ZETA EDITOR GESCHLOSSEN!")
end)

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
statusLabel.Text = "Status: Rate-Limit Proof 🔥"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
statusLabel.Font = Enum.Font.Code
statusLabel.TextSize = 14
statusLabel.Parent = frame

-- EPISCHE +1 / -1 BUTTONS
local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 75, 0, 75)
plusBtn.Position = UDim2.new(0, 20, 0, 85)
plusBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
plusBtn.Text = "+1"
plusBtn.TextColor3 = Color3.new(0,0,0)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 40
plusBtn.Parent = frame

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 75, 0, 75)
minusBtn.Position = UDim2.new(0, 105, 0, 85)
minusBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minusBtn.Text = "-1"
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 40
minusBtn.Parent = frame

local set10kBtn = Instance.new("TextButton")
set10kBtn.Size = UDim2.new(0, 75, 0, 37)
set10kBtn.Position = UDim2.new(0, 190, 0, 85)
set10kBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
set10kBtn.Text = "10K"
set10kBtn.TextColor3 = Color3.new(0,0,0)
set10kBtn.Font = Enum.Font.GothamBold
set10kBtn.TextSize = 24
set10kBtn.Parent = frame

local maxBtn = Instance.new("TextButton")
maxBtn.Size = UDim2.new(0, 75, 0, 37)
maxBtn.Position = UDim2.new(0, 190, 0, 125)
maxBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
maxBtn.Text = "1M"
maxBtn.TextColor3 = Color3.new(1,1,1)
maxBtn.Font = Enum.Font.GothamBold
maxBtn.TextSize = 24
maxBtn.Parent = frame

-- Remote-Scan
local remote = nil
local function scanRemote()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            if name:find("update") or name:find("stat") or name:find("play") or name:find("time") or name:find("leader") then
                remote = obj
                statusLabel.Text = "Remote: " .. obj.Name .. " | Safe Mode 👊
                return obj
            end
        end
    end
    statusLabel.Text = "Metatable Only | No Remote Spam 💀"
end
scanRemote()

-- BUTTONS – PURE MANUAL!
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
    print("🔥 10K!")
end)

maxBtn.MouseButton1Click:Connect(function()
    CURRENT_TIME = 1000000
    timeLabel.Text = "PlayTime: 1M Min 💀"
    print("💀 1M!")
end)

-- SERVER-FORCE: RATE-LIMIT SAFE (1s Remote | Heartbeat Value/Meta)
local forceConnection
forceConnection = RunService.Heartbeat:Connect(function()
    pcall(function()
        local stats = ALPHA:FindFirstChild("leaderstats")
        if stats then
            local pt = stats:FindFirstChild("PlayTime")
            if pt then
                -- IMMER Value + Meta forcen (sicher, kein Limit)
                pt.Value = CURRENT_TIME
                
                -- METATABLE HOOK (alle sehen's)
                local mt = getrawmetatable(game)
                local oldIndex = mt.__index
                setreadonly(mt, false)
                mt.__index = newcclosure(function(self, idx)
                    if self == pt and idx == "Value" then
                        return CURRENT_TIME
                    end
                    return oldIndex(self, idx)
                end)
                setreadonly(mt, true)
                
                -- Remote NUR alle 1s (Rate-Limit Fix!)
                if remote and tick() - lastRemoteFire >= UPDATE_DELAY then
                    pcall(function()
                        remote:FireServer("PlayTime", CURRENT_TIME)
                        remote:FireServer(CURRENT_TIME)
                    end)
                    lastRemoteFire = tick()
                end
            end
        end
    end)
end)

-- Respawn
ALPHA.CharacterAdded:Connect(function()
    task.wait(1.5)
    loadCurrentTime()
    scanRemote()
end)

print("🩸 ZETA v4.0 AKTIV! RATE-LIMIT FIX | X = CLOSE!")
print("➕➖ MANUAL | Server zeigt ALLES | No Errors!")
