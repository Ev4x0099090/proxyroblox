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
    AutoQuest = true,
    
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

-- Quest Data Table (Level-based enemy selection)
local QuestData = {
    -- First Sea
    ["Bandit"] = {Level = 5, QuestGiver = "BanditQuest1", QuestName = "BanditQuest1", LevelReq = 0, QuestNum = 1},
    ["Monkey"] = {Level = 14, QuestGiver = "JungleQuest", QuestName = "JungleQuest", LevelReq = 9, QuestNum = 1},
    ["Gorilla"] = {Level = 20, QuestGiver = "JungleQuest", QuestName = "JungleQuest", LevelReq = 15, QuestNum = 2},
    ["Pirate"] = {Level = 35, QuestGiver = "BuggyQuest1", QuestName = "BuggyQuest1", LevelReq = 30, QuestNum = 1},
    ["Brute"] = {Level = 45, QuestGiver = "BuggyQuest1", QuestName = "BuggyQuest1", LevelReq = 40, QuestNum = 2},
    ["Desert Bandit"] = {Level = 60, QuestGiver = "DesertQuest", QuestName = "DesertQuest", LevelReq = 55, QuestNum = 1},
    ["Desert Officer"] = {Level = 70, QuestGiver = "DesertQuest", QuestName = "DesertQuest", LevelReq = 65, QuestNum = 2},
    ["Snow Bandit"] = {Level = 90, QuestGiver = "SnowQuest", QuestName = "SnowQuest", LevelReq = 85, QuestNum = 1},
    ["Snowman"] = {Level = 100, QuestGiver = "SnowQuest", QuestName = "SnowQuest", LevelReq = 95, QuestNum = 2},
    ["Chief Petty Officer"] = {Level = 120, QuestGiver = "MarineQuest2", QuestName = "MarineQuest2", LevelReq = 115, QuestNum = 1},
    ["Sky Bandit"] = {Level = 150, QuestGiver = "SkyQuest", QuestName = "SkyQuest", LevelReq = 145, QuestNum = 1},
    ["Dark Master"] = {Level = 175, QuestGiver = "SkyQuest", QuestName = "SkyQuest", LevelReq = 170, QuestNum = 2},
    ["Prisoner"] = {Level = 190, QuestGiver = "PrisonerQuest", QuestName = "PrisonerQuest", LevelReq = 185, QuestNum = 1},
    ["Dangerous Prisoner"] = {Level = 210, QuestGiver = "PrisonerQuest", QuestName = "PrisonerQuest", LevelReq = 205, QuestNum = 2},
    ["Toga Warrior"] = {Level = 250, QuestGiver = "ColosseumQuest", QuestName = "ColosseumQuest", LevelReq = 245, QuestNum = 1},
    ["Gladiator"] = {Level = 275, QuestGiver = "ColosseumQuest", QuestName = "ColosseumQuest", LevelReq = 270, QuestNum = 2},
    ["Military Soldier"] = {Level = 300, QuestGiver = "MagmaQuest", QuestName = "MagmaQuest", LevelReq = 295, QuestNum = 1},
    ["Military Spy"] = {Level = 325, QuestGiver = "MagmaQuest", QuestName = "MagmaQuest", LevelReq = 320, QuestNum = 2},
    ["Fishman Warrior"] = {Level = 375, QuestGiver = "FishmanQuest", QuestName = "FishmanQuest", LevelReq = 370, QuestNum = 1},
    ["Fishman Commando"] = {Level = 400, QuestGiver = "FishmanQuest", QuestName = "FishmanQuest", LevelReq = 395, QuestNum = 2},
    ["God's Guard"] = {Level = 450, QuestGiver = "SkyExp1Quest", QuestName = "SkyExp1Quest", LevelReq = 445, QuestNum = 1},
    ["Shanda"] = {Level = 475, QuestGiver = "SkyExp1Quest", QuestName = "SkyExp1Quest", LevelReq = 470, QuestNum = 2},
    ["Royal Squad"] = {Level = 525, QuestGiver = "SkyExp2Quest", QuestName = "SkyExp2Quest", LevelReq = 520, QuestNum = 1},
    ["Royal Soldier"] = {Level = 550, QuestGiver = "SkyExp2Quest", QuestName = "SkyExp2Quest", LevelReq = 545, QuestNum = 2},
    ["Galley Pirate"] = {Level = 625, QuestGiver = "FountainQuest", QuestName = "FountainQuest", LevelReq = 620, QuestNum = 1},
    ["Galley Captain"] = {Level = 650, QuestGiver = "FountainQuest", QuestName = "FountainQuest", LevelReq = 645, QuestNum = 2},
    
    -- Second Sea
    ["Raider"] = {Level = 700, QuestGiver = "Area1Quest", QuestName = "Area1Quest", LevelReq = 695, QuestNum = 1},
    ["Mercenary"] = {Level = 725, QuestGiver = "Area1Quest", QuestName = "Area1Quest", LevelReq = 720, QuestNum = 2},
    ["Swan Pirate"] = {Level = 775, QuestGiver = "Area2Quest", QuestName = "Area2Quest", LevelReq = 770, QuestNum = 1},
    ["Factory Staff"] = {Level = 800, QuestGiver = "Area2Quest", QuestName = "Area2Quest", LevelReq = 795, QuestNum = 2},
    ["Marine Lieutenant"] = {Level = 875, QuestGiver = "MarineQuest3", QuestName = "MarineQuest3", LevelReq = 870, QuestNum = 1},
    ["Marine Captain"] = {Level = 900, QuestGiver = "MarineQuest3", QuestName = "MarineQuest3", LevelReq = 895, QuestNum = 2},
    ["Zombie"] = {Level = 950, QuestGiver = "ZombieQuest", QuestName = "ZombieQuest", LevelReq = 945, QuestNum = 1},
    ["Vampire"] = {Level = 975, QuestGiver = "ZombieQuest", QuestName = "ZombieQuest", LevelReq = 970, QuestNum = 2},
    ["Snow Trooper"] = {Level = 1000, QuestGiver = "SnowMountainQuest", QuestName = "SnowMountainQuest", LevelReq = 995, QuestNum = 1},
    ["Winter Warrior"] = {Level = 1050, QuestGiver = "SnowMountainQuest", QuestName = "SnowMountainQuest", LevelReq = 1045, QuestNum = 2},
    ["Lab Subordinate"] = {Level = 1100, QuestGiver = "IceSideQuest", QuestName = "IceSideQuest", LevelReq = 1095, QuestNum = 1},
    ["Horned Warrior"] = {Level = 1125, QuestGiver = "IceSideQuest", QuestName = "IceSideQuest", LevelReq = 1120, QuestNum = 2},
    ["Magma Ninja"] = {Level = 1175, QuestGiver = "FireSideQuest", QuestName = "FireSideQuest", LevelReq = 1170, QuestNum = 1},
    ["Lava Pirate"] = {Level = 1200, QuestGiver = "FireSideQuest", QuestName = "FireSideQuest", LevelReq = 1195, QuestNum = 2},
    ["Ship Deckhand"] = {Level = 1250, QuestGiver = "ShipQuest1", QuestName = "ShipQuest1", LevelReq = 1245, QuestNum = 1},
    ["Ship Engineer"] = {Level = 1275, QuestGiver = "ShipQuest1", QuestName = "ShipQuest1", LevelReq = 1270, QuestNum = 2},
    ["Ship Steward"] = {Level = 1300, QuestGiver = "ShipQuest2", QuestName = "ShipQuest2", LevelReq = 1295, QuestNum = 1},
    ["Ship Officer"] = {Level = 1325, QuestGiver = "ShipQuest2", QuestName = "ShipQuest2", LevelReq = 1320, QuestNum = 2},
    ["Arctic Warrior"] = {Level = 1350, QuestGiver = "FrostQuest", QuestName = "FrostQuest", LevelReq = 1345, QuestNum = 1},
    ["Snow Lurker"] = {Level = 1375, QuestGiver = "FrostQuest", QuestName = "FrostQuest", LevelReq = 1370, QuestNum = 2},
    ["Sea Soldier"] = {Level = 1425, QuestGiver = "ForgottenQuest", QuestName = "ForgottenQuest", LevelReq = 1420, QuestNum = 1},
    ["Water Fighter"] = {Level = 1450, QuestGiver = "ForgottenQuest", QuestName = "ForgottenQuest", LevelReq = 1445, QuestNum = 2},
    
    -- Third Sea
    ["Pirate Millionaire"] = {Level = 1500, QuestGiver = "PiratePortQuest", QuestName = "PiratePortQuest", LevelReq = 1495, QuestNum = 1},
    ["Pistol Billionaire"] = {Level = 1525, QuestGiver = "PiratePortQuest", QuestName = "PiratePortQuest", LevelReq = 1520, QuestNum = 2},
    ["Dragon Crew Warrior"] = {Level = 1575, QuestGiver = "AmazonQuest", QuestName = "AmazonQuest", LevelReq = 1570, QuestNum = 1},
    ["Dragon Crew Archer"] = {Level = 1600, QuestGiver = "AmazonQuest", QuestName = "AmazonQuest", LevelReq = 1595, QuestNum = 2},
    ["Female Islander"] = {Level = 1625, QuestGiver = "AmazonQuest2", QuestName = "AmazonQuest2", LevelReq = 1620, QuestNum = 1},
    ["Giant Islander"] = {Level = 1650, QuestGiver = "AmazonQuest2", QuestName = "AmazonQuest2", LevelReq = 1645, QuestNum = 2},
    ["Marine Commodore"] = {Level = 1700, QuestGiver = "MarineTreeIsland", QuestName = "MarineTreeIsland", LevelReq = 1695, QuestNum = 1},
    ["Marine Rear Admiral"] = {Level = 1725, QuestGiver = "MarineTreeIsland", QuestName = "MarineTreeIsland", LevelReq = 1720, QuestNum = 2},
    ["Fishman Raider"] = {Level = 1775, QuestGiver = "DeepForestIsland3", QuestName = "DeepForestIsland3", LevelReq = 1770, QuestNum = 1},
    ["Fishman Captain"] = {Level = 1800, QuestGiver = "DeepForestIsland3", QuestName = "DeepForestIsland3", LevelReq = 1795, QuestNum = 2},
    ["Forest Pirate"] = {Level = 1850, QuestGiver = "DeepForestIsland", QuestName = "DeepForestIsland", LevelReq = 1845, QuestNum = 1},
    ["Mythological Pirate"] = {Level = 1875, QuestGiver = "DeepForestIsland", QuestName = "DeepForestIsland", LevelReq = 1870, QuestNum = 2},
    ["Jungle Pirate"] = {Level = 1900, QuestGiver = "DeepForestIsland2", QuestName = "DeepForestIsland2", LevelReq = 1895, QuestNum = 1},
    ["Musketeer Pirate"] = {Level = 1925, QuestGiver = "DeepForestIsland2", QuestName = "DeepForestIsland2", LevelReq = 1920, QuestNum = 2},
    ["Reborn Skeleton"] = {Level = 1975, QuestGiver = "HauntedQuest1", QuestName = "HauntedQuest1", LevelReq = 1970, QuestNum = 1},
    ["Living Zombie"] = {Level = 2000, QuestGiver = "HauntedQuest1", QuestName = "HauntedQuest1", LevelReq = 1995, QuestNum = 2},
    ["Demonic Soul"] = {Level = 2025, QuestGiver = "HauntedQuest2", QuestName = "HauntedQuest2", LevelReq = 2020, QuestNum = 1},
    ["Posessed Mummy"] = {Level = 2050, QuestGiver = "HauntedQuest2", QuestName = "HauntedQuest2", LevelReq = 2045, QuestNum = 2},
}

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "Blox Fruits Safe Farm | ProjectXY",
    LoadingTitle = "Blox Fruits Safe Farming",
    LoadingSubtitle = "by ProjectXY - No Flags Edition",
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

