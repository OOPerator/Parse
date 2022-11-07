you = owner
pack = you.Backpack

staff = Instance.new("Tool",pack) staff.Name = "Lightning"
staff.CanBeDropped = false
staff.RequiresHandle = true
script.Parent = staff
staff.GripUp = Vector3.new(0,1,0)
staff.GripRight = Vector3.new(-1,0,0)
staff.GripPos = Vector3.new(0,-1.2,-0.1)
staff.GripForward = Vector3.new(0,0,1)

event = Instance.new("RemoteEvent",staff) event.Name = "thefunnyshoot"

handle = Instance.new("Part",staff) handle.Name = "Handle"
handle.Size = Vector3.new(1,6,1)
handle.BrickColor = BrickColor.new("Really black")

handlemesh = Instance.new("SpecialMesh",handle)
handlemesh.MeshId = "http://www.roblox.com/asset/?id=26414793"
handlemesh.Scale = Vector3.new(1.5,1.5,1.5)

gem = Instance.new("Part",staff) gem.Name = "NeonParts"
gem.Size = Vector3.new(1,1.2,1)
gem.Reflectance = 0.2
gmesh = Instance.new("SpecialMesh",gem) gmesh.MeshId = "rbxassetid://2570899763"
gmesh.Scale = Vector3.new(1.3,1.3,1.3)

weld = Instance.new("Weld",gem)
weld.Part0 = gem
weld.Part1 = handle
weld.C0 = CFrame.new(0,-4.5,0)

focal = Instance.new("Part",staff) focal.Name = "Caster"
focal.Size = Vector3.new(0.1,0.1,0.1)
focal.Transparency = 1

weld = Instance.new("Weld",focal)
weld.Part0 = focal
weld.Part1 = gem
weld.C0 = CFrame.new(0,0,-1)


NLS([[

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local uis = game:GetService("UserInputService")

local shotlol = script.Parent.thefunnyshoot

local gun = script.Parent

local ClickConnection

local KeyConnection

local held = false

function Swait(num)
	if num == 0 or num == nil then
		game:GetService("RunService").Heartbeat:Wait()
	else
		for i=1,num do
			game:GetService("RunService").Heartbeat:Wait()
		end
	end
end

script.Parent.Equipped:Connect(function()
	ClickConnection = uis.InputBegan:Connect(function(input,istyping)
		if istyping then
			return
		elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
			local FromP = gun.Caster.CFrame.Position
			local ToP = mouse.Hit
			shotlol:FireServer(FromP, ToP)			
		end
	end)
end)

script.Parent.Unequipped:Connect(function()
	ClickConnection:Disconnect()
end)


]],staff)



--[[
\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//

lighnting canon omg!

Made by XanderGaming112 and no one else. Enjoy.

\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
]]

local Player = nil
local Character = nil

local equipped = false

local debris = game:GetService("Debris")
local tweenservice = game:GetService("TweenService")


local MRANDOM = math.random

function Cube(cframe,size,color,orientation,tweenedorientation,transparency,endsize,ttime,debtime)
	local cube = Instance.new("Part",script.Parent.Effects)
	cube.Size = size
	cube.Color = color
	cube.CanCollide = false
	cube.Anchored = true
	cube.Massless = true
	cube.Orientation = orientation
	cube.CFrame = cframe
	cube.Material = Enum.Material.Neon

	debris:AddItem(cube,debtime)

	tweenservice:Create(cube,TweenInfo.new(ttime),{Orientation=tweenedorientation,Transparency=transparency,Size=endsize}):Play()
end

function Swait(num)
	if num == 0 or num == nil then
		game:GetService("RunService").Heartbeat:Wait()
	else
		for i=1,num do
			game:GetService("RunService").Heartbeat:Wait()
		end
	end
end

script.Parent.Equipped:Connect(function()
	local plr = game:GetService("Players"):GetPlayerFromCharacter(script.Parent.Parent)
	Player = plr
	Character = plr.Character
	equipped = true

	while equipped do
		script.Parent.NeonParts.Color = Color3.fromHSV((tick()%5)/5,1,1)
		Swait()
	end
end)

