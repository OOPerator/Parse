Player = owner
Pack = Player.Backpack

tool = Instance.new("Tool",Pack) tool.Name = "Shaften"
tool.CanBeDropped = false
tool.RequiresHandle = false

Event = Instance.new("RemoteEvent",tool) Event.Name = "fire"

Head = Player.Character.Head


Handle = Instance.new("Part",tool) Handle.Name = "kek"
Handle.Massless = true
Handle.Size = Vector3.new(1.2, 1.2 ,1.2)
Handle.BrickColor = BrickColor.new("Rust")
Handle.TopSurface = "Smooth"
Handle.BottomSurface = "Smooth"
Handle.Shape = "Cylinder"
Handle.Material = "SmoothPlastic"
Handle.Transparency = 1

weld = Instance.new("Weld",Handle)
weld.C0 = CFrame.new(0, 1.2 ,0)
weld.Part0 = Head
weld.Part1 = Handle

Shaft = Instance.new("Part",tool) Shaft.Name = "Shaft"
Shaft.Massless = true
Shaft.Size = Vector3.new(8, 1, 1)
Shaft.BrickColor = BrickColor.new("Rust")
Shaft.TopSurface = "Smooth"
Shaft.BottomSurface = "Smooth"
Shaft.Shape = "Cylinder"
Shaft.Material = "SmoothPlastic"

weld = Instance.new("Weld",Shaft)
weld.C0 = CFrame.new(0,1.4,-4) * CFrame.Angles( math.rad(0),math.rad(90),math.rad(0) )
weld.Part0 = Head
weld.Part1 = Shaft

Ball1 = Instance.new("Part",tool) Ball1.Name = "Ball1"
Ball1.Massless = true
Ball1.Size = Vector3.new(2.5, 2.5, 2.5)
Ball1.BrickColor = BrickColor.new("Rust")
Ball1.TopSurface = "Smooth"
Ball1.BottomSurface = "Smooth"
Ball1.Shape = "Ball"
Ball1.Material = "SmoothPlastic"

weld = Instance.new("Weld",Ball1)
weld.C0 = CFrame.new(0.8, 0.91 ,0)
weld.Part0 = Head
weld.Part1 = Ball1

Ball2 = Instance.new("Part",tool) Ball2.Name = "Ball2"
Ball2.Massless = true
Ball2.Size = Vector3.new(2.5, 2.5, 2.5)
Ball2.BrickColor = BrickColor.new("Rust")
Ball2.TopSurface = "Smooth"
Ball2.BottomSurface = "Smooth"
Ball2.Shape = "Ball"
Ball2.Material = "SmoothPlastic"

weld = Instance.new("Weld",Ball2)
weld.C0 = CFrame.new(-0.8, 0.91 ,0)
weld.Part0 = Head
weld.Part1 = Ball2

Tip = Instance.new("Part",tool) Tip.Name = "bullet"
Mesh = Instance.new("FileMesh",Tip)
Mesh.MeshId = "http://www.roblox.com/asset/?id=1527559"
Mesh.Scale = Vector3.new(0.6, 0.6, 0.6)
Tip.Massless = true
Tip.Size = Vector3.new(1,1,1)
Tip.BrickColor = BrickColor.new("Dusty Rose")

weld = Instance.new("Weld",Tip)
weld.C0 = CFrame.new(0, 1.38 ,-7.7) * CFrame.Angles( math.rad(-90), math.rad(0), math.rad(0) )
weld.Part0 = Head
weld.Part1 = Tip


NLS([[
	
	local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local uis = game:GetService("UserInputService")

local shotlol = script.Parent.fire

local gun = script.Parent

local ClickConnection

local KeyConnection

script.Parent.Equipped:Connect(function()
	ClickConnection = mouse.Button1Down:Connect(function()
		local FromP = gun.bullet.CFrame.Position
		local ToP = mouse.Hit.Position
		shotlol:FireServer(FromP, ToP)	
	end)
end)

script.Parent.Unequipped:Connect(function()
	ClickConnection:Disconnect()
end)

	
	
	
	]],Handle.Parent)



local remote = Event

local char=nil


function CastProperRay(Start,Direction,Distance,Ignore)
	local NewRCP = RaycastParams.new()
	NewRCP.FilterDescendantsInstances = Ignore
	NewRCP.FilterType = Enum.RaycastFilterType.Blacklist
	NewRCP.IgnoreWater = true
	local RaycastResult = workspace:Raycast(Start,Direction * Distance,NewRCP)
	if not RaycastResult then
		return nil,Direction * Distance,nil
	end
	return RaycastResult.Instance,RaycastResult.Position,RaycastResult.Normal
end


remote.OnServerEvent:Connect(function(player, FromP, ToP)
	local loudlol = Instance.new("Sound", tool.bullet)
	loudlol.SoundId = "rbxassetid://4810729508"
	loudlol.Volume = 4
	loudlol:Play()

	local Dist = (ToP-FromP).magnitude
	local Part,Position,Normal = CastProperRay(FromP,(ToP-FromP).unit*1000,Dist,{workspace:FindFirstChildOfClass("Terrain"),char})
	local Lazer = Instance.new("Part",workspace)
	Lazer.Anchored = true
	Lazer.CanCollide = false
	Lazer.Size = Vector3.new(1,1,Dist)
	Lazer.Material = Enum.Material.SmoothPlastic
	Lazer.CFrame = CFrame.new(FromP,Position)*CFrame.new(0,0,-Dist/2)
	Lazer.Color = Color3.fromRGB(255,255,255)
	game.Debris:AddItem(Lazer,0.5)
	local TweenService = game:GetService("TweenService")

	local part1 = Lazer



	local Info1 = TweenInfo.new(

		0.5,

		Enum.EasingStyle.Cubic, 

		Enum.EasingDirection.Out,

		0, 
		false,

		0 

	)



	local Goals1 =

		{

			Transparency = 1;

			Size = Vector3.new(0,0,Dist);

		}



	local TweenService = game:GetService("TweenService")




	local Info2 = TweenInfo.new(

		0.5,

		Enum.EasingStyle.Cubic, 

		Enum.EasingDirection.Out,

		0, 
		false,

		0 

	)



	local Goals =

		{

			Transparency = 1;

			Size = Vector3.new(4,4,4);

		}

	local tween = TweenService:Create(part1,Info1,Goals1)
	tween:Play()
	if Part then
		if Part.Parent.ClassName == "Model" then
			Part.Parent:BreakJoints()

		elseif Part.Parent.Parent.ClassName == "Model" then
			Part.Parent.Parent:BreakJoints()			
		end
	end
end)
