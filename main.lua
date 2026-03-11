-- BRANDON HUB 🚷 ANTI-LAG / FPS BOOST
-- SEPARATE MODULE
-- MADE BY BRANDON HUB

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Lighting = game:GetService("Lighting")

-- // CONFIG // --
local MY_DISCORD = "https://discord.gg/FNR3G4kAEE"

-- // 1. NOTIFICATION // --
local function Notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "BRANDON HUB 🚷",
        Text = text,
        Duration = 5,
        Button1 = "OK"
    })
end

-- // 2. THE NUCLEAR ANTI-LAG // --
local function CleanLag()
    -- Copy Discord to Clipboard instantly
    setclipboard(MY_DISCORD)
    Notify("Discord Link Copied! Join us.")

    -- Disable heavy visual settings
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy() -- Removes textures for max speed
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        elseif v:IsA("PostEffect") then -- Removes Blur, Bloom, etc.
            v.Enabled = false
        end
    end
    
    if workspace:FindFirstChildOfClass("Terrain") then
        local t = workspace:FindFirstChildOfClass("Terrain")
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
    end

    Notify("FPS BOOST ACTIVE! 🚀")
end

-- // 3. EXECUTION // --
CleanLag()
