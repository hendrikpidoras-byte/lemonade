-- ULTRA STEALTH AddTokens v4 – SINGLE FIRE EVERY 2-3 MIN (NO BAN) 👑😈
repeat task.wait() until game:IsLoaded()
task.wait(4)  -- Long stealth delay

local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage:WaitForChild("AddTokens")
local leaderstats = player:WaitForChild("leaderstats")
local tokens = leaderstats:WaitForChild("Tokens")
local targetAmount = 1  -- MANUAL START +1

print("Ultra stealth loaded | Current: " .. tokens.Value .. " | Next fire in ~2 min")

-- INVISIBLE GUI (drag to hide, semi-transparent)
local sg = Instance.new("ScreenGui")
sg.Name = "UltraStealth"
sg.ResetOnSpawn = false
sg.Parent = game.CoreGui

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 180, 0, 80)
frame.Position = UDim2.new(0, 5, 0, 5)  -- Hidden top-left
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.8  -- Almost invisible
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0.5, 0)
label.BackgroundTransparency = 1
label.Text = "Stealth: " .. tokens.Value
label.TextColor3 = Color3.fromRGB(0, 255, 0)
label.Font = Enum.Font.Gotham
label.TextSize = 10

local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0.45, 0, 0.5, 0)
plus.Position = UDim2.new(0, 0, 0.5, 0)
plus.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
plus.BackgroundTransparency = 0.5
plus.Text = "+1"
plus.TextColor3 = Color3.new(0, 0, 0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 14
plus.MouseButton1Click:Connect(function()
    targetAmount = targetAmount + 1
    label.Text = "Stealth: " .. targetAmount .. " next"
    print("Queued: +" .. targetAmount)
end)

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0.45, 0, 0.5, 0)
minus.Position = UDim2.new(0.55, 0, 0.5, 0)
minus.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minus.BackgroundTransparency = 0.5
minus.Text = "-1"
minus.TextColor3 = Color3.new(1, 1, 1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 14
minus.MouseButton1Click:Connect(function()
    targetAmount = math.max(1, targetAmount - 1)
    label.Text = "Stealth: " .. targetAmount .. " next"
    print("Queued: +" .. targetAmount)
end)

-- METATABLE SPOOF (LOCAL VIEW + ANTI-RESET)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)
mt.__index = newcclosure(function(self, key)
    if self == tokens and key == "Value" then return tokens.Value + targetAmount end  -- Preview spoof
    return oldIndex(self, key)
end)
setreadonly(mt, true)

-- SINGLE STEALTHY FIRE (Every 2-3 min, random arg)
task.spawn(function()
    while task.wait(math.random(120, 180)) do  -- 2-3 min random
        pcall(function()
            local argType = math.random(1, 3)
            if argType == 1 then
                remote:FireServer(targetAmount)  -- Number arg
            elseif argType == 2 then
                remote:FireServer("passive")     -- String arg (common)
            else
                remote:FireServer()              -- Empty
            end
            print("Stealth fire: +" .. targetAmount .. " (type " .. argType .. ")")
        end)
    end
end)

print("V4 ULTRA STEALTH ACTIVE – Fires every 2-3 min | Drag GUI to hide | ALT/VPN 😈")
