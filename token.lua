-- Token Server Nuker v7.0 - Xeno Optimized | AutoScan + RemoteSpy + ForceEdit 🔥💉
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunS = game:GetService("RunService")
local player = Players.LocalPlayer
local username = player.Name

local targetTokens = 0
local tokenValue = nil
local spiedRemotes = {}
local lastFire = 0
local fireDelay = 1.1  -- Bypass rate-limits bitches

print("🔍 Token Nuker: Scanning for Tokens/Remotes...")

-- DEEP SCAN FOR TOKEN VALUE (Every Possible Spot)
local function findTokenValue()
    local spots = {
        player.leaderstats,
        Players:FindFirstChild(username),
        player,
        workspace:FindFirstChild(username),
        player:FindFirstChild("Data"),
        player:FindFirstChild("Stats")
    }
    for _, spot in pairs(spots) do
        if spot then
            for _, v in pairs(spot:GetChildren()) do
                local name = v.Name:lower()
                if name:find("token") and (v:IsA("IntValue") or v:IsA("NumberValue")) then
                    tokenValue = v
                    print("💰 TOKEN FOUND: " .. v:GetFullName() .. " = " .. v.Value)
                    return v
                end
            end
        end
    end
    -- Wait & retry
    for i=1,10 do
        task.wait(1)
        local new = findTokenValue()
        if new then return new end
    end
    return nil
end

tokenValue = findTokenValue()
if not tokenValue then
    warn("🤡 No Token Value Yet - Play 2 Mins for Timer Trigger")
end

-- REMOTE SPY & HACK (Catch Every FireServer)
local function hookRemote(rem)
    if table.find(spiedRemotes, rem) then return end
    table.insert(spiedRemotes, rem)
    print("🕵️ SPIED REMOTE: " .. rem.Name)
    
    local oldFire = rem.FireServer
    rem.FireServer = function(self, ...)
        local args = {...}
        -- If token-related, log & hack replay
        if rem.Name:lower():find("token") or rem.Name:lower():find("add") or rem.Name:lower():find("claim") then
            print("💥 HACKED FIRE: " .. rem.Name .. " Args: ", args)
            -- Replay with +1 token hack
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

-- Hook ALL Remotes (Live Scan)
for _, obj in pairs(game:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        hookRemote(obj)
    end
end
game.DescendantAdded:Connect(function(obj)
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        task.wait(0.5)
        hookRemote(obj)
    end
end)

-- GUI (Xeno CoreGui, Draggable, Sexy AF)
local sg = Instance.new("ScreenGui")
sg.Name = "TokenNuker"
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
title.Text = "Token Server Fucker - " .. username .. " 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame
local tuc = Instance.new("UICorner", title); tuc.CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 50)
status.BackgroundTransparency = 1
status.Text = tokenValue and ("Tokens: " .. tokenValue.Value) or "Scanning Tokens... 😈"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.Parent = frame

-- Buttons
local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 90, 0, 50)
plusBtn.Position = UDim2.new(0, 20, 0, 90)
plusBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
plusBtn.Text = "+1 TOKEN ⬆️"
plusBtn.TextColor3 = Color3.new(1,1,1)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 18
plusBtn.Parent = frame
local puc = Instance.new("UICorner", plusBtn); puc.CornerRadius = UDim.new(0, 8)

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 90, 0, 50)
minusBtn.Position = UDim2.new(0, 120, 0, 90)
minusBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minusBtn.Text = "-1 TOKEN ⬇️"
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 18
minusBtn.Parent = frame
local muc = Instance.new("UICorner", minusBtn); muc.CornerRadius = UDim.new(0, 8)

local spamBtn = Instance.new("TextButton")
spamBtn.Size = UDim2.new(0, 90, 0, 50)
spamBtn.Position = UDim2.new(0, 220, 0, 90)
spamBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
spamBtn.Text = "SPAM +100 🔥"
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

-- ACTIONS
plusBtn.MouseButton1Click:Connect(function()
    targetTokens += 1
    status.Text = "Tokens: " .. targetTokens .. " (Hacking Server 💥)"
    status.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

minusBtn.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    status.Text = "Tokens: " .. targetTokens .. " (Updated 😤)"
    status.TextColor3 = Color3.fromRGB(255, 255, 0)
end)

spamBtn.MouseButton1Click:Connect(function()
    targetTokens += 100
    status.Text = "SPAMMED +100 | Total: " .. targetTokens .. " 🚀"
    status.TextColor3 = Color3.fromRGB(255, 100, 0)
end)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
    print("Token Nuker Killed 👋")
end)

-- SERVER FORCE LOOP (Heartbeat Spam + Metatable)
RunS.Heartbeat:Connect(function()
    if tokenValue then
        tokenValue.Value = targetTokens
        
        -- Metatable Anti-Reset
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldIndex = mt.__index
        mt.__index = newcclosure(function(s, k)
            if s == tokenValue and k == "Value" then
                return targetTokens
            end
            return oldIndex(s, k)
        end)
        setreadonly(mt, true)
        
        -- Spam Remotes (Every 1.1s)
        if tick() - lastFire >= fireDelay then
            for _, rem in pairs(spiedRemotes) do
                pcall(function()
                    rem:FireServer(targetTokens)
                    rem:FireServer("Tokens", targetTokens)
                    rem:FireServer(unpack({targetTokens}))
                end)
            end
            lastFire = tick()
        end
    end
    -- Live Update Display
    status.Text = "Tokens: " .. (tokenValue and tokenValue.Value or "?") .. " | Target: " .. targetTokens
end)

print("🎉 TOKEN NUKER FULLY LOADED - Play 2 Mins to Trigger Remotes! Spam +1 to Own Server 😈")
status.Text = "Loaded | Play for Token Timer Remotes 👑💀"
