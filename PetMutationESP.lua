local Players = game:GetService("Players")
local player = Players.LocalPlayer
local jobId = game.JobId

local executionKey = "PetMutationESP_" .. player.UserId .. "_" .. jobId

if getgenv()[executionKey] then
    return
end

getgenv()[executionKey] = true

local PlayerGui = player:WaitForChild("PlayerGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local MUTATION_DATA = {
    {name = "Shiny", rarity = "Legendary", color = Color3.fromRGB(255, 215, 0), icon = "✨"},
    {name = "Inverted", rarity = "Rare", color = Color3.fromRGB(138, 43, 226), icon = "🔄"},
    {name = "Frozen", rarity = "Epic", color = Color3.fromRGB(0, 191, 255), icon = "❄️"},
    {name = "Windy", rarity = "Common", color = Color3.fromRGB(144, 238, 144), icon = "💨"},
    {name = "Golden", rarity = "Mythical", color = Color3.fromRGB(255, 165, 0), icon = "👑"},
    {name = "Mega", rarity = "Legendary", color = Color3.fromRGB(255, 20, 147), icon = "🔥"},
    {name = "Tiny", rarity = "Uncommon", color = Color3.fromRGB(255, 182, 193), icon = "🐭"},
    {name = "Tranquil", rarity = "Epic", color = Color3.fromRGB(64, 224, 208), icon = "🌊"},
    {name = "IronSkin", rarity = "Rare", color = Color3.fromRGB(169, 169, 169), icon = "🛡️"},
    {name = "Radiant", rarity = "Mythical", color = Color3.fromRGB(255, 255, 255), icon = "💎"},
    {name = "Rainbow", rarity = "Divine", color = Color3.fromRGB(255, 0, 255), icon = "🌈"},
    {name = "Shocked", rarity = "Epic", color = Color3.fromRGB(255, 255, 0), icon = "⚡"},
    {name = "Ascended", rarity = "Divine", color = Color3.fromRGB(255, 69, 0), icon = "🚀"}
}

local RARITY_COLORS = {
    Common = Color3.fromRGB(155, 155, 155),
    Uncommon = Color3.fromRGB(30, 255, 0),
    Rare = Color3.fromRGB(0, 112, 221),
    Epic = Color3.fromRGB(163, 53, 238),
    Legendary = Color3.fromRGB(255, 128, 0),
    Mythical = Color3.fromRGB(255, 0, 0),
    Divine = Color3.fromRGB(255, 215, 0)
}

local MutationESP = {}
MutationESP.__index = MutationESP

function MutationESP.new()
    local self = setmetatable({}, MutationESP)
    
    self.currentMutation = MUTATION_DATA[math.random(#MUTATION_DATA)]
    self.espVisible = true
    self.guiVisible = true
    self.isAnimating = false
    self.connections = {}
    
    self:initializeGUI()
    self:setupESP()
    self:connectEvents()
    self:playStartupAnimation()
    
    return self
end

function MutationESP:initializeGUI()
    self.gui = Instance.new("ScreenGui")
    self.gui.Name = "CHEEETOOSSS"
    self.gui.ResetOnSpawn = false
    self.gui.IgnoreGuiInset = true
    self.gui.Parent = PlayerGui
    
    self:createMainContainer()
    self:createHeader()
    self:createControlButtons()
    self:createStatusPanel()
end

function MutationESP:createMainContainer()
    self.mainContainer = Instance.new("Frame")
    self.mainContainer.Size = UDim2.new(0, 320, 0, 240)
    self.mainContainer.Position = UDim2.new(0.5, -160, 0.5, -120)
    self.mainContainer.BackgroundTransparency = 1
    self.mainContainer.Active = true
    self.mainContainer.Draggable = true
    self.mainContainer.Parent = self.gui
    
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(8, 12, 20)
    background.BackgroundTransparency = 0.15
    background.Parent = self.mainContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = background
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 25, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 55))
    }
    gradient.Rotation = 135
    gradient.Parent = background
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(120, 180, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.4
    stroke.Parent = background
    
    local glassOverlay = Instance.new("Frame")
    glassOverlay.Size = UDim2.new(1, 0, 0.3, 0)
    glassOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    glassOverlay.BackgroundTransparency = 0.92
    glassOverlay.Parent = background
    
    local glassCorner = Instance.new("UICorner")
    glassCorner.CornerRadius = UDim.new(0, 20)
    glassCorner.Parent = glassOverlay
    
    self:createCloseButton()
end

function MutationESP:createCloseButton()
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeButton.BackgroundTransparency = 0.3
    closeButton.Text = "✕"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.Parent = self.mainContainer
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    
    closeButton.MouseEnter:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.1,
            Size = UDim2.new(0, 32, 0, 32)
        }):Play()
    end)
    
    closeButton.MouseLeave:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.3,
            Size = UDim2.new(0, 30, 0, 30)
        }):Play()
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        self:toggleGUI()
    end)
