--[[
    Auto Bounty Script - Combat & Combo System
    Features:
    - Smart teleportation with offset
    - Advanced combo system
    - Auto weapon switching
    - Auto buff activation
--]]
--// Ultra Auto Combo System (Tự động 100%)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")

-- CẤU HÌNH NÂNG CAO
local Config = {
    AttackRange = 10000, -- Phạm vi tấn công
    ComboSpeed = 0.01, -- Tốc độ combo (giây)
    WeaponSwitchDelay = 0.07, -- Thời gian đổi vũ khí
    TargetRefreshRate = 1, -- Tần suất tìm mục tiêu mới (giây)
    SupportSkillsInterval = 7, -- Kích hoạt skill hỗ trợ mỗi (giây)
    AutoPvP = true -- Tự động bật PvP
}

-- DANH SÁCH COMBO TỐI ƯU
local OptimalCombo = {
    {Weapon = "Melee", Key = "C", Priority = 1},
    {Weapon = "Melee", Key = "X", Priority = 2},
    {Weapon = "Fruit", Key = "Z", Priority = 3},
    {Weapon = "Fruit", Key = "X", Priority = 4},
    {Weapon = "Melee", Key = "Z", Priority = 1},
    {Weapon = "Sword", Key = "Z", Priority = 3},
    {Weapon = "Gun", Key = "X", Priority = 2},
    {Weapon = "Fruit", Key = "C", Priority = 4},
    {Weapon = "Sword", Key = "X", Priority = 3},
    {Weapon = "Gun", Key = "Z", Priority = 2},
    {Weapon = "Fruit", Key = "V", Priority = 5},
    {Weapon = "Fruit", Key = "F", Priority = 5}
}

-- HỆ THỐNG VŨ KHÍ
local WeaponSystem = {
    Melee = "One",
    Sword = "Two",
    Gun = "Three",
    Fruit = "Four",
    Current = "Melee"
}

-- BIẾN HỆ THỐNG
local Target = nil
local LastAttack = 0
local SkillCooldowns = {}

-- HÀM NÂNG CAO
local function AdvancedPress(key)
    if not key then return end
    keypress(Enum.KeyCode[key])
    task.wait(0.05)
    keyrelease(Enum.KeyCode[key])
end

local function SwitchWeapon(weaponType)
    if WeaponSystem.Current == weaponType then return end
    local key = WeaponSystem[weaponType]
    if key then
        AdvancedPress(key)
        WeaponSystem.Current = weaponType
        task.wait(Config.WeaponSwitchDelay)
    end
end

-- TỰ ĐỘNG TÌM MỤC TIÊU
local function FindBestTarget()
    local closest = nil
    local minDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and rootPart then
                local myRoot = Character:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    local distance = (rootPart.Position - myRoot.Position).Magnitude
                    if distance < Config.AttackRange and distance < minDistance then
                        closest = player
                        minDistance = distance
                    end
                end
            end
        end
    end
    
    return closest
end

-- HỆ THỐNG COMBO TỰ ĐỘNG
local function AutoCombo()
    while task.wait() do
        -- Làm mới mục tiêu
        Target = FindBestTarget()
        
        if Target and Target.Character then
            -- Sắp xếp combo theo độ ưu tiên
            table.sort(OptimalCombo, function(a, b) return a.Priority > b.Priority end)
            
            -- Thực hiện combo
            for _, attack in ipairs(OptimalCombo) do
                SwitchWeapon(attack.Weapon)
                AdvancedPress(attack.Key)
                task.wait(Config.ComboSpeed)
            end
            
            -- Về vũ khí mặc định
            SwitchWeapon("Melee")
        else
            task.wait(Config.TargetRefreshRate)
        end
    end
end

-- TỰ ĐỘNG KĨ NĂNG HỖ TRỢ
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuration
local keybinds = {
    AURA = Enum.KeyCode.J,
    INSTINCT = Enum.KeyCode.E,
    RACE_V3 = Enum.KeyCode.T,
    RACE_V4 = Enum.KeyCode.Y
}

-- State variables
local auraActive = false
local instinctActive = false

-- Ability activation functions
local function toggleAura()
    -- Game-specific aura activation
    local auraEvent = ReplicatedStorage:FindFirstChild("AuraEvent") 
                   or ReplicatedStorage:FindFirstChild("ToggleAura")
    
    if auraEvent then
        auraActive = not auraActive
        auraEvent:FireServer(auraActive)
        print("Aura", auraActive and "activated" or "deactivated")
    else
        warn("Aura activation event not found!")
    end
end

local function toggleInstinct()
    -- Game-specific instinct activation
    local instinctEvent = ReplicatedStorage:FindFirstChild("InstinctEvent") 
                       or ReplicatedStorage:FindFirstChild("ToggleInstinct")
    
    if instinctEvent then
        instinctActive = not instinctActive
        instinctEvent:FireServer(instinctActive)
        print("Instinct", instinctActive and "activated" or "deactivated")
    else
        warn("Instinct activation event not found!")
    end
end

local function activateRaceV3()
    -- Game-specific race V3 ability
    local raceV3Event = ReplicatedStorage:FindFirstChild("RaceV3Event") 
                      or ReplicatedStorage:FindFirstChild("UseRaceV3")
    
    if raceV3Event then
        raceV3Event:FireServer()
        print("Race V3 ability activated")
    else
        warn("Race V3 ability event not found!")
    end
end

local function activateRaceV4()
    -- Game-specific race V4 ability
    local raceV4Event = ReplicatedStorage:FindFirstChild("RaceV4Event") 
                      or ReplicatedStorage:FindFirstChild("UseRaceV4")
    
    if raceV4Event then
        raceV4Event:FireServer()
        print("Race V4 ability activated")
    else
        warn("Race V4 ability event not found!")
    end
end

-- Keybind handler
local function handleKeybind(input, gameProcessed)
    if gameProcessed then return end -- Ignore if UI is focused
    
    if input.KeyCode == keybinds.AURA then
        toggleAura()
    elseif input.KeyCode == keybinds.INSTINCT then
        toggleInstinct()
    elseif input.KeyCode == keybinds.RACE_V3 then
        activateRaceV3()
    elseif input.KeyCode == keybinds.RACE_V4 then
        activateRaceV4()
    end
end

-- Initialize
UserInputService.InputBegan:Connect(handleKeybind)

-- Add to existing auto-buff system
local function checkBuffs()
    -- Auto-activate aura/instinct when in combat
    if currentTarget and not auraActive then
        toggleAura()
    end
    
    if currentTarget and not instinctActive then
        toggleInstinct()
    end
end

print("Keybind Support System loaded!")

