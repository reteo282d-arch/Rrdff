local Library = {}

function Library:Init(menuTitle)
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local RS = game:GetService("RunService")
    local p = game.Players.LocalPlayer

    local sg = Instance.new("ScreenGui", p.PlayerGui)
    sg.Name = "FexawV3_Final_Mega"
    sg.ResetOnSpawn = false

    local targetHeight, targetWidth = 380, 520

    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0,0,0,0)
    main.Position = UDim2.new(0.5,0,0.5,0)
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.BackgroundColor3 = Color3.fromRGB(15,15,15)
    main.Visible = false
    main.ClipsDescendants = true
    Instance.new("UICorner", main)

    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Thickness = 3

    local side = Instance.new("Frame", main)
    side.Size = UDim2.new(0,160,1,0)
    side.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner", side)

    local ob = Instance.new("Frame", sg)
    ob.Size = UDim2.new(0,350,0,40)
    ob.Position = UDim2.new(0.5,-175,0.2,0)
    ob.BackgroundColor3 = Color3.fromRGB(15,15,15)
    ob.BackgroundTransparency = 0.2
    Instance.new("UICorner", ob)

    local obStroke = Instance.new("UIStroke", ob)
    obStroke.Thickness = 2

    local hue = 0

    RS.RenderStepped:Connect(function()
        hue += 0.0015
        if hue > 1 then
            hue = 0
        end

        local color = Color3.fromHSV(hue,1,1)

        mainStroke.Color = color
        obStroke.Color = color
    end)

    local dragBtn = Instance.new("TextButton", ob)
    dragBtn.Size = UDim2.new(0,60,1,0)
    dragBtn.BackgroundTransparency = 1
    dragBtn.Text = "÷ |"
    dragBtn.TextColor3 = Color3.new(1,1,1)
    dragBtn.TextSize = 22

    local openBtn = Instance.new("TextButton", ob)
    openBtn.Size = UDim2.new(1,-65,1,0)
    openBtn.Position = UDim2.new(0,65,0,0)
    openBtn.BackgroundTransparency = 1
    openBtn.Text = menuTitle or "FEXAW V3"
    openBtn.TextColor3 = Color3.new(1,1,1)
    openBtn.TextXAlignment = Enum.TextXAlignment.Left

    local dragging = false
    local dragStart
    local startPos
    local startPosMain

    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = ob.Position
            startPosMain = main.Position
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart

            ob.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )

            main.Position = UDim2.new(
                startPosMain.X.Scale,
                startPosMain.X.Offset + delta.X,
                startPosMain.Y.Scale,
                startPosMain.Y.Offset + delta.Y
            )
        end
    end)

    openBtn.MouseButton1Click:Connect(function()
        if not main.Visible then
            main.Visible = true

            TS:Create(
                main,
                TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                {Size = UDim2.new(0,targetWidth,0,targetHeight)}
            ):Play()
        else
            local tw = TS:Create(
                main,
                TweenInfo.new(0.25,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
                {Size = UDim2.new(0,0,0,0)}
            )

            tw:Play()

            tw.Completed:Connect(function()
                main.Visible = false
            end)
        end
    end)

    local mP = Instance.new("ScrollingFrame", main)
    mP.Position = UDim2.new(0,170,0,10)
    mP.Size = UDim2.new(1,-180,1,-20)
    mP.BackgroundTransparency = 1
    mP.ScrollBarThickness = 3
    mP.AutomaticCanvasSize = Enum.AutomaticSize.Y
    mP.CanvasSize = UDim2.new()

    local mpl = Instance.new("UIListLayout", mP)
    mpl.Padding = UDim.new(0,5)

    local order = 0

    local API = {}

    function API:Notify(text)
        local n = Instance.new("TextLabel", sg)
        n.Size = UDim2.new(0,250,0,40)
        n.Position = UDim2.new(1,-260,1,0)
        n.BackgroundColor3 = Color3.fromRGB(20,20,20)
        n.TextColor3 = Color3.new(1,1,1)
        n.Text = text
        n.BackgroundTransparency = 0
        n.TextTransparency = 0

        Instance.new("UICorner", n)

        TS:Create(
            n,
            TweenInfo.new(0.3),
            {Position = UDim2.new(1,-260,1,-60)}
        ):Play()

        task.delay(3,function()
            TS:Create(
                n,
                TweenInfo.new(0.4),
                {
                    BackgroundTransparency = 1,
                    TextTransparency = 1
                }
            ):Play()

            task.wait(0.4)

            n:Destroy()
        end)
    end

    function API:AddButton(text, callback)
        local b = Instance.new("TextButton", mP)
        b.Size = UDim2.new(1,-10,0,32)
        b.BackgroundColor3 = Color3.fromRGB(40,40,40)
        b.TextColor3 = Color3.new(1,1,1)
        b.Text = text

        Instance.new("UICorner", b)

        b.MouseButton1Click:Connect(function()
            local ripple = Instance.new("Frame", b)
            ripple.BackgroundColor3 = Color3.new(1,1,1)
            ripple.BackgroundTransparency = 0.7
            ripple.AnchorPoint = Vector2.new(0.5,0.5)
            ripple.Position = UDim2.new(0.5,0,0.5,0)
            ripple.Size = UDim2.new(0,0,0,0)

            Instance.new("UICorner", ripple).CornerRadius = UDim.new(1,0)

            TS:Create(
                ripple,
                TweenInfo.new(0.4),
                {
                    Size = UDim2.new(0,250,0,250),
                    BackgroundTransparency = 1
                }
            ):Play()

            game.Debris:AddItem(ripple,0.4)

            callback()
        end)
    end

    function API:CreateCategory(name)
        local container = Instance.new("Frame", mP)
        container.Size = UDim2.new(1,-10,0,0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundTransparency = 1
        container.Visible = false
        container.LayoutOrder = order

        local cl = Instance.new("UIListLayout", container)
        cl.Padding = UDim.new(0,5)

        local btn = Instance.new("TextButton", mP)
        btn.Size = UDim2.new(1,-10,0,30)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Text = "v "..name.." v"
        btn.LayoutOrder = order
        Instance.new("UICorner", btn)

        order += 1

        btn.MouseButton1Click:Connect(function()
            container.Visible = not container.Visible

            if container.Visible then
                container.LayoutOrder = -1000
                btn.LayoutOrder = -1000
            else
                container.LayoutOrder = order
                btn.LayoutOrder = order
            end

            btn.Text =
                (container.Visible and "^ " or "v ")
                ..name..
                (container.Visible and " ^" or " v")
        end)

        local CatAPI = {}

        function CatAPI:AddButton(text, callback)
            local b = Instance.new("TextButton", container)
            b.Size = UDim2.new(1,0,0,32)
            b.BackgroundColor3 = Color3.fromRGB(40,40,40)
            b.TextColor3 = Color3.new(1,1,1)
            b.Text = text

            Instance.new("UICorner", b)

            b.MouseButton1Click:Connect(callback)
        end

        function CatAPI:AddLabel(text)
            local l = Instance.new("TextLabel", container)
            l.Size = UDim2.new(1,0,0,30)
            l.BackgroundTransparency = 1
            l.TextColor3 = Color3.new(1,1,1)
            l.Text = text
        end

        function CatAPI:AddToggle(text, default, callback)
            local state = default or false

            local t = Instance.new("TextButton", container)
            t.Size = UDim2.new(1,0,0,32)
            t.BackgroundColor3 = Color3.fromRGB(40,40,40)
            t.TextColor3 = Color3.new(1,1,1)

            t.Text = text.." : "..(state and "ON" or "OFF")

            Instance.new("UICorner", t)

            t.MouseButton1Click:Connect(function()
                state = not state

                t.Text = text.." : "..(state and "ON" or "OFF")

                callback(state)
            end)
        end

        function CatAPI:AddTextbox(placeholder, callback)
            local box = Instance.new("TextBox", container)
            box.Size = UDim2.new(1,0,0,32)
            box.BackgroundColor3 = Color3.fromRGB(40,40,40)
            box.PlaceholderText = placeholder
            box.Text = ""
            box.TextColor3 = Color3.new(1,1,1)

            Instance.new("UICorner", box)

            box.FocusLost:Connect(function()
                callback(box.Text)
            end)
        end

        function CatAPI:AddSlider(text,min,max,default,callback)
            local value = default or min

            local frame = Instance.new("Frame", container)
            frame.Size = UDim2.new(1,0,0,45)
            frame.BackgroundTransparency = 1

            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1,0,0,20)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.Text = text.." : "..value

            local bar = Instance.new("Frame", frame)
            bar.Position = UDim2.new(0,0,0,25)
            bar.Size = UDim2.new(1,0,0,12)
            bar.BackgroundColor3 = Color3.fromRGB(30,30,30)

            Instance.new("UICorner", bar)

            local fill = Instance.new("Frame", bar)
            fill.Size = UDim2.new((value-min)/(max-min),0,1,0)
            fill.BackgroundColor3 = Color3.fromRGB(255,255,255)

            Instance.new("UICorner", fill)

            local draggingSlider = false

            bar.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = true
                end
            end)

            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = false
                end
            end)

            UIS.InputChanged:Connect(function(i)
                if draggingSlider and i.UserInputType == Enum.UserInputType.MouseMovement then
                    local percent = math.clamp(
                        (i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
                        0,
                        1
                    )

                    value = math.floor(min + ((max - min) * percent))

                    fill.Size = UDim2.new(percent,0,1,0)

                    label.Text = text.." : "..value

                    callback(value)
                end
            end)
        end

        function CatAPI:AddKeybind(text,key,callback)
            local current = key

            local b = Instance.new("TextButton", container)
            b.Size = UDim2.new(1,0,0,32)
            b.BackgroundColor3 = Color3.fromRGB(40,40,40)
            b.TextColor3 = Color3.new(1,1,1)

            b.Text = text.." : "..current.Name

            Instance.new("UICorner", b)

            b.MouseButton1Click:Connect(function()
                b.Text = text.." : ..."

                local c
                c = UIS.InputBegan:Connect(function(i,gp)
                    if not gp then
                        current = i.KeyCode
                        b.Text = text.." : "..current.Name
                        c:Disconnect()
                    end
                end)
            end)

            UIS.InputBegan:Connect(function(i,gp)
                if not gp and i.KeyCode == current then
                    callback()
                end
            end)
        end

        function CatAPI:CreateSub(subName)
            local subFrame = Instance.new("Frame", container)
            subFrame.Size = UDim2.new(1,0,0,0)
            subFrame.AutomaticSize = Enum.AutomaticSize.Y
            subFrame.BackgroundTransparency = 1

            local sBtn = Instance.new("TextButton", subFrame)
            sBtn.Size = UDim2.new(1,0,0,30)
            sBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            sBtn.TextColor3 = Color3.new(1,1,1)
            sBtn.Text = "[+] "..subName

            Instance.new("UICorner", sBtn)

            local sCon = Instance.new("Frame", subFrame)
            sCon.Position = UDim2.new(0,0,0,35)
            sCon.Size = UDim2.new(1,0,0,0)
            sCon.Visible = false
            sCon.AutomaticSize = Enum.AutomaticSize.Y
            sCon.BackgroundTransparency = 1

            local scl = Instance.new("UIListLayout", sCon)
            scl.Padding = UDim.new(0,5)

            sBtn.MouseButton1Click:Connect(function()
                sCon.Visible = not sCon.Visible

                sBtn.Text =
                    (sCon.Visible and "[-] " or "[+] ")
                    ..subName
            end)

            local SubAPI = {}

            function SubAPI:AddButton(text, callback)
                local b = Instance.new("TextButton", sCon)
                b.Size = UDim2.new(1,0,0,32)
                b.BackgroundColor3 = Color3.fromRGB(55,55,55)
                b.TextColor3 = Color3.new(1,1,1)
                b.Text = text

                Instance.new("UICorner", b)

                b.MouseButton1Click:Connect(callback)
            end

            return SubAPI
        end

        return CatAPI
    end

    return API
end

return Library
