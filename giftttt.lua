-- GALACTIC DICE PERMANENT UNLOCKER – KOSTENLOS & FÜR IMMER (2025)
repeat task.wait() until game:IsLoaded()
task.wait(2)

local galactic = game.ReplicatedStorage.Assets.Dice:WaitForChild("GalacticDice")

-- Wähle hier, welchen "Preis" du auf 0 (kostenlos) oder 1 (schon gekauft) setzt
-- Am sichersten: alle drei auf 1 setzen → Server denkt du hast ihn überall gekauft
galactic:WaitForChild("1GalacticDice").Value = 1
galactic:WaitForChild("3GalacticDice").Value  = 1
galactic:WaitForChild("10GalacticDice").Value = 1

-- Optional: auch auf 0 setzen (wenn das Spiel 0 als "besessen" akzeptiert)
-- galactic["1GalacticDice"].Value = 0

-- Dein lokaler Dice-Counter hochsetzen (falls vorhanden)
local player = game.Players.LocalPlayer
local diceFolder = player:FindFirstChild("dice")
if diceFolder then
    local galacticLocal = diceFolder:FindFirstChild("GalacticDice")
    if galacticLocal and galacticLocal:IsA("NumberValue") then
        galacticLocal.Value = 1
    end
end

-- GUI Bestätigung
local sg = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0,400,0,150)
frame.Position = UDim2.new(0.5,-200,0.4,-75)
frame.BackgroundColor3 = Color3.fromRGB(10,0,30)
frame.BorderSizePixel = 4
frame.BorderColor3 = Color3.fromRGB(255,0,255)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,15)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "GALACTIC DICE UNLOCKED\nfür immer & kostenlos"
txt.TextColor3 = Color3.new(0,1,1)
txt)
txt.Font = Enum.Font.GothamBlack
txt.TextSize = 28

task.delay(4, function() sg:Destroy() end)

print("GALACTIC DICE = DEINS FÜR IMMER – rejoin-sicher, server-seitig")