end

function MutationESP:createHeader()
    local headerFrame = Instance.new("Frame")
    headerFrame.Size = UDim2.new(1, -20, 0, 60)
    headerFrame.Position = UDim2.new(0, 10, 0, 10)
    headerFrame.BackgroundTransparency = 1
    headerFrame.Parent = self.mainContainer
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 0.7, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "🧬 MUTATION ESP CHEETOS 🧬"
    titleLabel.TextColor3 = Color3.fromRGB(220, 240, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextStrokeTransparency = 0.3
    titleLabel.TextStrokeColor3 = Color3.fromRGB(50, 150, 255)
    titleLabel.Parent = headerFrame
    
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(1, -40, 0.3, 0)
    subtitleLabel.Position = UDim2.new(0, 0, 0.7, 0)
    subtitleLabel.Text = "MUTATION ESP"
    subtitleLabel.TextColor3 = Color3.fromRGB(180, 200, 220)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextSize = 12
    subtitleLabel.TextStrokeTransparency = 0.6
    subtitleLabel.TextStrokeColor3 = Color3.fromRGB(30, 30, 50)
    subtitleLabel.Parent = headerFrame
end

function MutationESP:createControlButtons()
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, -20, 0, 80)
    buttonContainer.Position = UDim2.new(0, 10, 0, 80)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = self.mainContainer
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = buttonContainer
    
    self.rerollButton = self:createFriendlyButton("🎲 REROLL MUTATION", Color3.fromRGB(75, 0, 130), 1)
    self.rerollButton.Parent = buttonContainer
    
    self.toggleButton = self:createFriendlyButton("👁️ HIDE ESP", Color3.fromRGB(0, 100, 150), 2)
    self.toggleButton.Parent = buttonContainer
end

function MutationESP:createFriendlyButton(text, color, order)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0, 36)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.LayoutOrder = order
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = color
    button.BackgroundTransparency = 0.2
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.TextStrokeTransparency = 0.5
    button.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    button.AutoButtonColor = false
    button.Parent = buttonFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = button
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color:Lerp(Color3.new(1,1,1), 0.15)),
        ColorSequenceKeypoint.new(1, color:Lerp(Color3.new(0,0,0), 0.15))
    }
    gradient.Rotation = 90
    gradient.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = color:Lerp(Color3.new(1,1,1), 0.3)
    stroke.Thickness = 1
    stroke.Transparency = 0.6
    stroke.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.1,
            Size = UDim2.new(1.02, 0, 1.1, 0)
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {
            Transparency = 0.3,
            Thickness = 2
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {
            Transparency = 0.6,
            Thickness = 1
        }):Play()
    end)
    
    return buttonFrame
end

