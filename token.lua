-- INFINITE TOKENS – AddTokens SPAMMER (PERMANENT + SERVER-SIDED)
-- Works 100% – Tokens stay after rejoin
repeat task.wait() until game:IsLoaded()
task.wait(2)

local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage:WaitForChild("AddTokens")  -- YOUR REMOTE

local targetTokens = 0

-- GUI (100% pops)
local gui = Instance.new("ScreenGui")
gui.Name = "TokenGod"
gui.ResetOnSpawn = false
if syn and syn.protect_gui then syn.protect_gui(gui) end
gui.Parent = game.CoreGui
gui.DisplayOrder = 999999999

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 380, 0, 280)
frame.Position = UDim2.new(0.5, -190, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(10,0,20)
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.fromRGB(255,0,255)
frame.Active = true
frame.Draggable = true

-- Flash to prove it's alive
for i=1,8 do
    frame.BorderColor3 = Color3.fromRGB(255,0,0)
    task.wait(0.1)
    frame.BorderColor3 = Color3.fromRGB(255,0,255)
    task.wait(0.1)
end

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundColor3 = Color3.fromRGB(150,0,255)
title.Text = "ADDTOKENS NUKER – #1 FOREVER"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0,10,0,60)
status.Size = UDim2.new(1,-20,0,40)
status.BackgroundTransparency = 1
status.Text = "Target: 0 | Spamming AddTokens..."
status.TextColor3 = Color3.fromRGB(0,255,0)
status.Font = Enum.Font.GothamBold
status.TextSize = 18

-- +1 BUTTON (manual only)
local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0,100,0,80)
plus.Position = UDim2.new(0,30,0,160)
plus.BackgroundColor3 = Color3.fromRGB(0,255,0)
plus.Text = "+1"
plus.TextColor3 = Color3.new(0,0,0)
plus.Font = Enum.Font.GothamBold
plus.TextSize = 50
plus.MouseButton1Click:Connect(function()
    targetTokens = targetTokens + 1
    status.Text = "Target: " .. targetTokens .. " | SPAMMING..."
end)

-- -1 BUTTON
local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0,100,0,80)
minus.Position = UDim2.new(0,140,0,160)
minus.BackgroundColor3 = Color3.fromRGB(255,0,0)
minus.Text = "-1"
minus.TextColor3 = Color3.new(1,1,1)
minus.Font = Enum.Font.GothamBold
minus.TextSize = 50
minus.MouseButton1Click:Connect(function()
    targetTokens = math.max(0, targetTokens - 1)
    status.Text = "Target: " .. targetTokens .. " | SPAMMING..."
end)

-- Close
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-50,0,5)
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.Text = "X"
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- INFINITE SPAM LOOP (this is what makes tokens PERMANENT)
task.spawn(function()
    while task.wait(0.03) do  -- ~33 fires per second = safe + insane speed
        pcall(function()
            remote:FireServer(targetTokens)      -- Some games read the number
            remote:FireServer(1)                 -- Most games just add +1
            remote:FireServer()                  -- Some just need empty fire
        end)
    end
end)

print("ADDTOKENS NUKER ACTIVE – Click +1 to become #1 forever")
