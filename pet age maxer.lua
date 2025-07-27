local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local mutations = {
    {name = "Shiny", rarity = "Legendary", color = Color3.fromRGB(255, 215, 0)},
    {name = "Inverted", rarity = "Rare", color = Color3.fromRGB(138, 43, 226)},
    {name = "Frozen", rarity = "Epic", color = Color3.fromRGB(0, 191, 255)},
    {name = "Windy", rarity = "Common", color = Color3.fromRGB(144, 238, 144)},
    {name = "Golden", rarity = "Mythical", color = Color3.fromRGB(255, 165, 0)},
    {name = "Mega", rarity = "Legendary", color = Color3.fromRGB(255, 20, 147)},
    {name = "Tiny", rarity = "Uncommon", color = Color3.fromRGB(255, 182, 193)},
    {name = "Tranquil", rarity = "Epic", color = Color3.fromRGB(64, 224, 208)},
    {name = "IronSkin", rarity = "Rare", color = Color3.fromRGB(169, 169, 169)},
    {name = "Radiant", rarity = "Mythical", color = Color3.fromRGB(255, 255, 255)},
    {name = "Rainbow", rarity = "Divine", color = Color3.fromRGB(255, 0, 255)},
    {name = "Shocked", rarity = "Epic", color = Color3.fromRGB(255, 255, 0)},
    {name = "Ascended", rarity = "Divine", color = Color3.fromRGB(255, 69, 0)}
}

local currentMutation = mutations[math.random(#mutations)]
local espVisible = true
local animationSpeed = 0.02

local gui = Instance.new("ScreenGui")
gui.Name = "AdvancedPetMutationFinder"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, 320, 0, 220)
mainContainer.Position = UDim2.new(0.5, -160, 0.5, -110)
mainContainer.BackgroundTransparency = 1
mainContainer.Active = true
mainContainer.Draggable = true
mainContainer.Parent = gui

local backgroundFrame = Instance.new("Frame")
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
backgroundFrame.Parent = mainContainer

local backgroundCorner = Instance.new("UICorner")
backgroundCorner.CornerRadius = UDim.new(0, 20)
backgroundCorner.Parent = backgroundFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 25, 45))
}
gradient.Rotation = 45
gradient.Parent = backgroundFrame

local glowFrame = Instance.new("Frame")
glowFrame.Size = UDim2.new(1, 4, 1, 4)
glowFrame.Position = UDim2.new(0, -2, 0, -2)
glowFrame.BackgroundTransparency = 1
glowFrame.Parent = mainContainer

local glowStroke = Instance.new("UIStroke")
glowStroke.Color = Color3.fromRGB(100, 200, 255)
glowStroke.Thickness = 2
glowStroke.Transparency = 0.3
glowStroke.Parent = backgroundFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 22)
glowCorner.Parent = glowFrame

local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(1, -20, 0, 50)
titleContainer.Position = UDim2.new(0, 10, 0, 10)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = mainContainer

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🧬 MUTATION NEXUS 🧬"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextStrokeTransparency = 0.5
title.TextStrokeColor3 = Color3.fromRGB(100, 200, 255)
title.Parent = titleContainer

local function createAdvancedButton(text, yPos, primaryColor, secondaryColor)
    local btnContainer = Instance.new("Frame")
    btnContainer.Size = UDim2.new(1, -30, 0, 45)
    btnContainer.Position = UDim2.new(0, 15, 0, yPos)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = mainContainer

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = primaryColor
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = btnContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 15)
    btnCorner.Parent = btn

    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, primaryColor),
        ColorSequenceKeypoint.new(0.5, primaryColor:Lerp(secondaryColor, 0.3)),
        ColorSequenceKeypoint.new(1, secondaryColor)
    }
    btnGradient.Rotation = 45
    btnGradient.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = secondaryColor
    btnStroke.Thickness = 2
    btnStroke.Transparency = 0.4
    btnStroke.Parent = btn

    local btnText = Instance.new("TextLabel")
    btnText.Size = UDim2.new(1, 0, 1, 0)
    btnText.Position = UDim2.new(0, 0, 0, 0)
    btnText.Text = text
    btnText.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnText.BackgroundTransparency = 1
    btnText.Font = Enum.Font.GothamBold
    btnText.TextSize = 16
    btnText.TextStrokeTransparency = 0.7
    btnText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    btnText.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1.05, 0, 1.1, 0),
            Position = UDim2.new(-0.025, 0, -0.05, 0)
        }):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.3), {
            Transparency = 0,
            Thickness = 3
        }):Play()
        TweenService:Create(btnText, TweenInfo.new(0.3), {
            TextSize = 18
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.3), {
            Transparency = 0.4,
            Thickness = 2
        }):Play()
        TweenService:Create(btnText, TweenInfo.new(0.3), {
            TextSize = 16
        }):Play()
    end)

    return btn, btnText
