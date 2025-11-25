-- TOKEN NUKER v10.0 – MANUAL +1/-1 ONLY | NO AUTO MAX | GUI 100% FORCED 😈🔥
local Players = game:GetService("Players")
local RunS = game:GetService("RunService")
local player = Players.LocalPlayer
local username = player.Name

local targetTokens = 0  -- STARTS 0 - MANUAL +1/-1 ONLY
local tokenValue = nil
local spiedRemotes = {}
local consoleLines = {}
local countdownTime = 120

local function cprint(msg)
    table.insert(consoleLines, "["..os.date("%X").."] "..msg)
    if #consoleLines > 200 then table.remove(consoleLines,1) end
    print(msg)
end

-- FORCE GUI (TRIPLE SPAWN + FLASH)
task.spawn(function()
    task.wait(0.3)
    local CoreGui = game:GetService("CoreGui")
    local sg = Instance.new("ScreenGui")
    sg.Name = "TokenNukerV10_FORCED"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 999999999
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 320)
    frame.Position = UDim2.new(0.5, -190, 0.5, -160)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    frame.BorderSizePixel = 4
    frame.BorderColor3 = Color3.fromRGB(255, 0, 100)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = sg

    -- MASSIVE RED FLASH - IMPOSSIBLE TO MISS
    for i = 1, 10 do
        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        frame.BorderColor3 = Color3.fromRGB(255, 255, 0)
        task.wait(0.1)
        frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
        frame.BorderColor3 = Color3.fromRGB(255, 0, 100)
        task.wait(0.1)
    end

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,40)
    title.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    title.Text = "TOKEN MANUAL NUKER v10 – " .. username .. " 👑 (MANUAL +1/-1)"
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 16

    local countdownLabel = Instance.new("TextLabel", frame)
    countdownLabel.Position = UDim2.new(0,10,0,45)
    countdownLabel.Size = UDim2.new(1,-20,0,30)
    countdownLabel.BackgroundColor3 = Color3.fromRGB(40,0,0)
    countdownLabel.Text = "2-Min Remote Spy: 2:00 ⏳"
    countdownLabel.TextColor3 = Color3.fromRGB(255,255,0)
    countdownLabel.Font = Enum.Font.GothamBold
    countdownLabel.TextSize = 16

    local status = Instance.new("TextLabel", frame)
    status.Position = UDim2.new(0,10,0,80)
    status.Size = UDim2.new(1,-20,0,30)
    status.BackgroundTransparency = 1
    status.Text = "Target: 0 | Leaderstats Scan..."
    status.TextColor3 = Color3.fromRGB(0,255,0)
    status.Font = Enum.Font.Gotham
    status.TextSize = 16

    local consoleBox = Instance.new("TextBox", frame)
    consoleBox.Position = UDim2.new(0,10,0,115)
    consoleBox.Size = UDim2.new(1,-20,0,110)
    consoleBox.BackgroundColor3 = Color3.new(0,0,0)
    consoleBox.TextColor3 = Color3.fromRGB(0,255,0)
    consoleBox.Font = Enum.Font.Code
    consoleBox.TextSize = 11
    consoleBox.MultiLine = true
    consoleBox.TextWrapped = true
    consoleBox.ClearTextOnFocus = false
    consoleBox.Text = "GUI FORCED & READY\nMANUAL +1/-1 ACTIVE\n"

    -- MANUAL +1/-1 BUTTONS (EXACTLY +-1)
    local function btn(name, pos, color, callback)
        local b = Instance.new("TextButton", frame)
        b.Size = UDim2.new(0,85,0,55)
        b.Position = pos
        b.BackgroundColor3 = color
        b.Text = name
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 22
        b.MouseButton1Click:Connect(callback)
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
    end

    btn("+1", UDim2.new(0,15,0,235), Color3.fromRGB(0,255,0), function()
        targetTokens = targetTokens + 1  -- EXACT +1
        cprint("➕ MANUAL +1 CLICKED | NEW TARGET: " .. targetTokens)
    end)

    btn("-1", UDim2.new(0,110,0,235), Color3.fromRGB(255,0,0), function()
        targetTokens = math.max(0, targetTokens - 1)  -- EXACT -1, NO NEGATIVE
        cprint("➖ MANUAL -1 CLICKED | NEW TARGET: " .. targetTokens)
    end)

    btn("SPAM\n+50", UDim2.new(0,205,0,235), Color3.fromRGB(255,150,0), function()
        targetTokens = targetTokens + 50
        cprint("🔥 SPAM +50 CLICKED | NEW TARGET: " .. targetTokens)
    end)

    local close = Instance.new("TextButton", frame)
    close.Size = UDim2.new(0,45,0,45)
    close.Position = UDim2.new(1,-55,0,2)
    close.BackgroundColor3 = Color3.fromRGB(200,0,0)
    close.Text = "X"
    close.TextColor3 = Color3.new(1,1,1)
    close.Font = Enum.Font.GothamBold
    close.TextSize = 24
    close.MouseButton1Click:Connect(function() sg:Destroy(); cprint("GUI CLOSED 👋") end)
    Instance.new("UICorner", close).CornerRadius = UDim.new(0,99)

    cprint("🎉 GUI FLASHED RED - FULLY LOADED | MANUAL MODE ACTIVE")
end)

-- REMOTE SPY (SILENT, LOGS TO CONSOLE)
game.DescendantAdded:Connect(function(obj)
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        task.wait(0.3)
        local name = obj.Name:lower()
        if name:find("token") or name:find("claim") or name:find("reward") or name:find("add") then
            cprint("🕵️ 2-MIN TOKEN REMOTE SPIED: " .. obj.Name)
            countdownTime = 120  -- RESET COUNTDOWN
        end
    end
end)

-- MAIN FORCE LOOP
local lastTick = tick()
RunS.Heartbeat:Connect(function()
    if tick() - lastTick >= 0.5 then  -- 2Hz UPDATE
        -- LEADERSTATS SCAN
        local ls = player:FindFirstChild("leaderstats")
        if ls and not tokenValue then
            for _, v in pairs(ls:GetChildren()) do
                if v.Name:lower():find("token") and (v:IsA("IntValue") or v:IsA("NumberValue")) then
                    tokenValue = v
                    targetTokens = v.Value  -- SYNC CURRENT
                    cprint("💰 LEADERSTATS TOKENS FOUND: " .. v.Name .. " = " .. v.Value)
                    break
                end
            end
        end

        -- FORCE TARGET TO SERVER VALUE
        if tokenValue then
            tokenValue.Value = targetTokens
            status.Text = "Tokens: " .. tokenValue.Value .. " | MANUAL TARGET: " .. targetTokens
        end

        -- COUNTDOWN
        countdownTime = math.max(0, countdownTime - 0.5)
        local m = math.floor(countdownTime / 60)
        local s = math.floor(countdownTime % 60)
        countdownLabel.Text = "2-Min Remote Spy: " .. m .. ":" .. string.format("%02d", s) .. " ⏳"

        -- CONSOLE UPDATE (FIND GUI ELEMENTS)
        pcall(function()
            local gui = CoreGui:FindFirstChild("TokenNukerV10_FORCED")
            if gui then
                local consoleBox = gui.Frame.TextBox
                consoleBox.Text = table.concat(consoleLines, "\n")
                consoleBox.CanvasPosition = Vector2.new(0, 9e9)  -- AUTO SCROLL
            end
        end)

        lastTick = tick()
    end
end)

cprint("TOKEN NUKER v10.0 INJECTED | WAITING FOR RED FLASH + LEADERSTATS | CLICK +1/-1 MANUALLY 😈")
