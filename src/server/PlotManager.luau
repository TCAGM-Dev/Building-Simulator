local Util = require(game:GetService("ReplicatedStorage"):WaitForChild("Util"))

local Map = game.Workspace:WaitForChild("Map")
local PlotSpawns = Map:WaitForChild("PlotSpawns")
local Plots = Util.createInstance("Folder", {
    Name = "Plots",
    Parent = Map
})

local PlotManager = {}

local unassignedPlots: {Part} = {}
local assignedPlots: {[Player]: Part} = {}

for _, plotSpawn: Part in PlotSpawns:GetChildren() do
    local newPlot = Util.createInstance("Part", {
        Size = Vector3.new(30, .5, 30),
        Material = Enum.Material.Slate,
        Color = Color3.fromRGB(108, 99, 109),

        Anchored = true,
        CFrame = plotSpawn.CFrame,

        Parent = Plots
    })

    table.insert(unassignedPlots, newPlot)

    plotSpawn:Destroy()
end
PlotSpawns:Destroy()

function PlotManager.getPlot(player: Player): BasePart
    local plot = assignedPlots[player]
    if plot ~= nil then
        return plot
    end

    if #unassignedPlots <= 0 then
        error("Attempt to assign plot while none are unassigned")
    end

    local plotIndex = math.random(1, #unassignedPlots)
    plot = table.remove(unassignedPlots, plotIndex)
    assignedPlots[player] = plot

    return plot
end

function PlotManager.returnPlot(player: Player)
    local plot = assignedPlots[player]
    if plot == nil then
        return
    end

    assignedPlots[player] = nil
    table.insert(unassignedPlots, plot)
end

function PlotManager.teleportToPlot(player: Player, character: Model?)
    character = character or game.Players:GetPlayerFromCharacter(character)

    if character ~= player.Character then
        print("return")
        return
    end

    local plot = PlotManager.getPlot(player)

    character:PivotTo(CFrame.new(plot.Position + Vector3.new(0, 3, 0)))
end

return PlotManager