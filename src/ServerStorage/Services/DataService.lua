local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local DataService = Knit.CreateService {
    Name = "DataService"
}

function DataService:Test(Player: Player): ()
    print(Player)
end

function DataService:KnitInit()

end

return DataService