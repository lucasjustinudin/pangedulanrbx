--[[ 
    PANGEDULAN V2 - MODERN UI
    Style: Dark Glassmorphism & Neon
    Optimized by Gemini
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Bersihkan GUI lama
if PlayerGui:FindFirstChild("PangedulanModern") then
    PlayerGui.PangedulanModern:Destroy()
end

-- TEMA WARNA (Modern Dark Palette)
local Theme = {
    Background = Color3.fromRGB(25, 25, 35),    -- Gelap Modern
    Accent     = Color3.fromRGB(140, 80, 255),  -- Neon Purple
    Secondary  = Color3.fromRGB(45, 45, 55),    -- Abu Gelap untuk Button
    Text       = Color3.fromRGB(240, 240, 240), -- Putih Tulang
    TextDim    = Color3.fromRGB(180, 180, 180), -- Teks pudar
    Glow       = Color3.fromRGB(160, 100, 255)  -- Warna Glow
}

-- 1. SETUP SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PangedulanModern"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 2. MAIN FRAME (Container Utama)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400) -- Sedikit lebih lebar
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BackgroundTransparency = 0.1 -- Efek Kaca
MainFrame.ClipsDescendants = true
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5) -- Titik tengah untuk animasi pop-up
MainFrame.Parent = ScreenGui

-- Styling Main Frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = MainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Theme.Accent
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.2
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = MainFrame

-- Efek Glow Halus (Shadow)
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6014261993" -- Aset shadow halus Roblox
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.4
shadow.ZIndex = -1
shadow.Parent = MainFrame

-- 3. HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Theme.Background
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "PANGEDULAN"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.TextColor3 = Theme.Text
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Text = "V2.0 // SYSTEM"
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 10
SubTitle.TextColor3 = Theme.Accent
SubTitle.Size = UDim2.new(0, 100, 0, 20)
SubTitle.Position = UDim2.new(0, 20, 0, 32)
SubTitle.BackgroundTransparency = 1
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

-- Tombol Close (X) yang Modern
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BackgroundTransparency = 0.8
CloseBtn.Text = "×" -- Simbol X yang lebih estetik
CloseBtn.Font = Enum.Font.GothamMedium
CloseBtn.TextSize = 24
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, TextColor3 = Color3.new(1,1,1)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8, TextColor3 = Color3.fromRGB(255, 100, 100)}):Play()
end)

-- Garis Pembatas Header
local Separator = Instance.new("Frame")
Separator.Size = UDim2.new(1, 0, 0, 1)
Separator.Position = UDim2.new(0, 0, 0, 55)
Separator.BackgroundColor3 = Color3.new(1,1,1)
Separator.BackgroundTransparency = 0.9
Separator.BorderSizePixel = 0
Separator.Parent = MainFrame

-- 4. SCROLL CONTAINER
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollFrame.Position = UDim2.new(0, 10, 0, 65)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 2 -- Scrollbar tipis modern
ScrollFrame.ScrollBarImageColor3 = Theme.Accent
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.CanvasSize = UDim2.new(0,0,0,0)
ScrollFrame.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = ScrollFrame
UIList.Padding = UDim.new(0, 10)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- Padding atas bawah scroll
local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 5)
UIPadding.PaddingBottom = UDim.new(0, 10)
UIPadding.Parent = ScrollFrame

-- 5. FUNCTION: MODERN BUTTON CREATOR
local function createModernButton(text, icon, onClick)
    local btnContainer = Instance.new("TextButton")
    btnContainer.Size = UDim2.new(1, -10, 0, 45)
    btnContainer.BackgroundColor3 = Theme.Secondary
    btnContainer.Text = ""
    btnContainer.AutoButtonColor = false
    btnContainer.Parent = ScrollFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btnContainer
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Theme.Accent
    btnStroke.Transparency = 1
    btnStroke.Thickness = 1
    btnStroke.Parent = btnContainer

    -- Icon (Emoji / Text)
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Text = icon
    iconLabel.Size = UDim2.new(0, 40, 1, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.TextSize = 18
    iconLabel.Parent = btnContainer
    
    -- Teks Utama
    local textLabel = Instance.new("TextLabel")
    textLabel.Text = text
    textLabel.Size = UDim2.new(1, -50, 1, 0)
    textLabel.Position = UDim2.new(0, 45, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Theme.Text
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 14
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = btnContainer

    -- Animasi Hover Modern
    btnContainer.MouseEnter:Connect(function()
        TweenService:Create(btnContainer, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 75)}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
        TweenService:Create(textLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 55, 0, 0)}):Play() -- Geser teks
    end)
    
    btnContainer.MouseLeave:Connect(function()
        TweenService:Create(btnContainer, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Secondary}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
        TweenService:Create(textLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 45, 0, 0)}):Play() -- Balik teks
    end)

    btnContainer.MouseButton1Click:Connect(function()
        -- Efek Klik (Kecil sebentar)
        TweenService:Create(btnContainer, TweenInfo.new(0.1), {Size = UDim2.new(1, -15, 0, 43)}):Play()
        task.wait(0.1)
        TweenService:Create(btnContainer, TweenInfo.new(0.1), {Size = UDim2.new(1, -10, 0, 45)}):Play()
        
        if onClick then onClick(btnContainer, textLabel) end
    end)
    
    return btnContainer, textLabel
