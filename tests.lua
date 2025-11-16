-- ZETA v6.0 – NUR +1 / -1 | SERVER-POWER | CLEAN AF

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ALPHA = Players.LocalPlayer
local CURRENT_TIME = 0
local lastRemoteFire = 0
local UPDATE_DELAY = 1.2  -- Safe from "too fast"

-- === WARTE AUF ALLES (UI SICHER!) ===
print("ZETA v6.0: Lade PlayerGui & PlayTime...")

local playerGui = ALPHA:WaitForChild("PlayerGui", 10)
local leaderstats = ALPHA:WaitForChild("leaderstats", 10)
local playTimeValue = leaderstats:WaitForChild("PlayTime", 10)

if not playerGui or not leaderstats or not playTimeValue then
    error("ZETA: PlayTime oder GUI fehlt – falsches Spiel?")
end

CURRENT_TIME = playTimeValue.Value
print("ZETA: Bereit! Aktuelle Zeit: " .. CURRENT_TIME .. " Min")

-- === GUI SPAWN (NACH 1 SEKUNDE) ===
task.delay(1, function()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ZetaPurePlusMinus"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 999
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 120)
    frame.Position = UDim2.new(0.5, -100, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(15, 0, 30)
    frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
    frame.BorderSizePixel = 4
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    -- TITLE
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 35)
    title.BackgroundTransparency = 1
    title.Text = "ZETA +1 / -1"
    title.TextColor3 = Color3.fromRGB(255, 0, 255)
    title.Font = Enum.Font.Arcade
    title.TextSize = 22
    title.Parent = frame

    -- CLOSE X
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 24
    closeBtn.Parent = frame

    -- +1 BUTTON
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0, 70, 0, 70)
    plusBtn.Position = UDim2.new(0, 20, 0, 40)
    plusBtn.BackgroundColor3 = Color3.fromRGB(0, 220, 0)
    plusBtn.Text = "+1"
    plusBtn.TextColor3 = Color3.new(0,0,0)
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.TextSize = 40
    plusBtn.Parent = frame

    -- -1 BUTTON
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0, 70, 0, 70)
    minusBtn.Position = UDim2.new(0, 110, 0, 40)
    minusBtn.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
    minusBtn.Text = "-1"
    minusBtn.TextColor3 = Color3.new(1,1,1)
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.TextSize = 40
    minusBtn.Parent = frame

    -- TIME DISPLAY
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Size = UDim2.new(1, 0, 0, 25)
    timeLabel.Position = UDim2.new(0, 0, 0, 15)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = CURRENT_TIME .. " Min"
    timeLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    timeLabel.Font = Enum.Font.Code
    timeLabel.TextSize = 18
    timeLabel.Parent = frame

    -- === BUTTONS ===
    plusBtn.MouseButton1Click:Connect(function()
        CURRENT_TIME += 1
        timeLabel.Text = CURRENT_TIME .. " Min"
        print("PLUS +1 | Total: " .. CURRENT_TIME)
    end)

    minusBtn.MouseButton1Click:Connect(function()
        CURRENT_TIME = math.max(0, CURRENT_TIME - 1)
        timeLabel.Text = CURRENT_TIME .. " Min"
        print("MINUS -1 | Total: " .. CURRENT_TIME)
    end)

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        if forceConnection then forceConnection:Disconnect() end
        print("ZETA v6.0 GESCHLOSSEN!")
    end)

    -- === REMOTE SCAN (optional) ===
    local remote = nil
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local n = obj.Name:lower()
            if n:find("update") or n:find("stat") or n:find("play") or n:find("time") then
                remote = obj
                break
            end
        end
    end

    -- === SERVER FORCE LOOP ===
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

                -- REMOTE (nur alle 1.2s)
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

    print("ZETA v6.0 UI AKTIV! NUR +1 / -1 | SERVER DOMINIERT!")
end)