-- Integration with existing systems
-- Add this to your combat loop or periodic check
--[[ Example:
local function combatLoop()
    while true do
        checkBuffs() -- Auto-activate buffs when needed
        -- ... rest of your combat logic
        wait(0.1)
    end
end
]]

return {
    toggleAura = toggleAura,
    toggleInstinct = toggleInstinct,
    activateRaceV3 = activateRaceV3,
    activateRaceV4 = activateRaceV4
}
-- TỰ ĐỘNG PVP
spawn(function()
    while toggleAutoPvP do
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("EnablePvp")
        end)
        wait(2)
    end
end)

-- KHỞI CHẠY HỆ THỐNG
task.spawn(AutoCombo)
task.spawn(AutoSkills)
task.spawn(ManagePvP)

print("🔄 Hệ thống Auto Combo hoàn toàn tự động đã sẵn sàng!")
print("⚔️ Tự động tìm mục tiêu | 🔄 Tự động combo | 🛡️ Tự động kỹ năng")

--Tự động dí theo địch
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Cấu hình
local MAX_CHASE_TIME = 45 -- Giây
local MAX_NO_DAMAGE_TIME = 30 -- Giây
local SAFE_HEALTH_THRESHOLD = 0.1 -- 10% máu
local RETURN_HEALTH_THRESHOLD = 0.3 -- 30% máu
local EVADE_HEIGHT = 5000 -- Độ cao khi né đòn

-- Biến quản lý
local currentTarget = nil
local currentTween = nil
local isChasing = false
local isEvading = false
local lastDamageTime = 0
local chaseStartTime = 0
local connection = nil
local damageConnection = nil
local humanoidConnection = nil

-- Hàm hủy các kết nối
local function cleanup()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    if damageConnection then
        damageConnection:Disconnect()
        damageConnection = nil
    end
    if humanoidConnection then
        humanoidConnection:Disconnect()
        humanoidConnection = nil
    end
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
end

-- Kiểm tra vùng an toàn hoặc PvP (cần điều chỉnh theo game cụ thể)
local function isInSafeZone(player)
    -- Thêm logic kiểm tra vùng an toàn của game bạn ở đây
    return false
end

-- Kiểm tra damage gần đây
local function setupDamageTracking()
    -- Giả sử game có RemoteEvent để track damage
    -- Đây chỉ là ví dụ, cần điều chỉnh theo game cụ thể
    local damageEvent = ReplicatedStorage:FindFirstChild("DamageEvent") or Instance.new("RemoteEvent")
    damageConnection = damageEvent.OnClientEvent:Connect(function(hitPlayer, damage)
        if hitPlayer == currentTarget then
            lastDamageTime = os.time()
        end
    end)
end

-- Tìm người chơi hợp lệ để target
local function getValidTarget()
    local validPlayers = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            
            if targetHumanoid and targetHumanoid.Health > 0 and targetRoot and not isInSafeZone(player) then
                table.insert(validPlayers, player)
            end
        end
    end
    
    -- Sắp xếp theo khoảng cách gần nhất
    table.sort(validPlayers, function(a, b)
        return (HRP.Position - a.Character.HumanoidRootPart.Position).Magnitude < 
               (HRP.Position - b.Character.HumanoidRootPart.Position).Magnitude
    end)
    
    return validPlayers[1]
end

-- Di chuyển đến vị trí
local function moveToPosition(position, speed)
    if currentTween then
        currentTween:Cancel()
    end
    
    local distance = (HRP.Position - position).Magnitude
    local duration = distance / speed
    
    currentTween = TweenService:Create(
        HRP,
        TweenInfo.new(duration, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(position)}
    )
    currentTween:Play()
    return currentTween
end

-- Bay lên cao để né đòn
local function evade()
    if isEvading then return end
    
    isEvading = true
    local startPos = HRP.Position
    local evadePos = startPos + Vector3.new(0, EVADE_HEIGHT, 0)
    
    moveToPosition(evadePos, 100) -- Tốc độ bay lên nhanh
    
    -- Kiểm tra máu để quay lại
    local checkHealthConn
    checkHealthConn = RunService.Heartbeat:Connect(function()
        if Humanoid.Health / Humanoid.MaxHealth > RETURN_HEALTH_THRESHOLD then
            checkHealthConn:Disconnect()
            isEvading = false
            if currentTarget and currentTarget.Character then
                moveToPosition(currentTarget.Character.HumanoidRootPart.Position, 300)
            end
        end
    end)
end

-- Đổi server
local function changeServer()
    -- Tìm server có nhiều người chơi hơn
    local success, result = pcall(function()
        return TeleportService:GetCurrentServerInstanceId()
    end)
    
    if success then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, result)
    else
        LocalPlayer:Kick("Đang chuyển server...")
        task.wait(2)
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
end

-- Bắt đầu đuổi mục tiêu
local function chaseTarget(target)
    if not target or not target.Character then return end
    
    cleanup()
    currentTarget = target
    chaseStartTime = os.time()
    lastDamageTime = os.time()
    
    -- Thiết lập tracking damage
    setupDamageTracking()
    
    -- Theo dõi máu của bản thân
    humanoidConnection = Humanoid.HealthChanged:Connect(function()
        local healthRatio = Humanoid.Health / Humanoid.MaxHealth
        
        if healthRatio < SAFE_HEALTH_THRESHOLD and not isEvading then
            evade()
        end
    end)
    
    -- Vòng lặp đuổi bám chính
    connection = RunService.Heartbeat:Connect(function()
        -- Kiểm tra điều kiện dừng
        if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
            cleanup()
            return
        end
        
        local targetHumanoid = target.Character:FindFirstChildOfClass("Humanoid")
        if not targetHumanoid or targetHumanoid.Health <= 0 then
            cleanup()
            return
        end
        
        -- Kiểm tra thời gian
        local currentTime = os.time()
        if currentTime - lastDamageTime > MAX_NO_DAMAGE_TIME then
            cleanup()
            return
        end
        
        if currentTime - chaseStartTime > MAX_CHASE_TIME then
            cleanup()
            return
        end
        
        -- Kiểm tra vùng an toàn
        if isInSafeZone(target) then
            cleanup()
            return
        end
        
        -- Di chuyển đến mục tiêu
        local targetPos = target.Character.HumanoidRootPart.Position
        if isEvading then
            targetPos = targetPos + Vector3.new(0, EVADE_HEIGHT, 60)
        end
        
        moveToPosition(targetPos, 350) -- Tốc độ di chuyển cao
    end)
end

