local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage:WaitForChild("Roact"))

local Components = require(script.Parent:WaitForChild("Components"))

return Roact.createElement("ScreenGui", {
    IgnoreGuiInset = true
}, {
    Frame = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        Padding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 20)
        }),
        CenteredFrame = Roact.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.XY,
            AnchorPoint = Vector2.new(0, .5),
            Position = UDim2.new(0, 0, .5, 0)
        }, {
            Layout = Roact.createElement("UIListLayout", {
                Padding = UDim.new(0, 15)
            }),
            MoneyDisplay = Roact.createElement(Components.LeaderstatLabel, {
                valueName = "Money"
            }),
            HeightDisplay = Roact.createElement("Frame", {

            }, {
                Display = Roact.createElement(Components.LeaderstatLabel, {
                    valueName = "Height"
                }),
                Image = Roact.createElement("ImageLabel", {
                    
                })
            })
        })
    })
})