local Library = {}

function Library:Init(menuTitle)
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local RS = game:GetService("RunService")
    local p = game.Players.LocalPlayer
    local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
    sg.Name = "ThunderZ_Style_Full"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 999

    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(12, 10, 18)
    main.Visible = false
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(45, 40, 80)

    local top = Instance.new("Frame", main)
    top.Size = UDim2.new(1, 0, 0, 35)
    top.BackgroundColor3 = Color3.fromRGB(20, 18, 30)
    Instance.new("UICorner", top)

    local title = Instance.new("TextLabel", top)
    title.Size = UDim2.new(0.5, 0, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = menuTitle
    title.TextColor3 = Color3.fromRGB(180, 160, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left

    local close = Instance.new("TextButton", top)
    close.Size = UDim2.new(0, 30, 1, 0)
    close.Position = UDim2.new(1, -35, 0, 0)
    close.BackgroundTransparency = 1
    close.Text = "✕"
    close.TextColor3 = Color3.fromRGB(255, 80, 80)
    close.TextSize = 18

    local min = Instance.new("TextButton", top)
    min.Size = UDim2.new(0, 30, 1, 0)
    min.Position = UDim2.new(1, -65, 0, 0)
    min.BackgroundTransparency = 1
    min.Text = "—"
    min.TextColor3 = Color3.new(1, 1, 1)
    min.TextSize = 18

    local confirm = Instance.new("Frame", sg)
    confirm.Size = UDim2.new(0, 0, 0, 0)
    confirm.Position = UDim2.new(0.5, 0, 0.5, 0)
    confirm.AnchorPoint = Vector2.new(0.5, 0.5)
    confirm.BackgroundColor3 = Color3.fromRGB(20, 18, 30)
    confirm.Visible = false
    confirm.ClipsDescendants = true
    Instance.new("UICorner", confirm)
    Instance.new("UIStroke", confirm).Color = Color3.new(1,0,0)

    local cL = Instance.new("TextLabel", confirm)
    cL.Size = UDim2.new(1, 0, 0.5, 0)
    cL.BackgroundTransparency = 1
    cL.Text = "Are you sure you want to close the menu?"
    cL.TextColor3 = Color3.new(1, 1, 1)
    cL.Font = Enum.Font.GothamBold
    cL.TextSize = 14

    local yes = Instance.new("TextButton", confirm)
    yes.Size = UDim2.new(0, 100, 0, 30)
    yes.Position = UDim2.new(0.5, -110, 0.6, 0)
    yes.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    yes.Text = "Да"
    yes.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", yes)

    local no = Instance.new("TextButton", confirm)
    no.Size = UDim2.new(0, 100, 0, 30)
    no.Position = UDim2.new(0.5, 10, 0.6, 0)
    no.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
    no.Text = "Нет"
    no.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", no)

    local ob = Instance.new("Frame", sg)
    ob.Size = UDim2.new(0, 250, 0, 35)
    ob.Position = UDim2.new(0.5, -125, 0.05, 0)
    ob.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    ob.Visible = true
    Instance.new("UICorner", ob)
    local obS = Instance.new("UIStroke", ob)
    obS.Thickness, obS.Color = 2, Color3.fromRGB(80, 80, 160)
    local openBtn = Instance.new("TextButton", ob)
    openBtn.Size, openBtn.BackgroundTransparency, openBtn.Text = UDim2.new(1, 0, 1, 0), 1, "OPEN MENU"
    openBtn.TextColor3, openBtn.Font = Color3.new(1,1,1), Enum.Font.GothamBold

    local sidebar = Instance.new("ScrollingFrame", main)
    sidebar.Size = UDim2.new(0, 160, 1, -45)
    sidebar.Position = UDim2.new(0, 0, 0, 40)
    sidebar.BackgroundTransparency = 1
    sidebar.ScrollBarThickness = 0
    sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UIListLayout", sidebar).Padding = UDim.new(0, 2)
    Instance.new("UIPadding", sidebar).PaddingLeft = UDim.new(0, 10)

    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1, -175, 1, -45)
    content.Position = UDim2.new(0, 170, 0, 40)
    content.BackgroundTransparency = 1

    local function drag(g, a)
        local d, ds, sp
        a.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true ds = i.Position sp = g.Position end end)
        UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then local dl = i.Position - ds g.Position = UDim2.new(sp.X.Scale, sp.X.Offset + dl.X, sp.Y.Scale, sp.Y.Offset + dl.Y) end end)
        UIS.InputEnded:Connect(function() d = false end)
    end
    drag(main, top)
    drag(ob, ob)

    openBtn.MouseButton1Click:Connect(function()
        main.Visible, ob.Visible = true, false
        TS:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 620, 0, 420)}):Play()
    end)

    min.MouseButton1Click:Connect(function()
        TS:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3)
        main.Visible, ob.Visible = false, true
    end)

    close.MouseButton1Click:Connect(function()
        confirm.Visible = true
        TS:Create(confirm, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 150)}):Play()
    end)

    no.MouseButton1Click:Connect(function()
        TS:Create(confirm, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3)
        confirm.Visible = false
    end)

    yes.MouseButton1Click:Connect(function()
        sg:Destroy()
    end)

    local API = {}
    local actT = nil

    function API:CreateTab(icon, name)
        local b = Instance.new("TextButton", sidebar)
        b.Size = UDim2.new(1, 0, 0, 35)
        b.BackgroundTransparency = 1
        b.Text = "  " .. icon .. "  " .. name
        b.TextColor3 = Color3.fromRGB(140, 130, 170)
        b.Font = Enum.Font.Gotham
        b.TextXAlignment = Enum.TextXAlignment.Left

        local t = Instance.new("ScrollingFrame", content)
        t.Size = UDim2.new(1, 0, 1, 0)
        t.BackgroundTransparency = 1
        t.Visible = false
        t.ScrollBarThickness = 2
        t.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Instance.new("UIListLayout", t).Padding = UDim.new(0, 8)

        if not actT then
            actT = t
            t.Visible = true
            b.TextColor3 = Color3.new(1, 1, 1)
        end

        b.MouseButton1Click:Connect(function()
            if actT then
                actT.Visible = false
                for _, v in pairs(sidebar:GetChildren()) do
                    if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(140, 130, 170) end
                end
            end
            actT = t
            t.Visible = true
            b.TextColor3 = Color3.new(1, 1, 1)
        end)

        local E = {}
        function E:Section(txt)
            local l = Instance.new("TextLabel", t)
            l.Size = UDim2.new(1, 0, 0, 30)
            l.BackgroundTransparency = 1
            l.Text = "↪ [ " .. txt .. " ] ↩"
            l.TextColor3 = Color3.fromRGB(120, 110, 200)
            l.Font = Enum.Font.GothamBold
            l.TextSize = 13
        end

        function E:AddToggle(txt, def, cb)
            local s = def
            local btn = Instance.new("TextButton", t)
            btn.Size = UDim2.new(1, -10, 0, 38)
            btn.BackgroundColor3 = Color3.fromRGB(22, 20, 35)
            btn.Text = "  " .. txt .. ": " .. (s and "ON" or "OFF")
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                s = not s
                btn.Text = "  " .. txt .. ": " .. (s and "ON" or "OFF")
                cb(s)
            end)
        end

        function E:AddDropdown(icon, txt, list, cb)
            local d = Instance.new("Frame", t)
            d.Size = UDim2.new(1, -10, 0, 38)
            d.BackgroundColor3 = Color3.fromRGB(22, 20, 35)
            Instance.new("UICorner", d)
            local btn = Instance.new("TextButton", d)
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = "  " .. icon .. "  " .. txt .. "                                        v"
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextXAlignment = Enum.TextXAlignment.Left
            local scroll = Instance.new("Frame", t)
            scroll.Size = UDim2.new(1, -10, 0, 0)
            scroll.Visible = false
            scroll.AutomaticSize = Enum.AutomaticSize.Y
            scroll.BackgroundColor3 = Color3.fromRGB(15, 13, 25)
            Instance.new("UIListLayout", scroll)
            Instance.new("UICorner", scroll)
            btn.MouseButton1Click:Connect(function() scroll.Visible = not scroll.Visible end)
            for _, v in pairs(list) do
                local o = Instance.new("TextButton", scroll)
                o.Size = UDim2.new(1, 0, 0, 30)
                o.Text = v
                o.BackgroundColor3 = Color3.fromRGB(30, 28, 45)
                o.TextColor3 = Color3.new(0.8, 0.8, 0.8)
                Instance.new("UICorner", o)
                o.MouseButton1Click:Connect(function()
                    btn.Text = "  " .. icon .. "  " .. v .. "                                        v"
                    scroll.Visible = false
                    cb(v)
                end)
            end
        end

        function E:AddButton(txt, cb)
            local btn = Instance.new("TextButton", t)
            btn.Size = UDim2.new(1, -10, 0, 38)
            btn.BackgroundColor3 = Color3.fromRGB(22, 20, 35)
            btn.Text = "  " .. txt
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(cb)
        end

        return E
    end

    function API:Notify(msg)
        local n = Instance.new("TextLabel", sg)
        n.Size = UDim2.new(0, 220, 0, 40)
        n.Position = UDim2.new(1, 10, 1, -60)
        n.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        n.TextColor3, n.Text = Color3.new(1,1,1), msg
        Instance.new("UICorner", n)
        Instance.new("UIStroke", n).Color = Color3.fromRGB(80, 80, 160)
        TS:Create(n, TweenInfo.new(0.4), {Position = UDim2.new(1, -230, 1, -60)}):Play()
        task.delay(3, function()
            TS:Create(n, TweenInfo.new(0.4), {Position = UDim2.new(1, 10, 1, -60)}):Play()
            task.wait(0.4) n:Destroy()
        end)
    end

    return API
end

return Library
