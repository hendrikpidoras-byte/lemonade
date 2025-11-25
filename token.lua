-- Token Nuker v8.0 - CONSOLE GUI + 2-MIN COUNTDOWN | Leaderstats Locked 😈🔥
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
local countdownTime = 120  -- 2 minutes for token tick
local consoleLines = {}

-- CONSOLE PRINT FUNCTION (Feeds GUI)
local function consolePrint(msg)
    table.insert(consoleLines, "["..os.date("%H:%M:%S").."] "..msg)
    if #consoleLines > 50 then table.remove(consoleLines, 1) end
    print(msg)  -- Also executor console
end

-- DEEP LEADERSTATS TOKEN SCAN
local function scanTokens()
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        for _, v in pairs(leaderstats:GetChildren()) do
            if v.Name:lower():find("token") and (v:IsA("IntValue") or v:IsA("NumberValue")) then
                if v ~= tokenValue then
                    tokenValue = v
                    consolePrint("💰 TOKEN LOCKED IN LEADERSTATS: " .. v.Name .. " = " .. v.Value)
                end
                return true
            end
        end
    end
    return false
end

-- Initial Scan
scanTokens()

-- REMOTE SPY (Triggers Countdown Reset)
local function hookRemote(rem)
    if table.find(spiedRemotes, rem) then return end
    table.insert(spiedRemotes, rem)
    consolePrint("🕵️ TOKEN REMOTE SPIED: " .. rem.Name .. " (Countdown Reset!)")
    countdownTime = 120  -- Reset on spy hit
    local oldFire = rem.FireServer
    rem.FireServer = function(self, ...)
        local args = {...}
        local name = rem.Name:lower()
        if name:find("token") or name:find("claim") or name:find("add") or name:find("reward") then
            consolePrint("💥 HACK REPLAY: " .. rem.Name .. " | Args: " .. table.concat(args, ", "))
            task.spawn(function()
                task.wait(0.1)
                local hackArgs = {unpack(args)}
                if #hackArgs > 0 then hackArgs[1] = hackArgs[1] + 1 end  -- +1 hack
                pcall(oldFire, self, unpack(hackArgs))
            end)
        end
        return oldFire(self, ...)
    end
end

-- Hook All + Live
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

-- GUI WITH CONSOLE TEXTBOX + COUNTDOWN
local sg = Instance.new("ScreenGui")
sg.Name = "TokenNukerV8"
sg.ResetOnSpawn = false
sg.DisplayOrder = 999999
sg.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 280)
frame.Position = UDim2.new(0.5, -175, 0.3, -140)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = sg
local uc = Instance.new("UICorner", frame); uc.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
title.Text = "Token Console Nuker v8.0 - " .. username .. " 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- COUNTDOWN LABEL
local countdownLabel = Instance.new("TextLabel")
countdownLabel.Size = UDim2.new(1, -20, 0, 25)
countdownLabel.Position = UDim2.new(0, 10, 0, 40)
countdownLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
countdownLabel.Text = "2-Min Token Timer: 2:00 ⏳"
countdownLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
countdownLabel.Font = Enum.Font.GothamBold
countdownLabel.TextSize = 14
countdownLabel.Parent = frame
local cdc = Instance.new("UICorner", countdownLabel); cdc.CornerRadius = UDim.new(0, 6)

-- TOKENS STATUS
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 25)
status.Position = UDim2.new(0, 10, 0, 70)
status.BackgroundTransparency = 1
status.Text = "Tokens: Scanning... | Target: 0"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.Parent = frame