end

-- Helper: Load Script
local function runScript(url)
    task.spawn(function()
        local s, r = pcall(game.HttpGet, game, url)
        if s then loadstring(r)() end
    end)
end

-- 6. CONTENT BUTTONS

createModernButton("Spectator Mode", "👁️", function() runScript("https://pastefy.app/uzM8fN4Q/raw") end)
createModernButton("Fly & Rayap Besi", "🪁", function() runScript("https://pastefy.app/bIjtwpOB/raw") end)
createModernButton("Double Jump", "⬆️", function() runScript("https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/doublejump.txt") end)
createModernButton("Jalan Udara", "💨", function() runScript("https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/Airwalk.txt") end)
createModernButton("Record Gameplay", "📹", function() runScript("https://https://pastebin.com/raw/UNNHEtVH") end)

-- FITUR TOGGLE (Lamp, Speed, Fling)

-- Lampu
local lampOn = false
local lampBtn, lampTxt = createModernButton("Lampu Kepala", "💡", function(btn, txt)
    lampOn = not lampOn
    local char = Player.Character
    
    if lampOn then
        txt.TextColor3 = Theme.Accent
        if char then
            local head = char:FindFirstChild("Head")
            if head then
                local l = Instance.new("PointLight", head)
                l.Name = "ModernLamp"
                l.Range = 60
                l.Brightness = 2
            end
        end
    else
        txt.TextColor3 = Theme.Text
        if char then
            for _,v in pairs(char:GetDescendants()) do
                if v.Name == "ModernLamp" then v:Destroy() end
            end
        end
    end
end)

-- Speed
local speedOn = false
createModernButton("Super Speed & Trail", "⚡", function(btn, txt)
    speedOn = not speedOn
    local char = Player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    
    if speedOn then
        txt.TextColor3 = Theme.Accent
        if hum then hum.WalkSpeed = 60 end
        -- Simple Trail Logic
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local t = Instance.new("Trail", hrp)
            t.Name = "SpeedTrail"
            local a1 = Instance.new("Attachment", hrp); a1.Position = Vector3.new(0,-1,0)
            local a2 = Instance.new("Attachment", hrp); a2.Position = Vector3.new(0,1,0)
            t.Attachment0 = a1; t.Attachment1 = a2
            t.Lifetime = 0.4
        end
    else
        txt.TextColor3 = Theme.Text
        if hum then hum.WalkSpeed = 16 end
        if char then 
            for _,v in pairs(char:GetDescendants()) do 
                if v.Name == "SpeedTrail" then v:Destroy() end 
            end 
        end
    end
end)

-- Fling
local flingActive = false
local flingConn
createModernButton("Chaos Fling", "💥", function(btn, txt)
    flingActive = not flingActive
    if flingActive then
        txt.TextColor3 = Color3.fromRGB(255, 50, 50) -- Merah bahaya
        flingConn = RunService.Heartbeat:Connect(function()
            local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.AssemblyLinearVelocity = Vector3.new(math.random(-50,50), 500, math.random(-50,50))
                hrp.RotVelocity = Vector3.new(900,900,900)
            end
        end)
    else
        txt.TextColor3 = Theme.Text
        if flingConn then flingConn:Disconnect() end
        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.AssemblyLinearVelocity = Vector3.zero end
    end
end)


-- 7. MAP SELECTOR (Modern Dropdown Style)
local MapContainer = Instance.new("Frame")
MapContainer.Size = UDim2.new(1, -10, 0, 80)
MapContainer.BackgroundColor3 = Theme.Secondary
MapContainer.Parent = ScrollFrame
Instance.new("UICorner", MapContainer).CornerRadius = UDim.new(0, 10)

local MapTitle = Instance.new("TextLabel")
MapTitle.Text = "TELEPORT MAP"
MapTitle.Size = UDim2.new(1, 0, 0, 25)
MapTitle.BackgroundTransparency = 1
MapTitle.TextColor3 = Theme.TextDim
MapTitle.Font = Enum.Font.GothamBold
MapTitle.TextSize = 10
MapTitle.Parent = MapContainer

