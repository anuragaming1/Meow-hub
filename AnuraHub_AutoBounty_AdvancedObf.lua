
function __anura_fake_7468()
    local a, b = 1, 2
    for i = 1, 10 do
        a = a + b
        b = b + a
    end
    return a + b
end


function __deobf_str(tbl)
    local s = __deobf_str({})
    for i = 1, #tbl do
        s = s .. string.char(tbl[i])
    end
    return s
end

--[[
Anura Hub - Auto Bounty [Fluxus Android Optimized]
- Không cần menu, tự động chạy (Kaitun UI)
- Tối ưu cho Fluxus Android: hạn chế lag, chống clone nil, tránh bị kick - FPS Boost, Auto Skill, Tween TP, Race V3/V4, Aura, Instinct, Sea Beast, v.v. ]]
-- Kiểm tra v_001c
local v_001c = identifyexecutor and identifyexecutor() or __deobf_str({85,110,107,110,111,119,110}) if v_001c ~= __deobf_str({70,108,117,120,117,115}) then warn(__deobf_str({83,99,114,105,112,116,32,110,224,121,32,99,104,7881,32,116,7889,105,32,432,117,32,99,104,111,32,70,108,117,120,117,115,32,65,110,100,114,111,105,100,46}))
end
-- Chống kick + anti-banwave
pcall(v_0010()
if setfflag then setfflag(__deobf_str({65,98,117,115,101,82,101,112,111,114,116,83,99,114,101,101,110,115,104,111,116,80,101,114,99,101,110,116,97,103,101}), __deobf_str({48}))
setfflag(__deobf_str({68,70,70,108,97,103,65,98,117,115,101,82,101,112,111,114,116,83,99,114,101,101,110,115,104,111,116}), __deobf_str({70,97,108,115,101}))
end
if setreadonly then setreadonly(getrawmetatable(game), false)
end
end)
-- FPS Boost
for _,v in pairs(game:GetDescendants()) do if v:IsA(__deobf_str({66,97,115,101,80,97,114,116})) then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 elseif v:IsA(__deobf_str({68,101,99,97,108})) then v.Transparency = 1 end
end
-- Tắt hiệu ứng + khói
game:GetService(__deobf_str({76,105,103,104,116,105,110,103})).GlobalShadows = false game:GetService(__deobf_str({76,105,103,104,116,105,110,103})).FogEnd = 100000 settings().Rendering.QualityLevel = __deobf_str({76,101,118,101,108,48,49}) collectgarbage(__deobf_str({99,111,117,110,116}))
-- UI Bảng Điều Khiển
local v_0025 = Instance.new(__deobf_str({118,95,48,48,50,53}), game.CoreGui)
v_0025.Name = __deobf_str({65,110,117,114,97,72,117,98,95,85,73}) local v_001a = Instance.new(__deobf_str({73,109,97,103,101,76,97,98,101,108}), v_0025)
v_001a.Size = UDim2.new(0, 300, 0, 200)
v_001a.Position = UDim2.new(0.5, -150, 0.5, -100)
v_001a.BackgroundTransparency = 1 v_001a.Image = __deobf_str({114,98,120,97,115,115,101,116,105,100,58,47,47,49,51,49,49,53,49,55,51,49,54,48,52,51,48,57}) local v_000d = Instance.new(__deobf_str({84,101,120,116,76,97,98,101,108}), v_001a)
v_000d.Size = UDim2.new(1, 0, 0, 30)
v_000d.Text = __deobf_str({65,110,117,114,97,32,72,117,98}) v_000d.TextColor3 = Color3.fromRGB(255, 0, 0)
v_000d.TextStrokeTransparency = 0 v_000d.TextSize = 20 v_000d.BackgroundTransparency = 1 local v_0017 = Instance.new(__deobf_str({84,101,120,116,76,97,98,101,108}), v_001a)
v_0017.Position = UDim2.new(0, 0, 0, 30)
v_0017.Size = UDim2.new(1, 0, 0, 20)
v_0017.Text = __deobf_str({65,117,116,111,32,66,111,117,110,116,121}) v_0017.TextColor3 = Color3.fromRGB(0, 255, 0)
v_0017.TextSize = 16 v_0017.BackgroundTransparency = 1 -- Thông tin Kill và Bounty
local v_0013 = Instance.new(__deobf_str({84,101,120,116,76,97,98,101,108}), v_001a)
v_0013.Position = UDim2.new(0, 10, 0, 60)
v_0013.Size = UDim2.new(1, -20, 0, 20)
v_0013.Text = __deobf_str({66,111,117,110,116,121,58,32,48}) v_0013.TextColor3 = Color3.fromRGB(255, 255, 255)
v_0013.BackgroundTransparency = 1 v_0013.TextScaled = true local v_001d = Instance.new(__deobf_str({84,101,120,116,76,97,98,101,108}), v_001a)
v_001d.Position = UDim2.new(0, 10, 0, 85)
v_001d.Size = UDim2.new(1, -20, 0, 20)
v_001d.Text = __deobf_str({75,105,108,108,115,58,32,48}) v_001d.TextColor3 = Color3.fromRGB(255, 255, 255)
v_001d.BackgroundTransparency = 1 v_001d.TextScaled = true local v_0020 = Instance.new(__deobf_str({84,101,120,116,76,97,98,101,108}), v_001a)
v_0020.Position = UDim2.new(0, 10, 0, 110)
v_0020.Size = UDim2.new(1, -20, 0, 20)
v_0020.Text = __deobf_str({70,80,83,58,32,54,48}) v_0020.TextColor3 = Color3.fromRGB(255, 255, 255)
v_0020.BackgroundTransparency = 1 v_0020.TextScaled = true -- Cập nhật FPS theo thời gian
spawn(v_0010()
while true do local v_0005 = tick()
task.wait()
local v_001e = math.floor(1 / (tick() - v_0005))
v_0020.Text = __deobf_str({70,80,83,58,32}) .. v_001e task.wait(1)
end
end)
-- Auto bật Aura, Instinct, Race
spawn(v_0010()
while true do pcall(v_0010()
if not game.Players.LocalPlayer.Character:FindFirstChild(__deobf_str({72,97,115,66,117,115,111})) then game:GetService(__deobf_str({82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101})).Remotes.CommF_:InvokeServer(__deobf_str({66,117,115,111}))
end
if not game.Players.LocalPlayer.Character:FindFirstChild(__deobf_str({73,110,115,116,105,110,99,116})) then game:GetService(__deobf_str({82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101})).Remotes.CommE:InvokeServer(__deobf_str({75,101,110}), true)
end
if game:GetService(__deobf_str({82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101})).Remotes:FindFirstChild(__deobf_str({65,99,116,105,118,97,116,101,82,97,99,101,86,52})) then game:GetService(__deobf_str({82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101})).Remotes.ActivateRaceV4:FireServer()
end
end)
task.wait(5)
end
end)
-- Tự động tìm player khác và Tween TP
local v_0010 getRandomEnemy()
local v_000f = {}
for _, plr in pairs(game.Players:GetPlayers()) do if plr ~= game.Players.LocalPlayer and plr.Team ~= game.Players.LocalPlayer.Team then table.insert(v_000f, plr)
end
end
return #v_000f > 0 and v_000f[math.random(1, #v_000f)] or nil end
local v_0012 = game:GetService(__deobf_str({118,95,48,48,49,50}))
local v_0010 tweenToTarget(v_0015)
local v_0009 = game.Players.LocalPlayer.Character if not v_0009 or not v_0015 or not v_0015.Character then return end
local v_0014 = v_0009:FindFirstChild(__deobf_str({72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116}))
local v_0011 = v_0015.Character:FindFirstChild(__deobf_str({72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116}))
if v_0014 and v_0011 then local v_0019 = (v_0014.Position - v_0011.Position).magnitude local v_0001 = v_0019 / 300 local v_0024 = v_0012:Create(v_0014, TweenInfo.new(v_0001, Enum.EasingStyle.Linear), {CFrame = v_0011.CFrame + Vector3.new(0, 3, 0)})
v_0024:Play()
v_0024.Completed:Wait()
end
end
-- Tự động combo chiêu Z/X/C/V/F và đánh thường nếu hết chiêu
local v_0010 attackTarget(v_0015)
local v_001f = game:GetService(__deobf_str({118,95,48,48,49,102}))
local v_0008 = {__deobf_str({90}), __deobf_str({88}), __deobf_str({67}), __deobf_str({86}), __deobf_str({70})}
for _, key in pairs(v_0008) do v_001f:SendKeyEvent(true, key, false, game)
task.wait(0.5)
v_001f:SendKeyEvent(false, key, false, game)
end
task.wait(1)
-- đánh thường
for i = 1, 5 do v_001f:SendMouseButtonEvent(0, 0, 0, true, game, 1)
task.wait(0.2)
end
end
-- Vòng lặp Auto Kill
spawn(v_0010()
while true do local v_0015 = getRandomEnemy()
if v_0015 then tweenToTarget(v_0015)
attackTarget(v_0015)
end
task.wait(3)
end
end)
-- Auto chọn team theo config
local v_0016 = __deobf_str({80,105,114,97,116,101,115}) -- chỉnh thành __deobf_str({77,97,114,105,110,101,115}) nếu muốn pcall(v_0010()
if game.Players.LocalPlayer.Team == nil then for _, v in pairs(game:GetService(__deobf_str({80,108,97,121,101,114,115})).LocalPlayer.PlayerGui:GetChildren()) do if v:FindFirstChild(__deobf_str({67,104,111,111,115,101,84,101,97,109})) then game:GetService(__deobf_str({82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101})).Remotes.CommF_:InvokeServer(__deobf_str({83,101,116,84,101,97,109}), v_0016)
end
end
end
end)
-- Theo dõi số kill và auto server hop sau 6 kill
local v_0021 = 0 local v_000e = game:GetService(__deobf_str({118,95,48,48,48,101}))
local v_0026 = game:GetService(__deobf_str({118,95,48,48,50,54}))
local v_0023 = game.PlaceId local v_0010 hopServer()
local v_0000 = {}
local v_0002 = game:HttpGet(__deobf_str({104,116,116,112,115,58,47,47,103,97,109,101,115,46,114,111,98,108,111,120,46,99,111,109,47,118,49,47,103,97,109,101,115,47}) .. v_0023 .. __deobf_str({47,118,95,48,48,48,48,47,80,117,98,108,105,99,63,115,111,114,116,79,114,100,101,114,61,65,115,99,38,108,105,109,105,116,61,49,48,48}))
for _, server in pairs(v_000e:JSONDecode(v_0002).data) do if server.playing < server.maxPlayers then table.insert(v_0000, server.id)
end
end
if #v_0000 > 0 then v_0026:TeleportToPlaceInstance(v_0023, v_0000[math.random(1, #v_0000)], game.Players.LocalPlayer)
end
end
-- Summon Sea Beast khi đủ 10m v_000a
spawn(v_0010()
while true do local v_000a = game.Players.LocalPlayer.leaderstats and game.Players.LocalPlayer.leaderstats.Bounty if v_000a and v_000a.Value >= 10000000 then game:GetService(__deobf_str({82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101})).Remotes.CommF_:InvokeServer(__deobf_str({83,101,97,66,101,97,115,116}))
end
task.wait(30)
end
end)
-- Next Player button
local v_0022 = Instance.new(__deobf_str({84,101,120,116,66,117,116,116,111,110}), v_001a)
v_0022.Position = UDim2.new(0.5, -60, 1, -40)
v_0022.Size = UDim2.new(0, 120, 0, 25)
v_0022.Text = __deobf_str({78,101,120,116,32,80,108,97,121,101,114}) v_0022.TextScaled = true v_0022.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
v_0022.TextColor3 = Color3.fromRGB(255, 255, 255)
local v_000c = false v_0022.MouseButton1Click:Connect(v_0010()
v_000c = true end)
-- Đo thời gian chạy script
local v_0007 = os.v_0001()
spawn(v_0010()
while true do local v_000b = os.v_0001() - v_0007 local v_0003 = math.floor(v_000b / 60)
local v_0004 = v_000b % 60 v_000d.Text = __deobf_str({65,110,117,114,97,32,72,117,98,32,40})..v_0003..__deobf_str({109,32})..v_0004..__deobf_str({115,41}) task.wait(1)
end
end)
-- Kết hợp v_000c trong loop kill
spawn(v_0010()
while true do local v_0015 = getRandomEnemy()
if v_0015 then tweenToTarget(v_0015)
attackTarget(v_0015)
v_0021 = v_0021 + 1 v_001d.Text = __deobf_str({75,105,108,108,115,58,32})..v_0021 if v_0021 >= 6 then hopServer()
end
end
if v_000c then v_000c = false end
task.wait(3)
end
end)
-- FPS Boost + Fix Lag + Tối ưu Treo Máy
settings().Rendering.QualityLevel = __deobf_str({76,101,118,101,108,48,49}) game:GetService(__deobf_str({76,105,103,104,116,105,110,103})).GlobalShadows = false game:GetService(__deobf_str({76,105,103,104,116,105,110,103})).FogEnd = 9e9 game:GetService(__deobf_str({76,105,103,104,116,105,110,103})).Brightness = 0 for _, v in pairs(game:GetDescendants()) do if v:IsA(__deobf_str({66,97,115,101,80,97,114,116})) and not v:IsA(__deobf_str({77,101,115,104,80,97,114,116})) then v.Material = Enum.Material.Plastic v.Reflectance = 0 elseif v:IsA(__deobf_str({68,101,99,97,108})) or v:IsA(__deobf_str({84,101,120,116,117,114,101})) then v:Destroy()
elseif v:IsA(__deobf_str({80,97,114,116,105,99,108,101,69,109,105,116,116,101,114})) or v:IsA(__deobf_str({84,114,97,105,108})) then v.Lifetime = NumberRange.new(0)
end
end
game:GetService(__deobf_str({83,116,97,114,116,101,114,71,117,105})):SetCore(__deobf_str({82,101,115,101,116,66,117,116,116,111,110,67,97,108,108,98,97,99,107}), false)
game:GetService(__deobf_str({82,117,110,83,101,114,118,105,99,101})):Set3dRenderingEnabled(false)
-- Anti Kick, giữ kết nối
local v_0006 = game:service('v_0006')
game:service('Players').LocalPlayer.Idled:connect(v_0010()
v_0006:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
v_0006:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
-- Anti BanWave Update 26
local v_0010 protectRemotes()
local v_001b = {__deobf_str({66,97,110}), __deobf_str({75,105,99,107}), __deobf_str({83,104,117,116,100,111,119,110}), __deobf_str({83,101,116,66,97,110}), __deobf_str({83,101,116,75,105,99,107})}
for _, conn in pairs(getgc(true)) do if type(conn) == __deobf_str({118,95,48,48,49,48}) and getfenv(conn).script then local v_0018 = getfenv(conn).script.Name for _, word in ipairs(v_001b) do if string.find(v_0018:lower(), word:lower()) then hookfunction(conn, v_0010(...) return nil end)
end
end
end
end
end
pcall(protectRemotes)
-- Tắt các core scripts không cần thiết
for _, v in pairs(game:GetService(__deobf_str({83,116,97,114,116,101,114,71,117,105})):GetChildren()) do if v:IsA(__deobf_str({83,99,114,105,112,116})) or v:IsA(__deobf_str({76,111,99,97,108,83,99,114,105,112,116})) then v.Disabled = true end
end
print(__deobf_str({65,110,117,114,97,32,72,117,98,32,45,32,65,110,116,105,66,97,110,32,43,32,70,80,83,66,111,111,115,116,32,76,111,97,100,101,100,46}))