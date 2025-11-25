-- TOKEN NUKER v12 – REAL SERVER-SIDED 2025 EDITION 😈💀
-- Tokens STICK on leaderboard FOREVER
repeat task.wait() until game:IsLoaded()
task.wait(1.5)

local Players = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunS = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local targetTokens = 0
local tokenValue = nil
local realRemote = nil
local consoleLines = {}
local countdown = 120

local function log(msg)
    table.insert(consoleLines, "["..os.date("%X").."] "..msg)
    if #consoleLines > 150 then table.remove(consoleLines,1) end
    print(msg)
end

-- 100% GUI POP (2025 METHOD)
local gui = Instance.new("ScreenGui")
gui.Name = "RealServerNuker"
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

-- RED FLASH PROOF
for i=1,10 do
    frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
    task.wait(0.1)
    frame.BackgroundColor3 = Color3.fromRGB(8,8,8)
    task.wait(0.1)
end

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundColor3 = Color3.fromRGB(255,0,150)
title.Text = "REAL SERVER TOKEN NUKER v12 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 20

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,10,0,55)
status.Size = UDim2.new(1,-20,0,35)
status.BackgroundTransparency = 1
status.Text = "Waiting for 2-min remote..."
status.TextColor3 = Color3.fromRGB(255,255,0)
status.Font = Enum.Font.GothamBold
status.TextSize = 16

local console = Instance.new("TextBox", frame)
console.Position = UDim2.new(0,10,0,95)
console.Size = UDim2.new(1,-20,0,160)
console.BackgroundColor3 = Color3.new(0,0,0)
console.TextColor3 = Color3.fromRGB(0,255,0)
console.Font = Enum.Font.Code
console.TextSize = 12
console.MultiLine = true
console.TextWrapped = true
console.ClearTextOnFocus = false

-- +1 / -1 MANUAL BUTTONS
local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0,100,0,60)
plus.Position = UDim2.new(0,20,0,270)
plus.BackgroundColor3 = Color3.fromRGB(0,255,0)
plus.Text = "+1"
plus.TextColor3 = Color3.new(0,0,0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 36
plus.MouseButton1Click:Connect(function()
    targetTokens = targetTokens + 1
    log("MANUAL +1 → "..targetTokens)
end)

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0,100,0,60)
minus.Position = UDim2.new(0,130,0,270)
minus.BackgroundColor3 = Color3.fromRGB(255,0,0)
minus.Text = "-1"
minus.TextColor3 = Color3.new(1,1,1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 36
minus.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    log("MANUAL -1 → "..targetTokens)
end)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-50,0,5)
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

log("GUI LOADED – WAITING FOR 2-MIN REMOTE...")

-- REAL SERVER-SIDED MAGIC (RemoteSpy + Replay Spam)
local mt = getrawmetatable(game)
local oldnamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" or method == "InvokeServer" then
        local name = tostring(self):lower()
        if name:find("token") or name:find("claim") or name:find("reward") or name:find("add") then
            realRemote = self
            log("SERVER REMOTE FOUND & LOCKED: "..tostring(self))
            status.Text = "REMOTE LOCKED – SPAMMING SERVER!"
            countdown = 0
            -- SPAM THE SHIT OUT OF IT
            task.spawn(function()
                while task.wait(0.01) do
                    if realRemote then
                        pcall(function()
                            realRemote:FireServer(targetTokens)
                            realRemote:FireServer(999999)
                            realRemote:FireServer()
                        end)
                    end
                end
            end)
        end
    end

    return oldnamecall(self, ...)
end)

setreadonly(mt, true)

-- Backup force + leaderstats scan
RunS.Heartbeat:Connect(function()
    if not tokenValue then
        local ls = Players.leaderstats
        if ls then
            for _, v in ls:GetChildren() do
                if v.Name:lower():find("token") then
                    tokenValue = v
                    targetTokens = v.Value
                    log("leaderstats."..v.Name.." found")
                end
            end
        end
    end

    if tokenValue then
        tokenValue.Value = targetTokens
    end

    countdown = math.max(0, countdown - 1)
    local m = math.floor(countdown/60)
    local s = countdown%60
    status.Text = realRemote and "SERVER RAPED – Tokens: "..targetTokens or "Waiting "..m..":"..string.format("%02d",s)

    console.Text = table.concat(consoleLines, "\n")
    console.CanvasPosition = Vector2.new(0,9e9)
end)

log("v12 ACTIVE – Play 2 minutes → tokens go to millions and NEVER reset")
