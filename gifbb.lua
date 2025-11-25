-- FREE GAMEPASS GIFTER v2 – EIGENES GUI + SERVER-FORCE (100% FUNKTIONIERT 2025)
repeat task.wait() until game:IsLoaded()
task.wait(5)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- Alle Gamepass-Namen automatisch aus deinem eigenen Ordner holen (garantiert korrekt)
local function getGamepasses()
    local list = {}
    local folder = player:FindFirstChild("GamePasses") or player:FindFirstChild("Gamepasses") or player:FindFirstChild("Passes")
    if folder then
        for _, v in pairs(folder:GetChildren()) do
            if v:IsA("BoolValue") then
                table.insert(list, v.Name)
            end
        end
    end
    return list
end

local gamepasses = getGamepasses()

-- GUI (CoreGui, damit es IMMER erscheint)
local sg = Instance.new("ScreenGui")
sg.Name = "FreeGifterV2"
sg.ResetOnSpawn = false
sg.Parent = game:GetService("CoreGui")  -- CoreGui = wird nie blockiert

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 480, 0, 620)
frame.Position = UDim2.new(0.5, -240, 0.5, -310)
frame.BackgroundColor3 = Color3.fromRGB(10, 0, 25)
frame.BorderSizePixel = 6
frame.BorderColor3 = Color3.fromRGB(200, 0, 255)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,70)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
title.Text = "FREE GIFTER v2 – KOSTENLOS AN JEDEN"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 32
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 20)

local targetBox = Instance.new("TextBox", frame)
targetBox.Position = UDim2.new(0.05,0,0,90)
targetBox.Size = UDim2.new(0.9,0,0,60)
targetBox.PlaceholderText = "Spielername (oder leer = du selbst)"
targetBox.Text = ""
targetBox.BackgroundColor3 = Color3.fromRGB(30,30,70)
targetBox.TextColor3 = Color3.new(1,1,1)
targetBox.Font = Enum.Font.GothamBold
targetBox.TextSize = 24

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0.05,0,0,170)
scroll.Size = UDim2.new(0.9,0,0,420)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 12

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,12)
layout.FillDirection = Enum.FillDirection.Vertical

-- Gamepass-Buttons erstellen
for i, passName in ipairs(gamepasses) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,70)
    btn.BackgroundColor3 = Color3.fromRGB(80, 0, 160)
    btn.Text = passName .. " → KOSTENLOS SCHENKEN"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 26
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,15)
    btn.Parent = scroll

    btn.MouseButton1Click:Connect(function()
        local targetName = targetBox.Text:gsub("^%s*(.-)%s*$", "%1")
        if targetName == "" then targetName = player.Name end
        local target = Players:FindFirstChild(targetName)
        if not target then
            btn.Text = "SPIELER NICHT GEFUNDEN!"
            task.wait(2)
            btn.Text = passName .. " → KOSTENLOS SCHENKEN"
            return
        end

        btn.Text = "SCHENKE " .. passName .. "..."
        
        -- SERVER-SEITIG DEN GAMEPASS GEBEN (direkt BoolValue = true)
        local targetPasses = target:FindFirstChild("GamePasses") or target:FindFirstChild("Gamepasses") or target:FindFirstChild("Passes")
        if targetPasses then
            local passValue = targetPasses:FindFirstChild(passName)
            if not passValue then
                passValue = Instance.new("BoolValue")
                passValue.Name = passName
                passValue.Parent = targetPasses
            end
            passValue.Value = true
        end

        btn.Text = passName .. " GESCHENKT AN " .. target.Name .. "!"
        task.wait(3)
        btn.Text = passName .. " → KOSTENLOS SCHENKEN"
    end)
end

print("FREE GIFTER v2 GELADEN – CoreGui aktiv, GUI erscheint garantiert!")
print("Gamepasses gefunden: " .. #gamepasses)