script.Parent.Unequipped:Connect(function()
	equipped = false
end)




function Kill(foe)
	foe:BreakJoints()
	if foe:FindFirstChild("HumanoidRootPart") then				
		coroutine.wrap(function()
			for i=1,15 do
				coroutine.wrap(function()
					local explodeeffect = Instance.new("Part",Character)
					explodeeffect.CFrame = foe:FindFirstChild("HumanoidRootPart").CFrame
					explodeeffect.CanCollide = false
					explodeeffect.Anchored = true
					explodeeffect.Material = Enum.Material.Neon
					explodeeffect.Shape = Enum.PartType.Ball
					local mrandom = MRANDOM(1,2)
					if mrandom == 1 then
						explodeeffect.Color = Color3.fromHSV((tick()%5)/5,1,1)
					else
						explodeeffect.Color = Color3.fromRGB(255, 255, 255)
					end
					debris:AddItem(explodeeffect,2)

					tweenservice:Create(explodeeffect,TweenInfo.new(1,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Transparency=1,Size=Vector3.new(30,30,30),Orientation=Vector3.new(MRANDOM(-360,360),MRANDOM(-360,360),MRANDOM(-360,360))}):Play()

					local cyl = Instance.new("Part",Character)
					cyl.CanCollide = false
					local mrandom2 = MRANDOM(1,2)
					if mrandom2 == 1 then
						cyl.Color = Color3.fromHSV((tick()%5)/5,1,1)
					else
						cyl.Color = Color3.fromRGB(255, 255, 255)
					end
					cyl.Size = Vector3.new(100,0,0)
					cyl.Anchored = true
					cyl.CFrame = explodeeffect.CFrame
					cyl.Material = Enum.Material.Neon
					cyl.Shape = Enum.PartType.Cylinder
					cyl.Orientation = Vector3.new(MRANDOM(-360,360),MRANDOM(-360,360),MRANDOM(-360,360))
					debris:AddItem(cyl,5)
					tweenservice:Create(cyl,TweenInfo.new(1),{Transparency=1,Size=Vector3.new(100,.5,.5),Orientation=Vector3.new(MRANDOM(-360,360),MRANDOM(-360,360),MRANDOM(-360,360))}):Play()
				end)()
			end
		end)()

		for i,v in pairs(foe:GetChildren()) do
			if v:IsA("BasePart") then
				coroutine.wrap(function()
					v.Material = Enum.Material.Neon
					v.Color = Color3.fromRGB(0,0,0)
					local tween = tweenservice:Create(v,TweenInfo.new(1),{Transparency=1})
					tween:Play()
					tween.Completed:Wait()
					v:Destroy()
				end)()
			elseif v:IsA("Accessory") then
				v:Destroy()
			elseif v:IsA("Decal") then
				v:Destroy()
			elseif v:IsA("Tool") then
				v:Destroy()
			elseif v:IsA("Clothing") then
				v:Destroy()
			elseif v:IsA("LuaSourceContainer") then
				v:Destroy()
			end
		end
	else
		if foe:FindFirstChild("Torso") then
			coroutine.wrap(function()
				for i=1,15 do
					coroutine.wrap(function()
						local explodeeffect = Instance.new("Part",Character)
						explodeeffect.CFrame = foe:FindFirstChild("Torso").CFrame
						explodeeffect.CanCollide = false
						explodeeffect.Anchored = true
						explodeeffect.Material = Enum.Material.Neon
						explodeeffect.Shape = Enum.PartType.Ball
						local mrandom = MRANDOM(1,2)
						if mrandom == 1 then
							explodeeffect.Color = Color3.fromHSV((tick()%5)/5,1,1)
						else
							explodeeffect.Color = Color3.fromRGB(255, 255, 255)
						end
						debris:AddItem(explodeeffect,2)

						tweenservice:Create(explodeeffect,TweenInfo.new(1,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Transparency=1,Size=Vector3.new(30,30,30),Orientation=Vector3.new(MRANDOM(-360,360),MRANDOM(-360,360),MRANDOM(-360,360))}):Play()

						local cyl = Instance.new("Part",Character)
						cyl.CanCollide = false
						local mrandom2 = MRANDOM(1,2)
						if mrandom2 == 1 then
							cyl.Color = Color3.fromHSV((tick()%5)/5,1,1)
						else
							cyl.Color = Color3.fromRGB(255, 255, 255)
						end
						cyl.Size = Vector3.new(100,0,0)
						cyl.Anchored = true
						cyl.CFrame = explodeeffect.CFrame
						cyl.Material = Enum.Material.Neon
						cyl.Shape = Enum.PartType.Cylinder
						cyl.Orientation = Vector3.new(MRANDOM(-360,360),MRANDOM(-360,360),MRANDOM(-360,360))
						debris:AddItem(cyl,5)
						tweenservice:Create(cyl,TweenInfo.new(1),{Transparency=1,Size=Vector3.new(100,.5,.5),Orientation=Vector3.new(MRANDOM(-360,360),MRANDOM(-360,360),MRANDOM(-360,360))}):Play()
					end)()
				end
			end)()

			for i,v in pairs(foe:GetChildren()) do
				if v:IsA("BasePart") then
					coroutine.wrap(function()
						v.Material = Enum.Material.Neon
						v.Color = Color3.fromRGB(0,0,0)
						local tween = tweenservice:Create(v,TweenInfo.new(1),{Transparency=1})
						tween:Play()
						tween.Completed:Wait()
						v:Destroy()
					end)()
				elseif v:IsA("Accessory") then
					v:Destroy()
				elseif v:IsA("Decal") then
					v:Destroy()
				elseif v:IsA("Tool") then
					v:Destroy()
				elseif v:IsA("Clothing") then
					v:Destroy()
				elseif v:IsA("LuaSourceContainer") then
					v:Destroy()
				end
			end
		end
	end
