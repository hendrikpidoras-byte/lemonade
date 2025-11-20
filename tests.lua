-- Server-Sided PlayTime Destroyer v3 - RemoteSpy + AutoHack 😈💥
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local username = player.Name

-- GUI Setup (Delta CoreGui Fixed)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayTimeNuker"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999999

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.4, -125)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
title.Text = "Server PlayTime Hack - " .. username .. " 👑💀"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 25)
status.Position = UDim2.new(0, 10, 0, 45)
status.BackgroundTransparency = 1
status.Text = "Spying Remotes... Inject Done? 🔥"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextWrapped = true
status.Parent = frame

local remoteList = Instance.new("ScrollingFrame")
remoteList.Size = UDim2.new(1, -20, 0, 100)
remoteList.Position = UDim2.new(0, 10, 0, 75)
remoteList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
remoteList.BorderSizePixel = 0
remoteList.ScrollBarThickness = 8
remoteList.Parent = frame
local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 6)
listCorner.Parent = remoteList

local addSpam = Instance.new("TextButton")
addSpam.Size = UDim2.new(0.48, 0, 0, 35)
addSpam.Position = UDim2.new(0, 10, 0, 185)
addSpam.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
addSpam.Text = "SPAM +60 MINS ⬆️🔥"
addSpam.TextColor3 = Color3.new(1,1,1)
addSpam.Font = Enum.Font.GothamBold
addSpam.TextSize = 14
addSpam.Parent = frame
local addC = Instance.new("UICorner"); addC.CornerRadius = UDim.new(0, 6); addC.Parent = addSpam

local subSpam = Instance.new("TextButton")
subSpam.Size = UDim2.new(0.48, 0, 0, 35)
subSpam.Position = UDim2.new(0.52, -10, 0, 185)
subSpam.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
subSpam.Text = "RESET TO 0 ⬇️💀"
subSpam.TextColor3 = Color3.new(1,1,1)
subSpam.Font = Enum.Font.GothamBold
subSpam.TextSize = 14
subSpam.Parent = frame
local subC = Instance.new("UICorner"); subC.CornerRadius = UDim.new(0, 6); subC.Parent = subSpam

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = frame
local closeC = Instance.new("UICorner"); closeC.CornerRadius = UDim.new(0, 15); closeC.Parent = closeBtn

-- Remote Spy & AutoHack
local spiedRemotes = {}
local function addRemote(remote, args)
    if table.find(spiedRemotes, remote) then return end
    table.insert(spiedRemotes, remote)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 25)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = remote.Name .. " | Args: " .. #args
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextWrapped = true
    btn.Parent = remoteList
    btn.MouseButton1Click:Connect(function()
        -- Re-fire with +1 min hack (common arg types)
        local hackArgs = {unpack(args)}
        if #hackArgs > 0 then hackArgs[1] = hackArgs[1] + 1 end  -- Assume first arg time
        pcall(function() remote:FireServer(unpack(hackArgs)) end)
        status.Text = "Fired " .. remote.Name .. " +1 | Server Hacked 💥"
    end)
    remoteList.CanvasSize = UDim2.new(0, 0, 0, #remoteList:GetChildren() * 30)
end

-- Hook ALL Remotes (SimpleSpy Style)
for _, obj in pairs(game:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        if string.find(string.lower(obj.Name), "time") or string.find(string.lower(obj.Name), "play") then
            -- Auto spy playtime remotes
            obj.FireServer = function(self, ...)
                addRemote(self, {...})
                return self.FireServer(self, ...)
            end
        end
        -- Hook FireServer
        local oldFire = obj.FireServer
        obj.FireServer = function(self, ...)
            local args = {...}
            if string.lower(obj.Name):find("add") or string.lower(obj.Name):find("time") then
                addRemote(obj, args)
            end
            return oldFire(self, ...)
        end
    end
end

-- Find & Temp Edit Client Value (for display)
local function findPlayTime()
    return player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("PlayTime") or
           player:FindFirstChild("PlayTime") or
           Players:FindFirstChild(username):FindFirstChild("PlayTime")
end
local ptVal = findPlayTime()
if ptVal then status.Text = "Client PT: " .. ptVal.Value .. " | Spying Server Remotes 😈" end

-- Spam Buttons (Fire Common Remotes + Client)
local spamRemotes = {}  -- Filled by spy
addSpam.MouseButton1Click:Connect(function()
    -- Spam all spied
    for _, remote in pairs(spiedRemotes) do
        pcall(function()
            remote:FireServer(math.huge)  -- Overflow time bitch
        end)
    end
    if ptVal then ptVal.Value = ptVal.Value + 60 end
    status.Text = "SPAMMED +60 MINS SERVER-SIDE 🚀"
end)

subSpam.MouseButton1Click:Connect(function()
    for _, remote in pairs(spiedRemotes) do
        pcall(function() remote:FireServer(0) end)
    end
    if ptVal then ptVal.Value = 0 end
    status.Text = "RESET SERVER TIME TO 0 💀"
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

print("Server PlayTime Nuker LOADED for " .. username .. " - Spy Active! 👑")
status.Text = "FULLY ARMED - Play & Watch Remotes Pop 😈🔥"
