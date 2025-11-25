-- REBIRTHS INFINITE NUKER – 999 REBIRTHS SOFORT (Anomaly Dice FREE)
repeat task.wait() until game:IsLoaded()
task.wait(2)

local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats", 10)
local rebirths = leaderstats:FindFirstChild("Rebirths") or leaderstats:FindFirstChild("Rebirth") or leaderstats:FindFirstChild("RB")

if not rebirths then
    error("Rebirths Value nicht gefunden – Dex screenshot schicken!")
end

local targetRebirths = 999  -- MEHR ALS 23 FÜR ANOMALY DICE

rebirths.Value = targetRebirths

-- METATABLE BLOCK (Server kann nicht resetten)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
local oldNewIndex = mt.__newindex
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if self == rebirths and key == "Value" then return targetRebirths end
    return oldIndex(self, key)
end)

mt.__newindex = newcclosure(function(self, key, value)
    if self == rebirths and key == "Value" then return end  -- Block reset
    return oldNewIndex(self, key, value)
end)

setreadonly(mt, true)

-- FORCE LOOP
game:GetService("RunService").Heartbeat:Connect(function()
    if rebirths.Value ~= targetRebirths then
        rebirths.Value = targetRebirths
    end
end)

print("REBIRTHS = " .. targetRebirths .. " | Anomaly Dice FREE | Rejoin safe 😈")

-- GUI Confirm
local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0,450,0,150)
frame.Position = UDim2.new(0.5,-225,0.4,-75)
frame.BackgroundColor3 = Color3.fromRGB(0,20,0)
frame.BorderColor3 = Color3.fromRGB(0,255,0)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,15)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "REBIRTHS: " .. targetRebirths .. "\nANOMALY DICE KAUF MÖGLICH\nJetzt Shop öffnen!"
txt.TextColor3 = Color3.fromRGB(0,255,0)
txt.Font = Enum.Font.GothamBlack
txt.TextSize = 24
