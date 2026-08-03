-- DELTA - YOUR ANIMATION FOR 6 SECONDS

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

print("=== SCRIPT LOADED ===")

-- Create GUI
local function CreateGUI()
    local plr = Players.LocalPlayer
    if not plr then return end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "TestGUI"
    gui.Parent = plr.PlayerGui
    gui.ResetOnSpawn = false
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.Position = UDim2.new(0.5, -100, 0.5, -25)
    btn.BackgroundColor3 = Color3.new(1, 0, 0)
    btn.Text = "ACTIVATE"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 20
    btn.Font = Enum.Font.GothamBold
    btn.Parent = gui
    
    btn.MouseButton1Click:Connect(function()
        gui:Destroy()
        RunScript()
    end)
    
    return btn
end

function RunScript()
    print("=== RUNNING ===")
    
    local plr = Players.LocalPlayer
    if not plr then return end
    
    local char = plr.Character
    if not char then
        char = plr.CharacterAdded:Wait()
    end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- Get Animator
    local animator = humanoid:FindFirstChild("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
        task.wait(0.5)
    end
    
    -- PLAY YOUR ANIMATION - FULL 6 SECONDS
    print("Playing your animation...")
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://129082027131827"
    
    local track = animator:LoadAnimation(anim)
    if track then
        track:Play()
        print("✅ Your animation is playing for 6 seconds!")
        task.wait(6)  -- WAIT FULL 6 SECONDS
        track:Stop()
        print("✅ Animation finished!")
    else
        print("❌ Failed to load your animation!")
    end
    
    print("=== DONE ===")
end

-- Start
CreateGUI()

-- R key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R then
        local gui = Players.LocalPlayer.PlayerGui:FindFirstChild("TestGUI")
        if gui then gui:Destroy() end
        RunScript()
    end
end)

print("=== READY - Click button or press R ===")
