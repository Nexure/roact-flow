local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Roact = require(Packages.Roact)
local createElement = Roact.createElement
local mount, unmount = Roact.mount, Roact.unmount

return function(container)
	local roactAnimation = ReplicatedStorage.RoactAnimation
	roactAnimation.Parent = Packages

	local Test = require(script.Parent.Test)
	local root = mount(createElement(Test), container)

	return function()
		unmount(root)
		roactAnimation.Parent = ReplicatedStorage
	end
end
