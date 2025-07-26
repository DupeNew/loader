-- Advanced Pet Age Modifier Script
-- Modern curved design with spectacular visual effects and animations

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local character = player.Character or player.CharacterAdded:Wait()

-- Variables
local currentAge = 0
local targetAge = 50
local isProcessing = false

-- Advanced GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "AdvancedPetAgeModifier"
screenGui.ResetOnSpawn = false

-- Main container with advanced styling
local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, 380, 0, 280)
mainContainer.Position = UDim2.new(0.5, -190, 0.5, -140)
mainContainer.BackgroundTransparency = 1
mainContainer.Active = true
mainContainer.Draggable = true
mainContainer.Parent = screenGui

-- Animated background with gradient
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
backgroundFrame.Parent = mainContainer

local backgroundCorner = Instance.new("UICorner")
backgroundCorner.CornerRadius = UDim.new(0, 25)
backgroundCorner.Parent = backgroundFrame

-- Dynamic gradient overlay
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(15, 25, 35)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(25, 15, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 20, 25))
}
gradient.Rotation = 45
gradient.Parent = backgroundFrame

-- Animated border glow
local glowStroke = Instance.new("UIStroke")
glowStroke.Color = Color3.fromRGB(0, 255, 150)
glowStroke.Thickness = 3
glowStroke.Transparency = 0.4
glowStroke.Parent = backgroundFrame

-- Particle effect background
local particleContainer = Instance.new("Frame")
particleContainer.Size = UDim2.new(1, 0, 1, 0)
particleContainer.Position = UDim2.new(0, 0, 0, 0)
particleContainer.BackgroundTransparency = 1
particleContainer.ClipsDescendants = true
particleContainer.Parent = mainContainer

-- Create floating particles for background effect
local function createParticle()
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
    particle.Position = UDim2.new(math.random(), 0, 1.1, 0)
    particle.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    particle.BackgroundTransparency = math.random(30, 80) / 100
    particle.Parent = particleContainer

    local particleCorner = Instance.new("UICorner")
    particleCorner.CornerRadius = UDim.new(1, 0)
    particleCorner.Parent = particle

    -- Animate particle floating upward
    local floatTween = TweenService:Create(particle,
        TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Linear),
        {Position = UDim2.new(math.random(), 0, -0.1, 0), BackgroundTransparency = 1}
    )
    floatTween:Play()

    floatTween.Completed:Connect(function()
        particle:Destroy()
    end)
end

-- Spawn particles continuously
spawn(function()
    while true do
        createParticle()
        wait(math.random(1, 3) / 10)
    end
end)

-- Advanced title with glow effect
local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(1, -30, 0, 60)
titleContainer.Position = UDim2.new(0, 15, 0, 15)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = mainContainer

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "⚡ PET AGE ACCELERATOR ⚡"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextStrokeTransparency = 0.3
title.TextStrokeColor3 = Color3.fromRGB(0, 255, 150)
title.Parent = titleContainer

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0.4, 0)
subtitle.Position = UDim2.new(0, 0, 0.6, 0)
subtitle.Text = "Instantly boost your pet to maximum age"
subtitle.TextColor3 = Color3.fromRGB(180, 180, 200)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextStrokeTransparency = 0.7
subtitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
subtitle.Parent = titleContainer

-- Pet information panel with advanced styling
local petInfoPanel = Instance.new("Frame")
petInfoPanel.Size = UDim2.new(1, -30, 0, 80)
petInfoPanel.Position = UDim2.new(0, 15, 0, 85)
petInfoPanel.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
petInfoPanel.Parent = mainContainer

local petInfoCorner = Instance.new("UICorner")
petInfoCorner.CornerRadius = UDim.new(0, 15)
petInfoCorner.Parent = petInfoPanel

local petInfoStroke = Instance.new("UIStroke")
petInfoStroke.Color = Color3.fromRGB(0, 150, 255)
petInfoStroke.Thickness = 2
petInfoStroke.Transparency = 0.5
petInfoStroke.Parent = petInfoPanel

