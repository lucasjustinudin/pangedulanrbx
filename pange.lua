--[[ 
    REMASTERED GUI - PANGEDULAN
    Optimized by Gemini
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Bersihkan GUI lama jika ada (anti-duplicate)
if PlayerGui:FindFirstChild("PangedulanGui") then
    PlayerGui.PangedulanGui:Destroy()
end

-- KONFIGURASI TEMA
local Theme = {
    Main = Color3.fromRGB(30, 0, 60),
    Accent = Color3.fromRGB(150, 0, 200),
    Text = Color3.fromRGB(255, 255, 255),
    Button = Color3.fromRGB(20, 20, 20),
    Gradient1 = Color3.fromRGB(90, 0, 180),
    Gradient2 = Color3.fromRGB(30, 0, 60)
}

-- 1. SETUP GUI UTAMA
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PangedulanGui" -- Nama diganti
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame Utama
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 340)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -170)
MainFrame.BackgroundColor3 = Theme.Main
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Kosmetik Frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = MainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.5
mainStroke.Parent = MainFrame

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Gradient1),
    ColorSequenceKeypoint.new(1, Theme.Gradient2)
}
mainGradient.Rotation = 45
mainGradient.Parent = MainFrame

-- Navbar (Judul)
local Navbar = Instance.new("Frame")
Navbar.Size = UDim2.new(1, 0, 0, 45)
Navbar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Navbar.BackgroundTransparency = 0.5
Navbar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "PANGEDULAN" -- Judul Utama Diganti
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 18
TitleLabel.TextColor3 = Theme.Text
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Navbar

-- Tombol Close (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Theme.Text
CloseBtn.TextSize = 18
CloseBtn.Parent = Navbar

-- Scrolling Frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -55)
ScrollFrame.Position = UDim2.new(0, 5, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.CanvasSize = UDim2.new(0,0,0,0)
ScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Mini Button (Floating PGD)
local MiniFrame = Instance.new("TextButton")
MiniFrame.Name = "MiniFrame"
MiniFrame.Size = UDim2.new(0, 50, 0, 50)
MiniFrame.Position = UDim2.new(0.9, 0, 0.1, 0)
MiniFrame.BackgroundColor3 = Theme.Main
MiniFrame.Text = "PGD" -- Singkatan Pangedulan
MiniFrame.Font = Enum.Font.GothamBlack
MiniFrame.TextColor3 = Theme.Text
MiniFrame.TextSize = 14
MiniFrame.Visible = false
MiniFrame.Parent = ScreenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(1, 0)
miniCorner.Parent = MiniFrame

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Theme.Accent
miniStroke.Thickness = 2
miniStroke.Parent = MiniFrame

-- 2. DRAG SYSTEM
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

makeDraggable(MainFrame)
makeDraggable(MiniFrame)

-- Logika Close/Open
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniFrame.Visible = true
end)

MiniFrame.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniFrame.Visible = false
end)

-- 3. FUNGSI UTAMA

local function animateButton(btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Button}):Play()
    end)
end

local function createButton(text, url)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Theme.Button
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Theme.Text
    btn.TextSize = 14
    btn.Parent = ScrollFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    animateButton(btn)

    btn.MouseButton1Click:Connect(function()
        if url and url ~= "" then
            task.spawn(function()
                local success, response = pcall(game.HttpGet, game, url)
                if success then
                    local func, err = loadstring(response)
                    if func then func() else warn("Error Loadstring:", err) end
                else
                    warn("Gagal mengambil script:", url)
                end
            end)
        end
    end)
end

-- DAFTAR SCRIPT
createButton("👁️ Spectator", "https://pastefy.app/uzM8fN4Q/raw")
createButton("🪁 Fly & Rayap Besi", "https://pastefy.app/bIjtwpOB/raw")
createButton("⬆️ Double Jump", "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/doublejump.txt")
createButton("💨 Jalan Udara", "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/Airwalk.txt")
createButton("📹 Record Gameplay", "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/rec.txt")


-- 4. FITUR KHUSUS (Lamp, Speed, Fling)

-- A. LAMPU KEPALA
local LampBtn = Instance.new("TextButton")
LampBtn.Size = UDim2.new(0.9, 0, 0, 35)
LampBtn.BackgroundColor3 = Theme.Button
LampBtn.Text = "💡 Lampu Kepala: OFF"
LampBtn.Font = Enum.Font.GothamBold
LampBtn.TextColor3 = Theme.Text
LampBtn.TextSize = 14
LampBtn.Parent = ScrollFrame
Instance.new("UICorner", LampBtn).CornerRadius = UDim.new(0, 8)