function MutationESP:createStatusPanel()
    local statusFrame = Instance.new("Frame")
    statusFrame.Size = UDim2.new(1, -20, 0, 60)
    statusFrame.Position = UDim2.new(0, 10, 1, -70)
    statusFrame.BackgroundColor3 = Color3.fromRGB(8, 12, 20)
    statusFrame.BackgroundTransparency = 0.2
    statusFrame.Parent = self.mainContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = statusFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 25, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 55))
    }
    gradient.Rotation = 90
    gradient.Parent = statusFrame
    
    self.statusStroke = Instance.new("UIStroke")
    self.statusStroke.Color = self.currentMutation.color
    self.statusStroke.Thickness = 2
    self.statusStroke.Transparency = 0.4
    self.statusStroke.Parent = statusFrame
    
    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.new(0, 40, 0, 40)
    iconFrame.Position = UDim2.new(0, 10, 0.5, -20)
    iconFrame.BackgroundColor3 = self.currentMutation.color
    iconFrame.BackgroundTransparency = 0.3
    iconFrame.Parent = statusFrame
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 10)
    iconCorner.Parent = iconFrame
    
    self.mutationIcon = Instance.new("TextLabel")
    self.mutationIcon.Size = UDim2.new(1, 0, 1, 0)
    self.mutationIcon.Text = self.currentMutation.icon
    self.mutationIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.mutationIcon.BackgroundTransparency = 1
    self.mutationIcon.Font = Enum.Font.GothamBold
    self.mutationIcon.TextSize = 20
    self.mutationIcon.Parent = iconFrame
    
    self.mutationNameLabel = Instance.new("TextLabel")
    self.mutationNameLabel.Size = UDim2.new(1, -60, 0.5, 0)
    self.mutationNameLabel.Position = UDim2.new(0, 55, 0, 8)
    self.mutationNameLabel.Text = "Active: " .. self.currentMutation.name
    self.mutationNameLabel.TextColor3 = self.currentMutation.color
    self.mutationNameLabel.BackgroundTransparency = 1
    self.mutationNameLabel.Font = Enum.Font.GothamBold
    self.mutationNameLabel.TextSize = 14
    self.mutationNameLabel.TextStrokeTransparency = 0.4
    self.mutationNameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    self.mutationNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.mutationNameLabel.Parent = statusFrame
    
    self.rarityLabel = Instance.new("TextLabel")
    self.rarityLabel.Size = UDim2.new(1, -60, 0.5, 0)
    self.rarityLabel.Position = UDim2.new(0, 55, 0.5, 0)
    self.rarityLabel.Text = self.currentMutation.rarity .. " Tier"
    self.rarityLabel.TextColor3 = self.currentMutation.color:Lerp(Color3.new(1, 1, 1), 0.4)
    self.rarityLabel.BackgroundTransparency = 1
    self.rarityLabel.Font = Enum.Font.Gotham
    self.rarityLabel.TextSize = 11
    self.rarityLabel.TextStrokeTransparency = 0.6
    self.rarityLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    self.rarityLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.rarityLabel.Parent = statusFrame
    
    local creditLabel = Instance.new("TextLabel")
    creditLabel.Size = UDim2.new(1, -20, 0, 15)
    creditLabel.Position = UDim2.new(0, 10, 1, -20)
    creditLabel.Text = "⭐ MUTATION ESP by CHEETOS | FREE ⭐"
    creditLabel.TextColor3 = Color3.fromRGB(120, 160, 200)
    creditLabel.BackgroundTransparency = 1
    creditLabel.Font = Enum.Font.GothamMedium
    creditLabel.TextSize = 10
    creditLabel.TextStrokeTransparency = 0.7
    creditLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    creditLabel.Parent = self.mainContainer
end

function MutationESP:setupESP()
    local machine = self:findMutationMachine()
    if not machine then
        machine = self:createDemoMachine()
    end
    
    local basePart = machine:FindFirstChildWhichIsA("BasePart") or machine
    
    self.espContainer = Instance.new("BillboardGui")
    self.espContainer.Name = "GAYMUTATION"
    self.espContainer.Adornee = basePart
    self.espContainer.Size = UDim2.new(0, 300, 0, 120)
    self.espContainer.StudsOffset = Vector3.new(0, 5, 0)
    self.espContainer.AlwaysOnTop = true
    self.espContainer.Parent = basePart
    
    self:createESPDisplay()
end