local petInfoGradient = Instance.new("UIGradient")
petInfoGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 30))
}
petInfoGradient.Rotation = 90
petInfoGradient.Parent = petInfoPanel

-- Pet status display
local petInfo = Instance.new("TextLabel")
petInfo.Size = UDim2.new(1, -20, 0.6, 0)
petInfo.Position = UDim2.new(0, 10, 0, 5)
petInfo.Text = "🐾 Current Pet: [Scanning...]"
petInfo.TextColor3 = Color3.fromRGB(255, 255, 150)
petInfo.BackgroundTransparency = 1
petInfo.Font = Enum.Font.GothamBold
petInfo.TextSize = 16
petInfo.TextStrokeTransparency = 0.6
petInfo.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
petInfo.TextXAlignment = Enum.TextXAlignment.Left
petInfo.Parent = petInfoPanel

-- Age display
local ageInfo = Instance.new("TextLabel")
ageInfo.Size = UDim2.new(1, -20, 0.4, 0)
ageInfo.Position = UDim2.new(0, 10, 0.6, 0)
ageInfo.Text = "⏰ Current Age: Unknown"
ageInfo.TextColor3 = Color3.fromRGB(150, 200, 255)
ageInfo.BackgroundTransparency = 1
ageInfo.Font = Enum.Font.Gotham
ageInfo.TextSize = 14
ageInfo.TextStrokeTransparency = 0.7
ageInfo.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
ageInfo.TextXAlignment = Enum.TextXAlignment.Left
ageInfo.Parent = petInfoPanel

-- Advanced button with spectacular design
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, -30, 0, 55)
buttonContainer.Position = UDim2.new(0, 15, 0, 175)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainContainer

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, 0)
button.Position = UDim2.new(0, 0, 0, 0)
button.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
button.Text = ""
button.AutoButtonColor = false
button.Parent = buttonContainer

-- Curved corners for button
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 18)
buttonCorner.Parent = button

-- Button gradient
local buttonGradient = Instance.new("UIGradient")
buttonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 80, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
}
buttonGradient.Rotation = 45
buttonGradient.Parent = button

-- Animated button border
local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(255, 200, 0)
buttonStroke.Thickness = 3
buttonStroke.Transparency = 0.3
buttonStroke.Parent = button

-- Button icon and text container
local buttonContent = Instance.new("Frame")
buttonContent.Size = UDim2.new(1, 0, 1, 0)
buttonContent.Position = UDim2.new(0, 0, 0, 0)
buttonContent.BackgroundTransparency = 1
buttonContent.Parent = button

-- Button icon
local buttonIcon = Instance.new("TextLabel")
buttonIcon.Size = UDim2.new(0, 30, 1, 0)
buttonIcon.Position = UDim2.new(0, 10, 0, 0)
buttonIcon.Text = "⚡"
buttonIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonIcon.BackgroundTransparency = 1
buttonIcon.Font = Enum.Font.GothamBold
buttonIcon.TextSize = 24
buttonIcon.TextStrokeTransparency = 0.5
buttonIcon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
buttonIcon.Parent = buttonContent

-- Button text
local buttonLabel = Instance.new("TextLabel")
buttonLabel.Size = UDim2.new(1, -50, 1, 0)
buttonLabel.Position = UDim2.new(0, 40, 0, 0)
buttonLabel.Text = "ACCELERATE TO AGE 50"
buttonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonLabel.BackgroundTransparency = 1
buttonLabel.Font = Enum.Font.GothamBold
buttonLabel.TextSize = 18
buttonLabel.TextStrokeTransparency = 0.5
buttonLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
buttonLabel.TextXAlignment = Enum.TextXAlignment.Left
buttonLabel.Parent = buttonContent

-- Button hover animations
button.MouseEnter:Connect(function()
    if not isProcessing then
        TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1.05, 0, 1.1, 0),
            Position = UDim2.new(-0.025, 0, -0.05, 0)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.3), {
            Transparency = 0,
            Thickness = 4
        }):Play()
        TweenService:Create(buttonLabel, TweenInfo.new(0.3), {
            TextSize = 20
        }):Play()
        TweenService:Create(buttonIcon, TweenInfo.new(0.3), {
            TextSize = 28
        }):Play()
    end
