local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local MessageBroadcastService = Knit.CreateService{
    Name = "MessageBroadcastService";
    Client = {
        BroadcastMessage = Knit.CreateSignal();
    };
}

function MessageBroadcastService:KnitInit()
    
end

function MessageBroadcastService:KnitStart()
    Players.PlayerAdded:Connect(function(player)
        task.wait(5)
        self:BroadcastMessage(player, {"This message is brought to you by Qubit Commisions!"; "This is pretty cool?"; "Hopefully this can be done soon!";})
    end)
end

function MessageBroadcastService:BroadcastMessage(player, message)
    self.Client.BroadcastMessage:Fire(player, message)
end

return MessageBroadcastService