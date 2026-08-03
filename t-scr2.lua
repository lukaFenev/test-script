-- DELTA - FIXED ANIMATION + KICK

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("=== SCRIPT LOADED ===")

-- REMOTE
local remote = ReplicatedStorage:FindFirstChild("KickRemote")
if not remote then
    remote = Instance.new("RemoteEvent")
    remote.Name = "KickRemote"
    remote.Parent = ReplicatedStorage
end

-- SERVER SCRIPT
local function CreateServerScript()
    local script = Instance.new("Script")
    script.Name = "KickServer"
    script.Parent = ReplicatedStorage
    script.Source = [=[
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local remote = ReplicatedStorage:FindFirstChild("KickRemote")
        
        if remote then
            remote.OnServerEvent:Connect(function(player)
                print("=== SERVER KICK STARTED ===")
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= player then
                        print("Kicking:", p.Name)
                        p:Kick("Kicked!")
                    end
                end
                task.wait(0.5)
                print("Kicking host:", player.Name)
                player:Kick("Game over!")
            end)
        end
    ]=]
    return script
end
CreateServerScript()

-- ========== GUI ==========
local function CreateGUI()
    local player = Players.LocalPlayer
    if not player then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MainGUI"
    screenGui.Parent = player.PlayerGui
    screenGui.ResetOnSpawn = false
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 300, 0, 80)
    btn.Position = UDim2.new(0.5, -150, 0.5, -40)
    btn.BackgroundColor3 = Color3.new(1, 0, 0)
    btn.Text = "ACTIVATE"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 30
    btn.Font = Enum.Font.GothamBold
    btn.Parent = screenGui
    
    btn.MouseButton1Click:Connect(function()
        print("🖱️ CLICKED!")
        screenGui:Destroy()
        Main()
    end)
end

-- ========== MAIN ==========
function Main()
    print("=== MAIN RUNNING ===")
    
    local player = Players.LocalPlayer
    if not player then 
        print("❌ No player!")
        return 
    end
    
    local char = player.Character
    if not char then
        print("⏳ Waiting for character...")
        char = player.CharacterAdded:Wait()
    end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then 
        print("❌ No root!")
        return 
    end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then 
        print("❌ No humanoid!")
        return 
    end
    
    print("✅ Character found!")
    
    -- ===== ANIMATION - FIXED =====
    print("Playing animation...")
    
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://129082027131827"
    
    -- Get or create Animator
    local animator = humanoid:FindFirstChild("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
        print("✅ Created Animator")
    end
    
    -- Wait for animator to be ready
    task.wait(0.5)
    
    local success, track = pcall(function()
        return animator:LoadAnimation(anim)
    end)
    
    if success and track then
        track:Play()
        print("✅ Animation playing!")
        
        -- Wait for animation to finish
        task.wait(5)
        track:Stop()
        print("✅ Animation stopped!")
    else
        print("❌ Animation failed to load!")
        print("Error:", success)
        task.wait(5)
    end
    
    -- ===== KICK =====
    print("Firing kick remote...")
    remote:FireServer()
    print("✅ Kick fired!")
    
    print("=== DONE ===")
end

-- START
CreateGUI()

-- R KEY
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R then
        print("🔄 R KEY PRESSED!")
        local gui = Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI")
        if gui then gui:Destroy() end
        Main()
    end
end)

print("=== READY - Click button or press R ===")
print("📌 Animation ID: 129082027131827")