end)

button.MouseLeave:Connect(function()
    if not isProcessing then
        TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.3), {
            Transparency = 0.3,
            Thickness = 3
        }):Play()
        TweenService:Create(buttonLabel, TweenInfo.new(0.3), {
            TextSize = 18
        }):Play()
        TweenService:Create(buttonIcon, TweenInfo.new(0.3), {
            TextSize = 24
        }):Play()
    end
end)

-- Enhanced function to find equipped pet tool
local function getEquippedPetTool()
    character = player.Character or player.CharacterAdded:Wait()
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Tool") and child.Name:find("Age") then
            return child
        end
    end
    return nil
end

-- Extract current age from pet name
local function extractCurrentAge(petName)
    local ageMatch = petName:match("%[Age%s*(%d+)%]")
    return ageMatch and tonumber(ageMatch) or 0
end

-- Advanced GUI update function with animations
local function updateGUI()
    local pet = getEquippedPetTool()
    if pet then
        currentAge = extractCurrentAge(pet.Name)
        local petDisplayName = pet.Name:gsub("%s*%[Age%s*%d+%]", "")

        petInfo.Text = "🐾 Current Pet: " .. petDisplayName
        ageInfo.Text = "⏰ Current Age: " .. currentAge .. " / " .. targetAge

        -- Color coding based on age
        if currentAge >= targetAge then
            ageInfo.TextColor3 = Color3.fromRGB(0, 255, 100)
            petInfoStroke.Color = Color3.fromRGB(0, 255, 100)
        elseif currentAge >= targetAge * 0.7 then
            ageInfo.TextColor3 = Color3.fromRGB(255, 200, 0)
            petInfoStroke.Color = Color3.fromRGB(255, 200, 0)
        else
            ageInfo.TextColor3 = Color3.fromRGB(150, 200, 255)
            petInfoStroke.Color = Color3.fromRGB(0, 150, 255)
        end
    else
        petInfo.Text = "🐾 Current Pet: [No Pet Equipped]"
        ageInfo.Text = "⏰ Current Age: Unknown"
        ageInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
        petInfoStroke.Color = Color3.fromRGB(255, 100, 100)
    end
end

-- Continuous GUI updates with smooth animations
task.spawn(function()
    while true do
        updateGUI()
        wait(0.5)
    end
end)

