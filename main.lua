-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Player Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Update character references on respawn
Player.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Settings Table
_G.Config = {
    -- Main Farm
    AutoFarm = false,
    AutoFarmMode = "Level",
    SelectedWeapon = "Melee",
    FastAttack = false,
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
local BossList = {"Saber Expert", "Warden", "Chief Warden", "Swan", "Thunder God", "Cyborg"}

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
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
        end)
    end,
})

local Sea2Button = TeleportTab:CreateButton({
    Name = "Second Sea",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
        end)
    end,
})

local Sea3Button = TeleportTab:CreateButton({
    Name = "Third Sea",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
        end)
    end,
})

-- ================== MISC TAB ==================
local MiscSection = MiscTab:CreateSection("Miscellaneous")

local WhiteScreenToggle = MiscTab:CreateToggle({
    Name = "White Screen (FPS Boost)",
    CurrentValue = false,
    Flag = "WhiteScreen",
    Callback = function(Value)
        _G.Config.WhiteScreen = Value
        if Value then
            game:GetService("RunService"):Set3dRenderingEnabled(false)
        else
            game:GetService("RunService"):Set3dRenderingEnabled(true)
        end
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

-- Auto Haki Function (FIXED)
function AutoHaki()
    pcall(function()
        if _G.Config.AutoHaki and not Character:FindFirstChild("HasBuso") then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end
    end)
end

-- Auto Observation (FIXED)
function AutoObservation()
    pcall(function()
        if _G.Config.AutoObservation then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Ken", true)
        end
    end)
end

-- Equip Weapon Function (IMPROVED)
function EquipWeapon()
    pcall(function()
        for _, v in pairs(Player.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                if _G.Config.SelectedWeapon == "Melee" and v.ToolTip == "Melee" then
                    Humanoid:EquipTool(v)
                    return true
                elseif _G.Config.SelectedWeapon == "Sword" and v.ToolTip == "Sword" then
                    Humanoid:EquipTool(v)
                    return true
                elseif _G.Config.SelectedWeapon == "Blox Fruit" and v.ToolTip == "Blox Fruit" then
                    Humanoid:EquipTool(v)
                    return true
                end
            end
        end
    end)
end

-- Tween Function (IMPROVED)
function TweenToPosition(targetCFrame)
    pcall(function()
        local distance = (targetCFrame.Position - HumanoidRootPart.Position).Magnitude
        local speed = 300
        local duration = distance / speed
        
        local tweenInfo = TweenInfo.new(
            duration,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )
        
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        
        return tween
    end)
end

-- Fast Attack Function (FIXED - Alternative method)
local AttackCooldown = 0
function FastAttack()
    if not _G.Config.FastAttack then return end
    
    pcall(function()
        local currentTick = tick()
        if currentTick - AttackCooldown >= 0.1 then
            AttackCooldown = currentTick
            
            -- Try to get combat framework
            local CombatFramework = debug.getupvalues(require(Player.PlayerScripts.CombatFramework))
            for i, v in pairs(CombatFramework) do
                if type(v) == "table" then
                    if v.activeController then
                        v.activeController.timeToNextAttack = 0
                        v.activeController.hitboxMagnitude = 55
                        v.activeController.active = false
                        v.activeController.timeToNextBlock = 0
                        v.activeController.focusStart = 0
                        v.activeController.increment = 4
                        v.activeController.blocking = false
                        v.activeController.attacking = false
                        v.activeController.humanoid.AutoRotate = true
                    end
                end
            end
        end
    end)
end

-- Click Attack (Alternative to Fast Attack)
function ClickAttack()
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        wait()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
end

-- Bring Mobs Function (IMPROVED)
function BringMobs(targetPosition)
    if not _G.Config.BringMobs then return end
    
    pcall(function()
        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                local distance = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                
                if distance < 350 then
                    v.HumanoidRootPart.CFrame = targetPosition or (HumanoidRootPart.CFrame * CFrame.new(0, 0, -_G.Config.FarmDistance))
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                    v.HumanoidRootPart.Transparency = 1
                    v.Humanoid.WalkSpeed = 0
                    v.Humanoid.JumpPower = 0
                    
                    if v.Humanoid:FindFirstChild("Animator") then
                        v.Humanoid.Animator:Destroy()
                    end
                    
                    -- Make sure we can interact with the mob
                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                end
            end
        end
    end)
end

-- Get nearest enemy
function GetNearestEnemy()
    local nearestEnemy = nil
    local shortestDistance = math.huge
    
    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
            local distance = (enemy.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = enemy
            end
        end
    end
    
    return nearestEnemy
end

-- Auto Farm Level Loop (FIXED)
task.spawn(function()
    while task.wait() do
        if _G.Config.AutoFarm then
            pcall(function()
                local enemy = GetNearestEnemy()
                
                if enemy then
                    repeat
                        task.wait()
                        
                        -- Enable Haki
                        AutoHaki()
                        AutoObservation()
                        
                        -- Equip weapon
                        EquipWeapon()
                        
                        -- Position player
                        local attackCFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.FarmDistance, 0)
                        HumanoidRootPart.CFrame = attackCFrame
                        
                        -- Bring mobs
                        BringMobs(attackCFrame)
                        
                        -- Attack
                        if _G.Config.FastAttack then
                            FastAttack()
                        end
                        ClickAttack()
                        
                    until not _G.Config.AutoFarm or not enemy.Parent or enemy.Humanoid.Health <= 0
                end
            end)
        end
    end
end)

-- Auto Boss Farm (FIXED)
task.spawn(function()
    while task.wait() do
        if _G.Config.AutoBoss and _G.Config.SelectedBoss ~= "" then
            pcall(function()
                for _, boss in pairs(game.Workspace.Enemies:GetChildren()) do
                    if boss.Name == _G.Config.SelectedBoss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            
                            AutoHaki()
                            AutoObservation()
                            EquipWeapon()
                            
                            local attackCFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.FarmDistance, 0)
                            HumanoidRootPart.CFrame = attackCFrame
                            
                            if _G.Config.FastAttack then
                                FastAttack()
                            end
                            ClickAttack()
                            
                        until not _G.Config.AutoBoss or not boss.Parent or boss.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

-- Auto Stats Loops (FIXED)
task.spawn(function()
    while task.wait(0.5) do
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

-- Walk on Water (FIXED)
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if _G.Config.WalkOnWater then
                if game.Workspace:FindFirstChild("Map") then
                    local seaBase = game.Workspace.Map:FindFirstChild("WaterBase-Plane") or 
                                   game.Workspace.Map:FindFirstChild("WaterBase")
                    if seaBase then
                        seaBase.Size = Vector3.new(1000, 112, 1000)
                    end
                end
            end
        end)
    end
end)

-- No Clip (FIXED)
task.spawn(function()
    RunService.Stepped:Connect(function()
        if _G.Config.NoClip then
            pcall(function()
                for _, v in pairs(Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        end
    end)
end)

-- Speed Boost (FIXED)
task.spawn(function()
    while task.wait() do
        pcall(function()
            if _G.Config.FastSpeed then
                Humanoid.WalkSpeed = 16 * _G.Config.SpeedMultiplier
            else
                Humanoid.WalkSpeed = 16
            end
        end)
    end
end)

-- Anti AFK (FIXED)
Player.Idled:Connect(function()
    pcall(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Success Notification
Rayfield:Notify({
    Title = "Script Loaded!",
    Content = "Blox Fruits script loaded successfully",
    Duration = 5,
    Image = 4483362458,
})

print("✅ Blox Fruits Script Loaded Successfully - All Functions Active")