local maps = {
    {name = "MT DAUN", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/daun.txt"},
    {name = "MT SIBUATAN", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/%20sibuatan.txt"},
    {name = "MT ATIN", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/atin.txt"},
    {name = "MT ARUNIKA", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/arunika.txt"},
    {name = "MT LEMBAYANA", url = "https://raw.githubusercontent.com/Biontoken/Map-gunung/refs/heads/main/lembayana.txt"}
}
local mIdx = 1

local MapDisplay = Instance.new("TextButton")
MapDisplay.Size = UDim2.new(0.6, 0, 0, 35)
MapDisplay.Position = UDim2.new(0.2, 0, 0.4, 0)
MapDisplay.BackgroundColor3 = Theme.Background
MapDisplay.Text = maps[mIdx].name
MapDisplay.TextColor3 = Theme.Accent
MapDisplay.Font = Enum.Font.GothamBlack
MapDisplay.Parent = MapContainer
Instance.new("UICorner", MapDisplay).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", MapDisplay).Color = Theme.Accent; Instance.new("UIStroke", MapDisplay).Parent = MapDisplay

local function changeMap(dir)
    mIdx = mIdx + dir
    if mIdx < 1 then mIdx = #maps end
    if mIdx > #maps then mIdx = 1 end
    MapDisplay.Text = maps[mIdx].name
end

local Prev = Instance.new("TextButton"); Prev.Text = "<"; Prev.Size = UDim2.new(0,30,0,35); Prev.Position = UDim2.new(0.05,0,0.4,0); Prev.Parent = MapContainer; Prev.BackgroundColor3 = Theme.Background; Prev.TextColor3 = Theme.Text; Prev.Font = Enum.Font.GothamBold; Instance.new("UICorner", Prev).CornerRadius = UDim.new(0,6)
local Next = Instance.new("TextButton"); Next.Text = ">"; Next.Size = UDim2.new(0,30,0,35); Next.Position = UDim2.new(0.85,0,0.4,0); Next.Parent = MapContainer; Next.BackgroundColor3 = Theme.Background; Next.TextColor3 = Theme.Text; Next.Font = Enum.Font.GothamBold; Instance.new("UICorner", Next).CornerRadius = UDim.new(0,6)

Prev.MouseButton1Click:Connect(function() changeMap(-1) end)
Next.MouseButton1Click:Connect(function() changeMap(1) end)
MapDisplay.MouseButton1Click:Connect(function() runScript(maps[mIdx].url) end)

-- 8. MINI FLOATING BUTTON (Lingkaran Modern)
local MiniBtn = Instance.new("TextButton")
MiniBtn.Name = "MiniBtn"
MiniBtn.Size = UDim2.new(0, 50, 0, 50)
MiniBtn.Position = UDim2.new(0.9, 0, 0.8, 0)
MiniBtn.BackgroundColor3 = Theme.Background
MiniBtn.Text = "PGD"
MiniBtn.TextColor3 = Theme.Accent
MiniBtn.Font = Enum.Font.GothamBlack
MiniBtn.Visible = false
MiniBtn.Parent = ScreenGui
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0) -- Bulat
local miniStroke = Instance.new("UIStroke"); miniStroke.Color = Theme.Accent; miniStroke.Thickness = 2; miniStroke.Parent = MiniBtn

MiniBtn.MouseEnter:Connect(function()
    TweenService:Create(MiniBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Rotation = 180}):Play()
end)
MiniBtn.MouseLeave:Connect(function()
    TweenService:Create(MiniBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Rotation = 0}):Play()
end)

-- 9. DRAG & TOGGLE LOGIC
local function drag(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TweenService:Create(frame, TweenInfo.new(0.1), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end
    end)
    frame.InputEnded:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end 
    end)
end
drag(MainFrame)
drag(MiniBtn)

-- Toggle Animasi
CloseBtn.MouseButton1Click:Connect(function()
    -- Animasi Close (Shrink)
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.3)
    MainFrame.Visible = false
    MiniBtn.Visible = true
    -- Animasi Mini Muncul
    MiniBtn.Size = UDim2.new(0,0,0,0)
    TweenService:Create(MiniBtn, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Size = UDim2.new(0,50,0,50)}):Play()
end)

MiniBtn.MouseButton1Click:Connect(function()
    MiniBtn.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0,0,0,0)
    -- Animasi Open (Pop Up)
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 400)}):Play()
end)

-- START ANIMATION
MainFrame.Size = UDim2.new(0,0,0,0)
MainFrame.Visible = true
TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 400)}):Play()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "PANGEDULAN V2";
    Text = "Modern UI Loaded";
    Duration = 3;
})
