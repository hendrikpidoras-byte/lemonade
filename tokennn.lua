-- TOKEN NUKER v17 – GUI GUARANTEED + AddTokens STEALTH (NO BAN) 👑🔥
local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage:WaitForChild("AddTokens")
local leaderstats = player:WaitForChild("leaderstats")
local tokens = leaderstats:WaitForChild("Tokens")
local target = 1  -- MANUAL +1 START

-- BULLETPROOF GUI (PlayerGui Fallback)
local sg = Instance.new("ScreenGui")
sg.Name = "TokenStealth17"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui  -- NO COREGUI BLOCK
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 280, 0, 140)
frame.Position = UDim2.new(0.5, -140, 0.4, -70)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local uc = Instance.new("UICorner", frame)
uc.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
title.Text = "Token Stealth v17 – " .. player.Name
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -20, 0, 25)
status.Position = UDim2.new(0, 10, 0, 40)
status.BackgroundTransparency = 1
status.Text = "Tokens: " .. tokens.Value .. " | Next: +" .. target
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 14

local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0, 80, 0, 40)
plus.Position = UDim2.new(0, 20, 0, 70)
plus.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
plus.Text = "+1"
plus.TextColor3 = Color3.new(0,0,0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 24
Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 8)

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0, 80, 0, 40)
minus.Position = UDim2.new(0, 110, 0, 70)
minus.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minus.Text = "-1"
minus.TextColor3 = Color3.new(1,1,1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 24
Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 8)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 2.5)
close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 15)

-- BUTTONS
plus.MouseButton1Click:Connect(function()
    target = target + 1
    status.Text = "Tokens: " .. tokens.Value .. " | Next: +" .. target
end)

minus.MouseButton1Click:Connect(function()
    target = math.max(1, target - 1)
    status.Text = "Tokens: " .. tokens.Value .. " | Next: +" .. target
end)

close.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

-- STEALTH SINGLE FIRE (Every 2.1s random, arg random – NO BAN)
task.spawn(function()
    while task.wait(math.random(20,22)/10) do
        pcall(function()
            if math.random(1,3) == 1 then
                remote:FireServer(target)
            else
                remote:FireServer(1)
            end
            status.Text = "Tokens: " .. tokens.Value .. " | FIRED +" .. target .. " 💥"
        end)
    end
end)

print("TOKEN NUKER v17 FULLY LOADED – GUI OPEN, STEALTH SPAM ACTIVE 😈")
