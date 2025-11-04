local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local ReplayCache = {}
local RegisteredObjects = {}
local ActiveRecording = {}

local isRecording = false
local isReplaying = false

local timePassed = 0
local activeRecordingName = ""
local recordConnection = nil

local Step = Instance.new("BindableEvent")
local FrameStep = Instance.new("BindableEvent")
local OnRecord = Instance.new("BindableEvent")
local OnStop = Instance.new("BindableEvent")
local OnReplay = Instance.new("BindableEvent")
local OnReplayStop = Instance.new("BindableEvent")

local Module = {}

local function createPhantom(object)
    local phantom
    
    if (object.ClassName == "Part") then
        phantom = object:Clone()
        phantom.Material = Enum.Material.Neon
        phantom.Transparency = 0.75
        phantom.CanCollide = false
        phantom.Anchored = true
        
    elseif (object.ClassName == "Model") then
        local dummyTemplate = ReplicatedStorage:FindFirstChild("Dummy")
        if not dummyTemplate then
            phantom = object:Clone()
            for _, child in ipairs(phantom:GetDescendants()) do
                if (child:IsA("BasePart")) then
                    child.Transparency = 0.75
                    child.CanCollide = false
                    child.Anchored = true
                end
            end
        else
            phantom = dummyTemplate:Clone()
        end
        
        phantom.Name = object.Name
        
        if dummyTemplate then
            for _, child in ipairs(phantom:GetChildren()) do
                if (child:IsA("BasePart")) then
                    child.Transparency = 0.75
                    child.CanCollide = false
                    child.Anchored = true
                end
            end
        end
    end
    
    if phantom then
        phantom.Name = object.Name
        phantom.Parent = ReplicatedStorage
    end
    
    return phantom
end

Module.Register = function(object)
    assert(object ~= nil, "Please provide an object to register")
    
    if not table.find(RegisteredObjects, object) then
        table.insert(RegisteredObjects, object)
        
        if not ReplicatedStorage:FindFirstChild(object.Name) then
            createPhantom(object)
        end
    end
end

Module.Unregister = function(object)
    assert(object ~= nil, "Please provide an object to unregister")
    
    local index = table.find(RegisteredObjects, object)
    if index then
        table.remove(RegisteredObjects, index)
        
        local phantom = ReplicatedStorage:FindFirstChild(object.Name)
        if phantom then
            phantom:Destroy()
        end
    end
end

Module.Record = function(name)
    if isRecording then
        return
    end
    
    assert(name ~= nil and typeof(name) == "string" and #name > 0, "Please provide a name for the replay")
    
    activeRecordingName = name
    isRecording = true
    timePassed = 0
    ActiveRecording = {}
    
    for _, object in ipairs(RegisteredObjects) do
        ActiveRecording[object] = {}
    end
    
    OnRecord:Fire(name)
    
    recordConnection = RunService.Heartbeat:Connect(function(deltaTime)
        timePassed += deltaTime
        
        for object, framesArray in pairs(ActiveRecording) do
            local cframe
            if (object.ClassName == "Model") then
                if object.PrimaryPart then
                    cframe = object.PrimaryPart.CFrame
                else
                    cframe = CFrame.new()
                end
            elseif (object.ClassName == "Part") then
                cframe = object.CFrame
            end
            
            if cframe then
                table.insert(framesArray, cframe)
            end
        end
        
        Step:Fire(timePassed)
    end)
end

Module.Stop = function()
    if not isRecording then
        return
    end
    
    isRecording = false
    recordConnection:Disconnect()
    recordConnection = nil
    
    ReplayCache[activeRecordingName] = ActiveRecording
    
    OnStop:Fire(activeRecordingName)
    
    ActiveRecording = {}
    activeRecordingName = ""
    timePassed = 0
end

Module.Replay = function(name)
    if isReplaying then
        return
    end
    
    local replayData = ReplayCache[name]
    assert(replayData, "Could not find a replay with name: " .. name)
    
    isReplaying = true
    OnReplay:Fire(name)
    
    local replayFolder = Workspace:FindFirstChild("ThePhantomReplay")
    if replayFolder then
        replayFolder:ClearAllChildren()
    else
        replayFolder = Instance.new("Folder", Workspace)
        replayFolder.Name = "ThePhantomReplay"
    end
    
    local activeThreads = 0
    local totalFrames = 0
    
    for object, framesArray in pairs(replayData) do
        local phantom = ReplicatedStorage:FindFirstChild(object.Name)
        if not phantom then
            continue
        end
        
        activeThreads += 1
        if #framesArray > totalFrames then
            totalFrames = #framesArray
        end
        
        task.spawn(function()
            local playbackPhantom = phantom:Clone()
            playbackPhantom.Parent = replayFolder
            
            for frameIndex, cframe in ipairs(framesArray) do
                
                if (playbackPhantom.ClassName == "Model") then
                    if playbackPhantom.PrimaryPart then
                        playbackPhantom.PrimaryPart.CFrame = cframe
                    end
                else
                    playbackPhantom.CFrame = cframe
                end
                
                FrameStep:Fire(frameIndex)
                RunService.Heartbeat:Wait()
            end
            
            playbackPhantom:Destroy()
            activeThreads -= 1
        end)
    end
    
    task.spawn(function()
        while activeThreads > 0 do
            RunService.Heartbeat:Wait()
        end
        
        isReplaying = false
        OnReplayStop:Fire(name)
    end)
    
end

Module.Events = {
    STEP = Step,
    ON_RECORD = OnRecord,
    ON_STOP = OnStop,
    ON_REPLAY = OnReplay,
    ON_REPLAY_STOP = OnReplayStop,
    FRAME_STEP = FrameStep
}

local ReplayModule = Module 

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

if not Character then
    return
end

local RootPart = Character:WaitForChild("HumanoidRootPart")
if not Character.PrimaryPart then
    Character.PrimaryPart = RootPart
end

ReplayModule.Register(Character)

task.wait(3)
ReplayModule.Record("MyReplay")

task.wait(10)

ReplayModule.Stop()

task.wait(3)

ReplayModule.Replay("MyReplay")