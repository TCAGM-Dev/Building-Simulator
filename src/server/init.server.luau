-- [[ SERVICES ]] --
local RunService = game:GetService("RunService")

-- [[ LIBRARIES ]] --
local Util = require(game.ReplicatedStorage.Packages.Util)
local Database = require(game.ServerScriptService.Packages.Database)
local Leaderstat = require(game.ServerScriptService.Packages.Leaderstat)

-- [[ MODULES ]] --
local DataProvider = require(script:WaitForChild("DataProvider"))
local PlotManager = require(script:WaitForChild("PlotManager"))

-- [[ INSTANCES ]] --
local Money = Leaderstat.new("Money", 0)
local MaxHeight = Leaderstat.new("Height", 0)

-- [[ EVENTS ]] --
Util.forCharacters(function(character, player)
    task.wait() -- Wait for the default spawning behaviour to finish, otherwise it overrides the teleport
    PlotManager.teleportToPlot(player, character)
end)
game.Players.PlayerRemoving:Connect(PlotManager.returnPlot)

Util.forPlayers(function(player)
    local record = DataProvider:GetOrCreateRecord(player)
    record:GetValueChangedEvent("MaxHeight"):Connect(function(value)
        MaxHeight:of(player):set(math.round(value))
    end)
end)

DataProvider.RecordLoaded:Connect(function(record: Database.DatabaseRecord)
    print(`Data successfully loaded for {record.Player.Name}`)
end)

RunService.Heartbeat:Connect(function()
    for _, player in game.Players:GetPlayers() do
        local character = player.Character
        if character then
            local root = character.PrimaryPart
            if root then
                local plot = PlotManager.getPlot(player)

                local height = root.Position.Y - plot.Position.Y
                local record = DataProvider:GetOrCreateRecord(player)
                local maxHeight = record:GetValue("MaxHeight") or 0
                if height > maxHeight then
                    record:SetValue("MaxHeight", height)
                end
            end
        end
    end
end)