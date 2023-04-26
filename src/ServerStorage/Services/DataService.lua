--[=[ 
    DataService is the service responsible for handling all player data.

    It is responsible for loading, editing and saving data.
]=]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerService = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local StorageVersion = 1;
local DataStorage = DataStoreService:GetDataStore("PlayerData:" .. StorageVersion)

local Knit = require(ReplicatedStorage.Packages.Knit)

export type DataValue = {
    any
}

export type SavedData = {
    any: DataValue
}

export type EphemeralData = {
    any: DataValue
}

export type DataContainer = {
    Saved: SavedData;
    Ephemeral: EphemeralData;
}

export type PlayerData = {
    LogInId: number;
    LogOutId: number;
    OnlineTime: number;
    Data: DataContainer
}

export type DataCache = {
    number: PlayerData
}

local DataService = Knit.CreateService {
    Name = "DataService"
}

local Cache: DataCache = {}

local function Identifier(Player)
    return "UserIdentifier-" .. Player.UserId
end

local function InitialSavedData(): SavedData
    local NewSavedData: SavedData = {

    }

    return NewSavedData
end

local function InitialEphemeralData(): EphemeralData
    local NewEphemeralData: EphemeralData = {

    }

    return NewEphemeralData
end

local function InitialData(): PlayerData
    local NewData: PlayerData = {
        LogInId = 0;
        LogOutId = 0;
        OnlineTime = 0;
        Data = {
            Saved = InitialSavedData();
            Ephemeral = InitialEphemeralData();
        }
    }

    return NewData
end

local ComparisonData = InitialSavedData()

local function IterateThroughData(Content: (DataValue | SavedData), ComparisonContent: (DataValue | SavedData)): ()
    for Index,Data in pairs(ComparisonContent) do 
        if Content[Index] == nil then 
            Content[Index] = Data:Clone()
        else 
            if Data:ShouldIterate() then 
                IterateThroughData(Content[Index], Data)
            end
        end
    end
end

local function UpdateStructure(Data: PlayerData): ()
    Data.Ephemeral = InitialEphemeralData()

end

local function GetData(Player: Player): PlayerData
    local Data: PlayerData = InitialData()

    local function ErrorHandler(Succcess: boolean,Error: number): ()
        
    end

    local Success, LoadedData = xpcall(
        DataStorage.GetAsync,
        ErrorHandler,
        Identifier(Player)
    )

    if Success then
        Data = UpdateStructure(LoadedData)
    end

    return Data
end

--[=[
    Load/Retrieve the player data

    -- Getting the player data
    ```lua
    local PlayerData = DataService.get(Player)
    ```

    PlayerData.Data.Saved -- All data that will be saved to the DataStore
    PlayerData.Data.Ephemeral -- All data that will always delete itself after leaving and restore back to default when joining

    -- Retrieving values
    ```lua
        PlayerData.Data.Saved.Level.Value -- Would return a number
    ```

    -- Custom Properties
    ```lua
        PlayerData.Data.Saved.Level:GetLevelUpRequirements() -- Returns the amount of exp necessary for leveling up
    ```

    -- Creating values
    ```lua
        local CustomProperties = DataService.Properties.Coins -- A module inside Config table
        PlayerData.Data.Saved:Build("Coins", 50, CustomProperties)
        PlayerData.Data.Saved.Coins:Debit(100) -- Returns: false, "Insuficient funds"
        PlayerData.Data.Saved.Coins:Debit(30) -- Returns: true, 20
    ```

    -- Creating tables
    ```lua
        Player.Data.Saved:Build("Inventory", {}, DataService.Properties.Inventory)
    ```
]=]
function DataService.get(Player: Player): PlayerData
    if Cache[Player.UserId] then
        return Cache[Player.UserId]
    end

    Cache[Player.UserId] = GetData(Player);

    return Cache[Player.UserId]
end

function DataService:KnitStart()
    for _,Player in pairs(PlayerService:GetPlayers()) do 
        DataService.get(Player)
    end

    PlayerService.PlayerAdded:Connect(DataService.get)
end

function DataService:KnitInit()

end

return DataService