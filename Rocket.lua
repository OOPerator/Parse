pack = owner.Backpack

tool = Instance.new("Tool",pack)
tool.TextureId = "http://www.roblox.com/asset/?id=31613709"
tool.Name = "bigrocket"
tool.RequiresHandle = true
tool.CanBeDropped = false

remote = Instance.new("RemoteFunction",tool)
remote.Name = "MouseLoc"

handle = Instance.new("Part",tool)
handle.Name = "Handle"
handle.Size = Vector3.new(1, 5, 1)

hmesh = Instance.new("SpecialMesh",handle)
hmesh.MeshId = "http://www.roblox.com/asset/?id=31601544"
hmesh.TextureId = "http://www.roblox.com/asset/?id=31601599"

tool.GripUp = Vector3.new(0,0,1)
tool.GripRight = Vector3.new(1,0,0)
tool.GripPos = Vector3.new(0,-1,-0.8)
tool.GripForward = Vector3.new(0,1,0)

animfolder = Instance.new("Folder",tool)
animfolder.Name = "Animations"

subfold1 = Instance.new("Folder",animfolder)
subfold1.Name = "R15"

subfold2 = Instance.new("Folder",animfolder)
subfold2.Name = "R6"

anim1 = Instance.new("Animation",subfold1)
anim1.AnimationId = "rbxassetid://2513418440"
anim1.Name = "rocketkickback"

anim2 = Instance.new("Animation",subfold1)
anim2.AnimationId = "rbxassetid://2513438216"
anim2.Name = "rocketreload"

anim3 = Instance.new("Animation",subfold2)
anim3.AnimationId = "http://www.roblox.com/Asset?ID=31617132"
anim3.Name = "rocketkickback"

anim4 = Instance.new("Animation",subfold2)
anim4.AnimationId = "http://www.roblox.com/Asset?ID=31617128"
anim4.Name = "rocketreload"

launch = Instance.new("Sound",handle)
launch.Name = "Launch"
launch.SoundId = "rbxassetid://1796772196"

reload = Instance.new("Sound",handle)
reload.Name = "Reload"
reload.SoundId = "rbxassetid://1796772823"


NLS([[


local Tool = script.Parent

local MouseLoc = Tool:WaitForChild("MouseLoc",10)

function MouseLoc.OnClientInvoke()
	return game:GetService("Players").LocalPlayer:GetMouse().Hit.p
end


]],tool)



NLS([[

local MOUSE_ICON = 'rbxasset://textures/GunCursor.png'
local RELOADING_ICON = 'rbxasset://textures/GunWaitCursor.png'

local Tool = script.Parent

local Mouse = nil

local function UpdateIcon()
	if Mouse then
		Mouse.Icon = Tool.Enabled and MOUSE_ICON or RELOADING_ICON
	end
end

local function OnEquipped(mouse)
	Mouse = mouse
	UpdateIcon()
end

local function OnChanged(property)
	if property == 'Enabled' then
		UpdateIcon()
	end
end

Tool.Equipped:Connect(OnEquipped)
Tool.Changed:Connect(OnChanged)



]],tool)








local Tool = tool
Tool.Enabled = true

local AnimationFolder = Tool:WaitForChild("Animations")

local MouseLoc = Tool:WaitForChild("MouseLoc",10)

local Handle = Tool:WaitForChild("Handle",10)

local reload = 1

local rocketspeed = 300

local humanoid,character,player

local debris,players = game:GetService("Debris"), game:GetService("Players")

local reloadRocket = Instance.new("Part")
reloadRocket.CanCollide = false
reloadRocket.Size = Vector3.new(1,2,1)

local rocketMesh = Instance.new("SpecialMesh")
rocketMesh.MeshId = "http://www.roblox.com/asset/?id=31601976"
rocketMesh.TextureId = "http://www.roblox.com/asset/?id=31601599"
rocketMesh.Parent = reloadRocket

local CloneRocket = reloadRocket:Clone()

local ParticleAttachment = Instance.new("Attachment")
ParticleAttachment.Position = Vector3.new(0,1,0)
ParticleAttachment.Parent = CloneRocket

local Fire = Instance.new("Fire")
Fire.Color = Color3.fromRGB(255,132,0)
Fire.Heat = 25
Fire.SecondaryColor = Color3.new(1,0,0)
Fire.Size = 2
Fire.Enabled = true
Fire.Parent = ParticleAttachment

local Smoke = Instance.new("Smoke")
Smoke.Color = Color3.new(0,0,0)
Smoke.Enabled = true
Smoke.Opacity = 0
Smoke.RiseVelocity = 15
Smoke.Size = 0.5
Smoke.Parent = ParticleAttachment


local Animations = {}

