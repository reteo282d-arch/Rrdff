local Library = {}

function Library:Init(menuTitle)
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local RS = game:GetService("RunService")
    local p = game.Players.LocalPlayer

    local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
    sg.Name = "FexawV4_Pro"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 999

    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.Visible = false
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local top = Instance.new("Frame", main)
    top.Size = UDim2.new(1, 0, 0, 40)
    top.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Instance.new("UICorner", top).CornerRadius = UDim.new(0, 8)

    local dragging, dragInput, dragStart, startPos
    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local title = Instance.new("TextLabel", top)
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = menuTitle or "FEXAW PRO"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14

    local sideContainer = Instance.new("Frame", main)
    sideContainer.Size = UDim2.new(0, 150, 1, -40)
    sideContainer.Position = UDim2.new(0, 0, 0, 40)
    sideContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", sideContainer)

    local searchBox = Instance.new("TextBox", sideContainer)
    searchBox.Size = UDim2.new(0.9, 0, 0, 30)
    searchBox.Position = UDim2.new(0.05, 0, 0, 10)
    searchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    searchBox.PlaceholderText = "Search..."
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.new(1, 1, 1)
    searchBox.TextSize = 12
    Instance.new("UICorner", searchBox)

    local sidebar = Instance.new("ScrollingFrame", sideContainer)
    sidebar.Size = UDim2.new(1, 0, 1, -50)
    sidebar.Position = UDim2.new(0, 0, 0, 50)
    sidebar.BackgroundTransparency = 1
    sidebar.ScrollBarThickness = 0
    sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local sideLayout = Instance.new("UIListLayout", sidebar)
    sideLayout.Padding = UDim.new(0, 5)
    Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0, 5)

    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1, -155, 1, -45)
    content.Position = UDim2.new(0, 155, 0, 45)
    content.BackgroundTransparency = 1

    local open = Instance.new("TextButton", sg)
    open.Size = UDim2.new(0, 180, 0, 35)
    open.Position = UDim2.new(0.5, -90, 0.05, 0)
    open.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    open.TextColor3 = Color3.new(1, 1, 1)
    open.Text = "OPEN MENU"
    open.Font = Enum.Font.GothamBold
    Instance.new("UICorner", open)
    local btnStroke = Instance.new("UIStroke", open)
    btnStroke.Thickness = 2

    task.spawn(function()
        local h = 0
        while true do
            local c = Color3.fromHSV(h, 0.7, 1)
            stroke.Color = c
            btnStroke.Color = c
            h = h + 0.002
            if h > 1 then h = 0 end
            task.wait()
        end
    end)

    open.MouseButton1Click:Connect(function()
        main.Visible = true
        local isOpening = main.Size.X.Offset < 10
        TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = isOpening and UDim2.new(0, 550, 0, 400) or UDim2.new(0, 0, 0, 0)}):Play()
    end)

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local t = searchBox.Text:lower()
        for _, btn in pairs(sidebar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.Visible = btn.Text:lower():find(t) ~= nil
            end
        end
    end)

    local API = {}
    local activeTab = nil

    function API:Notify(text)
        local n = Instance.new("TextLabel", sg)
        n.Size = UDim2.new(0, 220, 0, 40)
        n.Position = UDim2.new(1, 10, 1, -60)
        n.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        n.TextColor3, n.Text = Color3.new(1,1,1), text
        n.Font = Enum.Font.GothamBold
        Instance.new("UICorner", n)
        local ns = Instance.new("UIStroke", n)
        ns.Thickness, ns.Color = 2, stroke.Color
        TS:Create(n, TweenInfo.new(0.4), {Position = UDim2.new(1, -230, 1, -60)}):Play()
        task.delay(3, function()
            TS:Create(n, TweenInfo.new(0.4), {Position = UDim2.new(1, 10, 1, -60)}):Play()
            task.wait(0.4) n:Destroy()
        end)
    end

    function API:CreateTab(name)
        local btn = Instance.new("TextButton", sidebar)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.Position = UDim2.new(0, 5, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.TextColor3, btn.Text = Color3.new(1, 1, 1), name
        btn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", btn)

        local tab = Instance.new("ScrollingFrame", content)
        tab.Size = UDim2.new(1, -5, 1, -5)
        tab.BackgroundTransparency = 1
        tab.Visible = false
        tab.ScrollBarThickness = 2
        tab.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local layout = Instance.new("UIListLayout", tab)
        layout.Padding = UDim.new(0, 6)
        Instance.new("UIPadding", tab).PaddingLeft = UDim.new(0, 5)

        if not activeTab then
            activeTab = tab
            tab.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end

        btn.MouseButton1Click:Connect(function()
            if activeTab then
                activeTab.Visible = false
                for _, v in pairs(sidebar:GetChildren()) do
                    if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end
                end
            end
            activeTab = tab
            tab.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)

        local function CreateElements(parent)
            local E = {}
            function E:AddButton(text, cb)
                local b = Instance.new("TextButton", parent)
                b.Size = UDim2.new(1, -10, 0, 35)
                b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                b.TextColor3, b.Text = Color3.new(1,1,1), text
                b.Font = Enum.Font.Gotham
                Instance.new("UICorner", b)
                b.MouseButton1Click:Connect(cb)
            end
            function E:AddToggle(text, def, cb)
                local s = def
                local b = Instance.new("TextButton", parent)
                b.Size = UDim2.new(1, -10, 0, 35)
                b.BackgroundColor3 = s and Color3.fromRGB(0, 130, 60) or Color3.fromRGB(35, 35, 35)
                b.TextColor3, b.Text = Color3.new(1,1,1), text..": "..(s and "ON" or "OFF")
                b.Font = Enum.Font.Gotham
                Instance.new("UICorner", b)
                b.MouseButton1Click:Connect(function()
                    s = not s
                    b.Text = text..": "..(s and "ON" or "OFF")
                    TS:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = s and Color3.fromRGB(0, 130, 60) or Color3.fromRGB(35, 35, 35)}):Play()
                    cb(s)
                end)
            end
            function E:AddLabel(text)
                local l = Instance.new("TextLabel", parent)
                l.Size = UDim2.new(1, -10, 0, 20)
                l.BackgroundTransparency, l.TextColor3, l.Text = 1, Color3.new(0.7,0.7,0.7), text
                l.TextSize, l.Font = 12, Enum.Font.Gotham
            end
            function E:CreateSub(subName)
                local subFrame = Instance.new("Frame", parent)
                subFrame.Size = UDim2.new(1, -10, 0, 32)
                subFrame.AutomaticSize = Enum.AutomaticSize.Y
                subFrame.BackgroundTransparency = 1
                local sBtn = Instance.new("TextButton", subFrame)
                sBtn.Size = UDim2.new(1, 0, 0, 32)
                sBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                sBtn.TextColor3, sBtn.Text = Color3.new(1,1,1), "[+] "..subName
                sBtn.Font = Enum.Font.GothamBold
                Instance.new("UICorner", sBtn)
                local sCon = Instance.new("Frame", subFrame)
                sCon.Position = UDim2.new(0, 10, 0, 38)
                sCon.Size = UDim2.new(1, -10, 0, 0)
                sCon.Visible = false
                sCon.AutomaticSize = Enum.AutomaticSize.Y
                sCon.BackgroundTransparency = 1
                Instance.new("UIListLayout", sCon).Padding = UDim.new(0, 5)
                sBtn.MouseButton1Click:Connect(function()
                    sCon.Visible = not sCon.Visible
                    sBtn.Text = (sCon.Visible and "[-] " or "[+] ")..subName
                end)
                return CreateElements(sCon)
            end
            function E:AddTextbox(t, cb)
                local b = Instance.new("TextBox", parent)
                b.Size = UDim2.new(1, -10, 0, 35)
                b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                b.PlaceholderText, b.Text = t, ""
                b.TextColor3, b.Font = Color3.new(1,1,1), Enum.Font.Gotham
                Instance.new("UICorner", b)
                b.FocusLost:Connect(function(enter) if enter then cb(b.Text) end end)
            end
            return E
        end
        return CreateElements(tab)
    end
    return API
end

return Library
