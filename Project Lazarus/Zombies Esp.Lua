local Workspace = game:GetService("Workspace")
local Folder = Workspace:WaitForChild("Folder")
local Model = "banana1"

local function HL()
    local targetModel = Folder:FindFirstChild(Model, true)
    if targetModel and targetModel:IsA("Model") then
        if not targetModel:FindFirstChildOfClass("Highlight") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = targetModel
            highlight.FillColor = Color3.fromRGB(255, 255, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 165, 0)
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            print("Highlight added to banana1.")
        end
    end
end

HL()
