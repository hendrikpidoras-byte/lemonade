-- STEALTH AddTokens ARG SPY (NO BAN, CONSOLE ONLY)
local remote = game.ReplicatedStorage.AddTokens
local oldFire = remote.FireServer
remote.FireServer = function(self, ...)
    local args = {...}
    print("🕵️ AddTokens FIRED WITH ARGS:", game:GetService("HttpService"):JSONEncode(args))
    return oldFire(self, ...)
end
print("Spy active – wait 2 min for natural fire 😈")
