-- Fixed PlayTime Editor v2 - Delta-Proof 💉😈
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local username = player.Name

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayTimeFuckery"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
title.Text = "PlayTime Editor - " .. username .. " 👑"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 140)
status.BackgroundTransparency = 1
status.Text = "Loaded - Ready to Grind 😈"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextWrapped = true
status.Parent = frame

-- Add Button
local addBtn = Instance.new("TextButton")
addBtn.Size = UDim2.new(0, 130, 0, 40)
addBtn.Position = UDim2.new(0, 20, 0, 70)
addBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
addBtn.Text = "+1 Minute ⬆️"
addBtn.TextColor3 = Color3.new(1, 1, 1)
addBtn.Font = Enum.Font.GothamBold
addBtn.TextSize = 16
addBtn.Parent = frame

local addCorner = Instance.new("UICorner")
addCorner.CornerRadius = UDim.new(0, 6)
addCorner.Parent = addBtn

-- Sub Button
local subBtn = Instance.new("TextButton")
subBtn.Size = UDim2.new(0, 130, 0, 40)
subBtn.Position = UDim2.new(0, 150, 0, 70)
subBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
subBtn.Text = "-1 Minute ⬇️"
subBtn.TextColor3 = Color3.new(1, 1, 1)
subBtn.Font = Enum.Font.GothamBold
subBtn.TextSize = 16
subBtn.Parent = frame

local subCorner = Instance.new("UICorner")
subCorner.CornerRadius = UDim.new(0, 6)
subCorner.Parent = subBtn

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeBtn

-- Function to Find PlayTime
local function findPlayTime()
    local candidates = {
        player:FindFirstChild("PlayTime"),
        Players:FindFirstChild(username):FindFirstChild("PlayTime"),
        player:WaitForChild("leaderstats", 5) and player.leaderstats:FindFirstChild("PlayTime"),
        workspace:FindFirstChild(username) and workspace[username]:FindFirstChild("PlayTime")
    }
    for _, val in ipairs(candidates) do
        if val and (val:IsA("IntValue") or val:IsA("NumberValue")) then
            return val
        end
    end
    return nil
end

local playTimeValue = findPlayTime()

if not playTimeValue then
    status.Text = "PlayTime Value Not Found - Check Game Folder 🤡"
    status.TextColor3 = Color3.fromRGB(255, 0, 0)
else
    status.Text = "Found PlayTime: " .. playTimeValue.Value .. " mins | Locked & Loaded 🔥"
end

-- Events
addBtn.MouseButton1Click:Connect(function()
    if playTimeValue then
        playTimeValue.Value = playTimeValue.Value + 1
        status.Text = "Added 1 Min | Total: " .. playTimeValue.Value .. " 💥"
        status.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        status.Text = "No Value Found, Fix Your Shit 😤"
        status.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

subBtn.MouseButton1Click:Connect(function()
    if playTimeValue then
        playTimeValue.Value = math.max(0, playTimeValue.Value - 1)
        status.Text = "Subbed 1 Min | Total: " .. playTimeValue.Value .. " 💀"
        status.TextColor3 = Color3.fromRGB(255, 255, 0)
    else
        status.Text = "No Value Found, Fix Your Shit 😤"
        status.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("GUI Nuked - Come Back Anytime Bitch 👋")
end)

print("PlayTime GUI Loaded for " .. username .. " - Delta Approved! 🚀")
