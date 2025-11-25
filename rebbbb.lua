-- REBIRTHS AUTO SPAMMER v5 – 999 PERMANENT NO RESET (2025 FIXED)
local Players = game:GetService("Players")
local RunS = game:GetService("RunService")
local player = Players.LocalPlayer
local rebirthRemote = game.ReplicatedStorage.Network.Client:WaitForChild("Rebirth")

local targetRebirths = 0  -- MANUAL START
local currentRebirths = 0
local isSpamming = false

-- CASH BOOST (damit server akzeptiert – aus Config)
local leaderstats = player:WaitForChild("leaderstats")
local cashValue = leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Money")
if cashValue then
    cashValue.Value = 999999999999  -- Infinite Cash for Rebirths
end

-- AUTO SPAM LOOP (1 fire/5s = undetected, server +1 pro fire)
local function startSpam()
    if isSpamming then return end
    isSpamming = true
    spawn(function()
        while isSpamming do
            task.wait(math.random(45,55))  -- 45-55s random (legit speed)
            pcall(function()
                local success, err = rebirthRemote:InvokeServer()
                if success then
                    currentRebirths = currentRebirths + 1
                    print("Rebirth #" .. currentRebirths .. " fired | Target: " .. targetRebirths)
                else
                    print("Rebirth failed: " .. tostring(err) .. " | Cash boosted?")
                end
            end)
            if currentRebirths >= targetRebirths then
                isSpamming = false
                print("999 Rebirths DONE – Server saved permanent 😈")
            end
        end
    end)
end

-- GUI
local sg = Instance.new("ScreenGui")
sg.Name = "RebirthSpammerV5"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 220)
frame.Position = UDim2.new(0.5, -175, 0.4, -110)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = sg
local uc = Instance.new("UICorner", frame); uc.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
title.Text = "Rebirths Auto Spammer v5 – " .. player.Name .. " 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame
local tuc = Instance.new("UICorner", title); tuc.CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 50)
status.BackgroundTransparency = 1
status.Text = "Current: 0 | Target: 0 | Spam Active: OFF"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.Parent = frame

local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 100, 0, 50)
plusBtn.Position = UDim2.new(0, 20, 0, 90)
plusBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
plusBtn.Text = "+1 TARGET ⬆️"
plusBtn.TextColor3 = Color3.new(1,1,1)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 18
plusBtn.Parent = frame
local puc = Instance.new("UICorner", plusBtn); puc.CornerRadius = UDim.new(0, 8)

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 100, 0, 50)
minusBtn.Position = UDim2.new(0, 130, 0, 90)
minusBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minusBtn.Text = "-1 TARGET ⬇️"
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 18
minusBtn.Parent = frame
local muc = Instance.new("UICorner", minusBtn); muc.CornerRadius = UDim.new(0, 8)

local spamBtn = Instance.new("TextButton")
spamBtn.Size = UDim2.new(0, 100, 0, 50)
spamBtn.Position = UDim2.new(0, 240, 0, 90)
spamBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
spamBtn.Text = "START SPAM 999 🔥"
spamBtn.TextColor3 = Color3.new(1,1,1)
spamBtn.Font = Enum.Font.GothamBold
spamBtn.TextSize = 14
spamBtn.Parent = frame
local suc = Instance.new("UICorner", spamBtn); suc.CornerRadius = UDim.new(0, 8)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = frame
local cuc = Instance.new("UICorner", closeBtn); cuc.CornerRadius = UDim.new(0, 99)

-- BUTTONS
plusBtn.MouseButton1Click:Connect(function()
    targetRebirths = targetRebirths + 1
    status.Text = "Current: " .. currentRebirths .. " | Target: " .. targetRebirths .. " | Spam: OFF"
end)

minusBtn.MouseButton1Click:Connect(function()
    targetRebirths = math.max(0, targetRebirths - 1)
    status.Text = "Current: " .. currentRebirths .. " | Target: " .. targetRebirths .. " | Spam: OFF"
end)

spamBtn.MouseButton1Click:Connect(function()
    targetRebirths = 999
    startSpam()
    status.Text = "Current: " .. currentRebirths .. " | Target: 999 | Spam: ON (5s fires)"
    status.TextColor3 = Color3.fromRGB(255, 100, 0)
end)

closeBtn.MouseButton1Click:Connect(function()
    isSpamming = false
    sg:Destroy()
end)

-- CASH FORCE (for Rebirth costs)
RunS.Heartbeat:Connect(function()
    if cashValue then
        cashValue.Value = 999999999999
    end
    if rebirthValue then
        rebirthValue.Value = currentRebirths
        status.Text = "Current: " .. currentRebirths .. " | Target: " .. targetRebirths .. " | Spam: " .. (isSpamming and "ON" or "OFF")
    end
end)

print("REBIRTHS SPAMMER v5 LOADED – Set target, hit START, wait ~1 hour for 999 | Server saves permanent 😈")