function IsTeamMate(Player1, Player2)
	return (Player1 and Player2 and not Player1.Neutral and not Player2.Neutral and Player1.TeamColor == Player2.TeamColor)
end

function TagHumanoid(humanoid, player)
	local Creator_Tag = Instance.new("ObjectValue")
	Creator_Tag.Name = "creator";
	Creator_Tag.Value = player;
	game:GetService("Debris"):AddItem(Creator_Tag, 2)
	Creator_Tag.Parent = humanoid
end

function UntagHumanoid(humanoid)
	for _, v in pairs(humanoid:GetChildren()) do
		if v:IsA("ObjectValue") and v.Name == "creator" then
			v:Destroy()
		end
	end
end

function onActivated()

	if not Tool.Enabled then return end
	Tool.Enabled = false

	local TargetPosition = MouseLoc:InvokeClient(player)

	local root = CloneRocket:Clone()

	Handle.Launch:Play()
	Animations.RocketKickBack:Play()

	local force = Instance.new("BodyForce")
	force.Force = Vector3.new(0,root:GetMass()*workspace.Gravity,0)
	force.Parent = root

	local spawnPosition = Handle.Position + (Handle.CFrame.upVector * (Handle.Size.Y / 2))

	root.CFrame = CFrame.new(spawnPosition, TargetPosition)* CFrame.Angles(math.pi/2,0,0)
	root.Velocity = (TargetPosition-spawnPosition).unit * rocketspeed	

	root.Parent = workspace
	root:SetNetworkOwner(nil)
	root.Locked = true
	root.Anchored = false


	local sound = Instance.new("Sound")
	sound.SoundId = "http://www.roblox.com/asset/?id=258057783"
	sound.Volume = 1
	sound.Parent = root
	local con
	con = root.Touched:Connect(function(part)
		if not part or not part.Parent or part:IsDescendantOf(character)then return end
		for _,v in pairs(root:GetChildren()) do
			if v:IsA("Attachment") then
				v:Destroy()
			end
		end
		local e = Instance.new("Explosion")
		e.BlastPressure = 60000
		e.BlastRadius = 20
		e.DestroyJointRadiusPercent = 20 -- no joint breakers
		e.Position = root.Position
		e.Parent = workspace
		e.Hit:Connect(function(hit)

			if hit.Name ~= "Base" then
				hit.Anchored = false
			end

			if part.Name ~= "Base" then
				part.Anchored = false
			end

			local Humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
			if Humanoid then
				if Humanoid ~= humanoid then
					UntagHumanoid(Humanoid)
					TagHumanoid(Humanoid,player)
				end
				Humanoid.Parent:BreakJoints()
			end


			if not part.Anchored then
				part.Velocity = (part.CFrame.p-e.Position).unit*(e.BlastPressure/100)
			end
			for _,joints in pairs(hit:GetJoints()) do
				joints:Destroy()
			end

		end)
		debris:AddItem(e,1.5)
		root.Sound:Play()
		root.Transparency = 1
		root.CanCollide = false
		debris:AddItem(root,2)
		con:Disconnect()
	end)

	Handle.Mesh.MeshId = "http://www.roblox.com/asset/?id=31611841"

	debris:AddItem(root,14)

	wait(reload)

	if Tool:IsDescendantOf(character) then
		Animations.RocketReload:Play()
		local rocketClone = reloadRocket:Clone()
		rocketClone.Parent = humanoid.Parent
		Handle.Reload:Play()
		local welder = Instance.new("Weld")
		welder.Part0 = rocketClone
		welder.Parent = rocketClone
		welder.Part1 = humanoid.Parent:FindFirstChild("Left Arm") or humanoid.Parent:FindFirstChild("LeftHand")
		welder.C0 = CFrame.new(0,welder.Part1.Size.Y/2+rocketClone.Size.Y/2,0)
		debris:AddItem(rocketClone,0.5)
	end

	wait(.5)

	Handle.Mesh.MeshId = "http://www.roblox.com/asset/?id=31601544"
	Tool.Enabled = true

end

Tool.Activated:Connect(onActivated)


function onEquipped()
	humanoid = Tool.Parent:FindFirstChildOfClass("Humanoid")
	character = humanoid.Parent
	player = players:GetPlayerFromCharacter(character)
	if not humanoid then return end
	Animations = {
		RocketKickBack = AnimationFolder:WaitForChild(humanoid.RigType.Name):WaitForChild("rocketkickback"),
		RocketReload = AnimationFolder:WaitForChild(humanoid.RigType.Name):WaitForChild("rocketreload")
	}
	for animname,anims in pairs(Animations) do
		Animations[animname] = humanoid:LoadAnimation(anims)
	end
end

function onUnequipped()
	for _,anims in pairs(Animations) do
		anims:Stop()
	end
	Animations = {}
end

Tool.Equipped:Connect(onEquipped)