end

local rerollBtn, rerollText = createAdvancedButton("🎲 REROLL MUTATION", 70,
    Color3.fromRGB(75, 0, 130), Color3.fromRGB(138, 43, 226))
local toggleBtn, toggleText = createAdvancedButton("👁️ TOGGLE ESP", 125,
    Color3.fromRGB(0, 100, 150), Color3.fromRGB(0, 191, 255))

local mutationPanel = Instance.new("Frame")
mutationPanel.Size = UDim2.new(1, -30, 0, 35)
mutationPanel.Position = UDim2.new(0, 15, 1, -55)
mutationPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mutationPanel.Parent = mainContainer

local mutationCorner = Instance.new("UICorner")
mutationCorner.CornerRadius = UDim.new(0, 12)
mutationCorner.Parent = mutationPanel

local mutationStroke = Instance.new("UIStroke")
mutationStroke.Color = currentMutation.color
mutationStroke.Thickness = 2
mutationStroke.Transparency = 0.3
mutationStroke.Parent = mutationPanel

local mutationDisplay = Instance.new("TextLabel")
mutationDisplay.Size = UDim2.new(1, -10, 1, 0)
mutationDisplay.Position = UDim2.new(0, 5, 0, 0)
mutationDisplay.Text = "Current: " .. currentMutation.name .. " (" .. currentMutation.rarity .. ")"
mutationDisplay.TextColor3 = currentMutation.color
mutationDisplay.BackgroundTransparency = 1
mutationDisplay.Font = Enum.Font.GothamBold
mutationDisplay.TextSize = 14
mutationDisplay.TextStrokeTransparency = 0.5
mutationDisplay.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
mutationDisplay.Parent = mutationPanel

local creditPanel = Instance.new("Frame")
creditPanel.Size = UDim2.new(1, -30, 0, 20)
creditPanel.Position = UDim2.new(0, 15, 1, -25)
creditPanel.BackgroundTransparency = 1
creditPanel.Parent = mainContainer

local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 1, 0)
credit.Position = UDim2.new(0, 0, 0, 0)
credit.Text = "✨ Created by CHEETOS ✨"
credit.TextColor3 = Color3.fromRGB(150, 150, 200)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.GothamMedium
credit.TextSize = 12
credit.TextStrokeTransparency = 0.8
credit.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
credit.Parent = creditPanel

local function findMachine()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (string.find(string.lower(obj.Name), "mutation") or string.find(string.lower(obj.Name), "mutate")) then
            return obj
        end
    end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and string.find(string.lower(obj.Name), "machine") then
            return obj
        end
    end
    return nil
end

local machine = findMachine()
if not machine or not machine:FindFirstChildWhichIsA("BasePart") then
    warn("Pet Mutation Machine not found. Creating demo ESP...")
    local demoPart = Instance.new("Part")
    demoPart.Name = "DemoMutationMachine"
    demoPart.Size = Vector3.new(4, 4, 4)
    demoPart.Position = Vector3.new(0, 10, 0)
    demoPart.Anchored = true
    demoPart.Parent = Workspace
    machine = demoPart
end

local basePart = machine:FindFirstChildWhichIsA("BasePart") or machine
local espContainer = Instance.new("BillboardGui", basePart)
espContainer.Name = "AdvancedMutationESP"
espContainer.Adornee = basePart
espContainer.Size = UDim2.new(0, 300, 0, 120)
espContainer.StudsOffset = Vector3.new(0, 5, 0)
espContainer.AlwaysOnTop = true

local espBackground = Instance.new("Frame")
espBackground.Size = UDim2.new(1, 0, 1, 0)
espBackground.Position = UDim2.new(0, 0, 0, 0)
espBackground.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
espBackground.BackgroundTransparency = 0.2
espBackground.Parent = espContainer

local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 20)
espCorner.Parent = espBackground

local espStroke = Instance.new("UIStroke")
espStroke.Color = currentMutation.color
espStroke.Thickness = 3
espStroke.Transparency = 0.3
espStroke.Parent = espBackground

