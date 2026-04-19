--[[
    Blox Fruits Script - Rayfield UI
    Complete Feature Set
]]

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Player Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Settings Table
_G.Config = {
    -- Main Farm
    AutoFarm = false,
    AutoFarmMode = "Level",
    SelectedWeapon = "Melee",
    FastAttackSpeed = 0.1,
    BringMobs = true,
    FarmDistance = 30,
    
    -- Mastery
    AutoMastery = false,
    MasteryType = "Level",
    KillAtHealth = 25,
    
    -- Combat
    AutoHaki = true,
    AutoObservation = false,
    
    -- Stats
    AutoMelee = false,
    AutoDefense = false,
    AutoSword = false,
    AutoGun = false,
    AutoFruit = false,
    
    -- Boss
    AutoBoss = false,
    SelectedBoss = "",
    
    -- Material
    AutoMaterial = false,
    SelectedMaterial = "",
    
    -- Misc
    AntiAFK = true,
    WhiteScreen = false,
    WalkOnWater = true,
    InfiniteEnergy = false,
    NoClip = false,
    FastSpeed = false,
    SpeedMultiplier = 1,
}

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "Blox Fruits Script | Premium",
    LoadingTitle = "Blox Fruits Script",
    LoadingSubtitle = "by YourName",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BloxFruitsRayfield",
        FileName = "BloxConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
})

-- Tabs
local MainTab = Window:CreateTab("🏠 Main", 4483362458)
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)
local StatsTab = Window:CreateTab("📊 Stats", 4483362458)
local BossTab = Window:CreateTab("👹 Boss", 4483362458)
local TeleportTab = Window:CreateTab("🌎 Teleport", 4483362458)
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

-- ================== MAIN TAB ==================
local FarmSection = MainTab:CreateSection("Auto Farm")

local AutoFarmToggle = MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        _G.Config.AutoFarm = Value
    end,
})

local WeaponDropdown = MainTab:CreateDropdown({
    Name = "Select Weapon Type",
    Options = {"Melee", "Sword", "Blox Fruit"},
    CurrentOption = "Melee",
    Flag = "WeaponDropdown",
    Callback = function(Option)
        _G.Config.SelectedWeapon = Option
    end,
})

local BringMobToggle = MainTab:CreateToggle({
    Name = "Bring Mobs",
    CurrentValue = true,
    Flag = "BringMobToggle",
    Callback = function(Value)
        _G.Config.BringMobs = Value
    end,
})

local FastAttackToggle = MainTab:CreateToggle({
    Name = "Fast Attack",
    CurrentValue = false,
    Flag = "FastAttackToggle",
    Callback = function(Value)
        _G.Config.FastAttack = Value
    end,
})

local MasterySection = MainTab:CreateSection("Mastery Farm")

local AutoMasteryToggle = MainTab:CreateToggle({
    Name = "Auto Mastery",
    CurrentValue = false,
    Flag = "AutoMasteryToggle",
    Callback = function(Value)
        _G.Config.AutoMastery = Value
    end,
})

local MasteryModeDropdown = MainTab:CreateDropdown({
    Name = "Mastery Mode",
    Options = {"Level", "Nearest"},
    CurrentOption = "Level",
    Flag = "MasteryMode",
    Callback = function(Option)
        _G.Config.MasteryType = Option
    end,
})

local HealthSlider = MainTab:CreateSlider({
    Name = "Kill at Health %",
    Range = {0, 100},
    Increment = 5,
    CurrentValue = 25,
    Flag = "HealthSlider",
    Callback = function(Value)
        _G.Config.KillAtHealth = Value
    end,
})

-- ================== COMBAT TAB ==================
local CombatSection = CombatTab:CreateSection("Combat Settings")

local AutoHakiToggle = CombatTab:CreateToggle({
    Name = "Auto Haki",
    CurrentValue = true,
    Flag = "AutoHaki",
    Callback = function(Value)
        _G.Config.AutoHaki = Value
    end,
})

local AutoObsToggle = CombatTab:CreateToggle({
    Name = "Auto Observation",
    CurrentValue = false,
    Flag = "AutoObs",
    Callback = function(Value)
        _G.Config.AutoObservation = Value
    end,
})

