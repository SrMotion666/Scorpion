-- Wait for player and their GUI to load properly
local Players = game:GetService("Players")
local player

repeat
	player = Players.LocalPlayer
	task.wait()
until player and player:FindFirstChild("PlayerGui")

-- Create and configure the loading GUI
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "LoadingGui"
loadingGui.ResetOnSpawn = false
loadingGui.Parent = player:WaitForChild("PlayerGui")

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 200, 0, 100)
loadingFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
loadingFrame.BackgroundColor3 = Color3.fromHex("#0A0A0A")
loadingFrame.BackgroundTransparency = 0.1
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = loadingGui

local loadingCorner = Instance.new("UICorner", loadingFrame)
loadingCorner.CornerRadius = UDim.new(0, 10)

local loadingStroke = Instance.new("UIStroke", loadingFrame)
loadingStroke.Color = Color3.fromHex("#FF0000")
loadingStroke.Thickness = 2
loadingStroke.Transparency = 0.3

-- Define scorpion emoji as hex sequence
local SCORPION_EMOJI = string.char(240, 159, 166, 130)  -- 

local titleLabel = Instance.new("TextLabel", loadingFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 10)
titleLabel.Text = SCORPION_EMOJI .. " Scorpion Premium v4.0"  -- Updated to v4.0
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextSize = 15
titleLabel.TextColor3 = Color3.fromHex("#FFFFFF")
titleLabel.BackgroundTransparency = 1
titleLabel.TextXAlignment = Enum.TextXAlignment.Center

local loadingText = Instance.new("TextLabel", loadingFrame)
loadingText.Size = UDim2.new(1, 0, 0, 20)
loadingText.Position = UDim2.new(0, 0, 0, 45)
loadingText.Text = "Loading..." -- Fixed text, no animation
loadingText.Font = Enum.Font.FredokaOne
loadingText.TextSize = 14
loadingText.TextColor3 = Color3.fromHex("#FF5555")
loadingText.BackgroundTransparency = 1
loadingText.TextXAlignment = Enum.TextXAlignment.Center

-- Loading dot animation: "Loading", "Loading.", "Loading..", "Loading..."
local dots = {"", ".", "..", "..."}
local dotIndex = 1
local loadingAnim = true

task.spawn(function()
	while loadingAnim do
		loadingText.Text = "Loading" .. dots[dotIndex]
		dotIndex = (dotIndex % #dots) + 1
		task.wait(0.5)
	end
end)

-- Progress bar background
local progressBarBG = Instance.new("Frame", loadingFrame)
progressBarBG.Size = UDim2.new(1, -20, 0, 10)
progressBarBG.Position = UDim2.new(0, 10, 1, -20)
progressBarBG.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
progressBarBG.BorderSizePixel = 0
Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)

-- Progress fill
local progressFill = Instance.new("Frame", progressBarBG)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromHex("#AA0000")
progressFill.BorderSizePixel = 0
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(0, 6)
progressFill.Name = "ProgressFill"
progressFill.Parent = progressBarBG

-- Animate progress fill over 5 seconds
local TweenService = game:GetService("TweenService")
TweenService:Create(progressFill, TweenInfo.new(5), {
	Size = UDim2.new(1, 0, 1, 0)
}):Play()

--  Your ENTIRE main script must go inside this function
function loadMainScript()
	print(" Main script starting after loading screen...")

	--  Paste your FULL main script below this line:
	-- COMPLETE PET RANDOMIZER - Enhanced Version
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Define all emojis as hex-encoded variables
local PAW_EMOJI = string.char(240, 159, 144, 190)       -- 
local DICE_EMOJI = string.char(240, 159, 142, 178)      -- 
local EYE_EMOJI = string.char(240, 159, 145, 129)       -- 
local RECYCLE_EMOJI = string.char(240, 159, 148, 129)  -- 
local EGG_EMOJI = string.char(240, 159, 165, 154)       -- 
local HOURGLASS_EMOJI = string.char(226, 143, 131)      -- 
local SCORPION_EMOJI = string.char(240, 159, 166, 130)  -- 
local STAR_EMOJI = string.char(226, 173, 166)           -- 

