local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage:WaitForChild("Roact"))

local Guis = script:WaitForChild("Guis")
local LeftSidebarGui = require(Guis:WaitForChild("LeftSidebar"))

local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local leftSidebarGuiHandle = Roact.mount(LeftSidebarGui, PlayerGui)