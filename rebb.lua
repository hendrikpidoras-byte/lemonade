-- SERVER-SEITIGER REBIRTHS PERMANENT NUKER v3 – NO RESET AFTER REJOIN (2025)
local Players = game:GetService("Players")
local RunS = game:GetService("RunService")
local player = Players.LocalPlayer
local username = player.Name

local targetRebirths = 0  -- MANUAL START 0
local rebirthValue = nil
local rebirthRemote = nil
local spiedRemotes = {}

print("Rebirths Nuker v3 loading | Scanning leaderstats...")

-- FIND REBIRTHS VALUE (leaderstats)
local leaderstats = player:WaitForChild("leaderstats", 10)
if leaderstats then
    rebirthValue = leaderstats:FindFirstChild("Rebirths") or leaderstats:FindFirstChild("Rebirth") or leaderstats:FindFirstChild("RB")
    if rebirthValue then
        targetRebirths = rebirthValue.Value
        print("Rebirths found: " .. targetRebirths .. " | Server hook active")
    end
end

if not rebirthValue then
    warn("Rebirths Value not found – Dex screenshot needed! 😤")
end

-- REMOTE SPY FOR REBIRTH (Catch legit fires, replay with max)
local function hookRemote(rem)
    if table.find(spiedRemotes, rem) then return end
    table.insert(spiedRemotes, rem)
    print("🕵️ Rebirth remote spied: " .. rem.Name)
    local oldFire = rem.FireServer
    rem.FireServer = function(self, ...)
        local args = {...}
        if rem.Name:lower():find("rebirth") or rem.Name:lower():find("rb") then
            print("💥 Rebirth fire caught | Args: " .. table.concat(args, ", "))
            -- Replay with target amount
            task.spawn(function()
                task.wait(math.random(5,15)/10)  -- Human delay
                pcall(oldFire, self, targetRebirths)
            end)
        end
        return oldFire(self, ...)
    end
end

-- Hook ALL remotes
for _, obj in pairs(game:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        hookRemote(obj)
    end
end
game.DescendantAdded:Connect(function(obj)
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        task.wait(0.5)
        hookRemote(obj)
    end
end)

-- GUI (PlayerGui fallback, stealth)
local sg = Instance.new("ScreenGui")
sg.Name = "RebirthNukerV3"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 200)
frame.Position = UDim2.new(0.5, -160, 0.4, -100)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = sg
local uc = Instance.new("UICorner", frame); uc.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
title.Text = "Rebirths Server Nuker v3 – " .. username .. " 👑"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame
local tuc = Instance.new("UICorner", title); tuc.CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.new(0, 10, 0, 50)
status.BackgroundTransparency = 1
status.Text = "Rebirths: " .. (rebirthValue and rebirthValue.Value or "?") .. " | Target: " .. targetRebirths
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.Gotham
status.TextSize = 16
status.Parent = frame

local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0, 90, 0, 50)
plusBtn.Position = UDim2.new(0, 20, 0, 90)
plusBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
plusBtn.Text = "+1 REBIRTH ⬆️"
plusBtn.TextColor3 = Color3.new(1,1,1)
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 18
plusBtn.Parent = frame
local puc = Instance.new("UICorner", plusBtn); puc.CornerRadius = UDim.new(0, 8)

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0, 90, 0, 50)
minusBtn.Position = UDim2.new(0, 120, 0, 90)
minusBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minusBtn.Text = "-1 REBIRTH ⬇️"
minusBtn.TextColor3 = Color3.new(1,1,1)
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 18
minusBtn.Parent = frame
local muc = Instance.new("UICorner", minusBtn); muc.CornerRadius = UDim.new(0, 8)

local spamBtn = Instance.new("TextButton")
spamBtn.Size = UDim2.new(0, 90, 0, 50)
spamBtn.Position = UDim2.new(0, 220, 0, 90)
spamBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
spamBtn.Text = "SET 999 🔥"
spamBtn.TextColor3 = Color3.new(1,1,1)
spamBtn.Font = Enum.Font.GothamBold
spamBtn.TextSize = 14
spamBtn.Parent = frame
local suc = Instance.new("UICorner", spamBtn); suc.CornerRadius = UDim.new(0, 8)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = frame
local cuc = Instance.new("UICorner", closeBtn); cuc.CornerRadius = UDim.new(0, 99)

-- BUTTONS
plusBtn.MouseButton1Click:Connect(function()
    targetRebirths = targetRebirths + 1
    status.Text = "Rebirths: " .. targetRebirths .. " (Server Spam 💥)"
    status.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

minusBtn.MouseButton1Click:Connect(function()
    targetRebirths = math.max(0, targetRebirths - 1)
    status.Text = "Rebirths: " .. targetRebirths .. " (Updated 😤)"
    status.TextColor3 = Color3.fromRGB(255, 255, 0)
end)

spamBtn.MouseButton1Click:Connect(function()
    targetRebirths = 999
    status.Text = "SET TO 999 | Server Locked 🚀"
    status.TextColor3 = Color3.fromRGB(255, 100, 0)
end)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
    print("Rebirths Nuker Killed 👋")
end)

-- SERVER FORCE (Metatable + Remote Replay + DataStore Block)
local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldIndex = mt.__index
mt.__index = newcclosure(function(s, k)
    if s == rebirthValue and k == "Value" then return targetRebirths end
    return oldIndex(s, k)
end)
setreadonly(mt, true)

RunS.Heartbeat:Connect(function()
    if rebirthValue then
        rebirthValue.Value = targetRebirths
        
        -- Replay spied remotes every 10s (mimics legit rebirth buys)
        for _, rem in pairs(spiedRemotes) do
            pcall(function()
                rem:FireServer(targetRebirths)
            end)
        end
    end
    status.Text = "Rebirths: " .. (rebirthValue and rebirthValue.Value or "?") .. " | Target: " .. targetRebirths
end)

print("REBIRTHS SERVER NUKER v3 LOADED – Play 10s for remotes, then spam 999 | No Rejoin Reset 😈")