-- PET TABLE
local petTable = {
    ["Common Egg"] = { "Dog", "Bunny", "Golden Lab" },
    ["Uncommon Egg"] = { "Chicken", "Black Bunny", "Cat", "Deer" },
    ["Rare Egg"] = { "Pig", "Monkey", "Rooster", "Orange Tabby", "Spotted Deer" },
    ["Legendary Egg"] = { "Cow", "Polar Bear", "Sea Otter", "Turtle", "Silver Monkey" },
    ["Mythical Egg"] = { "Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant" },
    ["Bug Egg"] = { "Snail", "Caterpillar", "Giant Ant", "Praying Mantis" },
    ["Night Egg"] = { "Frog", "Hedgehog", "Mole", "Echo Frog", "Night Owl" },
    ["Bee Egg"] = { "Bee", "Honey Bee", "Bear Bee", "Petal Bee" },
    ["AntiBee Egg"] = { "Wasp", "Moth", "Tarantula Hawk" },
    ["Oasis Egg"] = { "Meerkat", "Sand Snake", "Axolotl" },
    ["Paradise Egg"] = { "Ostrich", "Peacock", "Capybara" },
    ["Dinosaur Egg"] = { "Raptor", "Triceratops", "Stegosaurus" },
    ["Primal Egg"] = { "Parasaurolophus", "Iguanodon", "Pachycephalosaurus" },
    ["Zen Egg"] = { "Shiba Inu", "Nihonzaru", "Tanuki", "Tanchozuru", "Kappa" },
    ["Gourmet Egg"] = { "Bagel Bunny", "Pancake Mole", "Sushi Bear", "Spaghetti Sloth" }
}

-- ESP DISABLED BY DEFAULT
local espEnabled = false
local truePetMap = {}
local autoRunning = false
local manualRandomizing = false

-- SCORPION RED/BLACK THEME
local colors = {
    primary = Color3.fromHex("#0A0A0A"),     -- Dark black
    secondary = Color3.fromHex("#1A1A1A"),   -- Slightly lighter black
    accent = Color3.fromHex("#FF0000"),      -- Bright red
    highlight = Color3.fromHex("#AA0000"),   -- Darker red
    text = Color3.fromHex("#FFFFFF"),        -- White
    effect = Color3.fromHex("#FF5555")       -- Light red
}

-- THEMED GLITCH EFFECT
local function glitchLabelEffect(label)
    coroutine.wrap(function()
        local original = label.TextColor3
        for i = 1, 2 do
            label.TextColor3 = colors.effect  -- Use theme effect color
            task.wait(0.07)
            label.TextColor3 = original
            task.wait(0.07)
        end
    end)()
end

-- ENHANCED ESP FUNCTIONS
local function applyEggESP(eggModel, petName)
    local existingLabel = eggModel:FindFirstChild("PetBillboard", true)
    if existingLabel then existingLabel:Destroy() end
    local existingHighlight = eggModel:FindFirstChild("ESPHighlight")
    if existingHighlight then existingHighlight:Destroy() end
    if not espEnabled then return end

    local basePart = eggModel:FindFirstChildWhichIsA("BasePart")
    if not basePart then return end

    local hatchReady = true
    local hatchTime = eggModel:FindFirstChild("HatchTime")
    local readyFlag = eggModel:FindFirstChild("ReadyToHatch")

    if hatchTime and hatchTime:IsA("NumberValue") and hatchTime.Value > 0 then
        hatchReady = false
    elseif readyFlag and readyFlag:IsA("BoolValue") and not readyFlag.Value then
        hatchReady = false
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PetBillboard"
    billboard.Size = UDim2.new(0, 180, 0, 30)  -- Smaller size
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)  -- Lower position
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 300  -- Reduced distance
    billboard.Parent = basePart

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = EGG_EMOJI .. " " .. eggModel.Name .. " | " .. petName  -- Fixed egg emoji
    if not hatchReady then
        label.Text = HOURGLASS_EMOJI .. " " .. eggModel.Name .. " | " .. petName .. " (Not Ready)"  -- Fixed hourglass emoji
        label.TextColor3 = Color3.fromRGB(150, 150, 150)
        label.TextStrokeTransparency = 0.5
    else
        label.TextColor3 = colors.text
        label.TextStrokeTransparency = 0
    end
    label.TextScaled = false  -- Disabled text scaling
    label.TextSize = 12  -- Smaller font size
    label.Font = Enum.Font.FredokaOne
    label.TextWrapped = true  -- Wrap long names
    label.Parent = billboard

    glitchLabelEffect(label)

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight"
    highlight.FillColor = colors.highlight  -- Theme highlight color
    highlight.OutlineColor = colors.accent   -- Theme accent color
    highlight.FillTransparency = 0.8  -- More transparent
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = eggModel
    highlight.Parent = eggModel