end
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

local remote = script.Parent:WaitForChild("thefunnyshoot")

--def not stolen from lost hope :flushed: (not me!)
function Lightning(From,To,Number,Offset,Color,Time,StartSize,transparency)
	local magnitude = (From-To).magnitude
	local Table = {-Offset,Offset}

	for i=1,Number do
		local lightning = Instance.new("Part",Character)
		lightning.Anchored = true
		lightning.CanCollide = false
		lightning.Material = Enum.Material.Neon
		lightning.Color = Color
		lightning.Size = Vector3.new(2,2,magnitude/Number)

		local Offset = Vector3.new(Table[math.random(1, 2)], Table[math.random(1, 2)], Table[math.random(1, 2)])
		local pos = CFrame.new(To,From) * CFrame.new(0,0,magnitude/Number).p + Offset

		lightning.CFrame = CFrame.new(To,pos) * CFrame.new(0,0,magnitude/Number/2)

		if Number == i then
			local magnitude2 = (To-From).magnitude
			lightning.Size = Vector3.new(2,2,magnitude2)
			lightning.CFrame = CFrame.new(To, From) * CFrame.new(0,0,-magnitude2/2)
		else
			lightning.CFrame = CFrame.new(To, pos) * CFrame.new(0,0,magnitude/Number/2)
		end
		tweenservice:Create(lightning,TweenInfo.new(Time),{Size=Vector3.new(0,0,lightning.Size.Z),Transparency=transparency}):Play()
		To = lightning.CFrame * CFrame.new(0,0,magnitude/Number/2).p
		debris:AddItem(lightning,3)
	end
end

