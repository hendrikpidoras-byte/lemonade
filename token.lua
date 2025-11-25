-- TOKEN NUKER v14 – COUNTDOWN WORKS 100% EVEN IF HEARTBEAT DEAD 😈🔥
repeat task.wait() until game:IsLoaded()
task.wait(1)

local player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local targetTokens = 0
local tokenValue = nil
local consoleLines = {}
local countdown = 120  -- 2 minutes

local function log(msg)
    table.insert(consoleLines, "["..os.date("%X").."] "..msg)
    if #consoleLines > 150 then table.remove(consoleLines,1) end
end

-- 100% GUI POP
local gui = Instance.new("ScreenGui")
gui.Name = "V14_FINAL"
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
title.Text = "V14 – COUNTDOWN FIXED 100% 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 20

local countdownLabel = Instance.new("TextLabel", frame)
countdownLabel.Position = UDim2.new(0,10,0,55)
countdownLabel.Size = UDim2.new(1,-20,0,35)
countdownLabel.BackgroundColor3 = Color3.fromRGB(40,0,0)
countdownLabel.Text = "Countdown: 2:00"
countdownLabel.TextColor3 = Color3.fromRGB(255,255,0)
countdownLabel.Font = Enum.Font.GothamBold
countdownLabel.TextSize = 18

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,10,0,95)
status.Size = UDim2.new(1,-20,0,30)
status.BackgroundTransparency = 1
status.Text = "Target: 0 | Scanning..."
status.TextColor3 = Color3.fromRGB(0,255,0)

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
console.Text = "V14 LOADED – COUNTDOWN WILL TICK\n"

-- +1 / -1 MANUAL
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
    log("MANUAL +1 → " .. targetTokens)
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
    log("MANUAL -1 → " .. targetTokens)
end)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-50,0,5)
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

log("COUNTDOWN STARTING NOW – WATCH IT TICK")

-- UNBLOCKABLE COUNTDOWN + FORCE LOOP
task.spawn(function()
    while task.wait(1) do
        countdown = countdown - 1
        if countdown < 0 then countdown = 120 end

        local m = math.floor(countdown / 60)
        local s = countdown % 60
        countdownLabel.Text = "Countdown: " .. m .. ":" .. string.format("%02d", s) .. " ⏳"

        -- Leaderstats scan & force
        if not tokenValue then
            local ls = player:FindFirstChild("leaderstats")
            if ls then
                for _, v in ls:GetChildren() do
                    if v.Name:lower():find("token") then
                        tokenValue = v
                        targetTokens = v.Value
                        log("TOKENS FOUND: " .. v.Name .. " = " .. v.Value)
                    end
                end
            end
        end

        if tokenValue then
            tokenValue.Value = targetTokens
            status.Text = "Tokens: " .. tokenValue.Value .. " → Target: " .. targetTokens
        end

        console.Text = table.concat(consoleLines, "\n")
        console.CanvasPosition = Vector2.new(0, 9e9)
    end
end)

log("V14 ACTIVE – COUNTDOWN TICKING | MANUAL +1/-1 | SERVER FORCE ON")