-- CONSOLE TEXTBOX (Scrolling Logs)
local consoleBox = Instance.new("TextBox")
consoleBox.Size = UDim2.new(1, -20, 0, 110)
consoleBox.Position = UDim2.new(0, 10, 0, 100)
consoleBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
consoleBox.BorderSizePixel = 0
consoleBox.Text = "Console Loading...\n"
consoleBox.TextColor3 = Color3.fromRGB(0, 255, 0)
consoleBox.Font = Enum.Font.Code
consoleBox.TextSize = 12
consoleBox.TextXAlignment = Enum.TextXAlignment.Left
consoleBox.TextYAlignment = Enum.TextYAlignment.Top
consoleBox.MultiLine = true
consoleBox.ClearTextOnFocus = false
consoleBox.TextWrapped = true
consoleBox.Active = false  -- Read-only
consoleBox.Parent = frame
local conuc = Instance.new("UICorner", consoleBox); conuc.CornerRadius = UDim.new(0, 6)

-- Buttons
local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 70, 0, 35)
plusBtn.Position = UDim2.new(0, 15, 0, 220)
plusBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
plusBtn.Text = "+1 ⬆️"
plusBtn.TextColor3 = Color3.new(1,1,1)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 18
plusBtn.Parent = frame
Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 8)

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 70, 0, 35)
minusBtn.Position = UDim2.new(0, 95, 0, 220)
minusBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minusBtn.Text = "-1 ⬇️"
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 18
minusBtn.Parent = frame
Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 8)

local spamBtn = Instance.new("TextButton")
spamBtn.Size = UDim2.new(0, 70, 0, 35)
spamBtn.Position = UDim2.new(0, 175, 0, 220)
spamBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
spamBtn.Text = "+100 🔥"
spamBtn.TextColor3 = Color3.new(1,1,1)
spamBtn.Font = Enum.Font.GothamBold
spamBtn.TextSize = 14
spamBtn.Parent = frame
Instance.new("UICorner", spamBtn).CornerRadius = UDim.new(0, 8)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 2.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 99)

-- BUTTONS
plusBtn.MouseButton1Click:Connect(function()
    targetTokens += 1
    consolePrint("➕ +1 CLICKED | New Target: " .. targetTokens)
end)

minusBtn.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    consolePrint("➖ -1 CLICKED | New Target: " .. targetTokens)
end)

spamBtn.MouseButton1Click:Connect(function()
    targetTokens += 100
    consolePrint("💥 SPAM +100 | Total Target: " .. targetTokens)
end)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
    consolePrint("GUI NUKED 👋")
end)

-- MAIN LOOP: Force + Countdown + Console Update + Rescan
local lastCountdown = tick()
RunS.Heartbeat:Connect(function()
    -- Rescan Tokens
    scanTokens()
    
    -- Force Server Value
    if tokenValue then
        tokenValue.Value = targetTokens
        -- Metatable Anti-Reset
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldIndex = mt.__index
        mt.__index = newcclosure(function(s, k)
            if s == tokenValue and k == "Value" then return targetTokens end
            return oldIndex(s, k)
        end)
        setreadonly(mt, true)
        -- Remote Spam
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
    
    -- COUNTDOWN TICK
    if tick() - lastCountdown >= 1 then
        countdownTime -= 1
        local mins = math.floor(countdownTime / 60)
        local secs = countdownTime % 60
        countdownLabel.Text = "2-Min Token Timer: " .. mins .. ":" .. string.format("%02d", secs) .. " ⏳"
        if countdownTime <= 0 then
            countdownTime = 120
            consolePrint("⏰ COUNTDOWN HIT - SPYING FOR TOKEN REMOTE...")
        end
        lastCountdown = tick()
    end
    
    -- Update Status & Console Display
    status.Text = "Tokens: " .. (tokenValue and tokenValue.Value or "?") .. " | Target: " .. targetTokens
    consoleBox.Text = table.concat(consoleLines, "\n")
    consoleBox.CanvasPosition = Vector2.new(0, math.huge)  -- Auto-scroll
end)

consolePrint("🎉 TOKEN NUKER v8.0 LOADED | Leaderstats Scan Active | Countdown Started 😈")
consolePrint("Play & Wait 2:00 for Auto-Token Remote → SPAM +1 TO DOMINATE!")
consoleBox.Text = table.concat(consoleLines, "\n")  -- Initial fill
