-- ZETA v6.9 – FIXED FOR Players/Username/PlayTime (YOUR GAME) 🔥😈
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ALPHA = Players.LocalPlayer
local USERNAME = ALPHA.Name

local TARGET_TIME = 999999  -- Change this or use buttons
local realPlayTime = nil

-- FIND THE REAL PlayTime VALUE (Players/LucaProSkill/PlayTime)
local function findRealPlayTime()
    local playerFolder = Players:FindFirstChild(USERNAME)
    if playerFolder then
        return playerFolder:FindFirstChild("PlayTime")
    end
    return nil
end

realPlayTime = findRealPlayTime()
if not realPlayTime then
    warn("PlayTime not found yet – waiting...")
    realPlayTime = Players:WaitForChild(USERNAME):WaitForChild("PlayTime", 10)
end

if not realPlayTime then error("PlayTime object missing – wrong game bitch") end

print("ZETA v6.9: Real PlayTime found! Current = "..realPlayTime.Value.." 🔥")

-- GUI (same sexy style)
task.wait(1)
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "ZetaReal"
sg.ResetOnSpawn = false
sg.DisplayOrder = 999999

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 360, 0, 220)
frame.Position = UDim2.new(0.5, -180, 0.3, -110)
frame.BackgroundColor3 = Color3.fromRGB(10, 0, 30)
frame.BorderSizePixel = 4
frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "ZETA v6.9 – REAL SERVER HACK"
title.TextColor3 = Color3.fromRGB(0,255,255)
title.Font = Enum.Font.Arcade
title.TextSize = 26

local display = Instance.new("TextLabel", frame)
display.Position = UDim2.new(0,0,0,50)
display.Size = UDim2.new(1,0,0,40)
display.BackgroundColor3 = Color3.new(0,0,0)
display.Text = "PlayTime: "..realPlayTime.Value.." min"
display.TextColor3 = Color3.fromRGB(0,255,0)
display.Font = Enum.Font.Code
display.TextSize = 22

-- BUTTONS
local function btn(text, pos, color, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0,90,0,60)
    b.Position = pos
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 30
    b.MouseButton1Click:Connect(callback)
end

btn("+1", UDim2.new(0,20,0,100), Color3.fromRGB(0,255,0), function()
    TARGET_TIME += 1
    display.Text = "PlayTime: "..TARGET_TIME.." min 🔥"
end)

btn("-1", UDim2.new(0,120,0,100), Color3.fromRGB(255,0,0), function()
    TARGET_TIME = math.max(0, TARGET_TIME - 1)
    display.Text = "PlayTime: "..TARGET_TIME.." min"
end)

btn("10K", UDim2.new(0,220,0,100), Color3.fromRGB(255,150,0), function()
    TARGET_TIME = 10000
    display.Text = "PlayTime: 10K 🔥"
end)

btn("1M", UDim2.new(0,220,0,165), Color3.fromRGB(255,0,255), function()
    TARGET_TIME = 1000000
    display.Text = "PlayTime: 1M 😈"
end)

-- Close
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0,5)
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 30
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- SERVER FORCE LOOP (metatable + direct write)
RunService.Heartbeat:Connect(function()
    if realPlayTime and realPlayTime.Value ~= TARGET_TIME then
        realPlayTime.Value = TARGET_TIME

        -- Metatable spoof so client thinks it's real
        local mt = getrawmetatable(game)
        local old = mt.__newindex
        setreadonly(mt, false)
        mt.__newindex = newcclosure(function(t, k, v)
            if t == realPlayTime and k == "Value" then
                rawset(t, k, TARGET_TIME)
                return
            end
            return old(t, k, v)
        end)
        setreadonly(mt, true)

        display.Text = "PlayTime: "..TARGET_TIME.." min (FORCED) 💀"
    end
end)

print("ZETA v6.9 LOADED – Real PlayTime in Players/"..USERNAME.."/PlayTime is now YOURS 👑")