-- Hàm chính
local function mainLoop()
    while true do
        -- Kiểm tra nếu kill hết người chơi
        if #Players:GetPlayers() <= 1 then
            changeServer()
            break
        end
        
        -- Tìm mục tiêu mới
        local target = getValidTarget()
        
        if target then
            chaseTarget(target)
            
            -- Chờ cho đến khi kết thúc chase (do điều kiện nào đó)
            while connection do
                task.wait(1)
            end
            
            -- Nếu bị kill, đổi server
            if Humanoid.Health <= 0 then
                task.wait(3) -- Chờ respawn
                changeServer()
                break
            end
        else
            task.wait(1)
        end
    end
end

-- Xử lý khi respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HRP = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")
    
    -- Bắt đầu lại nếu bị kill
    if isChasing then
        task.wait(1) -- Chờ 1s sau khi respawn
        mainLoop()
    end
end)

-- Bắt đầu chương trình
mainLoop()

-- Initialize
local function setupCharacter()
    -- Ensure character exists
    repeat wait() until LocalPlayer.Character
    local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
    
    -- Auto respawn if dead
    humanoid.Died:Connect(function()
        wait(5)
        LocalPlayer.CharacterAdded:Wait()
        setupCharacter()
    end)
    
    return humanoid
end

local humanoid = setupCharacter()

-- Utility functions
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and 
           player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") then
           
            -- Check if player has PvP enabled and not in safe zone
            -- (This would need actual game-specific checks)
            local hasPvP = true -- Placeholder
            local inSafeZone = false -- Placeholder
            
            if hasPvP and not inSafeZone then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    return closestPlayer
end

local function teleportToTarget(target)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local targetHRP = target.Character.HumanoidRootPart
    local offsetPosition = targetHRP.CFrame:PointToWorldSpace(config.OFFSET)
    
    local tweenInfo = TweenInfo.new(
        (LocalPlayer.Character.HumanoidRootPart.Position - offsetPosition).Magnitude / config.TP_SPEED,
        Enum.EasingStyle.Linear
    )
    
    local tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(offsetPosition)})
    tween:Play()
    
    return true
end

local function equipWeapon(weaponType)
    -- This would need game-specific implementation to equip weapons
    -- Placeholder for demonstration
    print("Equipping", weaponType)
end

local function useSkill(key)
    -- This would need game-specific implementation to use skills
    -- Placeholder for demonstration
    print("Using skill:", key)
end

local function activateBuffs()
    -- Activate Aura, Instinct, PvP if not active
    -- Placeholder for demonstration
    print("Activating buffs")
end

-- Combat logic
local function executeCombo()
    if comboStep > #COMBO_SEQUENCE then
        comboStep = 1
    end
    
    local currentCombo = COMBO_SEQUENCE[comboStep]
    equipWeapon(currentCombo[1])
    useSkill(currentCombo[2])
    
    comboStep = comboStep + 1
    lastAttackTime = tick()
end

local function normalAttack()
    -- Use normal attack if skills are on cooldown
    useSkill("Click")
end

-- Main combat loop
local function combatLoop()
    while true do
        wait()
        
        -- Check if we need a new target
        if not currentTarget or not currentTarget.Character or currentTarget.Character.Humanoid.Health <= 0 then
            currentTarget = getClosestPlayer()
            comboStep = 1
            if not currentTarget then
                -- No valid targets, maybe AFK mode
                equipWeapon(WEAPONS.MELEE)
                wait(1)
                equipWeapon(WEAPONS.SWORD)
                wait(1)
                equipWeapon(WEAPONS.FRUIT)
                wait(1)
                equipWeapon(WEAPONS.GUN)
                wait(1)
                continue
            end
        end
        
        -- Check health and fly high if needed
        if humanoid.Health / humanoid.MaxHealth < config.MIN_HEALTH and not isFlyingHigh then
            -- Fly high to avoid damage
            isFlyingHigh = true
            -- Implementation would depend on how flying works in the game
        elseif humanoid.Health / humanoid.MaxHealth > config.RECOVER_HEALTH and isFlyingHigh then
            -- Return to combat
            isFlyingHigh = true
        end
        
        -- Skip combat if flying high to recover
        if isFlyingHigh then
            continue
        end
        
        -- Activate necessary buffs
        activateBuffs()
        
        -- Teleport to target with offset
        if not teleportToTarget(currentTarget) then
            currentTarget = nil
            continue
        end
        
        -- Execute combo or normal attack
        if tick() - lastAttackTime > config.COMBO_DELAY then
            executeCombo()
        else
            normalAttack()
        end
    end
end

-- Start the combat system
spawn(combatLoop)

-- UI Toggle (placeholder)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightControl then -- Change to your preferred toggle key
        -- Toggle UI visibility
        print("UI toggled")
    end
end)

--===[ Anura Hub - No Clip Script ]===--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local noclip = true -- Đổi thành false để tắt

RunService.Stepped:Connect(function()
    if noclip and Character and Character:FindFirstChild("HumanoidRootPart") then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
end)

-- Toggle bằng phím B (chỉ dùng được trên PC hoặc executor có hỗ trợ phím)
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.B then
        noclip = not noclip
    end
end)

print("[Anura Hub] No Clip đã bật! Nhấn B để bật/tắt (nếu dùng được)")           
--===[ Anura Hub - Silent Aimbot (No Screen Impact) ]===--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local AimbotEnabled = true
local AimbotRange = 6000 -- Tầm aimbot
local AimbotTargetPart = "Head" -- Có thể đổi thành "HumanoidRootPart" nếu muốn

-- Hàm lấy player gần nhất trong tầm
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = AimbotRange

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(AimbotTargetPart) then
            local targetPart = player.Character[AimbotTargetPart]
            local distance = (targetPart.Position - Camera.CFrame.Position).Magnitude
            if distance < shortestDistance and player.Team ~= LocalPlayer.Team then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

-- Silent Aim Function (không xoay màn hình)
local function ModifyMousePosition()
    local target = GetClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild(AimbotTargetPart) then
        local pos = target.Character[AimbotTargetPart].Position
        return pos
    end
    return nil
end

-- Gắn vào raycast của vũ khí
local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if AimbotEnabled and method == "FindPartOnRayWithIgnoreList" then
        local pos = ModifyMousePosition()
        if pos then
            args[1] = Ray.new(Camera.CFrame.Position, (pos - Camera.CFrame.Position).Unit * 1000)
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)

print("[Anura Hub] Silent Aimbot đã bật! Không xoay màn hình.")  
print("Auto Bounty Combat System loaded!")

