repeat wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local RS = game:GetService("RunService")
local VI = game:GetService("VirtualInputManager")
local WS = game:GetService("Workspace")

local gui = Instance.new("ScreenGui")
gui.Parent = game:GetService("CoreGui")

local f = Instance.new("Frame")
f.Size = UDim2.new(0, 160, 0, 100)
f.Position = UDim2.new(0.5, -80, 0.5, -50)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
f.Active = true
f.Draggable = true
f.Parent = gui

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0, 8)
c.Parent = f

local t = Instance.new("TextLabel")
t.Size = UDim2.new(1, 0, 0, 25)
t.BackgroundColor3 = Color3.fromRGB(30, 30, 70)
t.Text = "🔥 AUTO FARM"
t.TextColor3 = Color3.fromRGB(255, 200, 50)
t.Font = Enum.Font.SourceSansBold
t.TextScaled = true
t.Parent = f

local x = Instance.new("TextButton")
x.Size = UDim2.new(0, 20, 0, 20)
x.Position = UDim2.new(1, -25, 0, 2)
x.Text = "X"
x.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
x.TextColor3 = Color3.fromRGB(255, 255, 255)
x.Font = Enum.Font.SourceSansBold
x.TextScaled = true
x.Parent = t

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.8, 0, 0, 30)
btn.Position = UDim2.new(0.1, 0, 0.4, 0)
btn.Text = "🔴 OFF"
btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.SourceSansBold
btn.TextScaled = true
btn.Parent = f

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 20)
status.Position = UDim2.new(0, 0, 0.85, 0)
status.BackgroundTransparency = 1
status.Text = "PARADO"
status.TextColor3 = Color3.fromRGB(255, 0, 0)
status.Font = Enum.Font.SourceSansBold
status.TextScaled = true
status.Parent = f

local farmCon = nil
local ativo = false

x.MouseButton1Click:Connect(function()
    if farmCon then farmCon:Disconnect() end
    gui:Destroy()
end)

btn.MouseButton1Click:Connect(function()
    ativo = not ativo
    
    if ativo then
        btn.Text = "🟢 ON"
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        status.Text = "FARMANDO..."
        status.TextColor3 = Color3.fromRGB(0, 255, 0)
        
        farmCon = RS.Heartbeat:Connect(function()
            if not ativo then
                farmCon:Disconnect()
                return
            end
            
            for _, v in pairs(WS:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Torso") then
                    if v ~= char and v.Name ~= player.Name then
                        local h = v:FindFirstChild("Humanoid")
                        if h and h.Health > 0 then
                            hrp.CFrame = CFrame.new(v.Torso.Position + Vector3.new(0, 2, 0))
                            wait(0.1)
                            VI:SendKeyEvent(true, "q", false, game)
                            wait(0.05)
                            VI:SendKeyEvent(false, "q", false, game)
                            break
                        end
                    end
                end
            end
        end)
    else
        btn.Text = "🔴 OFF"
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        status.Text = "PARADO"
        status.TextColor3 = Color3.fromRGB(255, 0, 0)
        if farmCon then
            farmCon:Disconnect()
            farmCon = nil
        end
    end
end)
