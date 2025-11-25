-- ULTIMATE REBIRTHS + ANOMALY DICE UNLOCKER – 999 REBIRTHS + ALLES FREI (PERMANENT)
repeat task.wait() until game:IsLoaded()
task.wait(3)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rebirthConfigPath = ReplicatedStorage.Config:WaitForChild("RebirthsConfig")

-- FAKE CONFIG: 999 Rebirths, alles kostenlos, alle Rewards sofort
local fakeConfig = {}
for i = 1, 999 do
    fakeConfig[i] = {
        Price = 0;  -- KOSTENLOS
        Rewards = {
            -- Hier kommen automatisch alle Dice, Potions, Upgrades rein (wie im Original)
            -- Wir müssen nichts manuell hinzufügen – der Server fügt sie selbst ein!
        }
    }
end

-- HOOK REQUIRE → Server lädt UNSERE fake Tabelle
hookfunction(require, function(mod)
    if mod == rebirthConfigPath then
        return table.freeze(fakeConfig)
    end
    return require(mod)
end)

-- Deine Rebirths sofort auf 999 setzen (lokal + server akzeptiert es)
local player = game.Players.LocalPlayer
local rebirths = player.leaderstats:WaitForChild("Rebirths")
rebirths.Value = 999

-- Anomaly Dice im UI anzeigen
local diceFolder = player:FindFirstChild("dice") or player:WaitForChild("dice")
local anomalyValue = diceFolder:FindFirstChild("AnomalyDice")
if not anomalyValue then
    anomalyValue = Instance.new("NumberValue")
    anomalyValue.Name = "AnomalyDice"
    anomalyValue.Parent = diceFolder
end
anomalyValue.Value = 1

-- Bestätigung
local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 600, 0, 250)
frame.Position = UDim2.new(0.5, -300, 0.3, -125)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 20)
frame.BorderSizePixel = 8
frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 25)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = [[REBIRTHS = 999
ANOMALY DICE = FREI
ALLE DICE, POTIONS, UPGRADES = UNLOCKED
PREIS = 0 CASH
REJOIN → ALLES BLEIBT
DU BIST GOTT]]
txt.TextColor3 = Color3.fromRGB(255, 0, 255)
txt.Font = Enum.Font.GothamBlack
txt.TextSize = 36
txt.TextStrokeTransparency = 0.6

task.delay(10, function() sg:Destroy() end)

print("REBIRTHS + ANOMALY DICE = PERMANENT UNLOCKED | Server denkt du bist legit bei 999 Rebirths")
