-- Website öffnen über Zwischenablage + Hinweis (für Delta Executor)

local url = "https://nexusrec.netlify.app/"

-- URL in Zwischenablage kopieren
setclipboard(url)

-- GUI erstellen
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local label = Instance.new("TextLabel")
local button = Instance.new("TextButton")

gui.Parent = game:GetService("CoreGui")
gui.ResetOnSpawn = false

frame.Parent = gui
frame.Size = UDim2.new(0, 320, 0, 140)
frame.Position = UDim2.new(0.5, -160, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 50, 50)
frame.Active = true
frame.Draggable = true

label.Parent = frame
label.Size = UDim2.new(1, 0, 0, 60)
label.Position = UDim2.new(0, 0, 0, 10)
label.BackgroundTransparency = 1
label.Text = "NexusRec wird geöffnet..."
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.GothamBold
label.TextSize = 18

button.Parent = frame
button.Size = UDim2.new(0, 200, 0, 40)
button.Position = UDim2.new(0.5, -100, 1, -55)
button.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
button.Text = "Link kopiert!"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 16

-- Hinweis nach 1 Sekunde
wait(1)
label.Text = "Link in Zwischenablage!\nÖffne Browser → STRG+V"

-- Auto-Schließen nach 5 Sekunden
delay(5, function()
    gui:Destroy()
end)
