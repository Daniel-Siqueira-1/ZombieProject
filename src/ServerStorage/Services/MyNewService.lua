local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Knit = require(ReplicatedStorage.Packages.Knit)

local MyNewService = Knit.CreateService {
    Name = "MyNewService",
    Client = {},
}

MyNewService.PlayersRandomData = {}

local function DefaultData()
    return "WEIRDDATA"
end

function MyNewService.Client:YourClientMethod(Player: Player): ()
    print("TEST")
    return self.Server:GetPlayerData(Player)
end

function MyNewService:GetPlayerData(Player: Player): ()
    return MyNewService.PlayersRandomData[Player.UserId]
end

function MyNewService.CreateRandomData(Player: Player): ()
    MyNewService.PlayersRandomData[Player.UserId] = DefaultData()
end

function MyNewService:KnitStart()
    Players.PlayerAdded:Connect(MyNewService.CreateRandomData)
end


function MyNewService:KnitInit()
    
end


return MyNewService
