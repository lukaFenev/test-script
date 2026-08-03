-- DELTA - PHONE ANIMATION CONTROLLER (BUTTONS)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")

-- ANIMATION IDs
local ANIMS = {
    Climb = "rbxassetid://79803710816119",
    Idle = "rbxassetid://114314636834018",
    Jump = "rbxassetid://86004453773274",
    Fall = "rbxassetid://86004453773274",
    Landing = "rbxassetid://127502173653656",
    Walk = "rbxassetid://109289838022745",
    Run = "rbxassetid://109289838022745",
}

-- Load animations
local tracks = {}
for name, id in pairs(ANIMS) do
    local anim = Instance.new("Animation")
    anim.AnimationId = id
    local track = animator:LoadAnimation(anim)
    if track then
        tracks[name] = track
    end
end

local currentTrack = nil

local function PlayAnim(name)
    if currentTrack then
        currentTrack:Stop()
    end
    local track = tracks[name]
    if track then
        track:Play()
        currentTrack = track
    end
end

-- CREATE GUI WITH BUTTONS
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

local function MakeButton(text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 150, 0, 40)
    btn.Position = UDim2.new(0.5, -75, 0, y)
    btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text
    btn.TextSize = 18
    btn.Font = Enum.Font.GothamBold
    btn.Parent = screenGui
    btn.MouseButton1Click:Connect(callback)
    return btn
end

MakeButton("Idle", 50, function() PlayAnim("Idle") end)
MakeButton("Walk", 100, function() PlayAnim("Walk") end)
MakeButton("Run", 150, function() PlayAnim("Run") end)
MakeButton("Jump", 200, function() PlayAnim("Jump") end)
MakeButton("Fall", 250, function() PlayAnim("Fall") end)
MakeButton("Climb", 300, function() PlayAnim("Climb") end)
MakeButton("Landing", 350, function() PlayAnim("Landing") end)
MakeButton("STOP", 400, function() 
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
end)

print("=== PHONE ANIMATION CONTROLLER READY ===")
NOW: Buttons appear on screen. Tap them to play animations. Simple. 🚀

what the fuck does ll that mean? also im not sure if is the thing we need



function waitForChild(parent, childName)
	local child = parent:findFirstChild(childName)
	if child then return child end
	while true do
		child = parent.ChildAdded:wait()
		if child.Name==childName then return child end
	end
end

-- ANIMATION

-- declarations

local Figure = script.Parent
local Torso = waitForChild(Figure, "Torso")
local RightShoulder = waitForChild(Torso, "Right Shoulder")
local LeftShoulder = waitForChild(Torso, "Left Shoulder")
local RightHip = waitForChild(Torso, "Right Hip")
local LeftHip = waitForChild(Torso, "Left Hip")
local Neck = waitForChild(Torso, "Neck")
local Humanoid = waitForChild(Figure, "Humanoid")
local pose = "Standing"

local toolAnim = "None"
local toolAnimTime = 0

local jumpMaxLimbVelocity = 0.75

-- functions

function onRunning(speed)
	if speed>0 then
		pose = "Running"
	else
		pose = "Standing"
	end
end