local lampEnabled = false

local function updateLamp(char)
    if not char then return end
    local head = char:WaitForChild("Head", 2)
    if not head then return end
    
    local oldLamp = char:FindFirstChild("HeadLamp")
    if oldLamp then oldLamp:Destroy() end

    if lampEnabled then
        local lampPart = Instance.new("Part")
        lampPart.Name = "HeadLamp"
        lampPart.Size = Vector3.new(0.2, 0.2, 0.2)
        lampPart.CanCollide = false
        lampPart.Anchored = false
        lampPart.Transparency = 1
        lampPart.Parent = char
        
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = head
        weld.Part1 = lampPart
        weld.Parent = lampPart
        
        lampPart.CFrame = head.CFrame * CFrame.new(0, 1, 0)
        
        local light = Instance.new("PointLight")
        light.Brightness = 3
        light.Range = 60
        light.Color = Color3.fromRGB(255, 255, 230)
        light.Parent = lampPart
    end
end

LampBtn.MouseButton1Click:Connect(function()
    lampEnabled = not lampEnabled
    LampBtn.Text = lampEnabled and "💡 Lampu Kepala: ON" or "💡 Lampu Kepala: OFF"
    LampBtn.BackgroundColor3 = lampEnabled and Theme.Accent or Theme.Button
    updateLamp(Player.Character)
end)

Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    if lampEnabled then updateLamp(char) end
end)


-- B. SPEED & SELENDANG (Pelangi)
local SpeedToggleBtn = Instance.new("TextButton")
SpeedToggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
SpeedToggleBtn.BackgroundColor3 = Theme.Button
SpeedToggleBtn.Text = "⚡ Dapatkan Speed Button"
SpeedToggleBtn.Font = Enum.Font.GothamBold
SpeedToggleBtn.TextColor3 = Theme.Text
SpeedToggleBtn.TextSize = 14
SpeedToggleBtn.Parent = ScrollFrame
Instance.new("UICorner", SpeedToggleBtn).CornerRadius = UDim.new(0, 8)

local SpeedGuiRef = nil
local speedActive = false

local function createTrail(char)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for _, v in pairs(char:GetChildren()) do
        if v.Name == "RainbowTrail" then v:Destroy() end
    end

    local att0 = Instance.new("Attachment", hrp)
    att0.Position = Vector3.new(0, -1, 0)
    local att1 = Instance.new("Attachment", hrp)
    att1.Position = Vector3.new(0, 1, 0)
    
    local trail = Instance.new("Trail")
    trail.Name = "RainbowTrail"
    trail.Attachment0 = att0
    trail.Attachment1 = att1
    trail.Lifetime = 0.5
    trail.Parent = char
    
    task.spawn(function()
        while trail and trail.Parent do
            local hue = tick() % 5 / 5
            trail.Color = ColorSequence.new(Color3.fromHSV(hue, 1, 1))
            task.wait()
        end
    end)
end

local function toggleSpeedEffect(isActive)
    local char = Player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    
    if isActive then
        if hum then hum.WalkSpeed = 50 end
        createTrail(char)
    else
        if hum then hum.WalkSpeed = 16 end
        for _, v in pairs(char:GetChildren()) do
            if v.Name == "RainbowTrail" then v:Destroy() end
        end
    end
end

local function createExternalSpeedBtn()
    if SpeedGuiRef then SpeedGuiRef:Destroy() end
    
    local sg = Instance.new("ScreenGui")
    sg.Name = "SpeedExternal"
    sg.Parent = PlayerGui
    sg.ResetOnSpawn = false
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.Position = UDim2.new(1, -120, 0.7, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = "SPEED: OFF"
    btn.Font = Enum.Font.GothamBlack
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = sg
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        speedActive = not speedActive
        btn.Text = speedActive and "SPEED: ON" or "SPEED: OFF"
        btn.BackgroundColor3 = speedActive and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(20, 20, 20)
        toggleSpeedEffect(speedActive)
    end)
    
    SpeedGuiRef = sg
end

SpeedToggleBtn.MouseButton1Click:Connect(function()
    if SpeedGuiRef then
        SpeedGuiRef:Destroy()
        SpeedGuiRef = nil
        SpeedToggleBtn.Text = "⚡ Dapatkan Speed Button"
        SpeedToggleBtn.BackgroundColor3 = Theme.Button
        speedActive = false
        toggleSpeedEffect(false)
    else
        createExternalSpeedBtn()
        SpeedToggleBtn.Text = "⚡ Hapus Speed Button"
        SpeedToggleBtn.BackgroundColor3 = Theme.Accent
    end
end)

