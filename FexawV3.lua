local Library = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local MainColor = Color3.fromRGB(12, 10, 18)
local AccentColor = Color3.fromRGB(60, 50, 110)
local SecondaryColor = Color3.fromRGB(20, 18, 30)

function Library:Init(menuTitle)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Fexaw_Ultimate_XL"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = false

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Thickness = 2
    MainStroke.Color = AccentColor
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = SecondaryColor
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BorderSizePixel = 0

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 12)
    TopCorner.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TopBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = menuTitle or "FEXAW HUB"
    TitleLabel.TextColor3 = Color3.fromRGB(180, 160, 255)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local OpenBar = Instance.new("Frame")
    OpenBar.Name = "OpenBar"
    OpenBar.Parent = ScreenGui
    OpenBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    OpenBar.Position = UDim2.new(0.5, -160, 0.05, 0)
    OpenBar.Size = UDim2.new(0, 320, 0, 45)
    OpenBar.Visible = true

    local OBCorner = Instance.new("UICorner")
    OBCorner.CornerRadius = UDim.new(0, 8)
    OBCorner.Parent = OpenBar

    local OBStroke = Instance.new("UIStroke")
    OBStroke.Thickness = 2
    OBStroke.Color = Color3.fromRGB(80, 70, 150)
    OBStroke.Parent = OpenBar

    local OpenButton = Instance.new("TextButton")
    OpenButton.Parent = OpenBar
    OpenButton.BackgroundTransparency = 1
    OpenButton.Size = UDim2.new(1, 0, 1, 0)
    OpenButton.Font = Enum.Font.GothamBold
    OpenButton.Text = "OPEN " .. (menuTitle or "HUB")
    OpenButton.TextColor3 = Color3.new(1, 1, 1)
    OpenButton.TextSize = 14

    local ConfirmFrame = Instance.new("Frame")
    ConfirmFrame.Parent = ScreenGui
    ConfirmFrame.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
    ConfirmFrame.Size = UDim2.new(0, 0, 0, 0)
    ConfirmFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    ConfirmFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ConfirmFrame.Visible = false
    ConfirmFrame.ClipsDescendants = true
    Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0, 10)

    local ConfStroke = Instance.new("UIStroke", ConfirmFrame)
    ConfStroke.Color = Color3.fromRGB(255, 50, 50)
    ConfStroke.Thickness = 2

    local ConfLabel = Instance.new("TextLabel", ConfirmFrame)
    ConfLabel.Size = UDim2.new(1, 0, 0.5, 0)
    ConfLabel.BackgroundTransparency = 1
    ConfLabel.Text = "Are you sure you want to close?"
    ConfLabel.TextColor3 = Color3.new(1, 1, 1)
    ConfLabel.Font = Enum.Font.GothamBold
    ConfLabel.TextSize = 16

    local YesBtn = Instance.new("TextButton", ConfirmFrame)
    YesBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    YesBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
    YesBtn.Size = UDim2.new(0.35, 0, 0, 35)
    YesBtn.Text = "Да"
    YesBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", YesBtn)

    local NoBtn = Instance.new("TextButton", ConfirmFrame)
    NoBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
    NoBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
    NoBtn.Size = UDim2.new(0.35, 0, 0, 35)
    NoBtn.Text = "Нет"
    NoBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", NoBtn)

    local function MakeDraggable(obj, dragObj)
        local Dragging, DragStart, StartPos
        dragObj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
                DragStart = input.Position
                StartPos = obj.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then Dragging = false end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local Delta = input.Position - DragStart
                obj.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
            end
        end)
    end

    MakeDraggable(MainFrame, TopBar)
    MakeDraggable(OpenBar, OpenBar)

    local CloseButton = Instance.new("TextButton", TopBar)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -45, 0, 0)
    CloseButton.Size = UDim2.new(0, 45, 1, 0)
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.TextSize = 20

    local MinButton = Instance.new("TextButton", TopBar)
    MinButton.BackgroundTransparency = 1
    MinButton.Position = UDim2.new(1, -85, 0, 0)
    MinButton.Size = UDim2.new(0, 45, 1, 0)
    MinButton.Text = "—"
    MinButton.TextColor3 = Color3.new(1, 1, 1)
    MinButton.TextSize = 20

    CloseButton.MouseButton1Click:Connect(function()
        ConfirmFrame.Visible = true
        TweenService:Create(ConfirmFrame, TweenInfo.new(0.4), {Size = UDim2.new(0, 300, 0, 150)}):Play()
    end)

    NoBtn.MouseButton1Click:Connect(function()
        local t = TweenService:Create(ConfirmFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)})
        t:Play()
        t.Completed:Connect(function() ConfirmFrame.Visible = false end)
    end)

    YesBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    MinButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.4), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.4)
        MainFrame.Visible, OpenBar.Visible = false, true
    end)

    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible, OpenBar.Visible = true, false
        TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 650, 0, 480)}):Play()
    end)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 16, 26)
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.Size = UDim2.new(0, 180, 1, -45)

    local SearchBox = Instance.new("TextBox", Sidebar)
    SearchBox.Size = UDim2.new(1, -20, 0, 35)
    SearchBox.Position = UDim2.new(0, 10, 0, 10)
    SearchBox.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
    SearchBox.PlaceholderText = "🔍 Search Tab..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 6)

    local TabContainer = Instance.new("ScrollingFrame", Sidebar)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 55)
    TabContainer.Size = UDim2.new(1, 0, 1, -65)
    TabContainer.ScrollBarThickness = 0
    TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 5)

    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 185, 0, 50)
    ContentFrame.Size = UDim2.new(1, -190, 1, -55)

    task.spawn(function()
        local h = 0
        while true do
            local c = Color3.fromHSV(h, 0.7, 1)
            MainStroke.Color, OBStroke.Color = c, c
            h = h + 0.002
            task.wait()
        end
    end)

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local t = SearchBox.Text:lower()
        for _, v in pairs(TabContainer:GetChildren()) do
            if v:IsA("TextButton") then
                v.Visible = v.Text:lower():find(t) ~= nil
            end
        end
    end)

    local API = {}
    local CurrentTab = nil

    function API:CreateTab(icon, name)
        local TabBtn = Instance.new("TextButton", TabContainer)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(1, 0, 0, 40)
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.Text = "  " .. icon .. "  " .. name
        TabBtn.TextColor3 = Color3.fromRGB(150, 150, 180)
        TabBtn.TextSize = 14
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left

        local Page = Instance.new("ScrollingFrame", ContentFrame)
        Page.BackgroundTransparency = 1
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Visible = false
        Page.ScrollBarThickness = 2
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0, 8)
        Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        if not CurrentTab then
            CurrentTab = Page
            Page.Visible = true
            TabBtn.TextColor3 = Color3.new(1, 1, 1)
        end

        TabBtn.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Visible = false
                for _, v in pairs(TabContainer:GetChildren()) do
                    if v:IsA("TextButton") then
                        v.TextColor3 = Color3.fromRGB(150, 150, 180)
                    end
                end
            end
            CurrentTab = Page
            Page.Visible = true
            TabBtn.TextColor3 = Color3.new(1, 1, 1)
        end)

        local ElementAPI = {}

        function ElementAPI:Section(txt)
            local l = Instance.new("TextLabel", Page)
            l.Size = UDim2.new(1, -20, 0, 30)
            l.BackgroundTransparency = 1
            l.Text = "↪ [ " .. txt .. " ] ↩"
            l.TextColor3 = Color3.fromRGB(130, 120, 220)
            l.Font = Enum.Font.GothamBold
            l.TextSize = 14
        end

        function ElementAPI:AddButton(txt, cb)
            local b = Instance.new("TextButton", Page)
            b.Size = UDim2.new(1, -20, 0, 42)
            b.BackgroundColor3 = Color3.fromRGB(24, 22, 38)
            b.Text = "  " .. txt
            b.TextColor3 = Color3.new(1, 1, 1)
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Font = Enum.Font.Gotham
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(cb)
        end

        function ElementAPI:AddToggle(txt, def, cb)
            local s = def
            local b = Instance.new("TextButton", Page)
            b.Size = UDim2.new(1, -20, 0, 42)
            b.BackgroundColor3 = s and Color3.fromRGB(60, 150, 80) or Color3.fromRGB(24, 22, 38)
            b.Text = "  " .. txt .. ": " .. (s and "ON" or "OFF")
            b.TextColor3 = Color3.new(1, 1, 1)
            b.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

            b.MouseButton1Click:Connect(function()
                s = not s
                b.Text = "  " .. txt .. ": " .. (s and "ON" or "OFF")
                TweenService:Create(b, TweenInfo.new(0.3), {
                    BackgroundColor3 = s and Color3.fromRGB(60, 150, 80) or Color3.fromRGB(24, 22, 38)
                }):Play()
                cb(s)
            end)
        end

        function ElementAPI:AddTextbox(txt, cb)
            local b = Instance.new("TextBox", Page)
            b.Size = UDim2.new(1, -20, 0, 42)
            b.BackgroundColor3 = Color3.fromRGB(24, 22, 38)
            b.PlaceholderText = txt
            b.Text = ""
            b.TextColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.FocusLost:Connect(function(e)
                if e then cb(b.Text) end
            end)
        end

        function ElementAPI:AddSlider(txt, min, max, def, cb)
            local f = Instance.new("Frame", Page)
            f.Size = UDim2.new(1, -20, 0, 50)
            f.BackgroundColor3 = Color3.fromRGB(24, 22, 38)
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)

            local l = Instance.new("TextLabel", f)
            l.Size = UDim2.new(1, -15, 0, 20)
            l.BackgroundTransparency = 1
            l.Text = "  " .. txt .. ": " .. def
            l.TextColor3 = Color3.new(1, 1, 1)
            l.TextXAlignment = Enum.TextXAlignment.Left

            local bar = Instance.new("Frame", f)
            bar.Size = UDim2.new(0.9, 0, 0, 4)
            bar.Position = UDim2.new(0.05, 0, 0.7, 0)
            bar.BackgroundColor3 = Color3.fromRGB(50, 45, 80)

            local dot = Instance.new("Frame", bar)
            dot.Size = UDim2.new(0, 12, 2.5, 0)
            dot.Position = UDim2.new((def-min)/(max-min), 0, 0.5, 0)
            dot.BackgroundColor3 = Color3.new(1, 1, 1)
            dot.AnchorPoint = Vector2.new(0.5, 0.5)
            Instance.new("UICorner", dot)

            local dragging = false

            local function update(input)
                local p = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                dot.Position = UDim2.new(p, 0, 0.5, 0)
                local val = math.floor(min + (max - min) * p)
                l.Text = "  " .. txt .. ": " .. val
                cb(val)
            end

            bar.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    update(i)
                end
            end)

            UserInputService.InputChanged:Connect(function(i)
                if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                    update(i)
                end
            end)

            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
        end

        function ElementAPI:CreateSub(name)
            local f = Instance.new("Frame", Page)
            f.Size = UDim2.new(1, -20, 0, 42)
            f.BackgroundTransparency = 1
            f.AutomaticSize = Enum.AutomaticSize.Y

            local sb = Instance.new("TextButton", f)
            sb.Size = UDim2.new(1, 0, 0, 42)
            sb.BackgroundColor3 = Color3.fromRGB(30, 28, 48)
            sb.Text = "  [+] " .. name
            sb.TextColor3 = Color3.new(1, 1, 1)
            sb.Font = Enum.Font.GothamBold
            sb.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", sb).CornerRadius = UDim.new(0, 6)

            local sc = Instance.new("Frame", f)
            sc.Size = UDim2.new(1, -15, 0, 0)
            sc.Position = UDim2.new(0, 15, 0, 48)
            sc.Visible = false
            sc.BackgroundTransparency = 1
            sc.AutomaticSize = Enum.AutomaticSize.Y

            local sl = Instance.new("UIListLayout", sc)
            sl.Padding = UDim.new(0, 6)

            sb.MouseButton1Click:Connect(function()
                sc.Visible = not sc.Visible
                sb.Text = sc.Visible and "  [-] " .. name or "  [+] " .. name
            end)

            local SubAPI = {}

            function SubAPI:AddButton(t, c)
                local b = Instance.new("TextButton", sc)
                b.Size = UDim2.new(1, 0, 0, 38)
                b.BackgroundColor3 = Color3.fromRGB(24, 22, 38)
                b.Text = t
                b.TextColor3 = Color3.new(1, 1, 1)
                Instance.new("UICorner", b)
                b.MouseButton1Click:Connect(c)
            end

            function SubAPI:AddToggle(t, d, c)
                local s = d
                local b = Instance.new("TextButton", sc)
                b.Size = UDim2.new(1, 0, 0, 38)
                b.BackgroundColor3 = s and Color3.fromRGB(60, 150, 80) or Color3.fromRGB(24, 22, 38)
                b.Text = t .. ": " .. (s and "ON" or "OFF")
                b.TextColor3 = Color3.new(1, 1, 1)
                Instance.new("UICorner", b)

                b.MouseButton1Click:Connect(function()
                    s = not s
                    b.Text = t .. ": " .. (s and "ON" or "OFF")
                    TweenService:Create(b, TweenInfo.new(0.3), {
                        BackgroundColor3 = s and Color3.fromRGB(60, 150, 80) or Color3.fromRGB(24, 22, 38)
                    }):Play()
                    c(s)
                end)
            end

            return SubAPI
        end

        return ElementAPI
    end

    function API:Notify(msg)
        local n = Instance.new("TextLabel", ScreenGui)
        n.Size = UDim2.new(0, 250, 0, 50)
        n.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        n.Position = UDim2.new(1, 20, 1, -70)
        n.Text = msg
        n.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", n)
        Instance.new("UIStroke", n).Color = MainStroke.Color

        TweenService:Create(n, TweenInfo.new(0.5), {
            Position = UDim2.new(1, -270, 1, -70)
        }):Play()

        task.delay(4, function()
            TweenService:Create(n, TweenInfo.new(0.5), {
                Position = UDim2.new(1, 20, 1, -70)
            }):Play()
            task.wait(0.5)
            n:Destroy()
        end)
    end

    return API
end

return Library
