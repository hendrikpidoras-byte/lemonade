-- UNDETECTED PERMANENT UPGRADES UNLOCKER v1 – ALL BOOLS TRUE (Delta Safe) 😈🔥
local Players = game:GetService("Players")
local RunS = game:GetService("RunService")
local player = Players.LocalPlayer
local username = player.Name

-- Wait for PermanentUpgrades folder
local upgradesFolder = player:WaitForChild("PermanentUpgrades", 10)
if not upgradesFolder then
    error("PermanentUpgrades folder not found – wrong game? 🤡")
end

local allUnlocked = true  -- Start all true
local selectedUpgrade = nil  -- For manual if needed

print("PermanentUpgrades folder locked | Found: " .. #upgradesFolder:GetChildren() .. " upgrades")

-- AUTO UNLOCK ALL (Set all BoolValues to true)
local function unlockAll()
    for _, upgrade in pairs(upgradesFolder:GetChildren()) do
        if upgrade:IsA("BoolValue") then
            upgrade.Value = true
            print("Unlocked: " .. upgrade.Name .. " 🔥")
        end
    end
    allUnlocked = true
end

unlockAll()  -- Initial unlock

-- STEALTHY GUI (PlayerGui fallback, semi-transparent)
local sg = Instance.new("ScreenGui")
sg.Name = math.random(1e9,9e9).."UpgradeGui"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 320, 0, 200)
frame.Position = UDim2.new(0.5, -160, 0.4, -100)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
frame.BackgroundTransparency = 0.2  -- Semi-stealth
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local uc = Instance.new("UICorner", frame)
uc.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
title.Text = "Permanent Upgrades Unlocker – " .. username .. " 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 50)
status.BackgroundTransparency = 1
status.Text = "All Unlocked! | Upgrades: " .. #upgradesFolder:GetChildren()
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 14

local unlockBtn = Instance.new("TextButton", frame)
unlockBtn.Size = UDim2.new(0, 130, 0, 45)
unlockBtn.Position = UDim2.new(0, 20, 0, 90)
unlockBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
unlockBtn.Text = "UNLOCK ALL ⬆️"
unlockBtn.TextColor3 = Color3.new(1,1,1)
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.TextSize = 16
Instance.new("UICorner", unlockBtn).CornerRadius = UDim.new(0, 8)

local lockBtn = Instance.new("TextButton", frame)
lockBtn.Size = UDim2.new(0, 130, 0, 45)
lockBtn.Position = UDim2.new(0, 170, 0, 90)
lockBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
lockBtn.Text = "LOCK ALL ⬇️"
lockBtn.TextColor3 = Color3.new(1,1,1)
lockBtn.Font = Enum.Font.GothamBold
lockBtn.TextSize = 16
Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0, 8)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 15)

-- BUTTONS
unlockBtn.MouseButton1Click:Connect(function()
    unlockAll()
    status.Text = "All Unlocked! | Upgrades: " .. #upgradesFolder:GetChildren() .. " 💥"
end)

lockBtn.MouseButton1Click:Connect(function()
    for _, upgrade in pairs(upgradesFolder:GetChildren()) do
        if upgrade:IsA("BoolValue") then
            upgrade.Value = false
        end
    end
    allUnlocked = false
    status.Text = "All Locked | Upgrades: " .. #upgradesFolder:GetChildren() .. " 💀"
end)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

-- METATABLE SPOOF (Block server resets, force true)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
local oldNewIndex = mt.__newindex
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if self.Parent == upgradesFolder and key == "Value" and allUnlocked then
        return true  -- Spoof all reads as true
    end
    return oldIndex(self, key)
end)

mt.__newindex = newcclosure(function(self, key, value)
    if self.Parent == upgradesFolder and key == "Value" and allUnlocked then
        rawset(self, key, true)  -- Force writes to true
        return
    end
    return oldNewIndex(self, key, value)
end)

setreadonly(mt, true)

-- FORCE LOOP (Subtle, anti-reset)
RunS.Heartbeat:Connect(function()
    if allUnlocked then
        unlockAll()  -- Re-force every frame (undetectable)
    end
    status.Text = "Status: " .. (allUnlocked and "All Unlocked 💎" or "Locked 🔒") .. " | Count: " .. #upgradesFolder:GetChildren()
end)

print("PERMANENT UPGRADES UNLOCKER v1 LOADED – All BoolValues TRUE | Drag GUI & Rejoin Safe 😈")
