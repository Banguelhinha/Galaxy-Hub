local a=game.Players.LocalPlayer
local b=game:GetService("RunService")
local c=false
local d=nil
local e=Instance.new("ScreenGui",game.CoreGui)

local f=Instance.new("Frame",e)
f.Size=UDim2.new(0,270,0,350)
f.Position=UDim2.new(0.5,-135,0.4,0)
f.BackgroundColor3=Color3.fromRGB(40,40,40)
f.BackgroundTransparency=0.2
f.Active=true
f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,15)

local g=Instance.new("TextLabel",f)
g.Size=UDim2.new(1,-40,0,30)
g.Position=UDim2.new(0,10,0,5)
g.BackgroundTransparency=1
g.Text="🌌 Galaxy Hub"
g.TextColor3=Color3.fromRGB(255,255,255)
g.Font=Enum.Font.SourceSansBold
g.TextScaled=true
g.TextXAlignment=Enum.TextXAlignment.Left

local h=Instance.new("TextButton",f)
h.Size=UDim2.new(0,30,0,30)
h.Position=UDim2.new(1,-35,0,5)
h.Text="-"
h.BackgroundColor3=Color3.fromRGB(255,80,80)
h.TextColor3=Color3.fromRGB(255,255,255)
h.Font=Enum.Font.SourceSansBold
h.TextScaled=true
Instance.new("UICorner",h).CornerRadius=UDim.new(1,0)

local i=Instance.new("TextButton",e)
i.Size=UDim2.new(0,50,0,50)
i.Position=UDim2.new(0.1,0,0.8,0)
i.Text="🌌"
i.BackgroundColor3=Color3.fromRGB(0,170,255)
i.TextColor3=Color3.fromRGB(255,255,255)
i.Font=Enum.Font.SourceSansBold
i.TextScaled=true
i.Visible=false
i.Active=true
i.Draggable=true
Instance.new("UICorner",i).CornerRadius=UDim.new(1,0)

h.MouseButton1Click:Connect(function()
    f.Visible=false
    i.Visible=true
end)
i.MouseButton1Click:Connect(function()
    f.Visible=true
    i.Visible=false
end)

-- Conteúdo
local j=Instance.new("Frame",f)
j.Size=UDim2.new(1,-20,1,-80)
j.Position=UDim2.new(0,10,0,75)
j.BackgroundTransparency=1

-- Marcar posição
local k=Instance.new("TextButton",j)
k.Size=UDim2.new(1,0,0,40)
k.Position=UDim2.new(0,0,0,0)
k.Text="📍 Marcar Posição"
k.BackgroundColor3=Color3.fromRGB(0,170,255)
k.TextColor3=Color3.fromRGB(255,255,255)
k.Font=Enum.Font.SourceSansBold
k.TextScaled=true
Instance.new("UICorner",k).CornerRadius=UDim.new(0,12)

-- TP
local l=Instance.new("TextButton",j)
l.Size=UDim2.new(0.8,-5,0,40)
l.Position=UDim2.new(0,0,0,50)
l.Text="🚀 Teleportar à Posição"
l.BackgroundColor3=Color3.fromRGB(100,200,100)
l.TextColor3=Color3.fromRGB(255,255,255)
l.Font=Enum.Font.SourceSansBold
l.TextScaled=true
Instance.new("UICorner",l).CornerRadius=UDim.new(0,12)

local m=Instance.new("TextButton",j)
m.Size=UDim2.new(0.2,0,0,40)
m.Position=UDim2.new(0.8,5,0,50)
m.Text="⚙️"
m.BackgroundColor3=Color3.fromRGB(80,80,80)
m.TextColor3=Color3.fromRGB(255,255,255)
m.Font=Enum.Font.SourceSansBold
m.TextScaled=true
Instance.new("UICorner",m).CornerRadius=UDim.new(1,0)

k.MouseButton1Click:Connect(function()
    if a.Character and a.Character:FindFirstChild("HumanoidRootPart") then
        d=a.Character.HumanoidRootPart.Position
        k.Visible=false
    end
end)
l.MouseButton1Click:Connect(function()
    if d and a.Character and a.Character:FindFirstChild("HumanoidRootPart") then
        a.Character.HumanoidRootPart.CFrame=CFrame.new(d)
    end
end)
m.MouseButton1Click:Connect(function() k.Visible=true end)

-- Noclip
local n=Instance.new("TextButton",j)
n.Size=UDim2.new(1,0,0,40)
n.Position=UDim2.new(0,0,0,100)
n.Text="👻 Noclip: OFF"
n.BackgroundColor3=Color3.fromRGB(255,80,80)
n.TextColor3=Color3.fromRGB(255,255,255)
n.Font=Enum.Font.SourceSansBold
n.TextScaled=true
Instance.new("UICorner",n).CornerRadius=UDim.new(0,12)

n.MouseButton1Click:Connect(function()
    c=not c
    n.Text=c and "👻 Noclip: ON" or "👻 Noclip: OFF"
    n.BackgroundColor3=c and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)
end)

b.Stepped:Connect(function()
    if c and a.Character then
        for _,o in pairs(a.Character:GetDescendants()) do
            if o:IsA("BasePart") then o.CanCollide=false end
        end
    end
end)

-- AutoSteal
local coords={
    Vector3.new(-338,7,-75),
    Vector3.new(-218,7,-77),
    Vector3.new(-104,7,-77),
    Vector3.new(4,7,-79),
    Vector3.new(-101,7,76),
    Vector3.new(-219,7,74),
    Vector3.new(-326,7,74)
}
local auto=false

local p=Instance.new("TextButton",j)
p.Size=UDim2.new(1,0,0,40)
p.Position=UDim2.new(0,0,0,150)
p.Text="💰 AutoSteal: OFF"
p.BackgroundColor3=Color3.fromRGB(255,80,80)
p.TextColor3=Color3.fromRGB(255,255,255)
p.Font=Enum.Font.SourceSansBold
p.TextScaled=true
Instance.new("UICorner",p).CornerRadius=UDim.new(0,12)

p.MouseButton1Click:Connect(function()
    auto=not auto
    p.Text=auto and "💰 AutoSteal: ON" or "💰 AutoSteal: OFF"
    p.BackgroundColor3=auto and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,80,80)
end)

game.DescendantAdded:Connect(function(q)
    if q:IsA("ProximityPrompt") then
        q.Triggered:Connect(function()
            if auto and a.Character and a.Character:FindFirstChild("HumanoidRootPart") then
                for r=1,#coords do
                    a.Character.HumanoidRootPart.CFrame=CFrame.new(coords[r])
                    task.wait(0.2) -- rápido
                end
            end
        end)
    end
end)
