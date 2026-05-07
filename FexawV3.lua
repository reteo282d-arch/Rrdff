local Library = {}

function Library:Init(menuTitle)
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local RS = game:GetService("RunService")
    local p = game.Players.LocalPlayer

    local sg = Instance.new("ScreenGui")
    sg.Parent = p:WaitForChild("PlayerGui")
    sg.Name = "FexawV4_UI"
    sg.ResetOnSpawn = false

    local main = Instance.new("Frame")
    main.Parent = sg
    main.Size = UDim2.new(0,0,0,0)
    main.Position = UDim2.new(0.5,0,0.5,0)
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.BackgroundColor3 = Color3.fromRGB(15,15,15)
    main.Visible = false
    main.ClipsDescendants = true
    Instance.new("UICorner", main)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 2

    local top = Instance.new("Frame")
    top.Parent = main
    top.Size = UDim2.new(1,0,0,40)
    top.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", top)

    local title = Instance.new("TextLabel")
    title.Parent = top
    title.Size = UDim2.new(1,-10,1,0)
    title.Position = UDim2.new(0,10,0,0)
    title.BackgroundTransparency = 1
    title.Text = menuTitle or "FEXAW"
    title.TextColor3 = Color3.new(1,1,1)
    title.TextXAlignment = Enum.TextXAlignment.Left

    local sidebar = Instance.new("Frame")
    sidebar.Parent = main
    sidebar.Size = UDim2.new(0,150,1,-40)
    sidebar.Position = UDim2.new(0,0,0,40)
    sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)

    local content = Instance.new("Frame")
    content.Parent = main
    content.Size = UDim2.new(1,-150,1,-40)
    content.Position = UDim2.new(0,150,0,40)
    content.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", content)
    layout.Padding = UDim.new(0,5)

    local open = Instance.new("TextButton")
    open.Parent = sg
    open.Size = UDim2.new(0,200,0,35)
    open.Position = UDim2.new(0.5,-100,0.15,0)
    open.BackgroundColor3 = Color3.fromRGB(20,20,20)
    open.TextColor3 = Color3.new(1,1,1)
    open.Text = menuTitle or "FEXAW"
    Instance.new("UICorner", open)

    local hue = 0
    RS.RenderStepped:Connect(function()
        hue += 0.002
        if hue > 1 then hue = 0 end
        stroke.Color = Color3.fromHSV(hue,1,1)
    end)

    open.MouseButton1Click:Connect(function()
        if main.Visible then
            TS:Create(main, TweenInfo.new(0.25), {Size = UDim2.new(0,0,0,0)}):Play()
            task.wait(0.25)
            main.Visible = false
        else
            main.Visible = true
            TS:Create(main, TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {
                Size = UDim2.new(0,520,0,380)
            }):Play()
        end
    end)

    local API = {}
    local tabs = {}
    local active

    local function clear()
        for _,v in pairs(content:GetChildren()) do
            if v:IsA("GuiObject") then
                v:Destroy()
            end
        end
    end

    function API:Notify(text)
        local n = Instance.new("TextLabel")
        n.Parent = sg
        n.Size = UDim2.new(0,220,0,35)
        n.Position = UDim2.new(1,-230,1,-50)
        n.BackgroundColor3 = Color3.fromRGB(20,20,20)
        n.TextColor3 = Color3.new(1,1,1)
        n.Text = text
        Instance.new("UICorner", n)

        TS:Create(n, TweenInfo.new(0.3), {Position = UDim2.new(1,-230,1,-90)}):Play()

        task.delay(2.5,function()
            n:Destroy()
        end)
    end

    function API:CreateTab(name)
        local btn = Instance.new("TextButton")
        btn.Parent = sidebar
        btn.Size = UDim2.new(1,-10,0,30)
        btn.Position = UDim2.new(0,5,0,0)
        btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Text = name
        Instance.new("UICorner", btn)

        local tab = Instance.new("Frame")
        tab.Parent = content
        tab.Size = UDim2.new(1,0,1,0)
        tab.BackgroundTransparency = 1
        tab.Visible = false

        local list = Instance.new("UIListLayout", tab)
        list.Padding = UDim.new(0,5)

        btn.MouseButton1Click:Connect(function()
            if active then active.Visible = false end
            active = tab
            tab.Visible = true
        end)

        local T = {}

        function T:AddButton(text, cb)
            local b = Instance.new("TextButton")
            b.Parent = tab
            b.Size = UDim2.new(1,-10,0,32)
            b.BackgroundColor3 = Color3.fromRGB(40,40,40)
            b.TextColor3 = Color3.new(1,1,1)
            b.Text = text
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(cb)
        end

        function T:AddToggle(text, def, cb)
            local state = def
            local t = Instance.new("TextButton")
            t.Parent = tab
            t.Size = UDim2.new(1,-10,0,32)
            t.BackgroundColor3 = Color3.fromRGB(40,40,40)
            t.TextColor3 = Color3.new(1,1,1)
            t.Text = text..": "..(state and "ON" or "OFF")
            Instance.new("UICorner", t)

            t.MouseButton1Click:Connect(function()
                state = not state
                t.Text = text..": "..(state and "ON" or "OFF")
                cb(state)
            end)
        end

        function T:AddLabel(text)
            local l = Instance.new("TextLabel")
            l.Parent = tab
            l.Size = UDim2.new(1,-10,0,25)
            l.BackgroundTransparency = 1
            l.TextColor3 = Color3.new(1,1,1)
            l.Text = text
        end

        return T
    end

    return API
end

return Library