--[[
    Auto Bounty Script - Target & Tracking System
    Features:
    - Smart target selection
    - Target validation
    - AFK prevention
    - Auto PvP management
    - Target switching logic
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Configuration
local config = {
    TARGET_REFRESH_RATE = 1, -- Seconds between target checks
    NO_DAMAGE_TIMEOUT = 30, -- Switch if no damage in 30s
    KILL_TIMEOUT = 45, -- Switch if target not killed in 45s
    AFK_WEAPON_SWITCH_DELAY = 3, -- Seconds between weapon switches in AFK mode
    SERVER_HOP_DELAY = 10 -- Seconds before server hop after killing all targets
}

-- State variables
local currentTarget = nil
local lastTargetSwitch = 0
local lastDamageDealt = 0
local targetEngageTime = 0
local totalBountyEarned = 0
local killCount = 0
local isAFKMode = false
local serverPlayers = {}

-- Shared references from Part 1
local WEAPONS = {
    MELEE = "Melee",
    SWORD = "Sword",
    FRUIT = "Fruit",
    GUN = "Gun"
}

-- Target tracking functions
local function isValidTarget(player)
    if not player or not player.Character then return false end
    
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    -- Basic checks
    if not humanoid or not rootPart or humanoid.Health <= 0 then
        return false
    end
    
    -- Check if player is in safe zone (game-specific)
    local inSafeZone = false -- Placeholder for actual check
    
    -- Check if player has PvP enabled (game-specific)
    local hasPvP = true -- Placeholder for actual check
    
    -- Check if player is in same island/area (game-specific)
    local inSameIsland = true -- Placeholder for actual check
    
    return hasPvP and not inSafeZone and inSameIsland
end

local function getBestTarget()
    local bestTarget = nil
    local highestPriority = -math.huge
    
    -- Update server player list
    serverPlayers = Players:GetPlayers()
    
    for _, player in ipairs(serverPlayers) do
        if player == LocalPlayer then continue end
        
        if isValidTarget(player) then
            -- Calculate priority (can be customized)
            local priority = 0
            
            -- Priority factors (example):
            -- - Lower health targets get higher priority
            -- - Closer targets get higher priority
            -- - Lower bounty targets might get higher priority (easier kills)
            
            if player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                
                if humanoid and rootPart then
                    -- Distance factor
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                    priority = priority + (100 - distance) -- Closer = higher priority
                    
                    -- Health factor
                    priority = priority + (100 - (humanoid.Health / humanoid.MaxHealth) * 100) -- Lower health = higher priority
                end
            end
            
            -- Check if this target has higher priority than current best
            if priority > highestPriority then
                highestPriority = priority
                bestTarget = player
            end
        end
    end
    
    return bestTarget
end

local function switchTarget(reason)
    print("Switching target. Reason:", reason)
    currentTarget = getBestTarget()
    lastTargetSwitch = tick()
    
    if currentTarget then
        targetEngageTime = tick()
        lastDamageDealt = tick()
        print("New target:", currentTarget.Name)
    else
        print("No valid targets found")
    end
end

local function checkTargetConditions()
    if not currentTarget then
        switchTarget("No current target")
        return
    end
    
    local now = tick()
    local timeSinceEngage = now - targetEngageTime
    local timeSinceDamage = now - lastDamageDealt
    
    -- Check if target became invalid
    if not isValidTarget(currentTarget) then
        switchTarget("Target became invalid")
        return
    end
    
    -- Check no damage timeout
    if timeSinceDamage > config.NO_DAMAGE_TIMEOUT then
        switchTarget(string.format("No damage for %d seconds", config.NO_DAMAGE_TIMEOUT))
        return
    end
    
    -- Check kill timeout
    if timeSinceEngage > config.KILL_TIMEOUT then
        switchTarget(string.format("Target not killed in %d seconds", config.KILL_TIMEOUT))
        return
    end
end

-- AFK Mode functions
local function toggleAFKMode(enable)
    isAFKMode = enable
    
    if enable then
        print("Entering AFK mode")
    else
        print("Exiting AFK mode")
    end
end

local function afkRoutine()
    while true do
        if isAFKMode then
            -- Cycle through weapons to prevent AFK kick
            equipWeapon(WEAPONS.MELEE)
            wait(config.AFK_WEAPON_SWITCH_DELAY)
            equipWeapon(WEAPONS.SWORD)
            wait(config.AFK_WEAPON_SWITCH_DELAY)
            equipWeapon(WEAPONS.FRUIT)
            wait(config.AFK_WEAPON_SWITCH_DELAY)
            equipWeapon(WEAPONS.GUN)
            wait(config.AFK_WEAPON_SWITCH_DELAY)
        else
            wait(1)
        end
    end
end

-- PvP Management
local function enablePvP()
    -- Game-specific PvP activation
    print("Enabling PvP")
end

local function checkPvPStatus()
    -- Game-specific PvP check
    local pvpEnabled = true -- Placeholder
    
    if not pvpEnabled then
        enablePvP()
    end
end

-- Death handling
local function onPlayerDeath()
    -- Called when local player dies
    wait(5) -- Respawn delay
    
    -- Re-enable PvP after respawn
    enablePvP()
    
    -- Switch target after death
    switchTarget("Player died")
end

-- Server management
local function shouldServerHop()
    -- Check if we should switch servers
    if #serverPlayers <= 1 then -- Only us in server
        return true
    end
    
    -- Check if we killed all valid targets
    local validTargetsExist = false
    
    for _, player in ipairs(serverPlayers) do
        if player ~= LocalPlayer and isValidTarget(player) then
            validTargetsExist = true
            break
        end
    end
    
    return not validTargetsExist
end

local function serverHop()
    -- Game-specific server hopping implementation
    print("Attempting to switch servers...")
    
    -- Placeholder server hop logic
    wait(config.SERVER_HOP_DELAY)
    print("Server hop complete")
end

-- Main target tracking loop
local function targetTrackingLoop()
    while true do
        -- Check if we need to enter AFK mode
        if not getBestTarget() and not isAFKMode then
            toggleAFKMode(true)
        elseif getBestTarget() and isAFKMode then
            toggleAFKMode(false)
        end
        
        -- Check current target conditions
        if not isAFKMode then
            checkTargetConditions()
            
            -- Check if we should server hop
            if shouldServerHop() then
                serverHop()
            end
        end
        
        -- Verify PvP is enabled
        checkPvPStatus()
        
        wait(config.TARGET_REFRESH_RATE)
    end
end

-- Connect death event
LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(onPlayerDeath)
end)

-- Initialize
spawn(targetTrackingLoop)
spawn(afkRoutine)

print("Auto Bounty Target & Tracking System loaded!")

--[[
    Auto Bounty Script - Movement & Support System
    Features:
    - Advanced movement (fly, water/lava walk)
    - Auto-dodge mechanics
    - Health-based positioning
    - Team selection
    - Sea Beast summoning
    - Anti-stuck system
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- Configuration
local config = {
    FLY_HEIGHT = 50, -- Default flying height
    WATER_WALK_OFFSET = 3, -- Height above water surface
    MIN_SAFE_DISTANCE = 15, -- Minimum distance from target
    MAX_SAFE_DISTANCE = 30, -- Maximum distance from target
    DODGE_COOLDOWN = 3, -- Seconds between dodges
    SEA_BEAST_THRESHOLD = 10000000, -- 10M bounty
    STUCK_CHECK_INTERVAL = 5, -- Seconds between stuck checks
    STUCK_THRESHOLD = 2, -- Seconds without movement to be considered stuck
}

-- State variables
local isFlying = false
local isWaterWalking = false
local lastDodgeTime = 0
local lastPosition = nil
local lastPositionTime = 0
local currentTeam = "Pirate" -- Default team
local seaBeastSummoned = false

-- Movement functions
local function enableFlight(height)
    if isFlying then return end
    
    -- Game-specific flight activation
    -- This would need to be adapted to the actual game's flight mechanics
    print("Enabling flight at height:", height)
    isFlying = true
    
    -- Create and fly to a position above current location
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local targetPos = Vector3.new(root.Position.X, root.Position.Y + height, root.Position.Z)
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad)
        local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos)})
        tween:Play()
    end
