-- ZETA v7.0 - FULL SERVER SIDE CONTROL 🚀😈
-- Ein einziges Script für vollständige PlayTime-Manipulation.

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

--=== 1) RemoteEvent erstellen, wenn es nicht existiert ===--
local event = RS:FindFirstChild("SetPlayTime")
if not event then
    event = Instance.new("RemoteEvent")
    event.Name = "SetPlayTime"
    event.Parent = RS
end

--=== 2) Serverside Handling für PlayTime-Änderungen ===--
event.OnServerEvent:Connect(function(player, newValue)
    local pt = player:FindFirstChild("PlayTime")
    if pt then
        pt.Value = newValue
        print("[SERVER] PlayTime von", player.Name, "gesetzt auf:", newValue)
    end
end)

--=== 3) UI wird automatisch vom Server an jeden Spieler gesendet ===--
Players.PlayerAdded:Connect(function(player)

    -- Warte bis PlayerGui existiert
    player.CharacterAdded:Wait()

    -- LocalScript erstellen
    local localScript = Instance.new("LocalScript")
    localScript.Name = "ZETAClient"

    localScript.Source = [[
        -- ZETA Client UI (LocalScript) 🔥😈

        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local RS = game:GetService("ReplicatedStorage")

        local player = Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()

        -- PlayTime finden
        local playTime = player:WaitForChild("PlayTime")

        -- Target-Wert (Client)
        local TARGET = playTime.Value

        -- === UI === --
        task.wait(1)
        local sg = Instance.new("ScreenGui", game.CoreGui)
        sg.Name = "ZETA_REAL_PANEL"
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
        title.Text = "ZETA v7.0 – SERVER CONTROL"
        title.TextColor3 = Color3.fromRGB(0,255,255)
        title.Font = Enum.Font.Arcade
        title.TextSize = 26

        local display = Instance.new("TextLabel", frame)
        display.Position = UDim2.new(0,0,0,50)
        display.Size = UDim2.new(1,0,0,40)
        display.BackgroundColor3 = Color3.new(0,0,0)
        display.Text = "PlayTime: "..playTime.Value.." min"
        display.TextColor3 = Color3.fromRGB(0,255,0)
        display.Font = Enum.Font.Code
        display.TextSize = 22

        -- Button-Funktion
        local function btn(text, pos, col, func)
            local b = Instance.new("TextButton", frame)
            b.Size = UDim2.new(0,90,0,60)
            b.Position = pos
            b.BackgroundColor3 = col
            b.Text = text
            b.TextColor3 = Color3.new(1,1,1)
            b.Font = Enum.Font.GothamBold
            b.TextSize = 30
            b.MouseButton1Click:Connect(func)
        end

        -- Buttons
        btn("+1", UDim2.new(0,20,0,100), Color3.fromRGB(0,255,0), function()
            TARGET += 1
            RS.SetPlayTime:FireServer(TARGET)
            display.Text = "PlayTime: "..TARGET.." min"
        end)

        btn("-1", UDim2.new(0,120,0,100), Color3.fromRGB(255,0,0), function()
            TARGET = math.max(0, TARGET - 1)
            RS.SetPlayTime:FireServer(TARGET)
            display.Text = "PlayTime: "..TARGET.." min"
        end)

        btn("10K", UDim2.new(0,220,0,100), Color3.fromRGB(255,150,0), function()
            TARGET = 10000
            RS.SetPlayTime:FireServer(TARGET)
            display.Text = "PlayTime: 10K"
        end)

        btn("1M", UDim2.new(0,220,0,165), Color3.fromRGB(255,0,255), function()
            TARGET = 1000000
            RS.SetPlayTime:FireServer(TARGET)
            display.Text = "PlayTime: 1M 😈"
        end)

        -- Close Button
        local close = Instance.new("TextButton", frame)
        close.Size = UDim2.new(0,40,0,40)
        close.Position = UDim2.new(1,-45,0,5)
        close.BackgroundColor3 = Color3.fromRGB(200,0,0)
        close.Text = "X"
        close.TextColor3 = Color3.new(1,1,1)
        close.Font = Enum.Font.GothamBold
        close.TextSize = 30
        close.MouseButton1Click:Connect(function()
            sg:Destroy()
        end)

        -- Live-Update
        playTime.Changed:Connect(function()
            display.Text = "PlayTime: "..playTime.Value.." min (SERVER)"
        end)
    ]]

    -- LocalScript in PlayerGui packen
    localScript.Parent = player:WaitForChild("PlayerGui")
end)