end

local function removeEggESP(eggModel)
    local label = eggModel:FindFirstChild("PetBillboard", true)
    if label then label:Destroy() end
    local highlight = eggModel:FindFirstChild("ESPHighlight")
    if highlight then highlight:Destroy() end
end

-- EGG DETECTION
local function getPlayerGardenEggs(radius)
    local eggs = {}
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return eggs end

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and petTable[obj.Name] then
            local dist = (obj:GetModelCFrame().Position - root.Position).Magnitude
            if dist <= (radius or 60) then
                if not truePetMap[obj] then
                    local pets = petTable[obj.Name]
                    local chosen = pets[math.random(1, #pets)]
                    truePetMap[obj] = chosen
                end
                table.insert(eggs, obj)
            end
        end
    end
    return eggs
end

-- RANDOMIZATION FUNCTION
local function randomizeNearbyEggs()
    local eggs = getPlayerGardenEggs(60)
    for _, egg in ipairs(eggs) do
        local pets = petTable[egg.Name]
        local chosen = pets[math.random(1, #pets)]
        truePetMap[egg] = chosen
        if espEnabled then
            applyEggESP(egg, chosen)
        end
    end
    print(STAR_EMOJI .. " Randomized " .. #eggs .. " eggs " .. STAR_EMOJI)  -- Fixed emoji
end

-- THEMED VISUAL EFFECTS
local function flashEffect(button)
    local originalColor = button.BackgroundColor3
    for i = 1, 3 do
        button.BackgroundColor3 = colors.effect  -- Theme effect color
        task.wait(0.05)
        button.BackgroundColor3 = originalColor
        task.wait(0.05)
    end
end

-- MANUAL RANDOMIZATION WITH COUNTDOWN
local function manualRandomize(button)
    if manualRandomizing or autoRunning then return end
    manualRandomizing = true
    
    local originalText = button.Text
    for i = 3, 1, -1 do
        button.Text = DICE_EMOJI .. " Randomize in: "..i  -- Fixed emoji
        task.wait(1)
        if not manualRandomizing then break end
    end
    
    if manualRandomizing then
        flashEffect(button)
        randomizeNearbyEggs()
        button.Text = originalText
    end
    manualRandomizing = false
end

-- ENHANCED GUI SETUP
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PetHatchGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 200)  -- Increased height for credit
frame.Position = UDim2.new(0.5, -100, 0.5, -100)
frame.BackgroundColor3 = colors.primary
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = colors.accent
stroke.Thickness = 2
stroke.Transparency = 0.3

-- TITLE WITH EMOJIS
local titleContainer = Instance.new("Frame", frame)
titleContainer.Size = UDim2.new(1, 0, 0, 40)
titleContainer.Position = UDim2.new(0, 0, 0, 5)
titleContainer.BackgroundTransparency = 1

local title = Instance.new("TextLabel", titleContainer)
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = PAW_EMOJI .. " Egg Randomizer " .. DICE_EMOJI  -- Fixed emojis
title.Font = Enum.Font.FredokaOne
title.TextSize = 18
title.TextColor3 = colors.text
title.BackgroundTransparency = 1

-- BUTTON CREATION
local function createButton(text, yPos, isHighlight)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 32)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = isHighlight and colors.highlight or colors.secondary
    btn.Text = text
    btn.TextSize = isHighlight and 16 or 14
    btn.Font = Enum.Font.FredokaOne
    btn.TextColor3 = colors.text
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 8)
    
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = colors.accent
    btnStroke.Thickness = 1.5
    btnStroke.Transparency = 0.5
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {
            BackgroundColor3 = isHighlight and Color3.fromHex("#880000") or Color3.fromHex("#333333")
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {
            BackgroundColor3 = isHighlight and colors.highlight or colors.secondary
        }):Play()
    end)
    
    return btn
end

-- BUTTONS WITH EMOJIS
local randomizeBtn = createButton(DICE_EMOJI .. " Randomize Pets", 50, true)  -- Fixed emoji
local toggleBtn = createButton(EYE_EMOJI .. " ESP: OFF", 90, false)           -- Fixed emoji
local autoBtn = createButton(RECYCLE_EMOJI .. " Auto Randomize: OFF", 130, false)  -- Fixed emoji

-- CREDIT AT BOTTOM (BELOW AUTO BUTTON)
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, -20, 0, 20)
credit.Position = UDim2.new(0, 10, 0, 170)  -- Below auto button
credit.Text = SCORPION_EMOJI .. " Scorpion Premium v4.0"  -- Fixed emoji and version
credit.Font = Enum.Font.FredokaOne
credit.TextSize = 10
credit.TextColor3 = Color3.fromRGB(180, 180, 180)
credit.BackgroundTransparency = 0.8
credit.TextXAlignment = Enum.TextXAlignment.Center