local DistanceSlider = CombatTab:CreateSlider({
    Name = "Farm Distance",
    Range = {1, 50},
    Increment = 1,
    CurrentValue = 30,
    Flag = "FarmDistance",
    Callback = function(Value)
        _G.Config.FarmDistance = Value
    end,
})

-- ================== STATS TAB ==================
local StatsSection = StatsTab:CreateSection("Auto Upgrade Stats")

local MeleeToggle = StatsTab:CreateToggle({
    Name = "Auto Melee",
    CurrentValue = false,
    Flag = "AutoMelee",
    Callback = function(Value)
        _G.Config.AutoMelee = Value
    end,
})

local DefenseToggle = StatsTab:CreateToggle({
    Name = "Auto Defense",
    CurrentValue = false,
    Flag = "AutoDefense",
    Callback = function(Value)
        _G.Config.AutoDefense = Value
    end,
})

local SwordToggle = StatsTab:CreateToggle({
    Name = "Auto Sword",
    CurrentValue = false,
    Flag = "AutoSword",
    Callback = function(Value)
        _G.Config.AutoSword = Value
    end,
})

local GunToggle = StatsTab:CreateToggle({
    Name = "Auto Gun",
    CurrentValue = false,
    Flag = "AutoGun",
    Callback = function(Value)
        _G.Config.AutoGun = Value
    end,
})

local FruitToggle = StatsTab:CreateToggle({
    Name = "Auto Devil Fruit",
    CurrentValue = false,
    Flag = "AutoFruit",
    Callback = function(Value)
        _G.Config.AutoFruit = Value
    end,
})

-- ================== BOSS TAB ==================
local BossSection = BossTab:CreateSection("Boss Farming")

-- Boss list varies by sea
local BossList = {"Saber Expert", "Warden", "Chief Warden", "Swan"}

local BossDropdown = BossTab:CreateDropdown({
    Name = "Select Boss",
    Options = BossList,
    CurrentOption = BossList[1],
    Flag = "BossDropdown",
    Callback = function(Option)
        _G.Config.SelectedBoss = Option
    end,
})

local AutoBossToggle = BossTab:CreateToggle({
    Name = "Auto Farm Boss",
    CurrentValue = false,
    Flag = "AutoBoss",
    Callback = function(Value)
        _G.Config.AutoBoss = Value
    end,
})

-- ================== TELEPORT TAB ==================
local WorldSection = TeleportTab:CreateSection("World Teleport")

local Sea1Button = TeleportTab:CreateButton({
    Name = "First Sea",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end,
})

local Sea2Button = TeleportTab:CreateButton({
    Name = "Second Sea",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end,
})

local Sea3Button = TeleportTab:CreateButton({
    Name = "Third Sea",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end,
})

-- ================== MISC TAB ==================
local MiscSection = MiscTab:CreateSection("Miscellaneous")

local WhiteScreenToggle = MiscTab:CreateToggle({
    Name = "White Screen",
    CurrentValue = false,
    Flag = "WhiteScreen",
    Callback = function(Value)
        _G.Config.WhiteScreen = Value
        RunService:Set3dRenderingEnabled(not Value)
    end,
})

local WalkWaterToggle = MiscTab:CreateToggle({
    Name = "Walk on Water",
    CurrentValue = true,
    Flag = "WalkWater",
    Callback = function(Value)
        _G.Config.WalkOnWater = Value
    end,
})

local NoClipToggle = MiscTab:CreateToggle({
    Name = "No Clip",
    CurrentValue = false,
    Flag = "NoClip",
    Callback = function(Value)
        _G.Config.NoClip = Value
    end,
})

local RejoinButton = MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end,
})

-- ================== PLAYER TAB ==================
local PlayerSection = PlayerTab:CreateSection("Player Settings")

local SpeedToggle = PlayerTab:CreateToggle({
    Name = "Speed Boost",
    CurrentValue = false,
    Flag = "SpeedBoost",
    Callback = function(Value)
        _G.Config.FastSpeed = Value
    end,
})

local SpeedSlider = PlayerTab:CreateSlider({
    Name = "Speed Multiplier",
    Range = {1, 5},
    Increment = 0.5,
    CurrentValue = 1,
    Flag = "SpeedMultiplier",
    Callback = function(Value)
        _G.Config.SpeedMultiplier = Value
    end,
})

