-- 🌌 Galaxy Hub v3.3
local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local noclipAtivo = false
local savedPos = nil
local autoStealAtivo = false

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- Frame principal
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 270, 0, 250)
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
Title.Text = "🌌 Galaxy Hub v3.3"
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

-- Bolinha para reabrir
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
-- MAIN AREA  --
----------------
local MainFrame = Instance.new("Frame", Frame)
MainFrame.Size = UDim2.new(1, -20, 1, -50)
MainFrame.Position = UDim2.new(0, 10, 0, 40)
MainFrame.BackgroundTransparency = 1

-- Botão Marcar posição
local MarkButton = Instance.new("TextButton", MainFrame)
MarkButton.Size = UDim2.new(1, 0, 0, 40)
MarkButton.Position = UDim2.new(0, 0, 0, 0)
MarkButton.Text = "📍 Marcar Posição"
MarkButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
MarkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MarkButton.Font = Enum.Font.SourceSansBold
MarkButton.TextScaled = true
Instance.new("UICorner", MarkButton).CornerRadius = UDim.new(0, 12)

MarkButton.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedPos = player.Character.HumanoidRootPart.Position
    end
end)

-- AutoSteal
local AutoStealButton = Instance.new("TextButton", MainFrame)
AutoStealButton.Size = UDim2.new(1, 0, 0, 40)
AutoStealButton.Position = UDim2.new(0, 0, 0, 50)
AutoStealButton.Text = "🤖 AutoSteal: OFF"
AutoStealButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
AutoStealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoStealButton.Font = Enum.Font.SourceSansBold
AutoStealButton.TextScaled = true
Instance.new("UICorner", AutoStealButton).CornerRadius = UDim.new(0, 12)

AutoStealButton.MouseButton1Click:Connect(function()
    autoStealAtivo = not autoStealAtivo
    AutoStealButton.Text = autoStealAtivo and "🤖 AutoSteal: ON" or "🤖 AutoSteal: OFF"
    AutoStealButton.BackgroundColor3 = autoStealAtivo and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)
end)

-- Noclip
local NoclipButton = Instance.new("TextButton", MainFrame)
NoclipButton.Size = UDim2.new(1, 0, 0, 40)
NoclipButton.Position = UDim2.new(0, 0, 0, 100)
NoclipButton.Text = "👻 Noclip: OFF"
NoclipButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.Font = Enum.Font.SourceSansBold
NoclipButton.TextScaled = true
Instance.new("UICorner", NoclipButton).CornerRadius = UDim.new(0, 12)

NoclipButton.MouseButton1Click:Connect(function()
    noclipAtivo = not noclipAtivo
    NoclipButton.Text = noclipAtivo and "👻 Noclip: ON" or "👻 Noclip: OFF"
    NoclipButton.BackgroundColor3 = noclipAtivo and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)
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

--------------------
-- FUNÇÕES GERAIS --
--------------------
-- Teleporte suave inteligente
local function smoothTeleport(targetPos)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero

        local dist = (hrp.Position - targetPos).Magnitude
        local duration = dist > 100 and 4 or 0.5  

        local tween = TweenService:Create(
            hrp,
            TweenInfo.new(duration, Enum.EasingStyle.Linear),
            {CFrame = CFrame.new(targetPos)}
        )
        tween:Play()
        tween.Completed:Wait()
    end
end

-- Loop do AutoSteal
task.spawn(function()
    while task.wait(1) do
        if autoStealAtivo and savedPos then
            smoothTeleport(savedPos)
        end
    end
end)