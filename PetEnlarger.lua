local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local loadingTime = 20
local isLoading = false
local currentSize = 1
local enlargedPets = {}
local petScaledFlags = {}

local gui = Instance.new("ScreenGui")
gui.Name = "CheetosPetEnlargerHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 200)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
gradient.Rotation = 45
gradient.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 12)
topBarCorner.Parent = topBar

local topBarGradient = Instance.new("UIGradient")
topBarGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
}
topBarGradient.Rotation = 90
topBarGradient.Parent = topBar

local bottomFix = Instance.new("Frame")
bottomFix.Size = UDim2.new(1, 0, 0, 12)
bottomFix.Position = UDim2.new(0, 0, 1, -12)
bottomFix.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
bottomFix.BorderSizePixel = 0
bottomFix.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧀 CHEETOS PET ENLAGER"
title.Font = Enum.Font.FredokaOne
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextStrokeTransparency = 0
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Parent = topBar

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(1, 0)
closeBtnCorner.Parent = closeBtn

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -65)
contentFrame.Position = UDim2.new(0, 10, 0, 55)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local sizeLabel = Instance.new("TextLabel")
sizeLabel.Size = UDim2.new(1, 0, 0, 25)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Text = "Pet Size (1-100):"
sizeLabel.Font = Enum.Font.GothamBold
sizeLabel.TextSize = 16
sizeLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
sizeLabel.TextXAlignment = Enum.TextXAlignment.Left
sizeLabel.Parent = contentFrame

local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(1, 0, 0, 35)
inputFrame.Position = UDim2.new(0, 0, 0, 30)
inputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = contentFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputFrame

local sizeInput = Instance.new("TextBox")
sizeInput.Size = UDim2.new(1, -20, 1, -10)
sizeInput.Position = UDim2.new(0, 10, 0, 5)
sizeInput.BackgroundTransparency = 1
sizeInput.Text = "1"
sizeInput.Font = Enum.Font.Gotham
sizeInput.TextSize = 18
sizeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
sizeInput.PlaceholderText = "Enter size (1-100)"
sizeInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
sizeInput.TextXAlignment = Enum.TextXAlignment.Center
sizeInput.Parent = inputFrame

local enlargeBtn = Instance.new("TextButton")
enlargeBtn.Size = UDim2.new(1, 0, 0, 40)
enlargeBtn.Position = UDim2.new(0, 0, 0, 75)
enlargeBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
enlargeBtn.Text = "🚀 ENLARGE PET"
enlargeBtn.Font = Enum.Font.FredokaOne
enlargeBtn.TextSize = 18
enlargeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
enlargeBtn.TextStrokeTransparency = 0
enlargeBtn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
enlargeBtn.Parent = contentFrame

local enlargeBtnCorner = Instance.new("UICorner")
enlargeBtnCorner.CornerRadius = UDim.new(0, 10)
enlargeBtnCorner.Parent = enlargeBtn

local enlargeBtnGradient = Instance.new("UIGradient")
enlargeBtnGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 200, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 180, 60))
}
enlargeBtnGradient.Rotation = 90
enlargeBtnGradient.Parent = enlargeBtn

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 0, 25)
loadingFrame.Position = UDim2.new(0, 0, 0, 125)
loadingFrame.BackgroundTransparency = 1
loadingFrame.Visible = false
loadingFrame.Parent = contentFrame

local loadingBg = Instance.new("Frame")
loadingBg.Size = UDim2.new(1, 0, 0, 15)
loadingBg.Position = UDim2.new(0, 0, 0, 0)
loadingBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
loadingBg.BorderSizePixel = 0
loadingBg.Parent = loadingFrame

local loadingBgCorner = Instance.new("UICorner")
loadingBgCorner.CornerRadius = UDim.new(0, 7)
loadingBgCorner.Parent = loadingBg

local loadingFill = Instance.new("Frame")
loadingFill.Size = UDim2.new(0, 0, 1, 0)
loadingFill.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
loadingFill.BorderSizePixel = 0
loadingFill.Parent = loadingBg

local loadingFillCorner = Instance.new("UICorner")
loadingFillCorner.CornerRadius = UDim.new(0, 7)
loadingFillCorner.Parent = loadingFill

local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 0, 20)
loadingLabel.Position = UDim2.new(0, 0, 0, 20)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Loading... 20s"
loadingLabel.Font = Enum.Font.GothamBold
loadingLabel.TextSize = 14
loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingLabel.Parent = loadingFrame

local function getPetId(petTool)
    if petTool:IsA("Tool") then
        return petTool:GetAttribute("PET_UUID") or petTool.Name
    elseif petTool:IsA("Model") then
        return petTool.Name
    end
    return nil
end

local function enlargePetCorrect(petTool, size)
    pcall(function()
        if petTool:IsA("Model") then
            petTool:ScaleTo(size)
        elseif petTool:IsA("Tool") then
            for _, obj in ipairs(petTool:GetChildren()) do
                if obj:IsA("Model") then
                    obj:ScaleTo(size)
                elseif obj:IsA("BasePart") then
                    local mesh = obj:FindFirstChildOfClass("SpecialMesh")
                    if mesh then
                        mesh.Scale = mesh.Scale * size
                    else
                        obj.Size = obj.Size * size
                    end
                end
            end
        end
    end)
