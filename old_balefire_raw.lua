bin = script.Parent
local COOLDOWN = 1 --s

function balefire(pos)

local player = game.Players.LocalPlayer
if player == nil or player.Character == nil then return end

local char = player.Character.Head --I'maa firin mah laza! (Shoop da woop)

dir = (pos - char.CFrame.p).unit

for i = 1,10 do --Change this to change the range
local ex = Instance.new("Explosion") --I wonder if i can change it to sparkles
ex.BlastRadius = 3 --Blast radius, Don't go over 5.
ex.BlastPressure = 10000000 --Blast pressure, this one's a good one.
ex.Position = char.CFrame.p + (dir * 6 * i) + (dir * 7)
ex.Parent = game.Workspace
end
end


enabled = true
function onButton1Down(mouse)
if not enabled then
return
end

local player = game.Players.LocalPlayer
if player == nil then return end



enabled = false
mouse.Icon = "rbxasset://textures\\GunWaitCursor.png" --Cursor

-- find the best cf
local cf = mouse.Hit
local v = cf.lookVector

balefire(cf.p)

wait(COOLDOWN)
mouse.Icon = "rbxasset://textures\\GunCursor.png" --Cursor
enabled = true

end

function onSelected(mouse)
mouse.Icon = "rbxasset://textures\\GunCursor.png" --Cursor
mouse.Button1Down:connect(function() onButton1Down(mouse) end)
end

bin.Selected:connect(onSelected)
