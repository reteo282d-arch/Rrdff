local Library = {}

function Library:Init(menuTitle)
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local p = game.Players.LocalPlayer
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    sg.Name = "FexawV3_Official"
    sg.ResetOnSpawn = false

    local targetHeight, targetWidth = 380, 520
    
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.Visible = false
    main.ClipsDescendants = true
    Instance.new("UICorner", main)

    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Thickness = 3
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local side = Instance.new("Frame", main)
    side.Size = UDim2.new(0, 160, 1, 0)
    side.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", side)

    local ob = Instance.new("Frame", sg)
    ob.Size, ob.Position = UDim2.new(0, 350, 0, 40), UDim2.new(0.5, -175, 0.2, 0)
    ob.BackgroundColor3, ob.BackgroundTransparency = Color3.fromRGB(15, 15, 15), 0.2
    Instance.new("UICorner", ob)
    local obStroke = Instance.new("UIStroke", ob)
    obStroke.Thickness = 2

    task.spawn(function()
        local hue = 0
        while true do
            local color = Color3.fromHSV(hue, 1, 1)
            mainStroke.Color, obStroke.Color = color, color
            hue = hue + 0.005
            task.wait(0.01)
        end
    end)

    local dragBtn = Instance.new("TextButton", ob)
    dragBtn.Size, dragBtn.Text = UDim2.new(0, 60, 1, 0), "÷ |"
    dragBtn.BackgroundTransparency, dragBtn.TextColor3, dragBtn.TextSize = 1, Color3.new(1,1,1), 22

    local openBtn = Instance.new("TextButton", ob)
    openBtn.Size, openBtn.Position = UDim2.new(1, -65, 1, 0), UDim2.new(0, 65, 0, 0)
    openBtn.BackgroundTransparency, openBtn.Text, openBtn.TextColor3 = 1, menuTitle or "FEXAW V3", Color3.new(1,1,1)
    openBtn.TextXAlignment = Enum.TextXAlignment.Left

    local dragging, dragStart, startPos, startPosMain
    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart, startPos, startPosMain = input.Position, ob.Position, main.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            ob.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            main.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

    openBtn.MouseButton1Click:Connect(function()
        if not main.Visible then
            main.Visible = true
            TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, targetWidth, 0, targetHeight)}):Play()
        else
            local tw = TS:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)})
            tw:Play()
            tw.Completed:Connect(function() if main.Size.Y.Offset < 1 then main.Visible = false end end)
        end
    end)

    local mP = Instance.new("ScrollingFrame", main)
    mP.Position, mP.Size, mP.BackgroundTransparency = UDim2.new(0, 170, 0, 10), UDim2.new(1, -180, 1, -20), 1
    mP.ScrollBarThickness, mP.AutomaticCanvasSize = 2, Enum.AutomaticSize.Y
    Instance.new("UIListLayout", mP).Padding = UDim.new(0, 5)

    local API = {}

    function API:AddButton(text, callback, parent)
        local b = Instance.new("TextButton", parent or mP)
        b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, -10, 0, 30), Color3.fromRGB(35, 35, 35), text, Color3.new(1,1,1)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(callback)
    end

    function API:AddToggle(text, callback, parent)
        local state = false
        local b = Instance.new("TextButton", parent or mP)
        b.Size, b.BackgroundColor3, b.Text, b.TextColor3 = UDim2.new(1, -10, 0, 30), Color3.fromRGB(35, 35, 35), text .. ": OFF", Color3.new(1,1,1)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function()
            state = not state
            b.Text = text .. (state and ": ON" or ": OFF")
            TS:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(0,170,80) or Color3.fromRGB(35,35,35)}):Play()
            callback(state)
        end)
    end

    function API:AddSlider(text, min, max, default, callback, parent)
        local sFrame = Instance.new("Frame", parent or mP)
        sFrame.Size, sFrame.BackgroundColor3 = UDim2.new(1, -10, 0, 45), Color3.fromRGB(25,25,25)
        Instance.new("UICorner", sFrame)
        local label = Instance.new("TextLabel", sFrame)
        label.Size, label.BackgroundTransparency, label.Text, label.TextColor3 = UDim2.new(1, 0, 0, 20), 1, text .. ": " .. default, Color3.new(1,1,1)
        local slideBar = Instance.new("Frame", sFrame)
        slideBar.Size, slideBar.Position, slideBar.BackgroundColor3 = UDim2.new(0.9, 0, 0, 4), UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(50,50,50)
        local slideDot = Instance.new("Frame", slideBar)
        slideDot.Size, slideDot.BackgroundColor3 = UDim2.new(0, 12, 2.5, 0), Color3.new(1,1,1)
        slideDot.AnchorPoint = Vector2.new(0.5, 0.5)
        slideDot.Position = UDim2.new((default-min)/(max-min), 0, 0.5, 0)
        Instance.new("UICorner", slideDot).CornerRadius = UDim.new(1,0)
        
        local function update(input)
            local pos = math.clamp((input.Position.X - slideBar.AbsolutePosition.X) / slideBar.AbsoluteSize.X, 0, 1)
            slideDot.Position = UDim2.new(pos, 0, 0.5, 0)
            local value = math.floor(min + (max - min) * pos)
            label.Text = text .. ": " .. value
            callback(value)
        end
        slideBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local conn; conn = UIS.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
                end)
                UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then conn:Disconnect() end end)
            end
        end)
    end

    function API:CreateCategory(name)
        local catFrame = Instance.new("Frame", mP)
        catFrame.Size, catFrame.AutomaticSize, catFrame.BackgroundTransparency = UDim2.new(1, -10, 0, 30), Enum.AutomaticSize.Y, 1
        local btn = Instance.new("TextButton", catFrame)
        btn.Size, btn.BackgroundColor3, btn.Text, btn.TextColor3 = UDim2.new(1, 0, 0, 30), Color3.fromRGB(30,30,30), "[+] " .. name, Color3.new(1,1,1)
        Instance.new("UICorner", btn)
        local container = Instance.new("Frame", catFrame)
        container.Position, container.Size, container.Visible = UDim2.new(0, 0, 0, 35), UDim2.new(1, 0, 0, 0), false
        container.AutomaticSize, container.BackgroundTransparency = Enum.AutomaticSize.Y, 1
        Instance.new("UIListLayout", container).Padding = UDim.new(0, 5)
        btn.MouseButton1Click:Connect(function()
            container.Visible = not container.Visible
            btn.Text = (container.Visible and "[-] " or "[+] ") .. name
        end)
        local CatAPI = {}
        function CatAPI:AddButton(t, c) API:AddButton(t, c, container) end
        function CatAPI:AddToggle(t, c) API:AddToggle(t, c, container) end
        function CatAPI:AddSlider(t, mi, ma, d, c) API:AddSlider(t, mi, ma, d, c, container) end
        return CatAPI
    end

    return API
end

local FexawUI = Library:Init("FEXAW OFFICIAL V3")

FexawUI:AddButton("Destroy GUI", function() game.CoreGui:FindFirstChild("FexawV3_Official"):Destroy() end)

local PlayerTab = FexawUI:CreateCategory("Player Settings")
PlayerTab:AddSlider("WalkSpeed", 16, 500, 16, function(v) p.Character.Humanoid.WalkSpeed = v end)
PlayerTab:AddSlider("JumpPower", 50, 500, 50, function(v) p.Character.Humanoid.JumpPower = v end)

local Visuals = FexawUI:CreateCategory("Visuals")
Visuals:AddToggle("Enable ESP", function(s) print("ESP Status:", s) end)
Visuals:AddToggle("FullBright", function(s) game:GetService("Lighting").Brightness = s and 2 or 1 end)

