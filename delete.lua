me = owner
tool = Instance.new("Tool",owner.Backpack)
tool.RequiresHandle = false
tool.CanBeDropped = false
remote = Instance.new("RemoteEvent",tool)
remote.Name = "remote"

NLS([[
local mouse = game.Players.LocalPlayer:GetMouse()
tool = script.Parent
tool.Activated:Connect(function()	
	local target = mouse.Target	
	script.Parent.remote:FireServer(target)
end)
]],tool)

tool.remote.OnServerEvent:Connect(function(player,target)	
		target:Destroy()
end)
