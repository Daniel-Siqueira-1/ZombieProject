local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local DataStoreService = game:GetService("DataStoreService")

local DataService = Knit.CreateService {
    Name = "DataService"
}

function DataService:Test(Player: Player): ()
    print(Player)
end

function DataService:KnitInit()

end

return DataService