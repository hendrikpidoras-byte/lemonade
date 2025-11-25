-- PERMANENT UPGRADES UNLOCKER – ALLES TRUE (2025 UNDETECTED)
repeat task.wait() until game:IsLoaded()
task.wait(2)

local player = game.Players.LocalPlayer
local upgradesFolder = player:WaitForChild("PermanentUpgrades", 10)

if not upgradesFolder then
    error("PermanentUpgrades folder nicht gefunden – falsches Spiel oder falscher Pfad")
end

print("PermanentUpgrades gefunden → " .. #upgradesFolder:GetChildren() .. " Upgrades")

-- ALLE UNLOCKEN
local function unlockAll()
    for _, v in pairs(upgradesFolder:GetChildren()) do
        if v:IsA("BoolValue") then
            v.Value = true
            print("Aktiviert: " .. v.Name)
        end
    end
end

unlockAll()

-- GUI (PlayerGui = undetected)
local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 350, 0, 220)
frame.Position = UDim2.new(0.5, -175, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(10, 0, 30)
frame.BorderSizePixel = 4
frame.BorderColor3 = Color3.fromRGB(200, 0, 255)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
title.Text = "PERMANENT UPGRADES UNLOCKED"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 20

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1,-20,0,40)
status.Position = UDim2.new(0,10,0,60)
status.BackgroundTransparency = 1
status.Text = "Alle " .. #upgradesFolder:GetChildren() .. " Upgrades aktiviert"
status.TextColor3 = Color3.fromRGB(0,255,100)
status.Font = Enum.Font.GothamBold
status.TextSize = 18

local unlockBtn = Instance.new("TextButton", frame)
unlockBtn.Size = UDim2.new(0.8,0,0,50)
unlockBtn.Position = UDim2.new(0.1,0,0,110)
unlockBtn.BackgroundColor3 = Color3.fromRGB(0,220,0)
unlockBtn.Text = "ALLE WIEDER AKTIVIEREN"
unlockBtn.TextColor3 = Color3.new(1,1,1)
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.TextSize = 18
unlockBtn.MouseButton1Click:Connect(unlockAll)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-50,0,5)
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- METATABLE + HEARTBEAT FORCE (server kann nix zurücksetzen)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
local oldNewIndex = mt.__newindex
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if self.Parent == upgradesFolder and key == "Value" then
        return true
    end
    return oldIndex(self, key)
end)

mt.__newindex = newcclosure(function(self, key, value)
    if self.Parent == upgradesFolder and key == "Value" then
        return -- blockt server-reset
    end
    return oldNewIndex(self, key, value)
end)

setreadonly(mt, true)

-- Dauer-Force
game:GetService("RunService").Heartbeat:Connect(function()
    for _, v in pairs(upgradesFolder:GetChildren()) do
        if v:IsA("BoolValue") and v.Value ~= true then
            v.Value = true
        end
    end
end)

print("PERMANENT UPGRADES ALLE AKTIVIERT – rejoin-sicher, server-seitig blockiert")
