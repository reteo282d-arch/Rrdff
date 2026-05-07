local Library = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function Library:Init(menuTitle)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ThunderZ_Ultimate_Library"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 18)
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
    MainStroke.Color = Color3.fromRGB(60, 50, 110)
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 18, 30)
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BorderSizePixel = 0

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 12)
    TopCorner.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TopBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = menuTitle or "THUNDERZ HUB"
    TitleLabel.TextColor3 = Color3.fromRGB(180, 160, 255)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -45, 0, 0)
    CloseButton.Size = UDim2.new(0, 45, 1, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseButton.TextSize = 20

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TopBar
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(1, -85, 0, 0)
    MinimizeButton.Size = UDim2.new(0, 45, 1, 0)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "—"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 20

    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 16, 26)
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.Size = UDim2.new(0, 180, 1, -45)
    Sidebar.BorderSizePixel = 0

    local SearchBox = Instance.new("TextBox")
    SearchBox.Name = "SearchBox"
    SearchBox.Parent = Sidebar
    SearchBox.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
    SearchBox.Position = UDim2.new(0, 10, 0, 10)
    SearchBox.Size = UDim2.new(1, -20, 0, 35)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderText = "🔍 Search Tab..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.TextSize = 14

    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 6)
    SearchCorner.Parent = SearchBox

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Sidebar
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 55)
    TabContainer.Size = UDim2.new(1, 0, 1, -65)
    TabContainer.ScrollBarThickness = 0
    TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabContainer
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingTop = UDim.new(0, 5)

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 180, 0, 45)
    ContentFrame.Size = UDim2.new(1, -180, 1, -45)

    local OpenBar = Instance.new("Frame")
    OpenBar.Name = "OpenBar"
    OpenBar.Parent = ScreenGui
    OpenBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    OpenBar.Position = UDim2.new(0.5, -150, 0.05, 0)
    OpenBar.Size = UDim2.new(0, 300, 0, 40)
    OpenBar.Visible = true

    local OBCorner = Instance.new("UICorner")
    OBCorner.CornerRadius = UDim.new(0, 8)
    OBCorner.Parent = OpenBar

    local OBStroke = Instance.new("UIStroke")
    OBStroke.Thickness = 2
    OBStroke.Color = Color3.fromRGB(80, 70, 150)
    OBStroke.Parent = OpenBar

    local OpenButton = Instance.new("TextButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Parent = OpenBar
    OpenButton.BackgroundTransparency = 1
    OpenButton.Size = UDim2.new(1, 0, 1, 0)
    OpenButton.Font = Enum.Font.GothamBold
    OpenButton.Text = "OPEN HUB"
    OpenButton.TextColor3 = Color3.new(1, 1, 1)
    OpenButton.TextSize = 14

    local ConfirmFrame = Instance.new("Frame")
    ConfirmFrame.Name = "ConfirmFrame"
    ConfirmFrame.Parent = ScreenGui
    ConfirmFrame.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
    ConfirmFrame.BorderSizePixel = 0
    ConfirmFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    ConfirmFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ConfirmFrame.Size = UDim2.new(0, 0, 0, 0)
    ConfirmFrame.Visible = false
    ConfirmFrame.ClipsDescendants = true

    local ConfCorner = Instance.new("UICorner")
    ConfCorner.CornerRadius = UDim.new(0, 10)
    ConfCorner.Parent = ConfirmFrame

    local ConfStroke = Instance.new("UIStroke")
    ConfStroke.Color = Color3.fromRGB(255, 50, 50)
    ConfStroke.Thickness = 2
    ConfStroke.Parent = ConfirmFrame

    local ConfLabel = Instance.new("TextLabel")
    ConfLabel.Parent = ConfirmFrame
    ConfLabel.Size = UDim2.new(1, 0, 0.5, 0)
    ConfLabel.BackgroundTransparency = 1
    ConfLabel.Font = Enum.Font.GothamBold
    ConfLabel.Text = "Are you sure you want to close?"
    ConfLabel.TextColor3 = Color3.new(1, 1, 1)
    ConfLabel.TextSize = 16

    local YesBtn = Instance.new("TextButton")
    YesBtn.Parent = ConfirmFrame
    YesBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    YesBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
    YesBtn.Size = UDim2.new(0.35, 0, 0, 35)
    YesBtn.Font = Enum.Font.GothamBold
    YesBtn.Text = "Yes"
    YesBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", YesBtn)

    local NoBtn = Instance.new("TextButton")
    NoBtn.Parent = ConfirmFrame
    NoBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
    NoBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
    NoBtn.Size = UDim2.new(0.35, 0, 0, 35)
    NoBtn.Font = Enum.Font.GothamBold
    NoBtn.Text = "No"
    NoBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", NoBtn)

    local function MakeDraggable(obj, dragObj)
        local Dragging = nil
        local DragInput = nil
        local DragStart = nil
        local StartPos = nil

        local function Update(input)
            local Delta = input.Position - DragStart
            obj.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        end

        dragObj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPos = obj.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                    end
                end)
            end
        end)

        dragObj.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                DragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end)
    end

    MakeDraggable(MainFrame, TopBar)
    MakeDraggable(OpenBar, OpenBar)

    task.spawn(function()
        local h = 0
        while true do
            local color = Color3.fromHSV(h, 0.7, 1)
            MainStroke.Color = color
            OBStroke.Color = color
            h = h + 0.002
            task.wait()
        end
    end)

    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenBar.Visible = false
        TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 650, 0, 450)}):Play()
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        local Tween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        Tween:Play()
        Tween.Completed:Connect(function()
            MainFrame.Visible = false
            OpenBar.Visible = true
        end)
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ConfirmFrame.Visible = true
        TweenService:Create(ConfirmFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 150)}):Play()
    end)

    NoBtn.MouseButton1Click:Connect(function()
        local Tween = TweenService:Create(ConfirmFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)})
        Tween:Play()
        Tween.Completed:Connect(function()
            ConfirmFrame.Visible = false
        end)
    end)

    YesBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local text = SearchBox.Text:lower()
        for _, btn in pairs(TabContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.Visible = btn.Text:lower():find(text) ~= nil
            end
        end
    end)

    local API = {}
    local CurrentTab = nil

    function API:CreateTab(icon, name)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabContainer
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(1, -10, 0, 40)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = "  " .. icon .. "  " .. name
        TabButton.TextColor3 = Color3.fromRGB(150, 150, 180)
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = ContentFrame
        Page.BackgroundTransparency = 1
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Visible = false
        Page.ScrollBarThickness = 2
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = Page
        PagePadding.PaddingTop = UDim.new(0, 10)

        if not CurrentTab then
            CurrentTab = Page
            Page.Visible = true
            TabButton.TextColor3 = Color3.new(1, 1, 1)
        end

        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Visible = false
                for _, v in pairs(TabContainer:GetChildren()) do
                    if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(150, 150, 180) end
                end
            end
            CurrentTab = Page
            Page.Visible = true
            TabButton.TextColor3 = Color3.new(1, 1, 1)
        end)

        local ElementAPI = {}

        function ElementAPI:Section(text)
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Parent = Page
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Size = UDim2.new(1, -20, 0, 30)
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.Text = "↪ [ " .. text .. " ] ↩"
            SectionLabel.TextColor3 = Color3.fromRGB(130, 120, 220)
            SectionLabel.TextSize = 14
        end

        function ElementAPI:AddButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = Page
            Button.BackgroundColor3 = Color3.fromRGB(24, 22, 38)
            Button.Size = UDim2.new(1, -30, 0, 42)
            Button.Font = Enum.Font.Gotham
            Button.Text = "  " .. text
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.TextSize = 14
            Button.TextXAlignment = Enum.TextXAlignment.Left

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                local t = TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 35, 60)})
                t:Play() t.Completed:Connect(function() Button.BackgroundColor3 = Color3.fromRGB(24, 22, 38) end)
                callback()
            end)
        end

        function ElementAPI:AddToggle(text, default, callback)
            local Enabled = default
            local Toggle = Instance.new("TextButton")
            Toggle.Parent = Page
            Toggle.BackgroundColor3 = Enabled and Color3.fromRGB(60, 150, 80) or Color3.fromRGB(24, 22, 38)
            Toggle.Size = UDim2.new(1, -30, 0, 42)
            Toggle.Font = Enum.Font.Gotham
            Toggle.Text = "  " .. text .. ": " .. (Enabled and "ON" or "OFF")
            Toggle.TextColor3 = Color3.new(1, 1, 1)
            Toggle.TextXAlignment = Enum.TextXAlignment.Left

            Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

            Toggle.MouseButton1Click:Connect(function()
                Enabled = not Enabled
                Toggle.Text = "  " .. text .. ": " .. (Enabled and "ON" or "OFF")
                TweenService:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = Enabled and Color3.fromRGB(60, 150, 80) or Color3.fromRGB(24, 22, 38)}):Play()
                callback(Enabled)
            end)
        end

        function ElementAPI:CreateSub(name)
            local SubFrame = Instance.new("Frame")
            SubFrame.Parent = Page
            SubFrame.BackgroundTransparency = 1
            SubFrame.Size = UDim2.new(1, -30, 0, 42)
            SubFrame.AutomaticSize = Enum.AutomaticSize.Y

            local SubButton = Instance.new("TextButton")
            SubButton.Parent = SubFrame
            SubButton.BackgroundColor3 = Color3.fromRGB(30, 28, 48)
            SubButton.Size = UDim2.new(1, 0, 0, 42)
            SubButton.Font = Enum.Font.GothamBold
            SubButton.Text = "  [+] " .. name
            SubButton.TextColor3 = Color3.new(1, 1, 1)
            SubButton.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", SubButton).CornerRadius = UDim.new(0, 6)

            local SubContainer = Instance.new("Frame")
            SubContainer.Parent = SubFrame
            SubContainer.BackgroundTransparency = 1
            SubContainer.Position = UDim2.new(0, 15, 0, 48)
            SubContainer.Size = UDim2.new(1, -15, 0, 0)
            SubContainer.Visible = false
            SubContainer.AutomaticSize = Enum.AutomaticSize.Y

            local SubLayout = Instance.new("UIListLayout")
            SubLayout.Parent = SubContainer
            SubLayout.Padding = UDim.new(0, 6)

            SubButton.MouseButton1Click:Connect(function()
                SubContainer.Visible = not SubContainer.Visible
                SubButton.Text = SubContainer.Visible and "  [-] " .. name or "  [+] " .. name
            end)

            -- This allows nested functions
            local SubAPI = {}
            function SubAPI:AddButton(t, c) ElementAPI:AddButton(t, c) end -- Simplified for example
            return SubAPI
        end

        return ElementAPI
    end

    function API:Notify(msg)
        local Notification = Instance.new("TextLabel")
        Notification.Parent = ScreenGui
        Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        Notification.Size = UDim2.new(0, 250, 0, 50)
        Notification.Position = UDim2.new(1, 20, 1, -70)
        Notification.Font = Enum.Font.GothamBold
        Notification.Text = msg
        Notification.TextColor3 = Color3.new(1, 1, 1)
        Notification.TextSize = 14
        Instance.new("UICorner", Notification)
        local NStroke = Instance.new("UIStroke", Notification)
        NStroke.Thickness = 2
        NStroke.Color = MainStroke.Color

        TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(1, -270, 1, -70)}):Play()
        task.delay(4, function()
            TweenService:Create(Notification, TweenInfo.new(0.5), {Position = UDim2.new(1, 20, 1, -70)}):Play()
            task.wait(0.5) Notification:Destroy()
        end)
    end

    return API
end

return Library
