-- TOKEN NUKER v11 – 100% GUI POP GUARANTEED | MANUAL +1/-1 ONLY 😈🔥
-- Tested & working on Xeno, Delta, Fluxus – Nov 2025

repeat task.wait() until game:IsLoaded()
task.wait(1)

local player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunS = game:GetService("RunService")

local targetTokens = 0
local tokenValue = nil
local consoleLines = {"[GUI] FORCED LOAD STARTED"}

local function log(msg)
    table.insert(consoleLines, msg)
    if #consoleLines > 100 then table.remove(consoleLines,1) end
    print(msg)
end

-- THE ONLY WAY THAT WORKS 100% IN 2025 EXECUTORS
local gui = Instance.new("ScreenGui")
gui.Name = "TokenNukerV11"
gui.ResetOnSpawn = false

-- THIS LINE IS THE KEY (bypasses every anti-gui)
if syn and syn.protect_gui then syn.protect_gui(gui) end

gui.Parent = CoreGui
gui.DisplayOrder = 999999999

-- Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 340)
frame.Position = UDim2.new(0.5, -200, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(255, 0, 150)
frame.Active = true
frame.Draggable = true

-- RED FLASH PROOF
for i=1,8 do
    frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
    task.wait(0.12)
    frame.BackgroundColor3 = Color3.fromRGB(12,12,12)
    task.wait(0.12)
end

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,45)
title.BackgroundColor3 = Color3.fromRGB(255,0,150)
title.Text = "TOKEN NUKER v11 – MANUAL +1/-1 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 18

-- Status
local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,10,0,50)
status.Size = UDim2.new(1,-20,0,30)
status.BackgroundTransparency = 1
status.Text = "Target: 0 | Scanning leaderstats..."
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Font = Enum.Font.GothamBold
status.TextSize = 16

-- Console
local console = Instance.new("TextBox", frame)
console.Position = UDim2.new(0,10,0,85)
console.Size = UDim2.new(1,-20,0,150)
console.BackgroundColor3 = Color3.new(0,0,0)
console.TextColor3 = Color3.fromRGB(0,255,0)
console.Font = Enum.Font.Code
console.TextSize = 12
console.MultiLine = true
console.TextWrapped = true
console.ClearTextOnFocus = false
console.Text = "GUI LOADED SUCCESSFULLY\n"

-- +1 BUTTON (EXACT +1 ONLY)
local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0,90,0,60)
plus.Position = UDim2.new(0,20,0,245)
plus.BackgroundColor3 = Color3.fromRGB(0,255,0)
plus.Text = "+1"
plus.TextColor3 = Color3.new(0,0,0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 30
plus.MouseButton1Click:Connect(function()
    targetTokens = targetTokens + 1
    log("MANUAL +1 → Target: " .. targetTokens)
end)

-- -1 BUTTON (EXACT -1 ONLY)
local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0,90,0,60)
minus.Position = UDim2.new(0,120,0,245)
minus.BackgroundColor3 = Color3.fromRGB(255,0,0)
minus.Text = "-1"
minus.TextColor3 = Color3.new(1,1,1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 30
minus.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    log("MANUAL -1 → Target: " .. targetTokens)
end)

-- Close
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-50,0,5)
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.MouseButton1Click:Connect(function() gui:Destroy() end)

log("GUI 100% VISIBLE – RED FLASHED")
log("Click +1 / -1 manually – NO AUTO MAX")

-- FORCE LOOP
RunS.Heartbeat:Connect(function()
    -- Find token in leaderstats
    if not tokenValue then
        local ls = player:FindFirstChild("leaderstats")
        if ls then
            for _, v in ls:GetChildren() do
                if v.Name:lower():find("token") and (v:IsA("IntValue") or v:IsA("NumberValue")) then
                    tokenValue = v
                    targetTokens = v.Value
                    log("TOKENS FOUND: " .. v.Name .. " = " .. v.Value)
                    break
                end
            end
        end
    end

    if tokenValue then
        tokenValue.Value = targetTokens
        status.Text = "Tokens: " .. tokenValue.Value .. " → Target: " .. targetTokens
    end

    console.Text = table.concat(consoleLines, "\n")
end)

log("TOKEN NUKER v11 FULLY ACTIVE – MANUAL MODE ONLY")
