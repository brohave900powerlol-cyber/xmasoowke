-- BRANDON HUB 🚷 
-- ALL-IN-ONE PREMIUM + FREE
-- DRAGGABLE + TOGGLE + NO-DEATH PHYSICS

local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- // 1. STABLE PHYSICS ENGINE // --
local Spinning = false
local SpinSpeed = 50
local SpinPart = nil

local function StopSpin()
    Spinning = false
    if SpinPart then SpinPart:Destroy() SpinPart = nil end
end

local function StartSpin(speed)
    StopSpin()
    Spinning = true
    SpinSpeed = speed
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        SpinPart = Instance.new("BodyAngularVelocity")
        SpinPart.MaxTorque = Vector3.new(0, 1e6, 0) -- Y-axis only (Safe)
        SpinPart.P = 1250 -- Stability control
        SpinPart.AngularVelocity = Vector3.new(0, SpinSpeed, 0)
        SpinPart.Parent = hrp
    end
end

-- // 2. THE CUSTOM GUI (NO RAYFIELD) // --
local Screen = Instance.new("ScreenGui", LP.PlayerGui)
Screen.Name = "BrandonHub_V3"
Screen.ResetOnSpawn = false

-- FLOATING TOGGLE BUTTON
local OpenBtn = Instance.new("TextButton", Screen)
OpenBtn.Size = UDim2.new(0, 55, 0, 55)
OpenBtn.Position = UDim2.new(0, 15, 0.5, -27)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
OpenBtn.Text = "🚷"
OpenBtn.TextColor3 = Color3.fromRGB(0, 170, 255)
OpenBtn.TextSize = 25
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenBtn).Color = Color3.fromRGB(0, 170, 255)

-- MAIN HUB FRAME
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 230, 0, 280)
Main.Position = UDim2.new(0.5, -115, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.Visible = false
Main.Active = true
Instance.new("UICorner", Main)
local Glow = Instance.new("UIStroke", Main)
Glow.Color = Color3.fromRGB(0, 170, 255)
Glow.Thickness = 2

-- // 3. SMOOTH DRAGGING // --
local dragging, dStart, sPos
Main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dStart = i.Position; sPos = Main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dStart
        Main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y)
    end
end)
Main.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

-- // 4. BUTTONS // --
local function CreateBtn(name, pos, color, func)
    local B = Instance.new("TextButton", Main)
    B.Size = UDim2.new(0.85, 0, 0, 38)
    B.Position = UDim2.new(0.075, 0, 0, pos)
    B.BackgroundColor3 = color
    B.Text = name
    B.TextColor3 = Color3.new(1, 1, 1)
    B.Font = Enum.Font.GothamBold
    Instance.new("UICorner", B)
    B.MouseButton1Click:Connect(func)
end

-- TITLE
local T = Instance.new("TextLabel", Main)
T.Size = UDim2.new(1, 0, 0, 45)
T.Text = "BRANDON HUB 🚷"
T.TextColor3 = Color3.fromRGB(0, 170, 255)
T.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
T.Font = Enum.Font.GothamBold
Instance.new("UICorner", T)

-- SECTION: FREE
CreateBtn("Free Spin (Low)", 60, Color3.fromRGB(30, 30, 35), function() StartSpin(50) end)

-- SECTION: PREMIUM
CreateBtn("💎 Premium Spin (Tornado)", 105, Color3.fromRGB(0, 80, 150), function() StartSpin(250) end)
CreateBtn("🚀 Anti-Lag (Nuclear)", 150, Color3.fromRGB(0, 80, 150), function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
        if v:IsA("Decal") then v:Destroy() end
    end
end)

-- CONTROLS
CreateBtn("🛑 Stop All Scripts", 195, Color3.fromRGB(150, 0, 0), function() StopSpin() end)
CreateBtn("💬 Discord Link", 235, Color3.fromRGB(40, 40, 45), function() setclipboard("https://discord.gg/FNR3G4kAEE") end)

-- OPEN/CLOSE LOGIC
OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)