function onDied()
	pose = "Dead"
	local creatorTags = script.Parent.Humanoid:GetChildren()
	local victors = {}
	if #creatorTags >= 1 then
		for i = 1, #creatorTags do
			if creatorTags[i].Name == "creator" and creatorTags[i].Value ~= nil and creatorTags[i].Value.Parent ~= nil then
				local alreadyCounted = false
				if #victors >= 1 then
					for j = 1, #victors do
						if victors[j] == creatorTags[i].Value then alreadyCounted = true end
					end
				end
				if alreadyCounted == false then victors[#victors + 1] = creatorTags[i].Value end
			end
		end
	end
	if #victors >= 1 then
		for i = 1, #victors do
			if victors[i]:FindFirstChild("leaderstats") ~= nil and victors[i].leaderstats:FindFirstChild("KOs") ~= nil then
				victors[i].leaderstats.KOs.Value = victors[i].leaderstats.KOs.Value + 1
			end
			if victors[i]:FindFirstChild("EXP") ~= nil then
				victors[i].EXP.Value = victors[i].EXP.Value + 50
			end
		end
	end
	game.Players:GetPlayerFromCharacter(script.Parent).PlayerGui.MainGui.Cards.MenuBtn.Visible = false
end

function onJumping()
	pose = "Jumping"
end

function onClimbing()
	pose = "Climbing"
end

function onGettingUp()
	pose = "GettingUp"
end

function onFreeFall()
	pose = "FreeFall"
end

function onFallingDown()
	pose = "FallingDown"
end

function onSeated()
	pose = "Seated"
end

function onPlatformStanding()
	pose = "PlatformStanding"
end

function onSwimming(speed)
	if speed>0 then
		pose = "Running"
	else
		pose = "Standing"
	end
end

function moveJump()
	RightShoulder.MaxVelocity = jumpMaxLimbVelocity
	LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
	RightShoulder:SetDesiredAngle(3.14)
	LeftShoulder:SetDesiredAngle(-3.14)
	RightHip:SetDesiredAngle(0)
	LeftHip:SetDesiredAngle(0)
end


-- same as jump for now

function moveFreeFall()
	RightShoulder.MaxVelocity = jumpMaxLimbVelocity
	LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
	RightShoulder:SetDesiredAngle(3.14)
	LeftShoulder:SetDesiredAngle(-3.14)
	RightHip:SetDesiredAngle(0)
	LeftHip:SetDesiredAngle(0)
end

function moveSit()
	RightShoulder.MaxVelocity = 0.15
	LeftShoulder.MaxVelocity = 0.15
	RightShoulder:SetDesiredAngle(3.14 /2)
	LeftShoulder:SetDesiredAngle(-3.14 /2)
	RightHip:SetDesiredAngle(3.14 /2)
	LeftHip:SetDesiredAngle(-3.14 /2)
end

function getTool()	
	for _, kid in ipairs(Figure:GetChildren()) do
		if kid.className == "Tool" then return kid end
	end
	return nil
end

function getToolAnim(tool)
	for _, c in ipairs(tool:GetChildren()) do
		if c.Name == "toolanim" and c.className == "StringValue" then
			return c
		end
	end
	return nil
end

function animateTool()
	
	if (toolAnim == "None") then
		RightShoulder:SetDesiredAngle(1.57)
		return
	end

	if (toolAnim == "Slash") then
		RightShoulder.MaxVelocity = 0.5
		RightShoulder:SetDesiredAngle(0)
		return
	end

	if (toolAnim == "Lunge") then
		RightShoulder.MaxVelocity = 0.5
		LeftShoulder.MaxVelocity = 0.5
		RightHip.MaxVelocity = 0.5
		LeftHip.MaxVelocity = 0.5
		RightShoulder:SetDesiredAngle(1.57)
		LeftShoulder:SetDesiredAngle(1.0)
		RightHip:SetDesiredAngle(1.57)
		LeftHip:SetDesiredAngle(1.0)
		return
	end
end

function move(time)
	local amplitude
	local frequency
  
	if (pose == "Jumping") then
		moveJump()
		return
	end

	if (pose == "FreeFall") then
		moveFreeFall()
		return
	end
 
	if (pose == "Seated") then
		moveSit()
		return
	end

	local climbFudge = 0
	
	if (pose == "Running") then
    if (RightShoulder.CurrentAngle > 1.5 or RightShoulder.CurrentAngle < -1.5) then
			RightShoulder.MaxVelocity = jumpMaxLimbVelocity
		else			
			RightShoulder.MaxVelocity = 0.15
		end
		if (LeftShoulder.CurrentAngle > 1.5 or LeftShoulder.CurrentAngle < -1.5) then
			LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
		else			
			LeftShoulder.MaxVelocity = 0.15
		end
		amplitude = 1
		frequency = 9
	elseif (pose == "Climbing") then
		RightShoulder.MaxVelocity = 0.5 
		LeftShoulder.MaxVelocity = 0.5
		amplitude = 1
		frequency = 9
		climbFudge = 3.14
	else
		amplitude = 0.1
		frequency = 1
	end

	desiredAngle = amplitude * math.sin(time*frequency)

	RightShoulder:SetDesiredAngle(desiredAngle - climbFudge)
	LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
	RightHip:SetDesiredAngle(-desiredAngle)
	LeftHip:SetDesiredAngle(-desiredAngle)


	local tool = getTool()

	if tool then
	
		animStringValueObject = getToolAnim(tool)

		if animStringValueObject then
			toolAnim = animStringValueObject.Value
			-- message recieved, delete StringValue
			animStringValueObject.Parent = nil
			toolAnimTime = time + .3
		end

		if time > toolAnimTime then
			toolAnimTime = 0
			toolAnim = "None"
		end

		animateTool()

		
	else
		toolAnim = "None"
		toolAnimTime = 0
	end

end


-- connect events

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)
-- main program

local runService = game:service("RunService");

while Figure.Parent~=nil do
	local _, time = wait(0.1)
	move(time)
end
