local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Knit = require(ReplicatedStorage.Packages.Knit)

local Player = Players.LocalPlayer

local PlayerGui = Player:WaitForChild("PlayerGui")
local MessageUI = PlayerGui:WaitForChild("MessageUI")
local MessageFrame = MessageUI:WaitForChild("MessageFrame")

local MessageLabel = MessageFrame:WaitForChild("MessageLabel")

local TYPEWRITER_SPEED = 0.05 --Per letter
local MESSAGE_DISPLAY_TIME = 0.2

local function Typewrite(message)
    for i = 0, #message do
        MessageLabel.Text = string.sub(message, 1, i)
        task.wait(TYPEWRITER_SPEED)
    end 
end

local function Transition(msg, newIndex)
    local amt = #msg
    
    if (newIndex > amt) then
        MessageUI.Enabled = false
        return
    end

    Typewrite(msg[newIndex])
end


local MessageController = Knit.CreateController{
    Name = "MessageController";
}

function MessageController:KnitInit()
    
end

function MessageController:KnitStart()
    local MessageService = Knit.GetService("MessageBroadcastService")
    local displaying = false

    MessageService.BroadcastMessage:Connect(function(message)
        if (type(message) == 'string') then
            MessageUI.Enabled = true
            displaying = true
            Typewrite(message)
            task.wait(MESSAGE_DISPLAY_TIME)
            displaying = false
        else
            local curIndex = 1
            Typewrite(message[1])
            UserInputService.InputBegan:Connect(function(input, gpe)
                if (gpe) then
                    return
                end

                if (displaying) then
                    return
                end
                
                if (input.UserInputType == Enum.UserInputType.MouseButton1) then
                    curIndex += 1
                    Transition(message, curIndex)
                end
            end)
        end
    end)
end

return MessageController