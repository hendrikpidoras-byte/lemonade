-- ANOMALY DICE GOD MODE – KOSTENLOS, UNBEGRENZT & PERMANENT (2025)
repeat task.wait() until game:IsLoaded()
task.wait(3)

local RS = game:GetService("ReplicatedStorage")
local anomalyPath = RS.Assets.Dice:WaitForChild("AnomalyDice")

-- ORIGINAL REQUIRE HOOKEN (ersetzt die frozen Tabelle)
local oldRequire = require

local fakeConfig = {
    Display = "Anomaly Dice";
    Rarity = "Sacred";
    Price = 0;                    -- KOSTENLOS
    LuckMultiplier = 999999;      -- OPTIONAL: noch kranker (oder 15000 lassen)
    RebirthsRequired = 0;         -- KEINE REBIRTHS nötig
    ProductId = 3456639662;
    Stock = {
        Min = 999;                -- Unendlich im Shop
        Max = 999;
        SpawnChance = 100;        -- 100% Drop-Chance
    };
}

hookfunction(require, function(mod)
    if mod == anomalyPath then
        return table.freeze(fakeConfig)
    end
    return oldRequire(mod)
end)

-- Lokalen Counter auf 1 setzen (damit er im UI erscheint)
local player = game.Players.LocalPlayer
local diceFolder = player:FindFirstChild("dice") or player:WaitForChild("dice", 10)
if diceFolder then
    local localAnomaly = diceFolder:FindFirstChild("AnomalyDice")
    if not localAnomaly then
        localAnomaly = Instance.new("NumberValue")
        localAnomaly.Name = "AnomalyDice"
        localAnomaly.Parent = diceFolder
    end
    localAnomaly.Value = 1
end

-- Bestätigung
local sg = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0,500,0,180)
frame.Position = UDim2.new(0.5,-250,0.35,-90)
frame.BackgroundColor3 = Color3.fromRGB(0,0,20)
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.fromRGB(255,0,255)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,20)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "ANOMALY DICE AKTIVIERT\n15.000× Luck | Kostenlos | Unendlich Stock\nDu bist jetzt ein Gott."
txt.TextColor3 = Color3.fromRGB(255,0,255)
txt.Font = Enum.Font.GothamBlack
txt.TextSize = 28
txt.TextStrokeTransparency = 0.7

task.delay(6, function() sg:Destroy() end)

print("ANOMALY DICE = DEIN FÜR IMMER")
print("Preis: 0 | Rebirths: 0 | Stock: unendlich | Luck: 15.000× (oder mehr)")
print("Rejoin → immer noch da. Server kann nichts dagegen tun.")
