-- DELTA - CLASSIC R6 STYLE ANIMATION (WITH YOUR ANIM IDs)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Wait for Torso and Motor6D joints
local Torso = character:WaitForChild("Torso")
local RightShoulder = Torso:WaitForChild("Right Shoulder")
local LeftShoulder = Torso:WaitForChild("Left Shoulder")
local RightHip = Torso:WaitForChild("Right Hip")
local LeftHip = Torso:WaitForChild("Left Hip")
local Neck = Torso:WaitForChild("Neck")

local pose = "Standing"
local jumpMaxLimbVelocity = 0.75

-- ANIMATION IDs (your animations)
local ANIM_IDS = {
    Climb = "rbxassetid://79803710816119",
    Idle = "rbxassetid://114314636834018",
    Jump = "rbxassetid://86004453773274",
    Fall = "rbxassetid://86004453773274",
    Landing = "rbxassetid://127502173653656",
    Walk = "rbxassetid://109289838022745",
    Run = "rbxassetid://109289838022745",
}

-- Load animations into Animator (as backup)
local animator = humanoid:WaitForChild("Animator")
local animTracks = {}
for name, id in pairs(ANIM_IDS) do
    local anim = Instance.new("Animation")
    anim.AnimationId = id
    local track = animator:LoadAnimation(anim)
    if track then
        animTracks[name] = track
        print("✅ Loaded:", name)
    end
end

-- Classic animation functions
function moveJump()
    RightShoulder.MaxVelocity = jumpMaxLimbVelocity
    LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
    RightShoulder:SetDesiredAngle(3.14)
    LeftShoulder:SetDesiredAngle(-3.14)
    RightHip:SetDesiredAngle(0)
    LeftHip:SetDesiredAngle(0)
end

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
    RightShoulder:SetDesiredAngle(3.14/2)
    LeftShoulder:SetDesiredAngle(-3.14/2)
    RightHip:SetDesiredAngle(3.14/2)
    LeftHip:SetDesiredAngle(-3.14/2)
end

function move(time)
    local amplitude, frequency, climbFudge
    
    if pose == "Jumping" then
        moveJump()
        return
    end
    
    if pose == "FreeFall" then
        moveFreeFall()
        return
    end
    
    if pose == "Seated" then
        moveSit()
        return
    end
    
    climbFudge = 0
    
    if pose == "Running" then
        if RightShoulder.CurrentAngle > 1.5 or RightShoulder.CurrentAngle < -1.5 then
            RightShoulder.MaxVelocity = jumpMaxLimbVelocity
        else
            RightShoulder.MaxVelocity = 0.15
        end
        if LeftShoulder.CurrentAngle > 1.5 or LeftShoulder.CurrentAngle < -1.5 then
            LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
        else
            LeftShoulder.MaxVelocity = 0.15
        end
        amplitude = 1
        frequency = 9
    elseif pose == "Climbing" then
        RightShoulder.MaxVelocity = 0.5
        LeftShoulder.MaxVelocity = 0.5
        amplitude = 1
        frequency = 9
        climbFudge = 3.14
    else
        amplitude = 0.1
        frequency = 1
    end
    
    local desiredAngle = amplitude * math.sin(time * frequency)
    
    RightShoulder:SetDesiredAngle(desiredAngle - climbFudge)
    LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
    RightHip:SetDesiredAngle(-desiredAngle)
    LeftHip:SetDesiredAngle(-desiredAngle)
end

-- Event connections
humanoid.Running:Connect(function(speed)
    if speed > 0 then
        pose = "Running"
    else
        pose = "Standing"
    end
end)

humanoid.Jumping:Connect(function()
    pose = "Jumping"
end)

humanoid.Climbing:Connect(function()
    pose = "Climbing"
end)

humanoid.FreeFalling:Connect(function()
    pose = "FreeFall"
end)

humanoid.Seated:Connect(function()
    pose = "Seated"
end)

-- Main animation loop
local function AnimationLoop()
    while character and character.Parent do
        local _, time = task.wait(0.1)
        move(time)
    end
end

-- Start the loop
AnimationLoop()

print("=== CLASSIC ANIMATION CONTROLLER STARTED ===")