--// Galaxy Hub Simplificado + Infinite Jump + ESP Box + Speed ao Clicar

local player = game.Players.LocalPlayer
local players = game:GetService("Players")
local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local noclipAtivo = false
local savedPos = nil
local autoStealAtivo = false
local infJumpAtivo = false
local espAtivo = false
local currentSpeed = 16 -- velocidade inicial padrão

-- Coordenadas do AutoSteal
local stealCoords = {
    Vector3.new(-338, 7, -75),
    Vector3.new(-218, 7, -77),
    Vector3.new(-104, 7, -77),
    Vector3.new(4, 7, -79),
    Vector3.new(-101, 7, 76),
    Vector3.new(-219, 7, 74),
    Vector3.new(-326, 7, 74),
    Vector3.new(16, 7, 73) -- nova coord adicionada
}

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- Frame principal
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 260, 0, 400)
Frame.Position = UDim2.new(0.5, -130, 0.35, 0)
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
Title.Text = "🌌 Galaxy Hub"
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
-- MAIN AREA  --
----------------
local MainFrame = Instance.new("Frame", Frame)
MainFrame.Size = UDim2.new(1, -20, 1, -60)
MainFrame.Position = UDim2.new(0, 10, 0, 50)
MainFrame.BackgroundTransparency = 1

-- Função criar botão
local function criarBotao(texto, posY, cor)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.Text = texto
    btn.BackgroundColor3 = cor or Color3.fromRGB(0,170,255)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    return btn
end

-- Botões
local MarkButton = criarBotao("📍 Marcar Posição", 0, Color3.fromRGB(0,170,255))
local TpButton = criarBotao("🚀 Teleportar à Posição", 45, Color3.fromRGB(100,200,100))
local NoclipButton = criarBotao("👻 Noclip: OFF", 90, Color3.fromRGB(255,80,80))
local AutoStealButton = criarBotao("💎 AutoSteal: OFF", 135, Color3.fromRGB(255,80,80))
local InfJumpButton = criarBotao("🌀 Infinite Jump: OFF", 180, Color3.fromRGB(255,80,80))
local ESPButton = criarBotao("👁️ ESP: OFF", 225, Color3.fromRGB(255,80,80))
local SpeedButton = criarBotao("⚡ Speed: "..currentSpeed, 270, Color3.fromRGB(0,170,255))

----------------
-- FUNÇÕES    --
----------------
-- Marcar posição
MarkButton.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedPos = player.Character.HumanoidRootPart.Position
    end
end)

-- Teleportar
TpButton.MouseButton1Click:Connect(function()
    if savedPos and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(savedPos)
    end
end)

-- Noclip
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

-- AutoSteal toggle
AutoStealButton.MouseButton1Click:Connect(function()
    autoStealAtivo = not autoStealAtivo
    AutoStealButton.Text = autoStealAtivo and "💎 AutoSteal: ON" or "💎 AutoSteal: OFF"
    AutoStealButton.BackgroundColor3 = autoStealAtivo and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)
end)

-- AutoSteal função
local function teleportAll()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        for i = 1, #stealCoords do
            player.Character.HumanoidRootPart.CFrame = CFrame.new(stealCoords[i])
            task.wait(0.5)
        end
    end
end

ProximityPromptService.PromptTriggered:Connect(function(prompt, plr)
    if plr == player and autoStealAtivo then
        teleportAll()
    end
end)

-- Infinite Jump
InfJumpButton.MouseButton1Click:Connect(function()
    infJumpAtivo = not infJumpAtivo
    InfJumpButton.Text = infJumpAtivo and "🌀 Infinite Jump: ON" or "🌀 Infinite Jump: OFF"
    InfJumpButton.BackgroundColor3 = infJumpAtivo and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)
end)

uis.JumpRequest:Connect(function()
    if infJumpAtivo and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState("Jumping")
    end
end)

-- ESP (Box + Nome)
local function criarESP(plr)
    if plr == player then return end

    local function aplicarESP(char)
        if char:FindFirstChild("HumanoidRootPart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Name = "ESPBox"
            box.Size = Vector3.new(4, 6, 2)
            box.Color3 = Color3.fromRGB(0,170,255)
            box.Transparency = 0.5
            box.ZIndex = 0
            box.AlwaysOnTop = true
            box.Adornee = char.HumanoidRootPart
            box.Parent = char.HumanoidRootPart
        end

        if char:FindFirstChild("Head") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPName"
            billboard.Adornee = char.Head
            billboard.Size = UDim2.new(0,200,0,50)
            billboard.StudsOffset = Vector3.new(0,2,0)
            billboard.AlwaysOnTop = true
            billboard.Parent = char

            local text = Instance.new("TextLabel", billboard)
            text.Size = UDim2.new(1,0,1,0)
            text.BackgroundTransparency = 1
            text.Text = plr.Name
            text.TextColor3 = Color3.fromRGB(0,170,255)
            text.TextStrokeTransparency = 0
            text.Font = Enum.Font.SourceSansBold
            text.TextScaled = true
        end
    end

    if plr.Character then
        aplicarESP(plr.Character)
    end
    plr.CharacterAdded:Connect(function(newChar)
        task.wait(1)
        aplicarESP(newChar)
    end)
end

ESPButton.MouseButton1Click:Connect(function()
    espAtivo = not espAtivo
    ESPButton.Text = espAtivo and "👁️ ESP: ON" or "👁️ ESP: OFF"
    ESPButton.BackgroundColor3 = espAtivo and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)

    if espAtivo then
        for _, plr in pairs(players:GetPlayers()) do
            criarESP(plr)
        end
        players.PlayerAdded:Connect(criarESP)
    else
        for _, plr in pairs(players:GetPlayers()) do
            if plr.Character then
                if plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:FindFirstChild("ESPBox") then
                    plr.Character.HumanoidRootPart.ESPBox:Destroy()
                end
                if plr.Character:FindFirstChild("ESPName") then
                    plr.Character.ESPName:Destroy()
                end
            end
        end
    end
end)

-- Speed ao clicar (ciclo)
local speedSteps = {16, 30, 60, 100, 200}
local stepIndex = 1

local function setSpeed(val)
    currentSpeed = val
    SpeedButton.Text = "⚡ Speed: " .. currentSpeed
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = currentSpeed
    end
end

SpeedButton.MouseButton1Click:Connect(function()
    stepIndex = stepIndex + 1
    if stepIndex > #speedSteps then
        stepIndex = 1
    end
    setSpeed(speedSteps[stepIndex])
end)

player.CharacterAdded:Connect(function(char)
    task.wait(1)
    if char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = currentSpeed
    end
end)