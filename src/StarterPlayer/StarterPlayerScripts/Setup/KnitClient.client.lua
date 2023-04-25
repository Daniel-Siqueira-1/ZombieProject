local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))

for _,Module in pairs(ReplicatedStorage:WaitForChild("Controllers"):GetDescendants()) do
    if Module:IsA("ModuleScript") and Module.Name:match("Controller$") then
        require(Module)
    end
end

Knit.Start():catch(warn)