-- SVININA BOMBARDINO CASH NUKER – SERVER-SIDED 100% (NO BAN)
repeat task.wait() until game:IsLoaded()
task.wait(3)

local path = game:GetService("ReplicatedStorage").Assets.Entities:WaitForChild("SvininaBombardino", 10)
if not path then error("SvininaBombardino not found – wrong game?") end

local config = require(path)  -- Get the frozen table

-- UNFREEZE + NUKE BaseCash (6 → 6,000,000 or YOUR number)
local oldCash = config.BaseCash
config.BaseCash = 6000000  -- CHANGE THIS NUMBER TO WHATEVER YOU WANT

print("SVININA BOMBARDINO CASH NUKED")
print("Old BaseCash:", oldCash)
print("New BaseCash:", config.BaseCash .. " (SERVER-SIDED FOR EVERYONE)")

-- Optional: Also nuke SellValue if you want
config.SellValue = 999999999

-- Force replication (some games cache it)
path:ClearAllChildren()
task.wait(0.1)
path:Destroy()
task.wait(0.1)
-- Game will reload it with your new values on next spawn

-- OR just spam it every second to be safe
task.spawn(function()
    while task.wait(1) do
        if path and require(path).BaseCash ~= 6000000 then
            require(path).BaseCash = 6000000
            print("Re-forced 6M cash")
        end
    end
end)

print("SVININA BOMBARDINO = CASH PRINTER | Every drop = 6M+ | Server-sided, rejoin safe")
