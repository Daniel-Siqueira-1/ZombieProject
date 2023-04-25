local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
print("Creating controller")
local DataController = Knit.CreateController({
    Name = "DataController"
})

function DataController.KnitStart()
    print("TEST")
    local DataService = Knit.GetService("DataService")
    DataService:Test()
end

return DataController