--[[
    CHOPPED VERSION - Stops after spawning character
]]

local Players = game:GetService("Players")

local function CreateObject()
    local object = Instance.new("Model")
    object.Name = "RandObjTest"
    local parent = object
    
    -- Create 030obj (MeshPart)
    local obj030 = Instance.new("MeshPart")
    obj030.Name = "030obj"
    obj030.Size = Vector3.new(1, 1, 1)
    obj030.Anchored = true
    obj030.Parent = parent
    
    -- Bones inside 030obj
    local bdy = Instance.new("Bone")
    bdy.Name = "bdy"
    bdy.Parent = obj030
    
    local l_shulder = Instance.new("Bone")
    l_shulder.Name = "l_shulder"
    l_shulder.Parent = bdy
    
    local hand_l = Instance.new("Bone")
    hand_l.Name = "hand_l"
    hand_l.Parent = l_shulder
    
    local hand_l001 = Instance.new("Bone")
    hand_l001.Name = "hand_l.001"
    hand_l001.Parent = hand_l
    
    local r_shulder = Instance.new("Bone")
    r_shulder.Name = "r_shulder"
    r_shulder.Parent = bdy
    
    local hand_r = Instance.new("Bone")
    hand_r.Name = "hand_r"
    hand_r.Parent = r_shulder
    
    local hand_r001 = Instance.new("Bone")
    hand_r001.Name = "hand_r.001"
    hand_r001.Parent = hand_r
    
    local hed = Instance.new("Bone")
    hed.Name = "hed"
    hed.Parent = bdy
    
    local hed001 = Instance.new("Bone")
    hed001.Name = "hed.001"
    hed001.Parent = hed
    
    local l_leg = Instance.new("Bone")
    l_leg.Name = "l_leg"
    l_leg.Parent = bdy
    
    local l_leg001 = Instance.new("Bone")
    l_leg001.Name = "l_leg.001"
    l_leg001.Parent = l_leg
    
    local bdy001 = Instance.new("Bone")
    bdy001.Name = "bdy.001"
    bdy001.Parent = bdy
    
    local bdy002 = Instance.new("Bone")
    bdy002.Name = "bdy.002"
    bdy002.Parent = bdy001
    
    local r_leg = Instance.new("Bone")
    r_leg.Name = "r_leg"
    r_leg.Parent = bdy
    
    local r_leg001 = Instance.new("Bone")
    r_leg001.Name = "r_leg.001"
    r_leg001.Parent = r_leg
    
    -- Create InitialPoses (Folder)
    local initialPoses = Instance.new("Folder")
    initialPoses.Name = "InitialPoses"
    initialPoses.Parent = parent
    
    -- Helper function to create CFrameValues
    local function CreateCFrameValue(name, parent)
        local cframe = Instance.new("CFrameValue")
        cframe.Name = name
        cframe.Value = CFrame.new()
        cframe.Parent = parent
        return cframe
    end
    
    CreateCFrameValue("030obj_Composited", initialPoses)
    CreateCFrameValue("030obj_Original", initialPoses)
    CreateCFrameValue("030obj_Initial", initialPoses)
    CreateCFrameValue("Armature_Composited", initialPoses)
    CreateCFrameValue("Armature_Original", initialPoses)
    CreateCFrameValue("Armature_Initial", initialPoses)
    CreateCFrameValue("bdy_Composited", initialPoses)
    CreateCFrameValue("bdy_Original", initialPoses)
    CreateCFrameValue("bdy_Initial", initialPoses)
    CreateCFrameValue("l_shulder_Composited", initialPoses)
    CreateCFrameValue("l_shulder_Original", initialPoses)
    CreateCFrameValue("l_shulder_Initial", initialPoses)
    CreateCFrameValue("hand_l_Composited", initialPoses)
    CreateCFrameValue("hand_l_Original", initialPoses)
    CreateCFrameValue("hand_l_Initial", initialPoses)
    CreateCFrameValue("hand_l.001_Composited", initialPoses)
    CreateCFrameValue("hand_l.001_Original", initialPoses)
    CreateCFrameValue("hand_l.001_Initial", initialPoses)
    CreateCFrameValue("r_shulder_Composited", initialPoses)
    CreateCFrameValue("r_shulder_Original", initialPoses)
    CreateCFrameValue("r_shulder_Initial", initialPoses)
    CreateCFrameValue("hand_r_Composited", initialPoses)
    CreateCFrameValue("hand_r_Original", initialPoses)
    CreateCFrameValue("hand_r_Initial", initialPoses)
    CreateCFrameValue("hand_r.001_Composited", initialPoses)
    CreateCFrameValue("hand_r.001_Original", initialPoses)
    CreateCFrameValue("hand_r.001_Initial", initialPoses)
    CreateCFrameValue("hed_Composited", initialPoses)
    CreateCFrameValue("hed_Original", initialPoses)
    CreateCFrameValue("hed_Initial", initialPoses)
    CreateCFrameValue("hed.001_Composited", initialPoses)
    CreateCFrameValue("hed.001_Original", initialPoses)
    CreateCFrameValue("hed.001_Initial", initialPoses)
    CreateCFrameValue("l_leg_Composited", initialPoses)
    CreateCFrameValue("l_leg_Original", initialPoses)
    CreateCFrameValue("l_leg_Initial", initialPoses)
    CreateCFrameValue("l_leg.001_Composited", initialPoses)
    CreateCFrameValue("l_leg.001_Original", initialPoses)
    CreateCFrameValue("l_leg.001_Initial", initialPoses)
    CreateCFrameValue("bdy.001_Composited", initialPoses)
    CreateCFrameValue("bdy.001_Original", initialPoses)
    CreateCFrameValue("bdy.001_Initial", initialPoses)
    CreateCFrameValue("bdy.002_Composited", initialPoses)
    CreateCFrameValue("bdy.002_Original", initialPoses)
    CreateCFrameValue("bdy.002_Initial", initialPoses)
    CreateCFrameValue("r_leg_Composited", initialPoses)
    CreateCFrameValue("r_leg_Original", initialPoses)
    CreateCFrameValue("r_leg_Initial", initialPoses)
    CreateCFrameValue("r_leg.001_Composited", initialPoses)
    CreateCFrameValue("r_leg.001_Original", initialPoses)
    CreateCFrameValue("r_leg.001_Initial", initialPoses)
    
    local animController = Instance.new("AnimationController")
    animController.Name = "AnimationController"
    animController.Parent = parent
    
    return object
end

local function Main()
    local player = Players.LocalPlayer
    if not player or not player.Character then return end
    
    local character = player.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local spawnPosition = humanoidRootPart.Position
    
    local newObject = CreateObject()
    newObject.Parent = workspace
    
    local primaryPart = newObject:FindFirstChild("030obj")
    if primaryPart then
        newObject:SetPrimaryPartCFrame(CFrame.new(spawnPosition))
    end
    
    print("✅ Character spawned at:", spawnPosition)
    print("✅ Object Name:", newObject.Name)
    print("✅ Stopping script - character is ready!")
end

coroutine.wrap(Main)()
