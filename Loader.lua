-- 🌌 Galaxy Hub v3.6

local player = game.Players.LocalPlayer
local run = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local savedPos = nil
local noclipAtivo = false
local autoStealAtivo = false
local minimized = false

-- Função voo de 2s no ar
local function vooSuave(destino)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        local destinoElevado = destino + Vector3.new(0, 50, 0) -- sobe no ar
        local deslocamento = destinoElevado - hrp.Position
        local velocidade = deslocamento / 2 -- 2s

        local bv = Instance.new("BodyVelocity")
        bv.Velocity = velocidade
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Parent = hrp

        task.wait(2)
        bv:Destroy()
    end
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 270, 0, 300)
Frame.Position = UDim2.new(0.5, -135, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BackgroundTransparency = 0.3 -- 🤫 fundo transparente
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 15)

-- Título
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -60, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "🌌 Galaxy Hub v3.6"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão minimizar
local MinimizeButton = Instance.new("TextButton", Frame)
MinimizeButton.Size = UDim2.new(0, 40, 0, 30)
MinimizeButton.Position = UDim2.new(1, -45, 0, 5)
MinimizeButton.Text = "−"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextScaled = true
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 8)

-- Botões
local conteudo = {}

local MarkButton = Instance.new("TextButton", Frame)
MarkButton.Size = UDim2.new(1, 0, 0, 40)
MarkButton.Position = UDim2.new(0, 0, 0, 50)
MarkButton.Text = "📍 Marcar Posição"
MarkButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
MarkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MarkButton.Font = Enum.Font.SourceSansBold
MarkButton.TextScaled = true
Instance.new("UICorner", MarkButton).CornerRadius = UDim.new(0, 12)
table.insert(conteudo, MarkButton)

local NoclipButton = Instance.new("TextButton", Frame)
NoclipButton.Size = UDim2.new(1, 0, 0, 40)
NoclipButton.Position = UDim2.new(0, 0, 0, 100)
NoclipButton.Text = "👻 Noclip: OFF"
NoclipButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.Font = Enum.Font.SourceSansBold
NoclipButton.TextScaled = true
Instance.new("UICorner", NoclipButton).CornerRadius = UDim.new(0, 12)
table.insert(conteudo, NoclipButton)

local AutoStealButton = Instance.new("TextButton", Frame)
AutoStealButton.Size = UDim2.new(1, 0, 0, 40)
AutoStealButton.Position = UDim2.new(0, 0, 0, 150)
AutoStealButton.Text = "🤖 AutoSteal: OFF"
AutoStealButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
AutoStealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoStealButton.Font = Enum.Font.SourceSansBold
AutoStealButton.TextScaled = true
Instance.new("UICorner", AutoStealButton).CornerRadius = UDim.new(0, 12)
table.insert(conteudo, AutoStealButton)

-- Funções
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

-- Minimizar
local function atualizarConteudo(estado)
    for _, obj in ipairs(conteudo) do
        obj.Visible = estado
    end
end

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    atualizarConteudo(not minimized)
    MinimizeButton.Text = minimized and "+" or "−"
end)

-- Noclip loop
run.Stepped:Connect(function()
    if noclipAtivo and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- AutoSteal integração
ProximityPromptService.PromptTriggered:Connect(function(prompt, plr)
    if plr == player and autoStealAtivo and savedPos then
        vooSuave(savedPos)
    end
end)