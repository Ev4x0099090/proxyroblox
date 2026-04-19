local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

_G.Settings = {
    -- Farming
    AutoFarm = false,
    AutoFarmLevel = false,
    FastAttack = false,
    BringMob = true,
    
    -- Combat
    SelectedWeapon = "Melee",
    AutoHaki = false,
    
    -- Mastery
    AutoMastery = false,
    MasteryMode = "Level",
    HealthPercent = 25,
    
    -- Misc
    AntiAFK = true,
    WhiteScreen = false,
    RemoveNotifications = false,
}

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "Blox Fruits Script",
    LoadingTitle = "Loading Script...",
    LoadingSubtitle = "by Your Name",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BloxFruitsConfig",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
})

-- Create Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local CombatTab = Window:CreateTab("Combat", 4483362458)
local StatsTab = Window:CreateTab("Stats", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Main Section
local FarmSection = MainTab:CreateSection("Auto Farm")

local AutoLevelToggle = MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmLevel",
    Callback = function(Value)
        _G.Settings.AutoFarmLevel = Value
    end,
})

local WeaponDropdown = MainTab:CreateDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Blox Fruit"},
    CurrentOption = "Melee",
    Flag = "WeaponSelect",
    Callback = function(Option)
        _G.Settings.SelectedWeapon = Option
    end,
})

-- Combat Section
local CombatSection = CombatTab:CreateSection("Combat Settings")

local FastAttackToggle = CombatTab:CreateToggle({
    Name = "Fast Attack",
    CurrentValue = false,
    Flag = "FastAttack",
    Callback = function(Value)
        _G.Settings.FastAttack = Value
    end,
})

local BringMobToggle = CombatTab:CreateToggle({
    Name = "Bring Mob",
    CurrentValue = true,
    Flag = "BringMob",
    Callback = function(Value)
        _G.Settings.BringMob = Value
    end,
})

-- Stats Section
local StatsSection = StatsTab:CreateSection("Auto Stats")

local MeleeButton = StatsTab:CreateButton({
    Name = "Auto Melee Stats",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 3)
    end,
})

local DefenseButton = StatsTab:CreateButton({
    Name = "Auto Defense Stats",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 3)
    end,
})

-- Teleport Section
local TeleportSection = TeleportTab:CreateSection("World Teleport")

local Sea1Button = TeleportTab:CreateButton({
    Name = "Teleport to First Sea",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end,
})

local Sea2Button = TeleportTab:CreateButton({
    Name = "Teleport to Second Sea",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end,
})

-- Misc Section
local MiscSection = MiscTab:CreateSection("Miscellaneous")

local WhiteScreenToggle = MiscTab:CreateToggle({
    Name = "White Screen",
    CurrentValue = false,
    Flag = "WhiteScreen",
    Callback = function(Value)
        _G.Settings.WhiteScreen = Value
        game:GetService("RunService"):Set3dRenderingEnabled(not Value)
    end,
})

local RemoveNotifToggle = MiscTab:CreateToggle({
    Name = "Remove Notifications",
    CurrentValue = false,
    Flag = "RemoveNotif",
    Callback = function(Value)
        _G.Settings.RemoveNotifications = Value
        player.PlayerGui.Notifications.Enabled = not Value
    end,
})

-- Functions
function AutoHaki()
    if not player.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function EquipWeapon(weapon)
    if player.Backpack:FindFirstChild(weapon) then
        player.Character.Humanoid:EquipTool(player.Backpack:FindFirstChild(weapon))
    end
end

-- Auto Farm Loop
spawn(function()
    while wait() do
        if _G.Settings.AutoFarmLevel then
            pcall(function()
                -- Add your auto farm logic here
                AutoHaki()
                -- Equip weapon, find enemies, attack, etc.
            end)
        end
    end
end)

-- Anti AFK
if _G.Settings.AntiAFK then
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end

-- Notification
Rayfield:Notify({
    Title = "Script Loaded",
    Content = "Blox Fruits script loaded successfully!",
    Duration = 5,
    Image = 4483362458,
})