function MutationESP:createESPDisplay()
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(8, 12, 20)
    background.BackgroundTransparency = 0.15
    background.Parent = self.espContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 25)
    corner.Parent = background
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 50)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(15, 25, 45)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(25, 35, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 40, 60))
    }
    gradient.Rotation = 135
    gradient.Parent = background
    
    self.espStroke = Instance.new("UIStroke")
    self.espStroke.Color = self.currentMutation.color
    self.espStroke.Thickness = 3
    self.espStroke.Transparency = 0.2
    self.espStroke.Parent = background
    
    local iconContainer = Instance.new("Frame")
    iconContainer.Size = UDim2.new(0, 40, 0, 40)
    iconContainer.Position = UDim2.new(0, 15, 0.5, -20)
    iconContainer.BackgroundColor3 = self.currentMutation.color
    iconContainer.BackgroundTransparency = 0.2
    iconContainer.Parent = self.espContainer
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 15)
    iconCorner.Parent = iconContainer
    
    self.espIcon = Instance.new("TextLabel")
    self.espIcon.Size = UDim2.new(1, 0, 1, 0)
    self.espIcon.Text = "🧬"
    self.espIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.espIcon.BackgroundTransparency = 1
    self.espIcon.Font = Enum.Font.GothamBold
    self.espIcon.TextSize = 20
    self.espIcon.Parent = iconContainer
    
    self.espNameLabel = Instance.new("TextLabel")
    self.espNameLabel.Size = UDim2.new(1, -70, 0.5, 0)
    self.espNameLabel.Position = UDim2.new(0, 60, 0, 8)
    self.espNameLabel.Text = self.currentMutation.name
    self.espNameLabel.TextColor3 = self.currentMutation.color
    self.espNameLabel.BackgroundTransparency = 1
    self.espNameLabel.Font = Enum.Font.GothamBold
    self.espNameLabel.TextSize = 24
    self.espNameLabel.TextStrokeTransparency = 0.2
    self.espNameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    self.espNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.espNameLabel.Parent = self.espContainer
    
    self.espRarityLabel = Instance.new("TextLabel")
    self.espRarityLabel.Size = UDim2.new(1, -70, 0.35, 0)
    self.espRarityLabel.Position = UDim2.new(0, 60, 0.5, 0)
    self.espRarityLabel.Text = "✨ " .. self.currentMutation.rarity .. " Tier ✨"
    self.espRarityLabel.TextColor3 = self.currentMutation.color:Lerp(Color3.new(1, 1, 1), 0.3)
    self.espRarityLabel.BackgroundTransparency = 1
    self.espRarityLabel.Font = Enum.Font.Gotham
    self.espRarityLabel.TextSize = 14
    self.espRarityLabel.TextStrokeTransparency = 0.4
    self.espRarityLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    self.espRarityLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.espRarityLabel.Parent = self.espContainer
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -70, 0.15, 0)
    statusLabel.Position = UDim2.new(0, 60, 0.85, 0)
    statusLabel.Text = "● ACTIVE MUTATION"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.TextSize = 10
    statusLabel.TextStrokeTransparency = 0.6
    statusLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = self.espContainer
end

function MutationESP:findMutationMachine()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("mutation") or obj.Name:lower():find("mutate")) then
            return obj
        end
    end
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("machine") then
            return obj
        end
    end
    return nil
end

function MutationESP:createDemoMachine()
    local demoPart = Instance.new("Part")
    demoPart.Name = "MUTATIONESP"
    demoPart.Size = Vector3.new(4, 4, 4)
    demoPart.Position = Vector3.new(0, 10, 0)
    demoPart.Anchored = true
    demoPart.Parent = Workspace
    return demoPart
end

function MutationESP:connectEvents()
    self.rerollButton.TextButton.MouseButton1Click:Connect(function()
        if not self.isAnimating then
            self:animateReroll()
        end
    end)
    
    self.toggleButton.TextButton.MouseButton1Click:Connect(function()
        self:toggleESP()
    end)
    
    self.connections.renderStepped = RunService.RenderStepped:Connect(function()
        self:updateAnimations()
    end)
end

