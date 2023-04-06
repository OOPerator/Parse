local thistool = Instance.new("Tool",owner.Backpack)
thistool.RequiresHandle = false
thistool.Name = "1/4"


NLS([[

mouse = game.Players.LocalPlayer:GetMouse()

local tool = script.Parent
local mouse = game.Players.LocalPlayer:GetMouse()



tool.Activated:Connect(function()
	
	local target = mouse.Target

	tool.RemoteEvent:FireServer(target)
	
end)

]],thistool)


local tool = thistool
local MaxPieces = 12
local Explode = true

function IsWhole(Number)

	return math.ceil(Number) == Number
	
end

function ChangeAxis(Vector,Axis,Value)
	if(Axis == "x")then
		return Vector3.new(Value,Vector.y,Vector.z)
	end


	if(Axis == "y")then
		return Vector3.new(Vector.x,Value,Vector.z)
	end

	if(Axis == "z")then
		return Vector3.new(Vector.x,Vector.y,Value)
	end

end


tool.RemoteEvent.OnServerEvent:Connect(function(player,target)


	if(target==nil or target.ClassName == "MeshPart" or tool.Equipped == false)then return end
	local Targ = target
	local FF = 1

	if(Targ.Anchored) then Targ.Anchored = false
	end

	if(Targ.formFactor == Enum.FormFactor.Symmetric)then
		FF = 1 
	end

	if(Targ.formFactor == Enum.FormFactor.Brick)then
		FF = 1.2
	end

	if(Targ.formFactor == Enum.FormFactor.Plate)then
		FF = 0.4 
	end


	local New = Targ:Clone()

	local Rotation = Targ.CFrame - Targ.CFrame.p

	local SizeFactorX = 1

	local SizeFactorY = FF

	local SizeFactorZ = 1

	local Extra = (Targ.Size.x*Targ.Size.y*Targ.Size.z/(SizeFactorX*SizeFactorY*SizeFactorZ))/MaxPieces

	while Extra > 1 do

		SizeFactorX = SizeFactorX * 2
		SizeFactorY = SizeFactorY * 2
		SizeFactorZ = SizeFactorZ * 2
		if(SizeFactorX > Targ.Size.x)then
			SizeFactorX = Targ.Size.x
		end

		if(SizeFactorY > Targ.Size.y)then
			SizeFactorY = Targ.Size.y
		end

		if(SizeFactorZ > Targ.Size.z)then
			SizeFactorZ = Targ.Size.z
		end

		Extra = (Targ.Size.x*Targ.Size.y*Targ.Size.z/(SizeFactorX*SizeFactorY*SizeFactorZ))/MaxPieces
		task.wait()
	end

	local Start = Targ.Position - (Targ.CFrame.lookVector * (Targ.Size.z/2 + (SizeFactorZ / 2)))-((Targ.CFrame * CFrame.fromEulerAnglesXYZ(0,math.pi/2,0)).lookVector * (Targ.Size.x/2 + (SizeFactorX / 2)))-((Targ.CFrame * CFrame.fromEulerAnglesXYZ(math.pi/2,0,0)).lookVector * (Targ.Size.y/2 + (SizeFactorY/2)))

	New.Size = Vector3.new(SizeFactorX,SizeFactorY,SizeFactorZ)
	local OverShootZ = (Targ.Size.z/SizeFactorZ) - math.floor(Targ.Size.z/SizeFactorZ)
	local OverShootX = (Targ.Size.x/SizeFactorX) - math.floor(Targ.Size.x/SizeFactorX)
	local OverShootY = (Targ.Size.y/SizeFactorY) - math.floor(Targ.Size.y/SizeFactorY)
	print("SizeFactor",SizeFactorX,SizeFactorY,SizeFactorZ)
	print("OverShoot",OverShootX,OverShootY,OverShootZ)
	for z = 1,math.ceil(Targ.Size.z/SizeFactorZ) do
		if(OverShootZ > 0)then
			if(z == math.ceil(Targ.Size.z/SizeFactorZ))then
				z = z - ((1 - OverShootZ) / 2)
				New.Size = ChangeAxis(New.Size,"z",OverShootZ * SizeFactorZ)
			else
				New.Size = ChangeAxis(New.Size,"z",SizeFactorZ)
			end

		end

		for y = 1,math.ceil(Targ.Size.y/SizeFactorY) do
			if(OverShootY > 0)then
				if(y == math.ceil(Targ.Size.y/SizeFactorY))then
					y = y - ((1 - OverShootY) / 2)
					New.Size = ChangeAxis(New.Size,"y",OverShootY * SizeFactorY)
				else
					New.Size = ChangeAxis(New.Size,"y",SizeFactorY)
				end

			end

			for x = 1,math.ceil(Targ.Size.x/SizeFactorX) do
				if(OverShootX > 0)then
					if(x == math.ceil(Targ.Size.x/SizeFactorX))then
						x = x - ((1 - OverShootX) / 2)
						New.Size = ChangeAxis(New.Size,"x",OverShootX * SizeFactorX)
					else
						New.Size = ChangeAxis(New.Size,"x",SizeFactorX)
					end

				end

				local N = New:Clone()
				N.CFrame = CFrame.new(Start + (Targ.CFrame.lookVector * z * SizeFactorZ)+((Targ.CFrame * CFrame.fromEulerAnglesXYZ(0,math.pi/2,0)).lookVector * x * SizeFactorX)+((Targ.CFrame * CFrame.fromEulerAnglesXYZ(math.pi/2,0,0)).lookVector * y * SizeFactorY))*Rotation
				N.Parent = game.Workspace
			end

		end

	end

	Targ:Destroy()

end)
