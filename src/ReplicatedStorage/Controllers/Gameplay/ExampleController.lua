local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local DataController = Knit.CreateController({
    Name = "DataController"
})

function DataController.KnitStart()
    local MyNewService = Knit.GetService("MyNewService")
    MyNewService:YourClientMethod()
end

return DataController