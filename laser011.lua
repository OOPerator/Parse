local tween = game:GetService("TweenService")
local hb = game:GetService("RunService")
local tool = thistool
local NaN = 0/0
owner = owner

thistool = Instance.new("Tool",owner.Backpack)
thistool.Name = "laser"
thistool.RequiresHandle = true

event1 = Instance.new("RemoteEvent",thistool)
event1.Name = "Toggle"

event2 = Instance.new("RemoteEvent",thistool)
event2.Name = "Update"

handle = Instance.new("Part",thistool)
handle.Name = "Handle"
handle.Size = Vector3.new(0.2,0.2,0.2)
handle.Transparency = 1

thistool.GripUp = Vector3.new(0, 8.940696716308594e-08, 0.9999998807907104)
thistool.GripRight = Vector3.new(0.9999999403953552, 0, 0)
thistool.GripPos = Vector3.new(1.3678975105285645, 0.7379775643348694, -1.235037922859192)
thistool.GripForward = Vector3.new(-0, 0.9999999403953552, -5.960464477539063e-08)


NLS([[

local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local hb = game:GetService("RunService")

function Equipped()

	tool.Enabled = true	

	local held = false
	local function MouseDown()
		held = true
		tool.Toggle:FireServer(held)
	end
	mouse.Button1Down:Connect(MouseDown)

	local function MouseUp()
		held = false
		tool.Toggle:FireServer(held)
	end
	mouse.Button1Up:Connect(MouseUp)

	while true do
		hb.PreAnimation:Wait()
		if held and tool.Enabled then
			local hit_p = mouse.Hit.p
			local start_pos = tool.Handle.Position
			tool.Update:FireServer(hit_p,start_pos)			
		end	
	end
end

tool.Equipped:Connect(Equipped)

function UnEquipped()
	held = false
	tool.Enabled = false
end

tool.Unequipped:Connect(UnEquipped)

hb.PreAnimation:Connect(function()
	local path = tool.Handle:FindFirstChild("beam")
	if path and held then
		path.LocalTransparencyModifier = 0
	end
end)

]],thistool)

tool = thistool


tool.Equipped:Connect(function()
	
	tool.Enabled = true
	
end)



local isHolding = false


local hit_p
local start_pos

if tool.Handle:FindFirstChild("beam") then
	tool.Handle:FindFirstChild("beam"):Destroy()
end

toggleRemote = tool.Toggle

updatePos = tool.Update

function makebeampart()
	beam = Instance.new("Part",tool.Handle)
	beam.Name = "beam"
	beam.Anchored = true
	beam.CanCollide = false
	beam.Color = Color3.fromRGB(255,000,000)
	beam.Material = "Neon"
	beam.TopSurface = "Smooth"
	beam.BottomSurface = "Smooth"
	beam.CastShadow = false
	beam.Transparency = 1

end

toggleRemote.OnServerEvent:Connect(function(plr, state)
	
	if plr ~= owner then
		return
	end

	isHolding = state
	if isHolding == false then
		beam.Transparency = 1
	else
		beam.Transparency = 0
	end

		if not hit_p or not start_pos then
			repeat wait() until hit_p and start_pos
		end
	
	if tool.Enabled == true then
		repeat
			
			local direction = (hit_p - start_pos).Unit * 2000

			local ray = workspace:Raycast(start_pos, direction)


			local midpoint = start_pos + direction/2

			beam.CFrame = CFrame.new(midpoint,hit_p)
			beam.Size = Vector3.new(1,1,direction.magnitude)

						local function laze(hit)


				task.spawn(function()
					hit.Anchored = false
					
					local start = tick()

					while tick() < start + 0.5 do
						hb.Heartbeat:Wait()
						hit.Color = Color3.new(math.random(),math.random(),math.random())
						beam.Color = hit.Color
					end

				end)

				task.spawn(function()

					hit.Material = "Neon"

					local info = TweenInfo.new(	
						0.5,						
						Enum.EasingStyle.Elastic,						
						Enum.EasingDirection.In,					
						0,
						false,
						0
					)

					local goals = 
						{
							Transparency = 1;
							Position = hit.Position + Vector3.new(30,30,30);
						}

					local fx = tween:Create(hit,info,goals)
					fx:Play()

					task.wait(0.5)
					hit.AssemblyLinearVelocity = Vector3.new(NaN,NaN,NaN)
					hit.AssemblyAngularVelocity = Vector3.new(NaN,NaN,NaN)
					hit:Destroy()

				end)


			end


			if ray and ray.Instance and not ray.Instance:IsDescendantOf(owner.Character) and ray.Instance.Name ~= "Base" then				
				laze(ray.Instance)
			end



			local touch = workspace:GetPartsInPart(beam)
			for i,v in pairs(touch) do
				if not v:IsDescendantOf(owner.Character) and v.Name ~= "Base" then
					laze(v)
				end

			end


			hb.PreAnimation:Wait()
		until isHolding == false
		
	end

end)

updatePos.OnServerEvent:Connect(function(plr, hitPos, startPos)
	if plr ~= owner then
		return
	end

	hit_p = hitPos
	start_pos = startPos
end)

tool.Unequipped:Connect(function()
	tool.Enabled = false
	tool.Handle.beam:Destroy()
	isHolding = false
end)

tool.Equipped:Connect(makebeampart)


while true do

	pcall(function()

		hb.Heartbeat:Wait()

		beam.Color = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do
			hb.Heartbeat:Wait()
			beam.Color = Color3.new(255/255,i/255,0/255)
		end

		for i = 255,0,-10 do
			hb.Heartbeat:Wait()
			beam.Color = Color3.new(i/255,255/255,0/255)
		end

		for i = 0,255,10 do
			hb.Heartbeat:Wait()
			beam.Color = Color3.new(0/255,255/255,i/255)
		end

		for i = 255,0,-10 do
			hb.Heartbeat:Wait()
			beam.Color = Color3.new(0/255,i/255,255/255)
		end

		for i = 0,255,10 do
			hb.Heartbeat:Wait()
			beam.Color = Color3.new(i/255,0/255,255/255)
		end

		for i = 255,0,-10 do
			hb.Heartbeat:Wait()
			beam.Color = Color3.new(255/255,0/255,i/255)
		end


	end)

end



