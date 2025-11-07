-- Fake Key System GUI für Delta Executor
-- Get Key → Kopiert Link
-- Check Key → Immer "Invalid Key"

local url = "https://nexusrec.netlify.app/"

-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KeyBox = Instance.new("TextBox")
local CheckButton = Instance.new("TextButton")
local GetKeyButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- Parent
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Main Frame
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Size = UDim2.new(0, 380, 0, 220)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -110)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "🔐 NexusRec Key System"
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

-- Key Input Box
KeyBox.Parent = MainFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
KeyBox.BorderSizePixel = 1
KeyBox.BorderColor3 = Color3.fromRGB(80, 80, 90)
KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Font = Enum.Font.Code
KeyBox.TextSize = 16

-- Check Key Button
CheckButton.Parent = MainFrame
CheckButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CheckButton.Size = UDim2.new(0.4, 0, 0, 45)
CheckButton.Position = UDim2.new(0.55, 0, 0.65, 0)
CheckButton.Text = "Check Key"
CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckButton.Font = Enum.Font.GothamBold
CheckButton.TextSize = 16

-- Get Key Button
GetKeyButton.Parent = MainFrame
GetKeyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
GetKeyButton.Size = UDim2.new(0.4, 0, 0, 45)
GetKeyButton.Position = UDim2.new(0.05, 0, 0.65, 0)
GetKeyButton.Text = "Get Key"
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 16

-- Status Label
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.88, 0)
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 16

-- Button Effekte
local function hoverEffect(btn, hoverColor, normalColor)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = hoverColor
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = normalColor
    end)
end

hoverEffect(CheckButton, Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 80, 80))
hoverEffect(GetKeyButton, Color3.fromRGB(50, 100, 255), Color3.fromRGB(70, 130, 255))

-- Get Key Button → Kopiert Link
GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard(url)
    StatusLabel.Text = "✅ Link copied to clipboard!"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    -- 3 Sekunden anzeigen
    delay(3, function()
        if StatusLabel and StatusLabel.Parent then
            StatusLabel.Text = ""
        end
    end)
end)

-- Check Key Button → IMMER Invalid
CheckButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "❌ Invalid Key"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    
    -- 3 Sekunden anzeigen
    delay(3, function()
        if StatusLabel and StatusLabel.Parent then
            StatusLabel.Text = ""
        end
    end)
end)

-- Optional: Schließen mit Rechtsklick auf Frame
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        ScreenGui:Destroy()
    end
end)
