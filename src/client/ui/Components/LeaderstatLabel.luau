local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage:WaitForChild("Roact"))
local Trove = require(ReplicatedStorage:WaitForChild("Trove"))
local Util = require(ReplicatedStorage:WaitForChild("Util"))

local LeaderstatLabel = Roact.Component:extend("LeaderstatLabel")

function LeaderstatLabel:init()
    self.displayValue, self.updateDisplayValue = Roact.createBinding("")

    self._trove = Trove.new()

    self._valueInstance = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild(self.props.valueName)
    self._trove:Add(self._valueInstance:GetPropertyChangedSignal("Value"):Connect(function()
        self.updateDisplayValue(self._valueInstance.Value)
    end))
end

function LeaderstatLabel:render()
    return Roact.createElement("TextLabel", {
        TextSize = 40,
        Size = UDim2.new(0, 0, 0, 75),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,

        Text = self.displayValue
    })
end

function LeaderstatLabel:willUnmount()
    self._trove:Clean()
end

return LeaderstatLabel