function MutationESP:animateReroll()
    if self.isAnimating then return end
    self.isAnimating = true
    
    local originalText = self.rerollButton.TextButton.Text
    self.rerollButton.TextButton.Text = "⏳ REROLLING..."
    self.rerollButton.TextButton.Active = false
    
    local duration = 2
    local interval = 0.08
    local cycles = math.floor(duration / interval)
    
    spawn(function()
        for i = 1, cycles do
            local randomMutation = MUTATION_DATA[math.random(#MUTATION_DATA)]
            self:updateMutationDisplay(randomMutation, true)
            wait(interval)
        end
        
        self.currentMutation = MUTATION_DATA[math.random(#MUTATION_DATA)]
        self:updateMutationDisplay(self.currentMutation, false)
        
        local celebrationTween = TweenService:Create(self.espNameLabel,
            TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
            {TextSize = 35}
        )
        celebrationTween:Play()
        
        celebrationTween.Completed:Connect(function()
            TweenService:Create(self.espNameLabel,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {TextSize = 24}
            ):Play()
        end)
        
        self.rerollButton.TextButton.Text = originalText
        self.rerollButton.TextButton.Active = true
        self.isAnimating = false
    end)
end

function MutationESP:updateMutationDisplay(mutation, isFlashing)
    if isFlashing then
        self.espNameLabel.TextColor3 = Color3.new(1, 1, 1)
        self.espStroke.Color = Color3.new(1, 1, 1)
    else
        self.espNameLabel.TextColor3 = mutation.color
        self.espStroke.Color = mutation.color
        self.mutationNameLabel.TextColor3 = mutation.color
        self.statusStroke.Color = mutation.color
    end
    
    self.espNameLabel.Text = mutation.name
    self.espRarityLabel.Text = "✨ " .. mutation.rarity .. " Tier ✨"
    self.mutationIcon.Text = mutation.icon
    self.mutationNameLabel.Text = "Active: " .. mutation.name
    self.rarityLabel.Text = mutation.rarity .. " Tier"
end

function MutationESP:toggleESP()
    self.espVisible = not self.espVisible
    local buttonText = self.espVisible and "👁️ HIDE ESP" or "👁️ SHOW ESP"
    self.toggleButton.TextButton.Text = buttonText
    
    if self.espVisible then
        self.espContainer.Size = UDim2.new(0, 0, 0, 0)
        self.espContainer.Enabled = true
        TweenService:Create(self.espContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 300, 0, 120)}
        ):Play()
    else
        TweenService:Create(self.espContainer,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        ):Play()
        
        spawn(function()
            wait(0.3)
            self.espContainer.Enabled = false
        end)
    end
end

function MutationESP:toggleGUI()
    self.guiVisible = not self.guiVisible
    
    if self.guiVisible then
        self.mainContainer.Size = UDim2.new(0, 0, 0, 0)
        self.mainContainer.Visible = true
        TweenService:Create(self.mainContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 240)}
        ):Play()
    else
        TweenService:Create(self.mainContainer,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        ):Play()
        
        spawn(function()
            wait(0.3)
            self.mainContainer.Visible = false
        end)
    end
end

function MutationESP:updateAnimations()
    if not self.espVisible then return end
    
    local time = tick()
    local pulseScale = 1 + math.sin(time * 3) * 0.1
    local glowIntensity = (math.sin(time * 2) + 1) / 2
    
    self.espNameLabel.Size = UDim2.new(1, -70, 0.5 * pulseScale, 0)
    self.espStroke.Transparency = 0.3 + glowIntensity * 0.4
    
    if self.currentMutation.rarity == "Divine" then
        local colorShift = (time * 0.5) % 1
        local rainbowColor = Color3.fromHSV(colorShift, 0.8, 1)
        self.espNameLabel.TextColor3 = rainbowColor
        self.espStroke.Color = rainbowColor
    end
    
    self.espContainer.StudsOffset = Vector3.new(
        math.sin(time * 1.5) * 0.5,
        5 + math.cos(time * 2) * 0.3,
        math.cos(time * 1.2) * 0.3
    )
end

function MutationESP:playStartupAnimation()
    self.mainContainer.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(self.mainContainer,
        TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 320, 0, 240)}
    ):Play()
end

function MutationESP:destroy()
    for _, connection in pairs(self.connections) do
        connection:Disconnect()
    end
    if self.gui then
        self.gui:Destroy()
    end
    if self.espContainer then
        self.espContainer:Destroy()
    end
end

local mutationESP = MutationESP.new()

return mutationESP
