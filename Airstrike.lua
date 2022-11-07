tool = Instance.new("Tool",owner.Backpack)
script.Parent = tool
tool.Name = "bomb"
tool.CanBeDropped = false
tool.RequiresHandle = true

handle = Instance.new("Part",tool)
handle.Name = "Handle"
handle.Size = Vector3.new(0.5, 1, 0.5)
hmesh = Instance.new("SpecialMesh",handle)
hmesh.MeshId = "http://www.roblox.com/asset/?id=88742707"
hmesh.TextureId = "http://www.roblox.com/asset/?id=88742969"
hmesh.Scale = Vector3.new(0.792, 0.792, 0.792)
hmesh.Offset = Vector3.new(0, 0.5, 0)

tool.GripUp = Vector3.new(0, 1, 0)
tool.GripRight = Vector3.new(-0.997, 0, 0.081)
tool.GripPos = Vector3.new(0, -0.667, 0)
tool.GripForward = Vector3.new(0.081, 0, 0.997)

event = Instance.new("RemoteEvent",tool)
event.Name = "Fire"



NLS([[

local mouse = game.Players.LocalPlayer:GetMouse()
tool = script.Parent
tool.Activated:Connect(function()	
	local MousePos = mouse.Hit.p	
script.Parent.Fire:FireServer(MousePos)
end)

]],tool)



--[[Bezier]]--

local function lerp(p0,p1,t)
	return p0*(1-t) + p1*t
end

local function quad(p0,p1,p2,t)
	local l1 = lerp(p0,p1,t)
	local l2 = lerp(p0,p2,t)
	local quad = lerp(l1,l2,t)
	return quad
end



junk = game:GetService("Debris")
script.Parent.Fire.OnServerEvent:Connect(function(player,MousePos)

	
	
	local warhead = Instance.new("Part")

	warhead.Size = Vector3.new(1.5,1.5,6)
	warhead.CFrame = CFrame.Angles(math.rad(-90),0,0)
	warhead.Position = MousePos + Vector3.new(0,1000,0)
	warhead.Parent = game.Workspace
	warhead.Anchored = true
	
	
	
	local marker = Instance.new("Part")
	marker.Name = "Marker"
	marker.Size = Vector3.new(3,3,3)
	marker.Shape = "Ball"
	marker.Transparency = 1
	marker.CanCollide = false
	marker.TopSurface = "Smooth"
	marker.BottomSurface = "Smooth"
	marker.Position = MousePos + Vector3.new(0,0,0)
	marker.Anchored = true
	marker.Parent = game.Workspace
	
	
	
	local s = Instance.new("SelectionSphere")
	s.Parent = marker
	s.Color = BrickColor.new("Really black")
	s.Transparency = 0.10000000149011612
	s.Color3 = Color3.new(0.164706, 0, 0)
	s.Adornee = marker
	s.SurfaceColor = BrickColor.new("Really red")
	s.SurfaceColor3 = Color3.new(1, 0, 0)
	s.SurfaceTransparency = 0



	local mesh = Instance.new("SpecialMesh")
	mesh.MeshId = "http://www.roblox.com/asset/?id=88782666"
	mesh.TextureId = "http://www.roblox.com/asset/?id=88782631"
	mesh.Scale = Vector3.new(4.5, 4.5, 3)
	mesh.Parent = warhead



	local sound = Instance.new("Sound")
	sound.SoundId = "http://www.roblox.com/asset/?id=258057783"
	sound.Volume = 3
	sound.PlaybackSpeed = 1.5
	sound.Parent = warhead
	
	
	
	local start = MousePos + Vector3.new(0,1000,0)
	local finish = MousePos
	local middle = (finish - start) + Vector3.new(MousePos.X,0,MousePos.Z)

	
	
	local max = 50
	for i = 1,max do
		local t = i/max
		local update = quad(start,middle,finish,t)
		warhead.Position = update
		task.wait()
	end
	
	

	for _,v in pairs(warhead:GetChildren()) do
		if v:IsA("Attachment") then
			v:Destroy()
		end
	end
	
	
	
	local e = Instance.new("Explosion")
	e.BlastPressure = 80000
	e.BlastRadius = 30
	e.DestroyJointRadiusPercent = 30 -- yes joint breakers
	e.Position = warhead.Position
	e.Parent = warhead
	
	
	
	e.Hit:Connect(function(hit)

		if hit.Anchored == true then
			hit.Anchored = false
		end
		hit:BreakJoints()

		for _,joints in pairs(hit:GetJoints()) do
			joints:Destroy()
		end

		warhead.Sound:Play()
		warhead.Transparency = 1
		warhead.CanCollide = false
		junk:AddItem(marker,1)
		junk:AddItem(warhead,3)
		junk:AddItem(e,5)

	end)
end)