Player.CharacterAdded:Connect(function()
    if speedActive then
        task.wait(0.5)
        toggleSpeedEffect(true)
    end
end)


-- C. FLING
local FlingBtn = Instance.new("TextButton")
FlingBtn.Size = UDim2.new(0.9, 0, 0, 35)
FlingBtn.BackgroundColor3 = Theme.Button
FlingBtn.Text = "💥 Fling: OFF"
FlingBtn.Font = Enum.Font.GothamBold
FlingBtn.TextColor3 = Theme.Text
FlingBtn.TextSize = 14
FlingBtn.Parent = ScrollFrame
Instance.new("UICorner", FlingBtn).CornerRadius = UDim.new(0, 8)

local flingLoop = nil

local function startFling()
    flingLoop = RunService.Heartbeat:Connect(function()
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            hrp.AssemblyLinearVelocity = Vector3.new(math.random(-50,50), 500, math.random(-50,50))
            hrp.RotVelocity = Vector3.new(1000, 1000, 1000)
        end
    end)
end

local function stopFling()
    if flingLoop then
        flingLoop:Disconnect()
        flingLoop = nil
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
            char.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0)
        end
    end
end

FlingBtn.MouseButton1Click:Connect(function()
    if flingLoop then
        stopFling()
        FlingBtn.Text = "💥 Fling: OFF"
        FlingBtn.BackgroundColor3 = Theme.Button
    else
        startFling()
        FlingBtn.Text = "💥 Fling: ON"
        FlingBtn.BackgroundColor3 = Theme.Accent
    end
end)


-- D. MAP SELECTOR
local SelectorFrame = Instance.new("Frame")
SelectorFrame.Size = UDim2.new(0.9, 0, 0, 40)
SelectorFrame.BackgroundTransparency = 1
SelectorFrame.Parent = ScrollFrame

local maps = {
    {name = "MT DAUN", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/daun.txt"},
    {name = "MT SIBUATAN", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/%20sibuatan.txt"},
    {name = "MT ATIN", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/atin.txt"},
    {name = "MT ARUNIKA", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/arunika.txt"},
    {name = "MT LEMBAYANA", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/lembayana.txt"}
}
local mapIndex = 1

local MapLabel = Instance.new("TextButton")
MapLabel.Size = UDim2.new(0.6, 0, 1, 0)
MapLabel.Position = UDim2.new(0.2, 0, 0, 0)
MapLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MapLabel.Text = maps[mapIndex].name
MapLabel.TextColor3 = Theme.Text
MapLabel.Font = Enum.Font.GothamBold
MapLabel.TextSize = 12
MapLabel.Parent = SelectorFrame
Instance.new("UICorner", MapLabel).CornerRadius = UDim.new(0, 8)

local PrevBtn = Instance.new("TextButton")
PrevBtn.Size = UDim2.new(0.18, 0, 1, 0)
PrevBtn.Position = UDim2.new(0, 0, 0, 0)
PrevBtn.BackgroundColor3 = Theme.Accent
PrevBtn.Text = "<"
PrevBtn.Font = Enum.Font.GothamBlack
PrevBtn.TextColor3 = Theme.Text
PrevBtn.Parent = SelectorFrame
Instance.new("UICorner", PrevBtn).CornerRadius = UDim.new(0, 8)

local NextBtn = Instance.new("TextButton")
NextBtn.Size = UDim2.new(0.18, 0, 1, 0)
NextBtn.Position = UDim2.new(0.82, 0, 0, 0)
NextBtn.BackgroundColor3 = Theme.Accent
NextBtn.Text = ">"
NextBtn.Font = Enum.Font.GothamBlack
NextBtn.TextColor3 = Theme.Text
NextBtn.Parent = SelectorFrame
Instance.new("UICorner", NextBtn).CornerRadius = UDim.new(0, 8)

PrevBtn.MouseButton1Click:Connect(function()
    mapIndex = mapIndex - 1
    if mapIndex < 1 then mapIndex = #maps end
    MapLabel.Text = maps[mapIndex].name
end)

NextBtn.MouseButton1Click:Connect(function()
    mapIndex = mapIndex + 1
    if mapIndex > #maps then mapIndex = 1 end
    MapLabel.Text = maps[mapIndex].name
end)

MapLabel.MouseButton1Click:Connect(function()
    local url = maps[mapIndex].url
    task.spawn(function()
        local s, r = pcall(game.HttpGet, game, url)
        if s then loadstring(r)() end
    end)
end)

-- Notifikasi Start
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "PANGEDULAN", -- Notifikasi juga diganti
    Text = "GUI Berhasil Dimuat!",
    Duration = 3
})