function ShootEffect(cfram,color)
	for i=1,5 do
		local lol = Instance.new("Part",Character)
		lol.CanCollide = false
		lol.Anchored = true
		lol.CFrame = cfram
		lol.Size = Vector3.new(0,0,0)
		lol.Color = color
		lol.Orientation = Vector3.new(math.random(-360,360),math.random(-360,360),math.random(-360,360))

		local gaming = Instance.new("SpecialMesh",lol)
		gaming.MeshId = "rbxassetid://662586858"
		gaming.Scale = Vector3.new(0,0,0)

		debris:AddItem(lol,5)

		tweenservice:Create(lol,TweenInfo.new(1.1),{Transparency=1,Orientation=Vector3.new(math.random(-360,360),math.random(-360,360),math.random(-360,360))}):Play()
		tweenservice:Create(gaming,TweenInfo.new(1,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=Vector3.new(.1,.001,.1)}):Play()
	end
end

local mid = script.Parent.Caster

remote.OnServerEvent:Connect(function(player,FromP,ToP)

	local shoot1 = Instance.new("Sound", mid)
	shoot1.SoundId = "rbxassetid://642890855"
	shoot1.Volume = 10
	shoot1.PlaybackSpeed = .45
	shoot1:Play()

	debris:AddItem(shoot1,5)	
	local Dist = (FromP-ToP.Position).magnitude
	if Dist > 2048 then Dist = 2048 end
	local Part,Position,Normal = CastProperRay(FromP,(ToP.Position-FromP).unit*1000,Dist,{workspace:FindFirstChildOfClass("Terrain"),Character})
	if Dist < 50 then
		coroutine.wrap(function()
			for i=1,5 do
				Lightning(FromP,ToP.Position,4,1,Color3.fromHSV((tick()%5)/5,1,1),1,Vector3.new(0.5,3,0),1,false)
			end
		end)()
	else
		coroutine.wrap(function()
			for i=1,5 do
				Lightning(FromP,ToP.Position,10,2,Color3.fromHSV((tick()%5)/5,1,1),1,Vector3.new(0.5,3,0),1,false)
			end
		end)()
	end

	ShootEffect(script.Parent.Caster.CFrame,Color3.fromHSV((tick()%5)/5,1,1))
	ShootEffect(script.Parent.Caster.CFrame,Color3.fromRGB(255,255,255))

	local StartSquare = Instance.new("Part",Character)
	StartSquare.Color = Color3.fromHSV((tick()%5)/5,1,1)
	StartSquare.CanCollide = false
	StartSquare.Anchored = true
	StartSquare.CFrame = mid.CFrame
	StartSquare.Size = Vector3.new(0,0,0)
	StartSquare.Material = Enum.Material.Neon

	local EndSquare = Instance.new("Part",Character)
	EndSquare.Color = StartSquare.Color
	EndSquare.CanCollide = false
	EndSquare.Anchored = true
	EndSquare.CFrame = ToP
	EndSquare.Size = Vector3.new(0,0,0)
	EndSquare.Material = Enum.Material.Neon

	tweenservice:Create(StartSquare,TweenInfo.new(.7),{Size=Vector3.new(2,2,2),Transparency=1,Orientation=Vector3.new(MRANDOM(-360,360),MRANDOM(-360,360),MRANDOM(-360,360))}):Play()
	tweenservice:Create(EndSquare,TweenInfo.new(.7),{Size=Vector3.new(2,2,2),Transparency=1,Orientation=Vector3.new(MRANDOM(-360,360),MRANDOM(-360,360),MRANDOM(-360,360))}):Play()
	ShootEffect(EndSquare.CFrame,Color3.fromHSV((tick()%5)/5,1,1))
	ShootEffect(EndSquare.CFrame,Color3.fromRGB(255,255,255))
	debris:AddItem(StartSquare,1)
	debris:AddItem(EndSquare,1)

	if Part then
		if Part.Parent.ClassName == "Model" then
			if Part.Parent:FindFirstChildOfClass("Humanoid") then
				Kill(Part.Parent)
			end
		elseif Part.Parent.Parent.ClassName == "Model" then
			if Part.Parent.Parent:FindFirstChildOfClass("Humanoid") then
				Kill(Part.Parent.Parent)
			end
		end
	end
end)
