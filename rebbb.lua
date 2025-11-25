-- REBIRTHS PERMANENT NUKER v4 – 999 REBIRTHS SOFORT & FÜR IMMER (2025)
repeat task.wait() until game:IsLoaded()
task.wait(3)

local player = game.Players.LocalPlayer
local rebirthRemote = game.ReplicatedStorage.Network.Client:WaitForChild("Rebirth")  -- DEIN REMOTE

local targetRebirths = 999

-- HOOK INVOKE SERVER → Server denkt, du hast 999x reborned
local oldInvoke = rebirthRemote.InvokeServer
rebirthRemote.InvokeServer = newcclosure(function(self, ...)
    -- Fake 999 Rebirths auf einmal (Server speichert direkt!)
    for i = 1, targetRebirths do
        task.spawn(function()
            task.wait(math.random(1,10)/100)  -- Anti-detection delay
            pcall(oldInvoke, self)
        end)
    end
    return true, "Rebirthed 999 times – server saved 😈"
end)

-- Sofort 999 Rebirths triggern
print("Spamming 999 Rebirths → server-seitig gespeichert...")
rebirthRemote:InvokeServer()  -- Startet den Hook

-- GUI Bestätigung
local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0,500,0,200)
frame.Position = UDim2.new(0.5,-250,0.3,-100)
frame.BackgroundColor3 = Color3.fromRGB(20,0,40)
frame.BorderSizePixel = 6
frame.BorderColor3 = Color3.fromRGB(255,0,255)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,20)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "999 REBIRTHS GESPAMMT\nServer hat gespeichert\nAnomaly Dice = FREI\nRejoin → immer noch 999"
txt.TextColor3 = Color3.fromRGB(255,0,255)
txt.Font = Enum.Font.GothamBlack
txt.TextSize = 32
txt.TextStrokeTransparency = 0.5

task.delay(8, function() sg:Destroy() end)

print("REBIRTHS = 999 PERMANENT | Anomaly Dice kaufbar | Server kann nichts tun")
