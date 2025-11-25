-- FIXED GALACTIC DICE CASH NUKER v2 – HOOK REQUIRE (SERVER-SIDED 2025)
repeat task.wait() until game:IsLoaded()
task.wait(3)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local galacticPath = ReplicatedStorage.Assets.Dice:WaitForChild("GalacticDice")

-- ORIGINAL MODUL HOOKEN (ersetzt frozen table)
local oldRequire = require
local newConfig = {
    Rarity = "Common";
    BaseCash = 9999999;  -- DEIN WERT HIER ÄNDERN (z.B. 10000000)
    SellValue = 999999999;  -- Optional max
    WeightChance = 28333320;
    ViewportOffset = CFrame.new(0, 0, -7) * CFrame.Angles(0, math.pi, 0);
}

-- Hook require für diesen Pfad
local hooked = hookfunction(oldRequire, function(module)
    if module == galacticPath then
        return table.freeze(newConfig)  -- Neue gefrozene Tabelle zurückgeben
    end
    return oldRequire(module)
end)

-- Force reload (server repliziert)
galacticPath:Destroy()
task.wait(1)
-- Modul wird neu geladen mit hooked values

print("GALACTIC DICE FIXED – BaseCash: " .. newConfig.BaseCash .. " (SERVER-SIDED)")
print("Nächster Drop = " .. newConfig.BaseCash .. " Cash | Rejoin test: neu laden")
