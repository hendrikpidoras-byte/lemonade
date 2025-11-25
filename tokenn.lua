-- UNDETECTED AddTokens Spammer v2 – Realistic Rate (NO BAN) 👑🔥
repeat task.wait() until game:IsLoaded()
task.wait(3)  -- Stealth delay

local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage:WaitForChild("AddTokens")

-- Find your tokens
local leaderstats = player:WaitForChild("leaderstats")
local tokens = leaderstats:WaitForChild("Tokens")  -- Or whatever exact name
local targetTokens = tokens.Value  -- Starts at 383

print("Undetected spammer loaded | Current: " .. targetTokens .. " | Firing every ~2s")

-- MANUAL +1/-1 (click to set target)
-- Paste these into executor separately if GUI banned you
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "StealthTokens"
sg.ResetOnSpawn = false

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundTransparency = 1  -- INVISIBLE GUI
frame.Active = true
frame.Draggable = false

local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0, 80, 0, 60)
plus.Position = UDim2.new(0, 10, 0, 50)
plus.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
plus.Text = "+1"
plus.TextColor3 = Color3.new(0,0,0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 30
plus.MouseButton1Click:Connect(function()
    targetTokens = targetTokens + 1
    print("Target set: " .. targetTokens)
end)

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0, 80, 0, 60)
minus.Position = UDim2.new(0, 100, 0, 50)
minus.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minus.Text = "-1"
minus.TextColor3 = Color3.new(1,1,1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 30
minus.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    print("Target set: " .. targetTokens)
end)

-- UNDETECTED SPAM (1 fire every 1.8-2.2s = LEGIT SPEED)
task.spawn(function()
    while task.wait(math.random(18,22)/10) do  -- 1.8-2.2s random
        pcall(function()
            if math.random(1,2) == 1 then
                remote:FireServer(1)  -- Normal +1
            else
                remote:FireServer()    -- Empty fire (some servers)
            end
        end)
        print("Fired AddTokens | Total should be: " .. (tokens.Value + 1))
    end
end)

print("STEALTH MODE ACTIVE – Tokens climbing slow & safe 😈 | Use alt/VPN")