-- RANDOMIZE BUTTON ACTION
randomizeBtn.MouseButton1Click:Connect(function()
    manualRandomize(randomizeBtn)
end)

-- ESP TOGGLE ACTION
toggleBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    toggleBtn.Text = espEnabled and EYE_EMOJI .. " ESP: ON" or EYE_EMOJI .. " ESP: OFF"  -- Fixed emoji
    coroutine.wrap(function()
        local eggs = getPlayerGardenEggs(60)
        for _, egg in ipairs(eggs) do
            if espEnabled then
                applyEggESP(egg, truePetMap[egg])
            else
                removeEggESP(egg)
            end
        end
    end)()
end)

-- FIXED AUTO-RANDOMIZER
local bestPets = {
    ["Raccoon"] = true, ["Dragonfly"] = true, ["Queen Bee"] = true,
    ["Disco Bee"] = true, ["Fennec Fox"] = true, ["Fox"] = true,
    ["Mimic Octopus"] = true, ["T-Rex"] = true, ["Spinosaurus"] = true,
    ["Kitsune"] = true, ["French Fry Ferret"] = true
}

local function runAutoRandomize()
    while autoRunning do
        -- Update button to show countdown
        for i = 3, 1, -1 do
            if not autoRunning then break end
            randomizeBtn.Text = DICE_EMOJI .. " Randomize in: "..i  -- Fixed emoji
            task.wait(1)
        end
        
        if autoRunning then
            flashEffect(randomizeBtn)
            randomizeNearbyEggs()
        end
        
        -- Check for best pets
        if autoRunning then
            for _, petName in pairs(truePetMap) do
                if bestPets[petName] then
                    autoRunning = false
                    break
                end
            end
        end
    end
    
    -- Reset UI when auto stops
    autoBtn.Text = RECYCLE_EMOJI .. " Auto Randomize: OFF"  -- Fixed emoji
    randomizeBtn.Text = DICE_EMOJI .. " Randomize Pets"  -- Fixed emoji
end

autoBtn.MouseButton1Click:Connect(function()
    autoRunning = not autoRunning
    autoBtn.Text = autoRunning and RECYCLE_EMOJI .. " Auto Randomize: ON" or RECYCLE_EMOJI .. " Auto Randomize: OFF"  -- Fixed emoji
    
    if autoRunning then
        -- Start auto-randomizer in a separate coroutine
        coroutine.wrap(runAutoRandomize)()
    else
        randomizeBtn.Text = DICE_EMOJI .. " Randomize Pets"  -- Fixed emoji
    end
end)

-- Initialize ESP state
coroutine.wrap(function()
    task.wait(1)  -- Wait a moment for eggs to load
    local eggs = getPlayerGardenEggs(60)
    for _, egg in ipairs(eggs) do
        if espEnabled then
            applyEggESP(egg, truePetMap[egg])
        else
            removeEggESP(egg)
        end
    end
end)()

print(STAR_EMOJI .. " Pet Randomizer Enhanced Edition Loaded! " .. STAR_EMOJI)  -- Fixed emoji
end

-- After 5 seconds, destroy loading GUI and run main script
task.delay(5, function()
	loadingAnim = false --  stop the animation loop
	loadingGui:Destroy()
	loadMainScript()
end)