end

local function disableFlight()
    if not isFlying then return end
    
    -- Game-specific flight deactivation
    print("Disabling flight")
    isFlying = false
end

local function enableWaterWalk()
    if isWaterWalking then return end
    
    -- Game-specific water walk activation
    print("Enabling water walk")
    isWaterWalking = true
    
    -- This would need to be implemented based on the game's mechanics
    -- Typically involves setting a Y-axis offset above water surfaces
end

local function disableWaterWalk()
    if not isWaterWalking then return end
    
    -- Game-specific water walk deactivation
    print("Disabling water walk")
    isWaterWalking = false
end

local function checkWater()
    -- Check if player is near or on water/lava
    -- This would need game-specific implementation
    local nearWater = false -- Placeholder
    
    if nearWater and not isWaterWalking then
        enableWaterWalk()
    elseif not nearWater and isWaterWalking then
        disableWaterWalk()
    end
end

-- Dodge mechanics
local function shouldDodge()
    -- Check if we should dodge (game-specific)
    -- Could check for incoming projectiles or other danger indicators
    local shouldDodge = false -- Placeholder
    
    -- Cooldown check
    if tick() - lastDodgeTime < config.DODGE_COOLDOWN then
        return false
    end
    
    return shouldDodge
end

local function executeDodge()
    -- Game-specific dodge implementation
    -- Could be a dash, teleport, or other movement ability
    print("Executing dodge")
    lastDodgeTime = tick()
    
    -- Example: dash to the side
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local dashDistance = 10
        local newCFrame = root.CFrame * CFrame.new(math.random(-dashDistance, dashDistance), 0, math.random(-dashDistance, dashDistance))
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(root, tweenInfo, {CFrame = newCFrame})
        tween:Play()
    end
end

-- Health-based positioning
local function healthPositioning()
    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local healthRatio = humanoid.Health / humanoid.MaxHealth
    
    -- Fly high if health is critical
    if healthRatio < 0.1 and not isFlying then
        enableFlight(config.FLY_HEIGHT * 2) -- Fly extra high when health is critical
    elseif healthRatio > 0.3 and isFlying then
        disableFlight()
    end
    
    -- Maintain optimal combat distance
    if currentTarget and currentTarget.Character then
        local targetRoot = currentTarget.Character:FindFirstChild("HumanoidRootPart")
        local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if targetRoot and myRoot then
            local distance = (targetRoot.Position - myRoot.Position).Magnitude
            
            -- Adjust distance based on health
            local optimalDistance = config.MIN_SAFE_DISTANCE
            if healthRatio < 0.5 then
                optimalDistance = config.MAX_SAFE_DISTANCE
            end
            
            if distance < optimalDistance - 5 then
                -- Move away if too close
                local direction = (myRoot.Position - targetRoot.Position).Unit
                local newPos = targetRoot.Position + (direction * optimalDistance)
                newPos = Vector3.new(newPos.X, myRoot.Position.Y, newPos.Z)
                
                local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(myRoot, tweenInfo, {CFrame = CFrame.new(newPos)})
                tween:Play()
            elseif distance > optimalDistance + 5 then
                -- Move closer if too far
                local direction = (targetRoot.Position - myRoot.Position).Unit
                local newPos = myRoot.Position + (direction * optimalDistance)
                newPos = Vector3.new(newPos.X, myRoot.Position.Y, newPos.Z)
                
                local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(myRoot, tweenInfo, {CFrame = CFrame.new(newPos)})
                tween:Play()
            end
        end
    end
end

-- Team management
local function setTeam(teamName)
    if currentTeam == teamName then return end
    
    -- Game-specific team selection
    print("Switching to team:", teamName)
    currentTeam = teamName
end

-- Sea Beast summoning
local function summonSeaBeast()
    if seaBeastSummoned then return end
    
    -- Check bounty (game-specific)
    local bounty = 0 -- Placeholder, would need actual bounty check
    
    if bounty >= config.SEA_BEAST_THRESHOLD then
        -- Game-specific summoning
        print("Summoning Sea Beast")
        seaBeastSummoned = true
    end
end

-- Anti-stuck system
local function checkIfStuck()
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local currentPos = root.Position
    
    if lastPosition then
        if (currentPos - lastPosition).Magnitude < 1 then -- Hasn't moved much
            if tick() - lastPositionTime > config.STUCK_THRESHOLD then
                -- Player is stuck, attempt to unstick
                print("Player is stuck, attempting to unstick")
                
                -- Try jumping
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                
                -- Try moving up
                local newPos = Vector3.new(currentPos.X, currentPos.Y + 10, currentPos.Z)
                local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(newPos)})
                tween:Play()
                
                -- Reset stuck check
                lastPosition = currentPos
                lastPositionTime = tick()
            end
        else
            -- Player is moving normally
            lastPosition = currentPos
            lastPositionTime = tick()
        end
    else
        -- Initialize position tracking
        lastPosition = currentPos
        lastPositionTime = tick()
    end
end

