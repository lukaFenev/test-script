-- DELTA - MINIMUM VIABLE BUTTON

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("=== SCRIPT LOADED ===")

-- CREATE REMOTE FOR KICK
local remote = ReplicatedStorage:FindFirstChild("KickRemote")
if not remote then
    remote = Instance.new("RemoteEvent")
    remote.Name = "KickRemote"
    remote.Parent = ReplicatedStorage
end

-- CREATE SERVER SCRIPT
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
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= player then
                        p:Kick("Kicked!")
                    end
                end
                task.wait(0.5)
                player:Kick("Game over!")
            end)
        end
    ]=]
    return script
end
CreateServerScript()

-- ========== SIMPLE GUI ==========
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

-- ========== MAIN FUNCTION ==========
function Main()
    print("=== MAIN RUNNING ===")
    
    local player = Players.LocalPlayer
    if not player then return end
    
    local char = player.Character
    if not char then
        char = player.CharacterAdded:Wait()
    end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- INVISIBLE
    print("Making invisible...")
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
        end
    end
    
    -- ANIMATION
    print("Playing animation...")
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://129082027131827"
    
    local animator = humanoid:FindFirstChild("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end
    
    task.wait(0.2)
    
    local track = animator:LoadAnimation(anim)
    if track then
        track:Play()
        print("✅ Animation playing!")
    end
    
    -- WAIT
    print("Waiting 5 seconds...")
    task.wait(5)
    
    -- KICK
    print("Kicking everyone...")
    remote:FireServer()
    
    print("=== DONE ===")
end

-- CREATE GUI
CreateGUI()

-- R KEY
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R then
        local gui = Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI")
        if gui then gui:Destroy() end
        Main()
    end
end)

print("=== READY ===")
