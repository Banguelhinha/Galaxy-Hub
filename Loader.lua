-- 🌌 Galaxy Hub v3.9 FINAL
-- Funções: Marcar Posição, AutoSteal (TP Instantâneo), Noclip, Minimizar com bolinha

-- Serviços
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local savedPos = nil
local autoStealAtivo = false
local noclipAtivo = false

-- GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GalaxyHub"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🌌 Galaxy Hub v3.9"
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 10)

-- Minimizar
local MinButton = Instance.new("TextButton", Frame)
MinButton.Size = UDim2.new(0, 30, 0, 30)
MinButton.Position = UDim2.new(1, -35, 0, 5)
MinButton.Text = "-"
MinButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinButton.Font = Enum.Font.SourceSansBold
MinButton.TextScaled = true
Instance.new("UICorner", MinButton).CornerRadius = UDim.new(1, 0)

local OpenBall = Instance.new("TextButton", ScreenGui)
OpenBall.Size = UDim2.new(0, 50, 0, 50)
OpenBall.Position = UDim2.new(0.05, 0, 0.8, 0)
OpenBall.Text = "🌌"
OpenBall.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
OpenBall.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBall.Font = Enum.Font.SourceSansBold
OpenBall.TextScaled = true
OpenBall.Visible = false
OpenBall.Active = true
OpenBall.Draggable = true
Instance.new("UICorner", OpenBall).CornerRadius = UDim.new(1, 0)

MinButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    OpenBall.Visible = true
end)

OpenBall.MouseButton1Click:Connect(function()
    Frame.Visible = true
    OpenBall.Visible = false
end)

-- Função TP instantâneo
local function instantTeleport(targetPos)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        hrp.CFrame = CFrame.new(targetPos)
    end
end

-- Botão Marcar Posição
local markButton = Instance.new("TextButton", Frame)
markButton.Size = UDim2.new(0.8, 0, 0, 40)
markButton.Position = UDim2.new(0.1, 0, 0.2, 0)
markButton.Text = "📍 Marcar Posição"
markButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
markButton.TextColor3 = Color3.fromRGB(255, 255, 255)
markButton.Font = Enum.Font.SourceSansBold
markButton.TextScaled = true
Instance.new("UICorner", markButton).CornerRadius = UDim.new(0, 8)

markButton.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedPos = player.Character.HumanoidRootPart.Position
        markButton.Text = "📍 Posição Marcada!"
        task.wait(1)
        markButton.Text = "📍 Marcar Posição"
    end
end)

-- Botão AutoSteal
local stealButton = Instance.new("TextButton", Frame)
stealButton.Size = UDim2.new(0.8, 0, 0, 40)
stealButton.Position = UDim2.new(0.1, 0, 0.35, 0)
stealButton.Text = "💰 AutoSteal OFF"
stealButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
stealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stealButton.Font = Enum.Font.SourceSansBold
stealButton.TextScaled = true
Instance.new("UICorner", stealButton).CornerRadius = UDim.new(0, 8)

stealButton.MouseButton1Click:Connect(function()
    autoStealAtivo = not autoStealAtivo
    stealButton.Text = autoStealAtivo and "💰 AutoSteal ON" or "💰 AutoSteal OFF"
end)

-- AutoSteal: só depois de terminar interação completa
ProximityPromptService.PromptTriggered:Connect(function(prompt, plr)
    if autoStealAtivo and plr == player and savedPos then
        local holdTime = prompt.HoldDuration
        if holdTime > 0 then
            task.delay(holdTime, function()
                if autoStealAtivo and player.Character and savedPos then
                    instantTeleport(savedPos)
                end
            end)
        else
            instantTeleport(savedPos)
        end
    end
end)

-- Botão Noclip
local noclipButton = Instance.new("TextButton", Frame)
noclipButton.Size = UDim2.new(0.8, 0, 0, 40)
noclipButton.Position = UDim2.new(0.1, 0, 0.5, 0)
noclipButton.Text = "🚫 Noclip OFF"
noclipButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Font = Enum.Font.SourceSansBold
noclipButton.TextScaled = true
Instance.new("UICorner", noclipButton).CornerRadius = UDim.new(0, 8)

noclipButton.MouseButton1Click:Connect(function()
    noclipAtivo = not noclipAtivo
    noclipButton.Text = noclipAtivo and "🚫 Noclip ON" or "🚫 Noclip OFF"
end)

RunService.Heartbeat:Connect(function()
    if noclipAtivo and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)