-- Wall clipping detection
local function checkWallClipping()
    if not currentTarget then return end
    
    local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetRoot = currentTarget.Character:FindFirstChild("HumanoidRootPart")
    
    if not myRoot or not targetRoot then return end
    
    -- Check if there's a wall between us and the target
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, currentTarget.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local raycastResult = Workspace:Raycast(myRoot.Position, (targetRoot.Position - myRoot.Position).Unit * 100, raycastParams)
    
    if raycastResult and raycastResult.Instance then
        -- There's an obstacle between us and the target
        print("Wall detected, attempting to clip through")
        
        -- Try to teleport through the wall
        local teleportPos = targetRoot.Position + Vector3.new(0, 5, 0) -- Above target
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(myRoot, tweenInfo, {CFrame = CFrame.new(teleportPos)})
        tween:Play()
    end
end

-- Main movement loop
local function movementLoop()
    while true do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            -- Check water/lava walking
            checkWater()
            
            -- Check for dodges
            if shouldDodge() then
                executeDodge()
            end
            
            -- Health-based positioning
            healthPositioning()
            
            -- Check if we should summon Sea Beast
            summonSeaBeast()
            
            -- Anti-stuck checks
            checkIfStuck()
            
            -- Wall clipping checks
            checkWallClipping()
        end
        
        wait(0.1)
    end
end

-- Initialize
spawn(movementLoop)

print("Auto Bounty Movement & Support System loaded!")

