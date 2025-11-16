-- ZETA v5.0 – UI GARANTIERT | RATE-LIMIT FIX | CLOSE | SERVER DOMINANCE

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local ALPHA = Players.LocalPlayer
local CURRENT_TIME = 0
local lastRemoteFire = 0
local UPDATE_DELAY = 1.2  -- Sicher über Rate-Limit (20)

-- === 1. WARTE AUF ALLES (UI SICHER!) ===
print("ZETA v5.0: Warte auf PlayerGui & leaderstats...")

local playerGui = ALPHA:WaitForChild("PlayerGui", 10)
if not playerGui then
    error("PlayerGui fehlt – Executor-Problem!")
end

local leaderstats = ALPHA:WaitForChild("leaderstats", 10)
if not leaderstats then
    error("leaderstats fehlt – Spiel hat keine!")
end

local playTimeValue = leaderstats:WaitForChild("PlayTime", 10)
if not playTimeValue then
    error("PlayTime fehlt – falscher Spielmodus!")
end

CURRENT_TIME = playTimeValue.Value
print("ZETA: Alles geladen! PlayTime = " .. CURRENT_TIME)

-- === 2. GUI SPAWN MIT DELAY (100% SICHER) ===
task.delay(1, function()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ZetaPlayTimeV5"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 999
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 170)
    frame.Position = UDim2.new(0.5, -170, 0, 30)
    frame.BackgroundColor3 = Color3.fromRGB(12, 0, 25)
    frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
    frame.BorderSizePixel = 5
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    -- TITLE
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "ZETA v5.0 EDITOR"
    title.TextColor3 = Color3.fromRGB(0, 255, 255)
    title.Font = Enum.Font.Arcade
    title.TextSize = 24
    title.Parent = frame

    -- CLOSE BUTTON
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -40, 0, 2)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 28
    closeBtn.Parent = frame

    -- TIME LABEL
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Size = UDim2.new(1, 0, 0, 35)
    timeLabel.Position = UDim2.new(0, 0, 0, 40)
    timeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    timeLabel.BorderColor3 = Color3.fromRGB(0, 255, 0)
    timeLabel.Text = "PlayTime: " .. CURRENT_TIME .. " Min"
    timeLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    timeLabel.Font = Enum.Font.Code
    timeLabel.TextSize = 20
    timeLabel.Parent = frame

    -- STATUS
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 20)
    statusLabel.Position = UDim2.new(0, 0, 0, 75)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: UI Aktiv"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    statusLabel.Font = Enum.Font.Code
    statusLabel.TextSize = 15
    statusLabel.Parent = frame

    -- +1 BUTTON
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0, 80, 0, 80)
    plusBtn.Position = UDim2.new(0, 20, 0, 85)
    plusBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    plusBtn.Text = "+1"
    plusBtn.TextColor3 = Color3.new(0,0,0)
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.TextSize = 44
    plusBtn.Parent = frame

    -- -1 BUTTON
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0, 80, 0, 80)
    minusBtn.Position = UDim2.new(0, 110, 0, 85)
    minusBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    minusBtn.Text = "-1"
    minusBtn.TextColor3 = Color3.new(1,1,1)
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.TextSize = 44
    minusBtn.Parent = frame

    -- 10K & 1M
    local set10k = Instance.new("TextButton")
    set10k.Size = UDim2.new(0, 80, 0, 40)
    set10k.Position = UDim2.new(0, 200, 0, 85)
    set10k.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    set10k.Text = "10K"
    set10k.TextColor3 = Color3.new(0,0,0)
    set10k.Font = Enum.Font.GothamBold
    set10k.TextSize = 26
    set10k.Parent = frame

    local setMax = Instance.new("TextButton")
    setMax.Size = UDim2.new(0, 80, 0, 40)
    setMax.Position = UDim2.new(0, 200, 0, 125)
    setMax.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
    setMax.Text = "1M"
    setMax.TextColor3 = Color3.new(1,1,1)
    setMax.Font = Enum.Font.GothamBold
    setMax.TextSize = 26
    setMax.Parent = frame

    -- === BUTTON ACTIONS ===
    plusBtn.MouseButton1Click:Connect(function()
        CURRENT_TIME += 1
        timeLabel.Text = "PlayTime: " .. CURRENT_TIME .. " Min"
        print("➕ +1 | Total: " .. CURRENT_TIME)
    end)

    minusBtn.MouseButton1Click:Connect(function()
        CURRENT_TIME = math.max(0, CURRENT_TIME - 1)
        timeLabel.Text = "PlayTime: " .. CURRENT_TIME .. " Min"
        print("➖ -1 | Total: " .. CURRENT_TIME)
    end)

    set10k.MouseButton1Click:Connect(function()
        CURRENT_TIME = 10000
        timeLabel.Text = "PlayTime: 10K Min"
        print("🔥 10K SET!")
    end)

    setMax.MouseButton1Click:Connect(function()
        CURRENT_TIME = 1000000
        timeLabel.Text = "PlayTime: 1M Min"
        print("💀 1M MAX!")
    end)

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        if forceConnection then forceConnection:Disconnect() end
        print("ZETA v5.0 GESCHLOSSEN!")
    end)

    -- === REMOTE SCAN ===
    local remote = nil
    local function scanRemote()
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                local n = obj.Name:lower()
                if n:find("update") or n:find("stat") or n:find("play") or n:find("time") then
                    remote = obj
                    statusLabel.Text = "Remote: " .. obj.Name
                    return
                end
            end
        end
        statusLabel.Text = "Metatable Only"
    end
    scanRemote()

    -- === SERVER FORCE (SAFE + POWERFUL) ===
    local forceConnection
    forceConnection = RunService.Heartbeat:Connect(function()
        pcall(function()
            local pt = leaderstats:FindFirstChild("PlayTime")
            if pt then
                pt.Value = CURRENT_TIME

                -- METATABLE HOOK
                local mt = getrawmetatable(game)
                local old = mt.__index
                setreadonly(mt, false)
                mt.__index = newcclosure(function(s, k)
                    if s == pt and k == "Value" then return CURRENT_TIME end
                    return old(s, k)
                end)
                setreadonly(mt, true)

                -- REMOTE (1.2s delay)
                if remote and tick() - lastRemoteFire >= UPDATE_DELAY then
                    pcall(function()
                        remote:FireServer("PlayTime", CURRENT_TIME)
                        remote:FireServer(CURRENT_TIME)
                    end)
                    lastRemoteFire = tick()
                end
            end
        end)
    end)

    print("ZETA v5.0 UI ERSCHIENEN! +1 / -1 = SERVER POWER!")
end)
