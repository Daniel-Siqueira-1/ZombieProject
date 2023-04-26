local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local test = Knit.CreateController { Name = "test" }


function test:KnitStart()
    local DataService = Knit.GetService("DataService")
    DataService:MyMethod()
end


function test:KnitInit()
    
end


return test