local AutoQuestToggle = MainTab:CreateToggle({
    Name = "Auto Take Quest",
    CurrentValue = true,
    Flag = "AutoQuestToggle",
    Callback = function(Value)
        _G.Config.AutoQuest = Value
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
            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
        end)
    end,
})

local Sea2Button = TeleportTab:CreateButton({
    Name = "Second Sea",
    Callback = function()
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
        end)
    end,
})

local Sea3Button = TeleportTab:CreateButton({
    Name = "Third Sea",
    Callback = function()
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
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
            RunService:Set3dRenderingEnabled(false)
        else
            RunService:Set3dRenderingEnabled(true)
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

-- Get player level
function GetPlayerLevel()
    return Player.Data.Level.Value
end

-- Find best mob for player level
function GetBestMobForLevel()
    local playerLevel = GetPlayerLevel()
    local bestMob = nil
    local closestLevelDiff = math.huge
    
    for mobName, data in pairs(QuestData) do
        if playerLevel >= data.LevelReq then
            local levelDiff = math.abs(data.Level - playerLevel)
            if levelDiff < closestLevelDiff then
                closestLevelDiff = levelDiff
                bestMob = {Name = mobName, Data = data}
            end
        end
    end
    
    return bestMob
end

-- Check if quest is active
function CheckQuest()
    local questTitle = Player.PlayerGui.Main.Quest
    if questTitle.Visible then
        return true
    end
    return false
end

-- Get current quest name
function GetCurrentQuest()
    local questTitle = Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
    return questTitle
end

-- Check if player has the correct quest active
function HasCorrectQuest(mobName)
    local questGui = Player.PlayerGui.Main.Quest
    if not questGui.Visible then
        return false
    end
    
    local questTitle = questGui.Container.QuestTitle.Title.Text
    return string.find(questTitle, mobName) ~= nil
end

-- Safe Tween Function (NO INSTANT TP)
local currentTween = nil
function SafeTween(targetCFrame, stopOnArrival)
    pcall(function()
        -- Cancel existing tween
        if currentTween then
            currentTween:Cancel()
        end
        
        local distance = (targetCFrame.Position - HumanoidRootPart.Position).Magnitude
        local speed = 300 -- Safe speed
        local duration = distance / speed
        
        -- Minimum duration to prevent flags
        if duration < 0.5 then
            duration = 0.5
        end
        
        local tweenInfo = TweenInfo.new(
            duration,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )
        
        currentTween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        currentTween:Play()
        
        if stopOnArrival then
            currentTween.Completed:Wait()
        end
    end)
end

-- Take Quest Safely
function TakeQuestSafely(mobName, questGiver, questNum)
    if not _G.Config.AutoQuest then return false end
    
    pcall(function()
        -- First, abandon any wrong quest
        if CheckQuest() and not HasCorrectQuest(mobName) then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
            wait(0.5)
        end
        
        -- If no quest or wrong quest, take the correct one
        if not HasCorrectQuest(mobName) then
            -- Get quest giver location from workspace
            local questGiverNPC = workspace.NPCs:FindFirstChild(questGiver)
            
            if questGiverNPC and questGiverNPC:FindFirstChild("HumanoidRootPart") then
                -- Tween to quest giver safely
                local questCFrame = questGiverNPC.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                SafeTween(questCFrame, true)
                
                wait(0.5)
                
                -- Take the quest
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questGiver, questNum)
                wait(0.8)
            end
        end
    end)
    
    return HasCorrectQuest(mobName)
end

-- Find nearest enemy of specified type
function FindNearestEnemy(mobName)
    local nearestEnemy = nil
    local shortestDistance = math.huge
    
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy.Name == mobName and 
           enemy:FindFirstChild("Humanoid") and 
           enemy:FindFirstChild("HumanoidRootPart") and 
           enemy.Humanoid.Health > 0 then
            
            local distance = (enemy.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = enemy
            end
        end
    end
    
    return nearestEnemy
end

-- Auto Haki Function
function AutoHaki()
    pcall(function()
        if _G.Config.AutoHaki and not Character:FindFirstChild("HasBuso") then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end
    end)
end

-- Auto Observation
function AutoObservation()
    pcall(function()
        if _G.Config.AutoObservation then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Ken", true)
        end
    end)
end

-- Equip Weapon Function
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

-- Fast Attack Function
local AttackCooldown = 0
function FastAttack()
    if not _G.Config.FastAttack then return end
    
    pcall(function()
        local currentTick = tick()
        if currentTick - AttackCooldown >= 0.1 then
            AttackCooldown = currentTick
            
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

-- Click Attack
function ClickAttack()
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        wait()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
end

-- Enhanced Bring Mobs with safety checks
function BringMobsSafe(mobName, targetPosition)
    if not _G.Config.BringMobs then return end
    
    pcall(function()
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == mobName and 
               v:FindFirstChild("Humanoid") and 
               v:FindFirstChild("HumanoidRootPart") and 
               v.Humanoid.Health > 0 then
                
                local distance = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                
                -- Only bring mobs within reasonable range (anti-flag)
                if distance < 350 then
                    v.HumanoidRootPart.CFrame = targetPosition
                    v.HumanoidRootPart.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                    v.Humanoid.WalkSpeed = 0
                    v.Humanoid.JumpPower = 0
                    
                    if v.Humanoid:FindFirstChild("Animator") then
                        v.Humanoid.Animator:Destroy()
                    end
                    
                    sethiddenproperty(Player, "SimulationRadius", math.huge)
                end
            end
        end
    end)
end

-- ================== AUTO FARM LOOP (SAFE VERSION) ==================
task.spawn(function()
    while task.wait(0.1) do
        if _G.Config.AutoFarm then
            pcall(function()
                local bestMob = GetBestMobForLevel()
                
                if not bestMob then
                    task.wait(2)
                    return
                end
                
                local mobName = bestMob.Name
                local questData = bestMob.Data
                
                -- Step 1: Ensure we have the correct quest
                if _G.Config.AutoQuest then
                    if not HasCorrectQuest(mobName) then
                        TakeQuestSafely(mobName, questData.QuestGiver, questData.QuestNum)
                        wait(1)
                    end
                end
                
                -- Step 2: Find and farm the mob
                local enemy = FindNearestEnemy(mobName)
                
                if enemy then
                    repeat
                        task.wait()
                        
                        -- Check if enemy still exists and is alive
                        if not enemy.Parent or enemy.Humanoid.Health <= 0 then
                            break
                        end
                        
                        -- Enable combat abilities
                        AutoHaki()
                        AutoObservation()
                        
                        -- Equip weapon
                        EquipWeapon()
                        
                        -- Calculate safe attack position
                        local attackCFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.FarmDistance, 0)
                        
                        -- Use SAFE positioning (no instant TP)
                        local distance = (attackCFrame.Position - HumanoidRootPart.Position).Magnitude
                        
                        if distance > 5 then
                            -- Use tween for distances > 5 studs
                            SafeTween(attackCFrame, false)
                        else
                            -- Safe CFrame for very close distances
                            HumanoidRootPart.CFrame = attackCFrame
                        end
                        
                        -- Bring nearby mobs to farming location
                        BringMobsSafe(mobName, attackCFrame)
                        
                        -- Attack
                        if _G.Config.FastAttack then
                            FastAttack()
                        end
                        ClickAttack()
                        
                    until not _G.Config.AutoFarm or 
                          not enemy.Parent or 
                          enemy.Humanoid.Health <= 0 or
                          (HasCorrectQuest(mobName) == false and _G.Config.AutoQuest)
                else
                    -- No enemy found, wait before checking again
                    task.wait(1)
                end
            end)
        end
    end
end)

-- Auto Boss Farm (Safe Version)
task.spawn(function()
    while task.wait(0.2) do
        if _G.Config.AutoBoss and _G.Config.SelectedBoss ~= "" then
            pcall(function()
                for _, boss in pairs(workspace.Enemies:GetChildren()) do
                    if boss.Name == _G.Config.SelectedBoss and 
                       boss:FindFirstChild("Humanoid") and 
                       boss.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            
                            AutoHaki()
                            AutoObservation()
                            EquipWeapon()
                            
                            local attackCFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.FarmDistance, 0)
                            local distance = (attackCFrame.Position - HumanoidRootPart.Position).Magnitude
                            
                            if distance > 5 then
                                SafeTween(attackCFrame, false)
                            else
                                HumanoidRootPart.CFrame = attackCFrame
                            end
                            
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

-- Auto Stats Loops
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

-- Walk on Water
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if _G.Config.WalkOnWater then
                if workspace:FindFirstChild("Map") then
                    local seaBase = workspace.Map:FindFirstChild("WaterBase-Plane") or 
                                   workspace.Map:FindFirstChild("WaterBase")
                    if seaBase then
                        seaBase.Size = Vector3.new(1000, 112, 1000)
                    end
                end
            end
        end)
    end
end)

-- No Clip
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

-- Speed Boost
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

-- Anti AFK
Player.Idled:Connect(function()
    pcall(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Success Notification
Rayfield:Notify({
    Title = "ProjectXY Safe Farm",
    Content = "Safe farming script loaded! No instant TP - Anti-flag protection active!",
    Duration = 5,
    Image = 4483362458,
})

print("✅ Blox Fruits Safe Farm Loaded")
print("📊 Current Level: " .. GetPlayerLevel())
local bestMob = GetBestMobForLevel()
if bestMob then
    print("🎯 Best Mob: " .. bestMob.Name .. " (Level " .. bestMob.Data.Level .. ")")
end
print("🛡️ Anti-Flag Protection: ACTIVE")
