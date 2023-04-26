local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
print('TEST')
for _,Module in pairs(ServerStorage.Services:GetDescendants()) do 
    if Module:IsA("ModuleScript") and Module.Name:match("Service$") then
        require(Module)
    end
end

Knit.Start():catch(warn)