-- ================== CORE FUNCTIONS ==================

-- Auto Haki Function
function AutoHaki()
    if not Player.Character:FindFirstChild("HasBuso") then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end

-- Equip Weapon Function
function EquipWeapon()
    for _, v in pairs(Player.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            if _G.Config.SelectedWeapon == "Melee" and v.ToolTip == "Melee" then
                Humanoid:EquipTool(v)
                return
            elseif _G.Config.SelectedWeapon == "Sword" and v.ToolTip == "Sword" then
                Humanoid:EquipTool(v)
                return
            elseif _G.Config.SelectedWeapon == "Blox Fruit" and v.ToolTip == "Blox Fruit" then
                Humanoid:EquipTool(v)
                return
            end
        end
    end
end

-- Tween Function
function TweenToPosition(targetPos)
    local distance = (targetPos.Position - HumanoidRootPart.Position).Magnitude
    local speed = 300
    local tweenInfo = TweenInfo.new(distance/speed, Enum.EasingStyle.Linear)
    
    local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = targetPos})
    tween:Play()
    
    return tween
end

-- Fast Attack Function
local CombatFramework = require(Player.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = debug.getupvalues(CombatFramework)[2]

function FastAttack()
    if _G.Config.FastAttack then
        pcall(function()
            if CombatFrameworkR.activeController then
                CombatFrameworkR.activeController.timeToNextAttack = 0
                CombatFrameworkR.activeController.attacking = false
                CombatFrameworkR.activeController.increment = 3
                CombatFrameworkR.activeController.hitboxMagnitude = 55
                CombatFrameworkR.activeController.blocking = false
            end
        end)
    end
end

-- Bring Mobs Function
function BringMobs()
    if not _G.Config.BringMobs then return end
    
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            local distance = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if distance < 350 then
                v.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -_G.Config.FarmDistance)
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                v.HumanoidRootPart.Transparency = 1
                v.Humanoid.WalkSpeed = 0
                v.Humanoid.JumpPower = 0
                
                if v.Humanoid:FindFirstChild("Animator") then
                    v.Humanoid.Animator:Destroy()
                end
                
                sethiddenproperty(Player, "SimulationRadius", math.huge)
            end
        end
    end
end

-- Auto Farm Level Loop
spawn(function()
    while wait() do
        if _G.Config.AutoFarm then
            pcall(function()
                AutoHaki()
                EquipWeapon()
                FastAttack()
                BringMobs()
                
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                        repeat
                            wait(_G.Config.FastAttackSpeed)
                            AutoHaki()
                            EquipWeapon()
                            FastAttack()
                            
                            HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.FarmDistance, 0)
                            
                            VirtualUser:CaptureController()
                            VirtualUser:Button1Down(Vector2.new(1280, 672))
                        until not _G.Config.AutoFarm or not enemy.Parent or enemy.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

-- Auto Stats Loops
spawn(function()
    while wait(0.1) do
        pcall(function()
            if _G.Config.AutoMelee then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
            end
            if _G.Config.AutoDefense then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
            end
            if _G.Config.AutoSword then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
            end
            if _G.Config.AutoGun then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1)
            end
            if _G.Config.AutoFruit then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1)
            end
        end)
    end
end)

-- Walk on Water
spawn(function()
    while wait(0.1) do
        pcall(function()
            if _G.Config.WalkOnWater then
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
            else
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
            end
        end)
    end
end)

-- No Clip
spawn(function()
    RunService.Stepped:Connect(function()
        if _G.Config.NoClip then
            for _, v in pairs(Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

-- Speed Boost
spawn(function()
    while wait() do
        if _G.Config.FastSpeed then
            pcall(function()
                Humanoid.WalkSpeed = 16 * _G.Config.SpeedMultiplier
            end)
        else
            pcall(function()
                Humanoid.WalkSpeed = 16
            end)
        end
    end
end)

-- Anti AFK
Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Success Notification
Rayfield:Notify({
    Title = "Script Loaded!",
    Content = "Blox Fruits script loaded successfully",
    Duration = 5,
    Image = 4483362458,
})

print("Blox Fruits Script Loaded Successfully")
