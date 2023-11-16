thistool = Instance.new("Tool",owner.Backpack)
thistool.RequiresHandle = true
thistool.Name = "box"

handle = Instance.new("Part",thistool)
handle.Name = "Handle"
handle.Size = Vector3.new(2,2,2)
handle.TopSurface = "Smooth"
handle.BottomSurface = "Smooth"
handle.BrickColor = BrickColor.random()

mesh = Instance.new("FileMesh",handle)
mesh.MeshId = "rbxassetid://1254390558"
mesh.Scale = Vector3.new(0.1,0.1,0.1)

thistool.GripUp = Vector3.new(0, 1, 0)
thistool.GripRight = Vector3.new(1, 0, 0)
thistool.GripPos = Vector3.new(0, 0, 0) 
thistool.GripForward = Vector3.new(-0, -0, -1)

event = Instance.new("RemoteEvent",thistool)
event.Name = "event"




NLS([[

mouse = game.Players.LocalPlayer:GetMouse()
player = game.Players.LocalPlayer
tool = script.Parent

tool.Activated:Connect(function()
	local dead = player.Character.Humanoid.Health <= 0
if dead then return end
	local function LookAtMouse(MouseHit, HRP)
		local Gyro = Instance.new("BodyGyro", HRP)
		Gyro.P = 1000000
		Gyro.MaxTorque = Vector3.new(0, math.huge, 0)
		Gyro.CFrame = CFrame.new(HRP.Position, MouseHit)

		game:GetService("Debris"):AddItem(Gyro, .1)
	end
	
			LookAtMouse(mouse.Hit.p, player.Character.HumanoidRootPart)


	
	local hit_p = mouse.Hit.p
	local char_head = game.Players.LocalPlayer.Character.Head

	tool.event:FireServer(hit_p,char_head)

end)

]],thistool)


tool = thistool

debris = game:GetService("Debris")

runservice = game:GetService("RunService")

function MAIN(player,hit_p,char_head)

	local pos1 = char_head.Position + Vector3.new(0,5,0)

	local pos2 = hit_p

	local direction = pos2 - pos1

	local duration = math.log(1.001 + direction.Magnitude * 0.01)

	local force = direction/duration + Vector3.new(0, workspace.Gravity * duration *0.5 ,0)

	local proj = Instance.new("Part")
	proj.Name = "proj"
	proj.Shape = "Ball"
	proj.Size = Vector3.new(1,1,1)
	proj.TopSurface = "Smooth"
	proj.BottomSurface = "Smooth"
	proj.Material = "Neon"
	proj.Color = Color3.new(math.random(),math.random(),math.random())
	proj.Position = pos1
	proj.Parent = workspace
	proj.CanCollide = true
	proj:ApplyImpulse(force * proj.AssemblyMass)
	proj:SetNetworkOwner(nil)
	
	local proj_mesh = Instance.new("FileMesh",proj)
	proj_mesh.MeshId = "rbxassetid://1254390558"
	proj_mesh.Scale = Vector3.new(0.1,0.1,0.1)

	local att0 = Instance.new("Attachment",proj)
	att0.Name = "Attachment0"
	att0.CFrame = CFrame.new(0,0.25,0)

	local att1 = Instance.new("Attachment",proj)
	att1.Name = "Attachment1"
	att1.CFrame = CFrame.new(0,-0.25,0)

	local trail = Instance.new("Trail",proj)
	trail.Enabled = true
	trail.FaceCamera = false
	trail.TextureMode = "Stretch"
	trail.Color = ColorSequence.new(proj.Color)
	trail.Attachment0 = att0
	trail.Attachment1 = att1
	trail.LightEmission = 10
	trail.Lifetime = 2
	trail.MaxLength = math.huge
	trail.Transparency = NumberSequence.new(0,0)

	task.spawn(function()
		while not proj:GetAttribute("hit") and proj.Parent == workspace do
			proj.CFrame = CFrame.lookAt(proj.Position,pos2)
			runservice.PreAnimation:Wait()
		end
	end)

	
	local function timer()
		local updateInterval = 0.5
		local currentColor = 1
		local colors = {26, 21} 
		local ticksound = Instance.new("Sound",proj)
		ticksound.SoundId = "rbxasset://sounds\\clickfast.wav"		
		while updateInterval > .1 do
			wait(updateInterval)
			updateInterval = updateInterval * .9
			proj.BrickColor = BrickColor.new(colors[currentColor])
			currentColor = currentColor + 1
			if (currentColor > 2) then currentColor = 1 end	
			ticksound:play()	
		end
	end


	local function explode(projectile)
		local sound = Instance.new("Sound",proj)
		sound.SoundId = "rbxasset://sounds\\Rocket shot.wav"
		sound.Volume = 1
		sound:Play()

		local e = Instance.new("Explosion",workspace)
		e.Position = projectile.Position
		e.BlastPressure = 1000000
		e.BlastRadius = 10
		e.Hit:Connect(function(hit)

			local bad = hit.Parent:FindFirstChildOfClass("ForceField")
			if bad then bad:Destroy()
			end

			local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
			wait()
			if hum then hum:Destroy()
			end

			if hit.Anchored == true then
				hit.Anchored = false

				hit:BreakJoints()

				for _,joints in pairs(hit:GetJoints()) do
					joints:Destroy()		
				end
			end
			projectile.Transparency = 1

		end)


	end

	local function stick(touched)
		
		local landed = proj:GetAttribute("hit")
		if landed then return end
		local splatsound = Instance.new("Sound",proj)
		splatsound.Volume = 5
		splatsound.SoundId = "rbxasset://Sounds/splat.wav"
		if touched:isA"BasePart" then
			local weld = Instance.new("WeldConstraint",proj)
			weld.Part0 = proj
			weld.Part1 = touched
			splatsound:Play()
			print("stuck lol")
		end

		proj:SetAttribute("hit",true)
		trail:Destroy()
		timer()
		explode(proj)

	end

	proj.Touched:Connect(stick)
	
	debris:AddItem(proj,10)
end


tool.event.OnServerEvent:Connect(MAIN)

function rainbow()

	handle.Color = Color3.new(255/255,0/255,0/255)
	for i = 0,255,10 do
		wait()
		handle.Color = Color3.new(255/255,i/255,0/255)
	end
	for i = 255,0,-10 do
		wait()
		handle.Color = Color3.new(i/255,255/255,0/255)
	end
	for i = 0,255,10 do
		wait()
		handle.Color = Color3.new(0/255,255/255,i/255)
	end
	for i = 255,0,-10 do
		wait()
		handle.Color = Color3.new(0/255,i/255,255/255)
	end
	for i = 0,255,10 do
		wait()
		handle.Color = Color3.new(i/255,0/255,255/255)
	end
	for i = 255,0,-10 do
		wait()
		handle.Color = Color3.new(255/255,0/255,i/255)
	end

end

while true do

	pcall(rainbow)

end
