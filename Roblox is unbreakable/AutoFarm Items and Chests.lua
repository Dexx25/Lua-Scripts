-- Player reference
local player = game.Players.LocalPlayer

-- Get the folders
local chestFolder = workspace:WaitForChild("Chests"):WaitForChild("SpawnedChests")
local itemsFolder = workspace:WaitForChild("Map"):WaitForChild("Items"):WaitForChild("SpawnedItems")

-- Function to fire ProximityPrompt
local function firePrompt(prompt)
    if prompt and prompt:IsA("ProximityPrompt") then
        prompt:InputHoldBegin()
        task.wait(0.01) -- Simulate a small hold duration
        prompt:InputHoldEnd()
        print("Fired ProximityPrompt at:", prompt.Parent.Name)
    end
end

-- Function to teleport the player
local function teleportToPosition(position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 5, 0)) -- Slightly above position
    end
end

-- Function to handle Chests (like before)
local function handleChests()
    for _, chest in ipairs(chestFolder:GetChildren()) do
        if chest:IsA("Model")then
            local woodTop = chest:FindFirstChild("WoodTop")
            if woodTop then
                local proximityPrompt = woodTop:FindFirstChildWhichIsA("ProximityPrompt")
                if proximityPrompt then
                    teleportToPosition(woodTop.Position)
                    task.wait(0.5) -- Small delay
                    firePrompt(proximityPrompt)
                end
            end
        end
    end
end

-- Function to handle MeshParts or Models in SpawnedItems
local function handleSpawnedItems()
    for _, item in ipairs(itemsFolder:GetChildren()) do
        if item:IsA("Model") then
            -- For Models, teleport to the PrimaryPart if available
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart then
                teleportToPosition(primaryPart.Position)
                print("Teleported to Model:", item.Name)
            end
        elseif item:IsA("MeshPart") or item:IsA("Part") then
            -- For MeshParts or Parts
            teleportToPosition(item.Position)
            print("Teleported to MeshPart/Part:", item.Name)
        end
        task.wait(0.5) -- Small delay between items
    end
end

-- Main Script Execution
handleChests()      -- Handles Common Chests
handleSpawnedItems() -- Handles MeshParts and Models in SpawnedItems
