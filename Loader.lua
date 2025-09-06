-- 🌌 Galaxy Hub v3.1 (com controle de altura para mobile)

local player = game.Players.LocalPlayer
local run = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local noclipAtivo = false
local savedPos = nil
local autoStealAtivo = false
local flyHeight = 300 -- altura inicial

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- Frame principal
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 270, 0, 350)
Frame.Position = UDim2.new(0.5, -135, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BackgroundTransparency = 0.2
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 15)

-- Título
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "🌌 Galaxy Hub v3.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

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
OpenBall.Position = UDim2.new(0.1, 0, 0.8, 0)
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

----------------
-- BOTÕES MAIN --
----------------
local MarkButton = Instance.new("TextButton", Frame)
MarkButton.Size = UDim2.new(1, 0, 0, 40)
MarkButton.Position = UDim2.new(0, 0, 0, 50)
MarkButton.Text = "📍 Marcar Posição"
MarkButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
MarkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MarkButton.Font = Enum.Font.SourceSansBold
MarkButton.TextScaled = true
Instance.new("UICorner", MarkButton).CornerRadius = UDim.new(0, 12)

local NoclipButton = Instance.new("TextButton", Frame)
NoclipButton.Size = UDim2.new(1, 0, 0, 40)
NoclipButton.Position = UDim2.new(0, 0, 0, 100)
NoclipButton.Text = "👻 Noclip: OFF"
NoclipButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.Font = Enum.Font.SourceSansBold
NoclipButton.TextScaled = true
Instance.new("UICorner", NoclipButton).CornerRadius = UDim.new(0, 12)

local AutoStealButton = Instance.new("TextButton", Frame)
AutoStealButton.Size = UDim2.new(1, 0, 0, 40)
AutoStealButton.Position = UDim2.new(0, 0, 0, 150)
AutoStealButton.Text = "🤖 AutoSteal: OFF"
AutoStealButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
AutoStealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoStealButton.Font = Enum.Font.SourceSansBold
AutoStealButton.TextScaled = true
Instance.new("UICorner", AutoStealButton).CornerRadius = UDim.new(0, 12)

local FlyHeightButton = Instance.new("TextButton", Frame)
FlyHeightButton.Size = UDim2.new(1, 0, 0, 40)
FlyHeightButton.Position = UDim2.new(0, 0, 0, 200)
FlyHeightButton.Text = "🛫 Altura: " .. flyHeight
FlyHeightButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
FlyHeightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyHeightButton.Font = Enum.Font.SourceSansBold
FlyHeightButton.TextScaled = true
Instance.new("UICorner", FlyHeightButton).CornerRadius = UDim.new(0, 12)

----------------
-- CONEXÕES --
----------------
MarkButton.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedPos = player.Character.HumanoidRootPart.Position
    end
end)

NoclipButton.MouseButton1Click:Connect(function()
    noclipAtivo = not noclipAtivo
    NoclipButton.Text = noclipAtivo and "👻 Noclip: ON" or "👻 Noclip: OFF"
    NoclipButton.BackgroundColor3 = noclipAtivo and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)
end)

AutoStealButton.MouseButton1Click:Connect(function()
    autoStealAtivo = not autoStealAtivo
    AutoStealButton.Text = autoStealAtivo and "🤖 AutoSteal: ON" or "🤖 AutoSteal: OFF"
    AutoStealButton.BackgroundColor3 = autoStealAtivo and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)
end)

FlyHeightButton.MouseButton1Click:Connect(function()
    if flyHeight == 100 then
        flyHeight = 200
    elseif flyHeight == 200 then
        flyHeight = 300
    elseif flyHeight == 300 then
        flyHeight = 400
    else
        flyHeight = 100
    end
    FlyHeightButton.Text = "🛫 Altura: " .. flyHeight
end)

run.Stepped:Connect(function()
    if noclipAtivo and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- AutoSteal com voo para cima
ProximityPromptService.PromptTriggered:Connect(function(prompt, plr)
    if plr == player and autoStealAtivo and savedPos then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            -- voa alto
            hrp.CFrame = CFrame.new(hrp.Position.X, flyHeight, hrp.Position.Z)
            task.wait(1) -- tempo de segurança
            -- executa interação
            pcall(function()
                fireproximityprompt(prompt)
            end)
            task.wait(0.5)
            -- vai para o destino marcado
            hrp.CFrame = CFrame.new(savedPos + Vector3.new(0, 5, 0))
        end
    end
end)