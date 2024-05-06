local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local MessageBroadcastService = Knit.CreateService{
    Name = "MessageBroadcastService";
    Client = {
        BroadcastMessage = Knit.CreateSignal;
    };
}

function MessageBroadcastService:KnitInit()
    
end

function MessageBroadcastService:KnitStart()
    
end

return MessageBroadcastService