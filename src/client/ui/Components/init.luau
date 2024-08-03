local Util = require(game:GetService("ReplicatedStorage"):WaitForChild("Util"))

local Components = {}

for _, module in script:GetChildren() do
    Components[module.Name] = require(module)
end

return Components