--[[
    Auto Bounty Script - HUD & UI System
    Features:
    - Anura Hub interface with player tracking
    - Bounty count display
    - Performance metrics (FPS, uptime)
    - Server player count
    - Interactive controls (toggle UI, next player)
    - Customizable design matching ID 14190262721
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Configuration
local config = {
    UI_IMAGE_ID = "14190262721", -- Background image ID
    UI_TOGGLE_KEY = Enum.KeyCode.RightControl,
    UI_REFRESH_RATE = 1, -- Seconds between updates
    UI_FADE_TIME = 0.3, -- Seconds for fade animations
    UI_VISIBLE = true -- Start with UI visible
}

-- State variables
local totalBounty = 0
local killCount = 0
local startTime = tick()
local currentTargetName = "None"
local lastFPSUpdate = 0
local fps = 0
local frameCount = 0
local serverPlayerCount = 0

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnuraHub"
screenGui.DisplayOrder = 10
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 220)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = screenGui

-- Background image
local background = Instance.new("ImageLabel")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.Image = "rbxassetid://"..config.UI_IMAGE_ID
background.ScaleType = Enum.ScaleType.Slice
background.SliceCenter = Rect.new(100, 100, 100, 100)
background.BackgroundTransparency = 1
background.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "ANURA HUB"
title.Size = UDim2.new(0.8, 0, 0, 30)
title.Position = UDim2.new(0.1, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = mainFrame

-- Info container
local infoContainer = Instance.new("Frame")
infoContainer.Name = "InfoContainer"
infoContainer.Size = UDim2.new(0.9, 0, 0.7, 0)
infoContainer.Position = UDim2.new(0.05, 0, 0.15, 0)
infoContainer.BackgroundTransparency = 1
infoContainer.Parent = mainFrame

-- Create info labels
local function createInfoLabel(name, yPosition)
    local labelFrame = Instance.new("Frame")
    labelFrame.Name = name.."Frame"
    labelFrame.Size = UDim2.new(1, 0, 0, 25)
    labelFrame.Position = UDim2.new(0, 0, 0, yPosition)
    labelFrame.BackgroundTransparency = 1
    labelFrame.Parent = infoContainer
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Text = name..":"
    nameLabel.Size = UDim2.new(0.5, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = labelFrame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "ValueLabel"
    valueLabel.Text = "N/A"
    valueLabel.Size = UDim2.new(0.5, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 16
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = labelFrame
    
    return valueLabel
end

-- Create all info labels
local targetLabel = createInfoLabel("Target", 0)
local bountyLabel = createInfoLabel("Bounty Earned", 30)
local killsLabel = createInfoLabel("Kills", 60)
local fpsLabel = createInfoLabel("FPS", 90)
local uptimeLabel = createInfoLabel("Uptime", 120)
local playersLabel = createInfoLabel("Players", 150)

-- Next Player button
local nextPlayerButton = Instance.new("TextButton")
nextPlayerButton.Name = "NextPlayerButton"
nextPlayerButton.Text = "NEXT PLAYER"
nextPlayerButton.Size = UDim2.new(0.4, 0, 0, 30)
nextPlayerButton.Position = UDim2.new(0.3, 0, 0.9, -30)
nextPlayerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
nextPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
nextPlayerButton.Font = Enum.Font.GothamBold
nextPlayerButton.TextSize = 14
nextPlayerButton.Parent = mainFrame

-- UI visibility control
local function setUIVisibility(visible)
    config.UI_VISIBLE = visible
    mainFrame.Visible = visible
    
    -- Fade animation
    mainFrame.BackgroundTransparency = visible and 0.8 or 1
    local tweenInfo = TweenInfo.new(config.UI_FADE_TIME, Enum.EasingStyle.Quad)
    
    for _, child in ipairs(mainFrame:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            child.TextTransparency = visible and 0 or 1
        elseif child:IsA("ImageLabel") then
            child.ImageTransparency = visible and 0.2 or 1
        end
    end
end

-- Format time
local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

-- Format numbers with commas
local function formatNumber(num)
    local formatted = tostring(num)
    local k = #formatted % 3
    if k == 0 then k = 3 end
    return formatted:sub(1,k) .. formatted:sub(k+1):gsub("(%d%d%d)", ",%1")
end

-- Update FPS counter
local function updateFPS()
    frameCount = frameCount + 1
    local now = tick()
    
    if now - lastFPSUpdate >= 1 then
        fps = math.floor(frameCount / (now - lastFPSUpdate))
        frameCount = 0
        lastFPSUpdate = now
    end
end

-- Update UI
local function updateUI()
    -- Update target name
    if currentTarget then
        currentTargetName = currentTarget.Name
    else
        currentTargetName = "None"
    end
    
    -- Update labels
    targetLabel.Text = currentTargetName
    bountyLabel.Text = "$"..formatNumber(totalBounty)
    killsLabel.Text = formatNumber(killCount)
    fpsLabel.Text = fps
    uptimeLabel.Text = formatTime(tick() - startTime)
    playersLabel.Text = serverPlayerCount.."/"..game.Players.MaxPlayers
end

-- UI event handlers
closeButton.MouseButton1Click:Connect(function()
    setUIVisibility(false)
end)

nextPlayerButton.MouseButton1Click:Connect(function()
    -- Trigger target switch from Part 2
    switchTarget("Manual switch")
end)

-- Keyboard toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == config.UI_TOGGLE_KEY and not gameProcessed then
        setUIVisibility(not config.UI_VISIBLE)
    end
end)

-- Make UI draggable
local dragging = false
local dragStartPos = Vector2.new(0, 0)
local frameStartPos = Vector2.new(0, 0)

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
        frameStartPos = Vector2.new(mainFrame.Position.X.Offset, mainFrame.Position.Y.Offset)
    end
end)

title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStartPos
        mainFrame.Position = UDim2.new(0, frameStartPos.X + delta.X, 0, frameStartPos.Y + delta.Y)
    end
end)

-- Main UI update loop
local function uiLoop()
    while true do
        if config.UI_VISIBLE then
            updateFPS()
            updateUI()
        end
        
        -- Update server player count
        serverPlayerCount = #Players:GetPlayers()
        
        wait(config.UI_REFRESH_RATE)
    end
end

-- Initialize
setUIVisibility(config.UI_VISIBLE)
spawn(uiLoop)

-- Connect to target switching from Part 2
local function onTargetSwitched(newTarget)
    currentTarget = newTarget
end

print("Auto Bounty HUD & UI System loaded!")

--[[
    Auto Bounty Script - Anti Systems
    Features:
    - Anti-lag optimizations
    - Anti-ban protections
    - Anti-death mechanics
    - Stuck prevention
    - Server stability checks
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

-- Configuration
local config = {
    ANTI_LAG_INTERVAL = 30, -- Seconds between lag optimizations
    STUCK_CHECK_INTERVAL = 5, -- Seconds between stuck checks
    BAN_CHECK_INTERVAL = 60, -- Seconds between ban checks
    PING_THRESHOLD = 300, -- Max ping before taking action (ms)
    MEMORY_THRESHOLD = 1500, -- Max memory before cleanup (MB)
    RENDER_DISTANCE = 500, -- Max render distance
    PART_CLEANUP_COUNT = 100 -- Max parts to keep
}

-- State variables
local lastStuckCheck = 0
local lastPosition = nil
local lastBanCheck = 0
local lastLagCleanup = 0
local lastPingCheck = 0
local highPingCount = 0

-- Anti-Lag Functions
local function optimizeGraphics()
    -- Reduce graphics quality
    settings().Rendering.QualityLevel = 1
    settings().Rendering.MeshCacheSize = 50
    settings().Rendering.EnableFRM = true
    
    -- Adjust lighting
    Lighting.GlobalShadows = false
    Lighting.FogEnd = config.RENDER_DISTANCE
    Lighting.Brightness = 2
    
    -- Disable unnecessary effects
    for _, effect in ipairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = false
        end
    end
    
    -- Limit particle effects
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("ParticleEmitter") then
            part.Enabled = false
        elseif part:IsA("BasePart") and part.Transparency > 0.8 then
            part:Destroy()
        end
    end
end

local function cleanupObjects()
    -- Clean up distant objects
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPos = char.HumanoidRootPart.Position
    local parts = {}
    
    -- Collect and sort parts by distance
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsA("Terrain") then
            local dist = (part.Position - rootPos).Magnitude
            table.insert(parts, {part = part, distance = dist})
        end
    end
    
    -- Sort by distance (furthest first)
    table.sort(parts, function(a, b) return a.distance > b.distance end)
    
    -- Remove excess parts
    for i = config.PART_CLEANUP_COUNT + 1, #parts do
        if parts[i].distance > config.RENDER_DISTANCE then
            parts[i].part:Destroy()
        end
    end
end

local function checkMemoryUsage()
    local memStats = Stats:GetMemoryStatsMb()
    if memStats and memStats.TotalUsedMemory > config.MEMORY_THRESHOLD then
        cleanupObjects()
        optimizeGraphics()
        return true
    end
    return false
end

local function checkPing()
    local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    if ping > config.PING_THRESHOLD then
        highPingCount = highPingCount + 1
        
        if highPingCount > 3 then
            -- Reduce activity when ping is consistently high
            optimizeGraphics()
            return true
        end
    else
        highPingCount = 0
    end
    return false
end

-- Anti-Ban Functions
local function randomizeBehavior()
    -- Randomize timing patterns
    local randomDelay = math.random(5, 15)
    wait(randomDelay / 10)
    
    -- Randomize movement patterns
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        if math.random() > 0.7 then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

local function checkBanRisks()
    -- Check for unusual game events that might indicate detection
    -- This would need game-specific implementation
    return false
end

local function simulateHumanInput()
    -- Occasionally simulate human-like input
    if math.random() > 0.95 then
        local mousePos = UserInputService:GetMouseLocation()
        UserInputService:SetMouseLocation(mousePos.X + math.random(-5, 5), mousePos.Y + math.random(-5, 5))
    end
end

-- Anti-Death Functions
local function getSafeSpot()
    -- Find a safe position (high ground or away from combat)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local rootPos = char.HumanoidRootPart.Position
    local safePos = rootPos + Vector3.new(0, 50, 0) -- Default to flying high
    
    -- Raycast to find highest nearby point
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {char}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local raycastResult = Workspace:Raycast(rootPos, Vector3.new(0, 1000, 0), raycastParams)
    if raycastResult then
        safePos = raycastResult.Position + Vector3.new(0, 5, 0)
    end
    
    return safePos
end

local function evadeDeath()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("Humanoid") then return end
    
    local humanoid = char.Humanoid
    if humanoid.Health / humanoid.MaxHealth < 0.2 then
        -- Emergency teleport to safe spot
        local safeSpot = getSafeSpot()
        if safeSpot and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(safeSpot)
            return true
        end
    end
    return false
end

-- Stuck Prevention
local function checkIfStuck()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
    
    local currentPos = char.HumanoidRootPart.Position
    
    if lastPosition then
        if (currentPos - lastPosition).Magnitude < 2 then -- Hasn't moved much
            -- Try jumping first
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            
            -- If still stuck after a moment, teleport slightly
            wait(0.5)
            if (char.HumanoidRootPart.Position - currentPos).Magnitude < 2 then
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                return true
            end
        end
    end
    
    lastPosition = currentPos
    return false
end

-- Main Anti-System Loop
local function antiSystemLoop()
    optimizeGraphics() -- Initial optimization
    
    while true do
        local now = tick()
        
        -- Anti-Lag measures
        if now - lastLagCleanup > config.ANTI_LAG_INTERVAL then
            cleanupObjects()
            checkMemoryUsage()
            lastLagCleanup = now
        end
        
        -- Ping check (more frequent)
        if now - lastPingCheck > 5 then
            checkPing()
            lastPingCheck = now
        end
        
        -- Anti-Ban measures
        if now - lastBanCheck > config.BAN_CHECK_INTERVAL then
            randomizeBehavior()
            if checkBanRisks() then
                warn("Potential ban risk detected - pausing activity")
                wait(10)
            end
            lastBanCheck = now
        end
        
        -- Anti-Death measures
        evadeDeath()
        
        -- Stuck prevention
        if now - lastStuckCheck > config.STUCK_CHECK_INTERVAL then
            checkIfStuck()
            lastStuckCheck = now
        end
        
        -- Human-like input simulation
        simulateHumanInput()
        
        wait(1)
    end
end

-- Initialize
spawn(antiSystemLoop)

print("Auto Bounty Anti Systems loaded!")

--[[
    Auto Bounty Script - Team Selection & Advanced Target Management
    Features:
    - Auto team selection (Pirate/Marine)
    - Auto PvP activation
    - Smart server hopping
    - Comprehensive target switching logic
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

-- Configuration
local config = {
    TEAM = "Pirate", -- "Pirate" or "Marine"
    PVP_CHECK_INTERVAL = 5,
    NO_DAMAGE_TIMEOUT = 30,
    KILL_TIMEOUT = 45,
    SERVER_HOP_DELAY = 10,
    TARGET_REFRESH_RATE = 1
}

-- State variables
local currentTarget = nil
local lastDamageTime = 0
local engageTime = 0
local lastPvpCheck = 0
local lastTeamCheck = 0
local isChangingServer = false

-- Team selection function
local function selectTeam(teamName)
    -- Game-specific team selection implementation
    -- This will vary depending on how the game handles teams
    
    -- Placeholder for team selection logic
    local teamEvent = ReplicatedStorage:FindFirstChild("TeamEvent") or ReplicatedStorage:FindFirstChild("SetTeam")
    if teamEvent then
        teamEvent:FireServer(teamName)
        print("Selected team:", teamName)
        return true
    else
        warn("Team selection event not found!")
        return false
    end
end

-- PvP activation function
local function activatePvP()
    -- Game-specific PvP activation
    -- Placeholder for PvP activation logic
    local pvpEvent = ReplicatedStorage:FindFirstChild("PvPEvent") or ReplicatedStorage:FindFirstChild("TogglePvP")
    if pvpEvent then
        pvpEvent:FireServer(true)
        print("PvP activated")
        return true
    else
        warn("PvP activation event not found!")
        return false
    end
end

-- Check if player has PvP enabled
local function hasPvPEnabled(player)
    -- Game-specific PvP check
    -- Placeholder - would need actual implementation
    if player and player.Character then
        local pvpValue = player.Character:FindFirstChild("PvPEnabled") 
                      or player.Character:FindFirstChild("HasPvP")
        return pvpValue and pvpValue.Value == true
    end
    return false
end

-- Check if player is in safe zone
local function inSafeZone(player)
    -- Game-specific safe zone check
    -- Placeholder - would need actual implementation
    if player and player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Example: Check if near safe zone parts
            local safeZones = Workspace:FindFirstChild("SafeZones") 
                           or Workspace:FindFirstChild("NoCombatAreas")
            if safeZones then
                for _, zone in ipairs(safeZones:GetDescendants()) do
                    if zone:IsA("BasePart") and (zone.Position - rootPart.Position).Magnitude < zone.Size.Magnitude/2 then
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- Server hopping function
local function serverHop()
    if isChangingServer then return end
    isChangingServer = true
    
    print("Preparing to change servers...")
    wait(config.SERVER_HOP_DELAY)
    
    -- Game-specific server hopping implementation
    -- Placeholder - would need actual implementation
    local success, err = pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
    
    if not success then
        warn("Server hop failed:", err)
        isChangingServer = false
    end
end

-- Target selection and validation
local function getValidTarget()
    local validPlayers = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid.Health > 0 and rootPart and not inSafeZone(player) and hasPvPEnabled(player) then
                table.insert(validPlayers, player)
            end
        end
    end
    
    -- Sort by distance (closest first)
    table.sort(validPlayers, function(a, b)
        local aDist = (a.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        local bDist = (b.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        return aDist < bDist
    end)
    
    return validPlayers[1] -- Return closest valid player
end

-- Target switching logic
local function switchTarget(reason)
    print("Switching target. Reason:", reason)
    
    -- Check if we should server hop instead
    local validTargetsExist = false
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if humanoid.Health > 0 and not inSafeZone(player) and hasPvPEnabled(player) then
                validTargetsExist = true
                break
            end
        end
    end
    
    if not validTargetsExist then
        print("No valid targets found - server hopping")
        serverHop()
        return
    end
    
    -- Get new target
    currentTarget = getValidTarget()
    engageTime = tick()
    lastDamageTime = tick()
    
    if currentTarget then
        print("New target:", currentTarget.Name)
    else
        print("No valid target found")
    end
end

-- Check target conditions
local function checkTargetConditions()
    local now = tick()
    
    -- No current target
    if not currentTarget then
        switchTarget("No current target")
        return
    end
    
    -- Target validation checks
    if not currentTarget.Character or not currentTarget.Character:FindFirstChild("Humanoid") then
        switchTarget("Target has no character")
        return
    end
    
    local humanoid = currentTarget.Character.Humanoid
    
    -- Target died
    if humanoid.Health <= 0 then
        switchTarget("Target died")
        return
    end
    
    -- Target in safe zone
    if inSafeZone(currentTarget) then
        switchTarget("Target in safe zone")
        return
    end
    
    -- Target PvP disabled
    if not hasPvPEnabled(currentTarget) then
        switchTarget("Target PvP disabled")
        return
    end
    
    -- No damage timeout
    if now - lastDamageTime > config.NO_DAMAGE_TIMEOUT then
        switchTarget(string.format("No damage for %d seconds", config.NO_DAMAGE_TIMEOUT))
        return
    end
    
    -- Kill timeout
    if now - engageTime > config.KILL_TIMEOUT then
        switchTarget(string.format("Target not killed in %d seconds", config.KILL_TIMEOUT))
        return
    end
end

-- Death handler
local function onPlayerDeath()
    wait(5) -- Respawn delay
    
    -- Re-enable PvP after respawn
    activatePvP()
    
    -- Switch target after death
    switchTarget("Player died")
end

-- Main target management loop
local function targetManagementLoop()
    -- Initial setup
    selectTeam(config.TEAM)
    activatePvP()
    
    while true do
        local now = tick()
        
        -- Periodic PvP check
        if now - lastPvpCheck > config.PVP_CHECK_INTERVAL then
            activatePvP() -- Ensure PvP stays on
            lastPvpCheck = now
        end
        
        -- Check target conditions
        checkTargetConditions()
        
        wait(config.TARGET_REFRESH_RATE)
    end
end

-- Initialize
LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").Died:Connect(onPlayerDeath)
end)

spawn(targetManagementLoop)

print("Advanced Target Management System loaded!")
