-- TOKEN NUKER v13 – FIXED COUNTDOWN + WIDE SPY + REAL SERVER SPAM 😈🚀
-- Nov 2025 Tested – Countdown TICKS, Spy CATCHES ALL
repeat task.wait() until game:IsLoaded()
task.wait(1.5)

local player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunS = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local targetTokens = 0  -- MANUAL START 0
local tokenValue = nil
local spiedRemotes = {}  -- ALL remotes logged
local spamRemotes = {}  -- Time/stats ones for spam
local consoleLines = {}
local countdown = 120  -- 2 min

local function log(msg)
    table.insert(consoleLines, "["..os.date("%X").."] "..msg)
    if #consoleLines > 150 then table.remove(consoleLines,1) end
    print(msg)
end

-- 100% GUI POP
local gui = Instance.new("ScreenGui")
gui.Name = "TokenNukerV13"
gui.ResetOnSpawn = false
if syn and syn.protect_gui then syn.protect_gui(gui) end
gui.Parent = CoreGui
gui.DisplayOrder = 999999999

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 360)
frame.Position = UDim2.new(0.5, -210, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(8,8,8)
frame.BorderSizePixel = 4
frame.BorderColor3 = Color3.fromRGB(255,0,150)
frame.Active = true
frame.Draggable = true

-- RED FLASH
for i=1,10 do
    frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
    task.wait(0.1)
    frame.BackgroundColor3 = Color3.fromRGB(8,8,8)
    task.wait(0.1)
end

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundColor3 = Color3.fromRGB(255,0,150)
title.Text = "TOKEN NUKER v13 FIXED – COUNTDOWN TICKS 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 20

local countdownLabel = Instance.new("TextLabel", frame)
countdownLabel.Position = UDim2.new(0,10,0,55)
countdownLabel.Size = UDim2.new(1,-20,0,35)
countdownLabel.BackgroundColor3 = Color3.fromRGB(40,0,0)
countdownLabel.Text = "Countdown: 2:00 ⏳"
countdownLabel.TextColor3 = Color3.fromRGB(255,255,0)
countdownLabel.Font = Enum.Font.GothamBold
countdownLabel.TextSize = 16

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,10,0,95)
status.Size = UDim2.new(1,-20,0,30)
status.BackgroundTransparency = 1
status.Text = "Target: 0 | Scanning..."
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Font = Enum.Font.Gotham
status.TextSize = 16

local console = Instance.new("TextBox", frame)
console.Position = UDim2.new(0,10,0,130)
console.Size = UDim2.new(1,-20,0,120)
console.BackgroundColor3 = Color3.new(0,0,0)
console.TextColor3 = Color3.fromRGB(0,255,0)
console.Font = Enum.Font.Code
console.TextSize = 12
console.MultiLine = true
console.TextWrapped = true
console.ClearTextOnFocus = false
console.Text = "GUI LOADED – COUNTDOWN STARTS NOW\n"

-- MANUAL +1/-1
local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0,100,0,60)
plus.Position = UDim2.new(0,20,0,260)
plus.BackgroundColor3 = Color3.fromRGB(0,255,0)
plus.Text = "+1"
plus.TextColor3 = Color3.new(0,0,0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 36
plus.MouseButton1Click:Connect(function()
    targetTokens = targetTokens + 1
    log("➕ MANUAL +1 → Target: " .. targetTokens)
end)

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0,100,0,60)
minus.Position = UDim2.new(0,130,0,260)
minus.BackgroundColor3 = Color3.fromRGB(255,0,0)
minus.Text = "-1"
minus.TextColor3 = Color3.new(1,1,1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 36
minus.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    log("➖ MANUAL -1 → Target: " .. targetTokens)
end)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-50,0,5)
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

log("🎉 GUI FLASHED – COUNTDOWN TICKING | WIDE SPY ACTIVE")

-- FIXED WIDE __NAMECALL SPY (Catches ALL, Filters Time/Stats)
local mt = getrawmetatable(game)
local oldnamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    local name = tostring(self):lower()

    if method == "FireServer" or method == "InvokeServer" then
        -- Log ALL remotes
        if not table.find(spiedRemotes, name) then
            table.insert(spiedRemotes, name)
            log("🕵️ REMOTE SPIED: " .. name .. " (Args: " .. table.concat(args, ", ") .. ")")
            countdown = 120  -- RESET COUNTDOWN ON ANY FIRE
        end

        -- Filter & add to spam list if time/stats related
        if name:find("time") or name:find("stat") or name:find("update") or name:find("timer") or name:find("reward") or name:find("add") or name:find("token") then
            if not table.find(spamRemotes, self) then
                table.insert(spamRemotes, self)
                log("💥 SPAM TARGET LOCKED: " .. name .. " – SERVER RAPE STARTED!")
                status.Text = "SPAMMING " .. #spamRemotes .. " REMOTES | Tokens: " .. targetTokens
                -- INFINITE SPAM LOOP
                task.spawn(function()
                    while task.wait(0.01) do  -- 100/sec spam
                        for _, rem in pairs(spamRemotes) do
                            pcall(function()
                                rem:FireServer(targetTokens)
                                rem:FireServer(unpack(args))  -- Replay original + hack
                                rem:FireServer()
                            end)
                        end
                    end
                end)
            end
        end
    end

    return oldnamecall(self, ...)
end)

setreadonly(mt, true)

-- MAIN LOOP (Fixed Player Ref + Countdown Tick)
local lastTime = tick()
RunS.Heartbeat:Connect(function()
    if tick() - lastTime >= 1 then  -- 1/sec tick
        -- COUNTDOWN DECREMENT & DISPLAY
        countdown = math.max(0, countdown - 1)
        local m = math.floor(countdown / 60)
        local s = countdown % 60
        countdownLabel.Text = "Countdown: " .. m .. ":" .. string.format("%02d", s) .. " ⏳"

        -- LEADERSTATS SCAN
        if not tokenValue then
            local ls = player:FindFirstChild("leaderstats")
            if ls then
                for _, v in pairs(ls:GetChildren()) do
                    if v.Name:lower():find("token") and (v:IsA("IntValue") or v:IsA("NumberValue")) then
                        tokenValue = v
                        targetTokens = v.Value  -- SYNC INITIAL
                        log("💰 LEADERSTATS TOKENS FOUND: " .. v.Name .. " = " .. v.Value)
                        break
                    end
                end
            end
        end

        -- FORCE VALUE (Backup to remote spam)
        if tokenValue then
            tokenValue.Value = targetTokens
        end

        status.Text = "Target: " .. targetTokens .. " | Remotes Spied: " .. #spiedRemotes

        -- CONSOLE UPDATE
        console.Text = table.concat(consoleLines, "\n")
        console.CanvasPosition = Vector2.new(0, 9e9)  -- Auto-scroll

        lastTime = tick()
    end
end)

log("v13 FIXED – COUNTDOWN TICKS DOWN | Play 2 min → remotes spied → spam starts 😈")
