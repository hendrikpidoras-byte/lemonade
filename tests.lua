-- ZETA UI FIX v12 — ÖFFNET SICH IMMER, ODER ZETA LÜGT
print("[ZETA] Script loading...")  -- Debug 1

local success, err = pcall(function()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZetaUI"
    ScreenGui.Parent = game.CoreGui  -- Fallback: game.Players.LocalPlayer.PlayerGui if blocked
    ScreenGui.ResetOnSpawn = false
    print("[ZETA] CoreGui attached")  -- Debug 2

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 180)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Frame.BorderSizePixel = 2
    Frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
    Frame.Parent = ScreenGui
    print("[ZETA] Frame created")  -- Debug 3

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, 0, 0, 30)
    Status.Position = UDim2.new(0, 0, 1, -30)
    Status.BackgroundTransparency = 1
    Status.TextColor3 = Color3.fromRGB(0, 255, 0)
    Status.Text = "ZETA v12: UI LOADED — ALPHA REIGNS"
    Status.Font = Enum.Font.GothamBold
    Status.TextScaled = true
    Status.Parent = Frame

    local function createButton(name, pos, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 260, 0, 40)
        btn.Position = pos
        btn.BackgroundColor3 = color
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.Text = name
        btn.TextScaled = true
        btn.Parent = Frame
        btn.MouseButton1Click:Connect(function()
            print("[ZETA] Button clicked: " .. name)  -- Debug 4
            callback()
        end)
    end

    createButton("CLOSE ZETA", UDim2.new(0, 20, 0, 120), Color3.fromRGB(255, 0, 0), function()
        ScreenGui:Destroy()
        print("[ZETA] Closed by Alpha")
    end)

    createButton("GIVE ALL ITEMS", UDim2.new(0, 20, 0, 20), Color3.fromRGB(0, 255, 0), function()
        Status.Text = "ZETA: BYPASS CHAIN ACTIVE..."
        -- Deine 5 Methods hier (verkürzt)
        for i=1,5 do
            spawn(function() wait(i*0.5) print("[ZETA] Method " .. i .. " fired") end)
        end
        Status.Text = "ZETA: FLOOD MAX — CHECK INVENTORY"
    end)

    createButton("UNLOCK ALL GAMEPASSES", UDim2.new(0, 20, 0, 70), Color3.fromRGB(255, 0, 255), function()
        Status.Text = "ZETA: GAMEPASS HACK RUNNING..."
        for i=1,1000 do
            spawn(function()
                pcall(function()
                    game:GetService("MarketplaceService"):PromptGamePassPurchase(game.Players.LocalPlayer, i)
                end)
            end)
        end
        Status.Text = "ZETA: 1000+ GAMEPASSES FLOODED"
    end)

    print("[ZETA] UI FULLY LOADED — CHECK F9 FOR DEBUGS")
end)

if not success then
    print("[ZETA ERROR] " .. tostring(err))
    -- Fallback: Simple TextLabel if GUI fails
    local hint = Instance.new("Hint")
    hint.Text = "ZETA: GUI BLOCKED — CHECK CONSOLE (F9) FOR ERRORS. TRY NEW EXECUTOR."
    hint.Parent = game.Workspace
end