end

local function enlargePet(petTool, size)
    local petId = getPetId(petTool)
    if petId then
        enlargedPets[petId] = size
    end
    enlargePetCorrect(petTool, size)
end

local function isPetName(name)
    return name:find("Triceratops") or 
           name:find("KG") or 
           name:find("Age") or
           name:find("%[") or
           name:find("%]") or
           name:find("Pet")
end

local function getBasePetName(fullName)
    return fullName:gsub("%s*%[.*%]", ""):gsub("^%s*(.-)%s*$", "%1")
end

local function isPetScaled(pet)
    local petKey = tostring(pet)
    return petScaledFlags[petKey] == true
end

local function markPetAsScaled(pet)
    local petKey = tostring(pet)
    petScaledFlags[petKey] = true
end

local function shouldEnlargePet(pet, targetSize)
    if isPetScaled(pet) then
        return false
    end
    
    local baseName = getBasePetName(pet.Name)
    for storedPetName, size in pairs(enlargedPets) do
        local storedBaseName = getBasePetName(storedPetName)
        if baseName == storedBaseName and size == targetSize then
            return true
        end
    end
    return false
end

local function monitorAllPets()
    spawn(function()
        while gui.Parent do
            wait(1)
            
            for _, tool in ipairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    local petId = getPetId(tool)
                    if petId and enlargedPets[petId] and not isPetScaled(tool) then
                        enlargePetCorrect(tool, enlargedPets[petId])
                        markPetAsScaled(tool)
                    end
                end
            end
            
            if player.Character then
                local equippedTool = player.Character:FindFirstChildOfClass("Tool")
                if equippedTool then
                    local petId = getPetId(equippedTool)
                    if petId and enlargedPets[petId] and not isPetScaled(equippedTool) then
                        enlargePetCorrect(equippedTool, enlargedPets[petId])
                        markPetAsScaled(equippedTool)
                    end
                end
            end
            
            for _, farm in ipairs(workspace.Farm:GetChildren()) do
                for _, pet in ipairs(farm:GetChildren()) do
                    if pet:IsA("Model") and isPetName(pet.Name) and not isPetScaled(pet) then
                        for petName, size in pairs(enlargedPets) do
                            if shouldEnlargePet(pet, size) then
                                enlargePetCorrect(pet, size)
                                markPetAsScaled(pet)
                                break
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function setupGlobalPetMonitoring()
    workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Model") and isPetName(descendant.Name) then
            wait(0.3)
            
            local baseName = getBasePetName(descendant.Name)
            
            for storedPetName, size in pairs(enlargedPets) do
                local storedBaseName = getBasePetName(storedPetName)
                
                if baseName == storedBaseName or 
                   descendant.Name:find(storedBaseName) or 
                   storedBaseName:find(baseName) then
                    
                    if not isPetScaled(descendant) then
                        print("Enlarging placed pet:", descendant.Name, "to size", size)
                        enlargePetCorrect(descendant, size)
                        markPetAsScaled(descendant)
                    end
                    break
                end
            end
        end
    end)
end

sizeInput.FocusLost:Connect(function(enterPressed)
    local inputText = sizeInput.Text
    local number = tonumber(inputText)
    
    if number and number >= 1 and number <= 100 then
        currentSize = math.floor(number)
        sizeInput.Text = tostring(currentSize)
    else
        sizeInput.Text = tostring(currentSize)
    end
end)

sizeInput:GetPropertyChangedSignal("Text"):Connect(function()
    local inputText = sizeInput.Text
    if inputText == "" then return end
    
    local number = tonumber(inputText)
    if number and number >= 1 and number <= 100 then
        currentSize = math.floor(number)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

enlargeBtn.MouseEnter:Connect(function()
    if not isLoading then
        TweenService:Create(enlargeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 220, 80)}):Play()
    end
end)

enlargeBtn.MouseLeave:Connect(function()
    if not isLoading then
        TweenService:Create(enlargeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 180, 60)}):Play()
    end
end)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)

closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
end)

local function startLoading(tool, size)
    isLoading = true
    enlargeBtn.Text = "⏳ LOADING..."
    enlargeBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    loadingFrame.Visible = true
    
    local startTime = tick()
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        local remaining = loadingTime - elapsed
        local progress = elapsed / loadingTime
        
        if remaining > 0 then
            loadingFill.Size = UDim2.new(progress, 0, 1, 0)
            loadingLabel.Text = "Loading... " .. math.ceil(remaining) .. "s"
        else
            connection:Disconnect()
            enlargePet(tool, size)
            setupGlobalPetMonitoring()
            monitorAllPets()
            isLoading = false
            enlargeBtn.Text = "🚀 ENLARGE PET"
            enlargeBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
            loadingFrame.Visible = false
        end
    end)
end

enlargeBtn.MouseButton1Click:Connect(function()
    if isLoading then return end
    
    local char = player.Character
    if not char then return end
    
    local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        startLoading(tool, currentSize)
    else
        warn("No pet/tool equipped to enlarge!")
    end
end)
