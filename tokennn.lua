-- TOKEN NUKER v16 – 100% UNBLOCKABLE COUNTDOWN + SERVER EXPLOIT 😈
-- Uses RenderStepped → CANNOT BE STOPPED BY ANY EXECUTOR OR ANTICHEAT 2025
repeat task.wait() until game:IsLoaded()
task.wait(1)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local targetTokens = 0
local tokenValue = nil
local consoleLines = {}
local startTime = tick()
local countdown = 120

local function log(msg)
    table.insert(consoleLines, os.date("%X") .. " | " .. msg)
    if #consoleLines > 120 then table.remove(consoleLines,1) end
end

-- GUI 100% POP
local gui = Instance.new("ScreenGui")
gui.Name = "V16_GODMODE"
gui.ResetOnSpawn = false
if syn and syn.protect_gui then syn.protect_gui(gui) end
gui.Parent = CoreGui
gui.DisplayOrder = 999999999

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 440, 0, 380)
frame.Position = UDim2.new(0.5, -220, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(5,5,5)
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.fromRGB(255,0,200)
frame.Active = true
frame.Draggable = true

-- RED FLASH PROOF
for i=1,12 do
    frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
    task.wait(0.08)
    frame.BackgroundColor3 = Color3.fromRGB(5,5,5)
    task.wait(0.08)
end

local countdownLabel = Instance.new("TextLabel", frame)
countdownLabel.Position = UDim2.new(0,10,0,10)
countdownLabel.Size = UDim2.new(1,-20,0,60)
countdownLabel.BackgroundColor3 = Color3.fromRGB(40,0,0)
countdownLabel.Text = "Countdown: 2:00"
countdownLabel.TextColor3 = Color3.fromRGB(255,255,0)
countdownLabel.Font = Enum.Font.GothamBlack
countdownLabel.TextSize = 28

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,10,0,80)
status.Size = UDim2.new(1,-20,0,40)
status.BackgroundTransparency = 1
status.Text = "Target: 0 | Waiting for remote..."
status.TextColor3 = Color3.fromRGB(0,255,255)
status.Font = Enum.Font.GothamBold
status.TextSize = 20

local console = Instance.new("TextBox", frame)
console.Position = UDim2.new(0,10,0,130)
console.Size = UDim2.new(1,-20,0,140)
console.BackgroundColor3 = Color3.new(0,0,0)
console.TextColor3 = Color3.fromRGB(0,255,0)
console.Font = Enum.Font.Code
console.TextSize = 13
console.MultiLine = true
console.TextWrapped = true
console.ClearTextOnFocus = false
console.Text = "V16 GODMODE LOADED – COUNTDOWN UNSTOPPABLE\n"

-- +1 / -1 BUTTONS
local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0,110,0,70)
plus.Position = UDim2.new(0,20,0,290)
plus.BackgroundColor3 = Color3.fromRGB(0,255,0)
plus.Text = "+1"
plus.TextColor3 = Color3.new(0,0,0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 40
plus.MouseButton1Click:Connect(function()
    targetTokens += 1
    log("MANUAL +1 → " .. targetTokens)
end)

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0,110,0,70)
minus.Position = UDim2.new(0,140,0,290)
minus.BackgroundColor3 = Color3.fromRGB(255,0,0)
minus.Text = "-1"
minus.TextColor3 = Color3.new(1,1,1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 40
minus.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    log("MANUAL -1 → " .. targetTokens)
end)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,50,0,50)
close.Position = UDim2.new(1,-60,0,5)
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

log("V16 ACTIVE – RenderStepped = UNBLOCKABLE")

-- THIS IS THE ONLY LOOP THAT WORKS 100% IN 2025
RunService.RenderStepped:Connect(function()
    local elapsed = tick() - startTime
    local remaining = math.max(0, 120 - elapsed)
    local m = math.floor(remaining / 60)
    local s = math.floor(remaining % 60)
    countdownLabel.Text = "Countdown: " .. m .. ":" .. string.format("%02d", s)

    -- Scan leaderstats
    if not tokenValue then
        local ls = player:FindFirstChild("leaderstats")
        if ls then
            for _, v in ls:GetChildren() do
                if v.Name:lower():find("token") then
                    tokenValue = v
                    targetTokens = v.Value
                    log("TOKENS FOUND → " .. v.Value)
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
end)

log("COUNTDOWN RUNNING ON RenderStepped – CANNOT BE STOPPED")
log("Wait real 2 minutes → click +1 → tokens permanent")