local espLabel = Instance.new("TextLabel")
espLabel.Size = UDim2.new(1, -20, 0.6, 0)
espLabel.Position = UDim2.new(0, 10, 0, 10)
espLabel.BackgroundTransparency = 1
espLabel.Font = Enum.Font.GothamBold
espLabel.TextSize = 28
espLabel.TextStrokeTransparency = 0.2
espLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
espLabel.Text = currentMutation.name
espLabel.TextColor3 = currentMutation.color
espLabel.Parent = espContainer

local rarityLabel = Instance.new("TextLabel")
rarityLabel.Size = UDim2.new(1, -20, 0.3, 0)
rarityLabel.Position = UDim2.new(0, 10, 0.6, 0)
rarityLabel.BackgroundTransparency = 1
rarityLabel.Font = Enum.Font.Gotham
rarityLabel.TextSize = 16
rarityLabel.TextStrokeTransparency = 0.4
rarityLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
rarityLabel.Text = "✨ " .. currentMutation.rarity .. " Tier ✨"
rarityLabel.TextColor3 = currentMutation.color:Lerp(Color3.new(1, 1, 1), 0.3)
rarityLabel.Parent = espContainer

local pulseScale = 1
local glowIntensity = 0
local colorShift = 0

RunService.RenderStepped:Connect(function()
    if espVisible then
        local currentTime = time()
        pulseScale = 1 + math.sin(currentTime * 3) * 0.1
        espLabel.Size = UDim2.new(1, -20, 0.6 * pulseScale, 0)

        glowIntensity = (math.sin(currentTime * 2) + 1) / 2
        espStroke.Transparency = 0.3 + glowIntensity * 0.4

        if currentMutation.rarity == "Divine" then
            colorShift = (colorShift + animationSpeed) % 1
            local hsvColor = Color3.fromHSV(colorShift, 1, 1)
            espLabel.TextColor3 = hsvColor
            espStroke.Color = hsvColor
        end

        espContainer.StudsOffset = Vector3.new(
            math.sin(currentTime * 1.5) * 0.5,
            5 + math.cos(currentTime * 2) * 0.3,
            math.cos(currentTime * 1.2) * 0.3
        )
    end
end)

local function animateMutationReroll()
    rerollText.Text = "⏳ REROLLING..."
    rerollBtn.Active = false

    local duration = 2
    local interval = 0.08
    local cycles = math.floor(duration / interval)

    for i = 1, cycles do
        local randomMutation = mutations[math.random(#mutations)]
        espLabel.Text = randomMutation.name
        rarityLabel.Text = "✨ " .. randomMutation.rarity .. " Tier ✨"

        if i % 3 == 0 then
            espLabel.TextColor3 = Color3.new(1, 1, 1)
            espStroke.Color = Color3.new(1, 1, 1)
        else
            espLabel.TextColor3 = randomMutation.color
            espStroke.Color = randomMutation.color
        end

        task.wait(interval)
    end

    currentMutation = mutations[math.random(#mutations)]
    espLabel.Text = currentMutation.name
    espLabel.TextColor3 = currentMutation.color
    rarityLabel.Text = "✨ " .. currentMutation.rarity .. " Tier ✨"
    rarityLabel.TextColor3 = currentMutation.color:Lerp(Color3.new(1, 1, 1), 0.3)
    espStroke.Color = currentMutation.color

    mutationDisplay.Text = "Current: " .. currentMutation.name .. " (" .. currentMutation.rarity .. ")"
    mutationDisplay.TextColor3 = currentMutation.color
    mutationStroke.Color = currentMutation.color

    local celebrationTween = TweenService:Create(espLabel,
        TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
        {TextSize = 35}
    )
    celebrationTween:Play()

    celebrationTween.Completed:Connect(function()
        TweenService:Create(espLabel,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {TextSize = 28}
        ):Play()
    end)

    rerollText.Text = "🎲 REROLL MUTATION"
    rerollBtn.Active = true
end

local function toggleESP()
    espVisible = not espVisible
    toggleText.Text = espVisible and "👁️ HIDE ESP" or "👁️ SHOW ESP"

    if espVisible then
        espContainer.Enabled = true
        TweenService:Create(espContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 300, 0, 120)}
        ):Play()
    else
        local tween = TweenService:Create(espContainer,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        tween:Play()
        tween.Completed:Wait()
        espContainer.Enabled = false
    end
end

toggleBtn.MouseButton1Click:Connect(toggleESP)
rerollBtn.MouseButton1Click:Connect(animateMutationReroll)

local function playStartupAnimation()
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(mainContainer,
        TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 320, 0, 220)}
    ):Play()

    TweenService:Create(glowStroke,
        TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Transparency = 0.1}
    ):Play()
end

playStartupAnimation()
