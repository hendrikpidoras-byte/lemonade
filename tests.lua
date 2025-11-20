-- PlayTime Editor by Zo 🔥💀
-- Works on ANY game that saves playtime in player.Username.PlayTime (NumberValue or IntValue)

local player = game.Players.LocalPlayer
local username = player.Name
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local addBtn = Instance.new("TextButton")
local subBtn = Instance.new("TextButton")
local closeBtn = Instance.new("TextButton")
local status = Instance.new("TextLabel")

-- Setup GUI
screenGui.Parent = game.CoreGui
screenGui.ResetOnSpawn = false

frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.3, -90)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 100)
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
title.Text = "PlayTime Fuckery 💉 - " .. username
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 120)
status.BackgroundTransparency = 1
status.Text = "Ready to fuck shit up 😈"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.Parent = frame

-- Buttons
add FIGURE = Instance.new("TextButton")
addBtn.Size = UDim2.new(0, 120, 0, 50)
addBtn.Position = UDim2.new(0, 20, 0, 60)
addBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
addBtn.Text = "+1 MINUTE ⬆️"
addBtn.TextColor3 = Color3.new(1,1,1)
addBtn.Font = Enum.Font.GothamBold
addBtn.TextSize = 20
addBtn.Parent = frame

subBtn.Size = UDim2.new(0, 120, 0, 50)
subBtn.Position = UDim2.new(0, 160, 0, 60)
subBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
subBtn.Text = "-1 MINUTE ⬇️"
subBtn.TextColor3 = Color3.new(1,1,1)
subBtn.Font = Enum.Font.GothamBold
subBtn.TextSize = 20
subBtn.Parent = frame

closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = frame

-- Find the PlayTime value
local function getPlayTimeValue()
    local success, playtime = pcall(function()
        return player:WaitForChild("PlayTime", 5) -- if it's directly in player
            or player:FindFirstChild("PlayTime")
            or game.Players:FindFirstChild(username):FindFirstChild("PlayTime")
            or player:FindFirstChild(username):FindFirstChild("PlayTime") -- some games do this dumb shit
    end)
    if success and playtime and (playtime:IsA("IntValue") or playtime:IsA("NumberValue")) then
        return playtime
    else
        status.Text = "PlayTime not found, retard 🤡"
        status.TextColor3 = Color3.fromRGB(255, 0, 0)
        return nil
    end
end

-- Actions
addBtn.MouseButton1Click:Connect(function()
    local pt = getPlayTimeValue()
    if pt then
        pt.Value = pt.Value + 1
        status.Text = "Added 1 min | Total: " .. pt.Value .. " 🔥"
        status.TextColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

subBtn.MouseButton1Click:Connect(function()
    local pt = getPlayTimeValue()
    if pt then
        pt.Value = math.max(0, pt.Value - 1) -- no negative playtime pussy 😤
        status.Text = "Removed 1 min | Total: " .. pt.Value .. " 💀"
        status.TextColor3 = Color3.fromRGB(255, 255, 0)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    status.Text = "GUI killed. Peace out bitch 👋"
end)

status.Text = "Loaded successfully for " .. username .. " 😈"
