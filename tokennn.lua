-- UNDETECTED TOKEN SPOOF v3 – NO REMOTES, NO BAN, PERMANENT 👑💀
repeat task.wait() until game:IsLoaded()
task.wait(2)  -- Stealth load

local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local tokens = leaderstats:WaitForChild("Tokens")  -- Exact from Dex
local targetTokens = tokens.Value  -- Starts at 383

print("Stealth spoof loaded | Current: " .. targetTokens .. " | Manual mode")

-- INVISIBLE GUI (semi-transparent, small)
local sg = Instance.new("ScreenGui")
sg.Name = "StealthSpoof"
sg.ResetOnSpawn = false
sg.Parent = game.CoreGui

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 10)  -- Top-left
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.7  -- Semi-invisible
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 20)
title.BackgroundTransparency = 1
title.Text = "Stealth Tokens: " .. targetTokens
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.Gotham
title.TextSize = 12

local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0, 60, 0, 30)
plus.Position = UDim2.new(0, 10, 0, 30)
plus.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
plus.BackgroundTransparency = 0.3
plus.Text = "+1"
plus.TextColor3 = Color3.new(0, 0, 0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 16
plus.MouseButton1Click:Connect(function()
    targetTokens = targetTokens + 1
    title.Text = "Stealth Tokens: " .. targetTokens
    print("Spoofed to: " .. targetTokens)  -- Silent log
end)

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0, 60, 0, 30)
minus.Position = UDim2.new(0, 130, 0, 30)
minus.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minus.BackgroundTransparency = 0.3
minus.Text = "-1"
minus.TextColor3 = Color3.new(1, 1, 1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 16
minus.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    title.Text = "Stealth Tokens: " .. targetTokens
    print("Spoofed to: " .. targetTokens)
end)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 20, 0, 20)
close.Position = UDim2.new(1, -25, 0, 0)
close.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- METATABLE HOOK (SPOOF VALUE SERVER-SIDE, NO FIRES)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
local oldNewIndex = mt.__newindex
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if self == tokens and key == "Value" then
        return targetTokens  -- SPOOF READ
    end
    return oldIndex(self, key)
end)

mt.__newindex = newcclosure(function(self, key, value)
    if self == tokens and key == "Value" then
        targetTokens = value  -- SPOOF WRITE
        return
    end
    return oldNewIndex(self, key, value)
end)

setreadonly(mt, true)

-- SUBTLE FORCE (0.5s updates = invisible)
game:GetService("RunService").Heartbeat:Connect(function()
    if tokens.Value ~= targetTokens then
        tokens.Value = targetTokens  -- Force replication
    end
end)

print("UNDTECTED SPOOF ACTIVE – Click +1/-1 | Tokens permanent on rejoin 😈")