-- Progress bar for age modification
local progressContainer = Instance.new("Frame")
progressContainer.Size = UDim2.new(1, -30, 0, 25)
progressContainer.Position = UDim2.new(0, 15, 0, 240)
progressContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
progressContainer.Visible = false
progressContainer.Parent = mainContainer

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 12)
progressCorner.Parent = progressContainer

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.Position = UDim2.new(0, 0, 0, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
progressBar.Parent = progressContainer

local progressBarCorner = Instance.new("UICorner")
progressBarCorner.CornerRadius = UDim.new(0, 12)
progressBarCorner.Parent = progressBar

local progressText = Instance.new("TextLabel")
progressText.Size = UDim2.new(1, 0, 1, 0)
progressText.Position = UDim2.new(0, 0, 0, 0)
progressText.Text = "Processing..."
progressText.TextColor3 = Color3.fromRGB(255, 255, 255)
progressText.BackgroundTransparency = 1
progressText.Font = Enum.Font.GothamBold
progressText.TextSize = 14
progressText.TextStrokeTransparency = 0.5
progressText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
progressText.Parent = progressContainer

-- Advanced button click logic with spectacular effects
button.MouseButton1Click:Connect(function()
    if isProcessing then return end
    isProcessing = true

    local tool = getEquippedPetTool()
    if tool then
        -- Show progress bar
        progressContainer.Visible = true

        -- Disable button and change appearance
        button.Active = false
        buttonLabel.Text = "PROCESSING..."
        buttonIcon.Text = "⏳"

        -- Change button color to processing state
        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 150)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 80, 120)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 180))
        }

        -- Countdown with progress bar animation
        for i = 10, 1, -1 do
            progressText.Text = "⚡ Accelerating Age... " .. i .. "s"
            local progress = (11 - i) / 10
            TweenService:Create(progressBar, TweenInfo.new(0.8), {
                Size = UDim2.new(progress, 0, 1, 0)
            }):Play()
            wait(1)
        end

        -- Final acceleration effect
        progressText.Text = "🚀 MAXIMUM ACCELERATION!"
        TweenService:Create(progressBar, TweenInfo.new(0.3), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()

        -- Apply age change with celebration effect
        local newName = tool.Name:gsub("%[Age%s*%d+%]", "[Age " .. targetAge .. "]")
        tool.Name = newName

        -- Success animation
        buttonLabel.Text = "✅ AGE ACCELERATED!"
        buttonIcon.Text = "🎉"
        progressText.Text = "✨ SUCCESS! Pet aged to " .. targetAge .. "!"

        -- Change colors to success
        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 100)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 150, 80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 250, 120))
        }

        wait(3)

        -- Reset to normal state
        progressContainer.Visible = false
        buttonLabel.Text = "ACCELERATE TO AGE " .. targetAge
        buttonIcon.Text = "⚡"

        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 80, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
        }

    else
        -- No pet equipped error state
        buttonLabel.Text = "⚠️ NO PET DETECTED"
        buttonIcon.Text = "❌"

        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 30, 30)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(250, 70, 70))
        }

        wait(3)

        buttonLabel.Text = "ACCELERATE TO AGE " .. targetAge
        buttonIcon.Text = "⚡"

        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 80, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
        }
    end

    button.Active = true
    isProcessing = false
end)

-- Advanced credit panel with modern styling
local creditPanel = Instance.new("Frame")
creditPanel.Size = UDim2.new(1, -30, 0, 25)
creditPanel.Position = UDim2.new(0, 15, 1, -35)
creditPanel.BackgroundTransparency = 1
creditPanel.Parent = mainContainer

local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 1, 0)
credit.Position = UDim2.new(0, 0, 0, 0)
credit.Text = "⚡ Powered by CHEETOS Technology ⚡"
credit.TextColor3 = Color3.fromRGB(120, 150, 200)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.GothamMedium
credit.TextSize = 12
credit.TextStrokeTransparency = 0.8
credit.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
credit.Parent = creditPanel

-- Animated glow effects
RunService.RenderStepped:Connect(function()
    if not isProcessing then
        -- Breathing glow effect
        local breathe = (math.sin(tick() * 2) + 1) / 2
        glowStroke.Transparency = 0.4 + breathe * 0.3

        -- Subtle gradient rotation
        gradient.Rotation = 45 + math.sin(tick() * 0.5) * 10

        -- Title glow pulse
        title.TextStrokeTransparency = 0.3 + breathe * 0.4
    end
end)

-- Startup animation sequence
local function playStartupAnimation()
    -- Start with invisible container
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)

    -- Dramatic entrance animation
    TweenService:Create(mainContainer,
        TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0, 380, 0, 280),
            Position = UDim2.new(0.5, -190, 0.5, -140)
        }
    ):Play()

    -- Animate glow stroke
    TweenService:Create(glowStroke,
        TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Transparency = 0.1}
    ):Play()

    -- Staggered element animations
    wait(0.3)
    titleContainer.Position = UDim2.new(0, 15, 0, -50)
    TweenService:Create(titleContainer,
        TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Position = UDim2.new(0, 15, 0, 15)}
    ):Play()

    wait(0.2)
    petInfoPanel.Position = UDim2.new(0, -400, 0, 85)
    TweenService:Create(petInfoPanel,
        TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Position = UDim2.new(0, 15, 0, 85)}
    ):Play()

    wait(0.2)
    buttonContainer.Position = UDim2.new(0, 400, 0, 175)
    TweenService:Create(buttonContainer,
        TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Position = UDim2.new(0, 15, 0, 175)}
    ):Play()
end

-- Launch the spectacular entrance!
playStartupAnimation()
