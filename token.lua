-- Token Server Nuker v7.1 - Xeno | AutoScan Tokens + RemoteSpy 😈🔥
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunS = game:GetService("RunService")
local player = Players.LocalPlayer
local username = player.Name

local targetTokens = 0
local tokenValue = nil
local spiedRemotes = {}
local lastFire = 0
local fireDelay = 1.1

print("🔍 Token Nuker: Hunting Tokens...")

-- DEEP TOKEN HUNT
local function findTokenValue()
    local spots = {player.leaderstats, Players:FindFirstChild(username), player, workspace:FindFirstChild(username), player:FindFirstChild("Data"), player:FindFirstChild("Stats")}
    for _, spot in pairs(spots) do
        if spot then
            for _, v in pairs(spot:GetChildren()) do
                local name = v.Name:lower():find("token")
                if name and (v:IsA("IntValue") or v:IsA("NumberValue")) then
                    tokenValue = v
                    print("💰 TOKEN LOCKED: " .. v:GetFullName() .. " = " .. v.Value)
                    return v
                end
            end
        end
    end
    for i=1,15 do task.wait(1); local new = findTokenValue() if new then return new end end
    return nil
end
tokenValue = findTokenValue()

-- REMOTE SPY HELL
local function hookRemote(rem)
    if table.find(spiedRemotes, rem) then return end
    table.insert(spiedRemotes, rem)
    print("🕵️ TOKEN REMOTE SPIED: " .. rem.Name)
    local oldFire = rem.FireServer
    rem.FireServer = function(self, ...)
        local args = {...}
        if rem.Name:lower():find("token") or rem.Name:lower():find("claim") or rem.Name:lower():find("add") then
            print("💥 HACK REPLAY: " .. rem.Name, args)
            task.spawn(function()
                task.wait(0.1)
                local hackArgs = {unpack(args)}
                if #hackArgs > 0 then hackArgs[1] = hackArgs[1] + 1 end
                pcall(oldFire, self, unpack(hackArgs))
            end)
        end
        return oldFire(self, ...)
    end
end

for _, obj in pairs(game:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then hookRemote(obj) end
end
game.DescendantAdded:Connect(function(obj)
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then task.wait(0.5); hookRemote(obj) end
end)

-- GUI (Xeno CoreGui Beast)
local sg = Instance.new("ScreenGui")
sg.Name = "TokenNukerXeno"
sg.ResetOnSpawn = false
sg.DisplayOrder = 999999
sg.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 200)
frame.Position = UDim2.new(0.5, -160, 0.4, -100)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = sg
local uc = Instance.new("UICorner", frame); uc.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
title.Text = "Token Fucker v7.1 - " .. username .. " 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 50)
status.BackgroundTransparency = 1
status.Text = tokenValue and ("Tokens: " .. tokenValue.Value) or "Scan for 2-Min Tokens 😈"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.Parent = frame

local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 90, 0, 50)
plusBtn.Position = UDim2.new(0, 20, 0, 90)
plusBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
plusBtn.Text = "+1 TOKEN ⬆️"
plusBtn.TextColor3 = Color3.new(1,1,1)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 18
plusBtn.Parent = frame
Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 8)

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 90, 0, 50)
minusBtn.Position = UDim2.new(0, 120, 0, 90)
minusBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minusBtn.Text = "-1 TOKEN ⬇️"
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 18
minusBtn.Parent = frame
Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 8)

local spamBtn = Instance.new("TextButton")
spamBtn.Size = UDim2.new(0, 90, 0, 50)
spamBtn.Position = UDim2.new(0, 220, 0, 90)
spamBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
spamBtn.Text = "SPAM +100 🔥"
spamBtn.TextColor3 = Color3.new(1,1,1)
spamBtn.Font = Enum.Font.GothamBold
spamBtn.TextSize = 14
spamBtn.Parent = frame
Instance.new("UICorner", spamBtn).CornerRadius = UDim.new(0, 8)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 99)

-- BUTTONS
plusBtn.MouseButton1Click:Connect(function()
    targetTokens += 1
    status.Text = "Tokens: " .. targetTokens .. " (Server Spam 💥)"
    status.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

minusBtn.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    status.Text = "Tokens: " .. targetTokens .. " (Hacked 😤)"
    status.TextColor3 = Color3.fromRGB(255, 255, 0)
end)

spamBtn.MouseButton1Click:Connect(function()
    targetTokens += 100
    status.Text = "+100 SPAMMED | Total: " .. targetTokens .. " 🚀"
    status.TextColor3 = Color3.fromRGB(255, 100, 0)
end)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
    print("Nuker Killed 👋")
end)

-- SERVER DOMINATION LOOP
RunS.Heartbeat:Connect(function()
    if tokenValue then
        tokenValue.Value = targetTokens
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldIndex = mt.__index
        mt.__index = newcclosure(function(s, k)
            if s == tokenValue and k == "Value" then return targetTokens end
            return oldIndex(s, k)
        end)
        setreadonly(mt, true)
        if tick() - lastFire >= fireDelay then
            for _, rem in pairs(spiedRemotes) do
                pcall(function()
                    rem:FireServer(targetTokens)
                    rem:FireServer("Tokens", targetTokens)
                end)
            end
            lastFire = tick()
        end
    end
    status.Text = "Tokens: " .. (tokenValue and tokenValue.Value or "?") .. " | Target: " .. targetTokens
end)

print("🎉 TOKEN NUKER v7.1 ARMED - Wait 2 Mins for Remotes, Then Spam! 😈")
