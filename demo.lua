-- NexusRec.netlify.app öffnen (indirekt über Zwischenablage + Hinweis)

local url = "https://nexusrec.netlify.app/"

-- URL in Zwischenablage kopieren (funktioniert in Krnl, Fluxus, Synapse, etc.)
setclipboard(url)

-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 100, 100)
Frame.Size = UDim2.new(0, 350, 0, 180)
Frame.Position = UDim2.new(0.5, -175, 0.5, -90)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1
TextLabel.Size = UDim2.new(1, 0, 0, 60)
TextLabel.Position = UDim2.new(0, 0, 0, 10)
TextLabel.Text = "NexusRec wird geöffnet..."
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 18

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Position = UDim2.new(0.5, -100, 1, -70)
TextButton.Text = "Link in Zwischenablage!"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.Font = Enum.Font.GothamBold
TextButton.TextSize = 16

-- Hinweis anzeigen
spawn(function()
    wait(1)
    TextLabel.Text = "Link kopiert!\nDrücke STRG+V in deinem Browser"
    
    -- 5 Sekunden warten, dann GUI schließen
    wait(5)
    ScreenGui:Destroy()
end)
