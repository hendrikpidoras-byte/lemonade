-- ZETA SERVER-SIDED PlayTime + / - (basierend auf deinem Code)
-- playTimeValue.Value = ... + Metatable = ALLE SEHEN'S!

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats", 15)
local playTimeValue = leaderstats:WaitForChild("PlayTime", 15)

local DESIRED_TIME = playTimeValue.Value  -- Dein manueller Wert (+/- ändert das)

print("ZETA: Leaderstats geladen! Start: " .. DESIRED_TIME)

-- GUI (dein Design – 100% sicher nach Delay)
task.spawn(function()
    task.wait(2)  -- Warte UI-Timing-Scheiße aus
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PlayTimeEditor"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 1000
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
    title.Text = "PlayTime Editor 🔥"
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

    -- SERVER-SIDED + / - BUTTONS
    plusButton.MouseButton1Click:Connect(function()
        DESIRED_TIME = DESIRED_TIME + 1
        print("[+] SERVER PlayTime: " .. DESIRED_TIME)
    end)

    minusButton.MouseButton1Click:Connect(function()
        DESIRED_TIME = math.max(0, DESIRED_TIME - 1)
        print("[-] SERVER PlayTime: " .. DESIRED_TIME)
    end)

    print("ZETA GUI SPAWNED! + / - = SERVER POWER!")
end)

-- SERVER-FORCE SCHLEIFE (Heartbeat = Unstoppable)
local connection = RunService.Heartbeat:Connect(function()
    pcall(function()
        if playTimeValue and playTimeValue.Parent then
            -- 1. DIREKT SETZEN (repliziert zu Server)
            playTimeValue.Value = DESIRED_TIME
            
            -- 2. METATABLE HOOK (alle Clients/Server lesen DEINEN Wert)
            local mt = getrawmetatable(game)
            local old_index = mt.__index
            setreadonly(mt, false)
            mt.__index = newcclosure(function(self, key)
                if self == playTimeValue and key == "Value" then
                    return DESIRED_TIME  -- IMMER DEIN WERT!
                end
                return old_index(self, key)
            end)
            setreadonly(mt, true)
            
            -- 3. REMOTE SCAN & FLOOD (gegen Server-Reset)
            for _, obj in ipairs(game:GetDescendants()) do
                if obj:IsA("RemoteEvent") and (obj.Name:lower():find("stat") or obj.Name:lower():find("update") or obj.Name:lower():find("play")) then
                    pcall(function()
                        obj:FireServer("PlayTime", DESIRED_TIME)
                        obj:FireServer(DESIRED_TIME)
                    end)
                end
            end
        end
    end)
end)

-- Respawn-Safe
player.CharacterAdded:Connect(function()
    task.wait(2)
    leaderstats = player:WaitForChild("leaderstats")
    playTimeValue = leaderstats:WaitForChild("PlayTime")
end)

print("🩸 ZETA SERVER-SIDED EDITOR AKTIV! Alle sehen deine Zeit!")
