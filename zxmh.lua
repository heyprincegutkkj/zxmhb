-- Carregar biblioteca NoHyper
local success, NoHyper = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/3345-c-a-t-s-u-s/NoHyperLib/main/source.dll'))()
end)

if not success then
    warn("Falha ao carregar a biblioteca NoHyper:", NoHyper)
    return
end

-- Configurar tema
NoHyper.set_theme('nohyper')

-- Criar janela principal
local Window = NoHyper.new('ZxMHub', "https://media.discordapp.net/attachments/1253830400212729966/1256252330677112862/image.png?ex=668017a7&is=667ec627&hm=57727be3597d96b6cdbb0c9381d36161c3d7f19e97d5fe62493bbeb00ac95ae5&=&format=webp&quality=lossless&width=358&height=112", 'Welcome!')

-- Adicionar links
Window:AddYoutube('https://www.youtube.com/l')
Window:AddWebsite('https://heyprincegut.discloud.app')
Window:AddDiscord('https://discord.gg/PZ9mHQgQ')

-- Criar abas
local General = Window:NewTab('General', 'earth')
local Setting = Window:NewTab('Setting', 'list')

-- Seções na aba General
local Example = General:NewSection('Example', 'positon', 'left')
local RightSection = General:NewSection('Section', 'ads', 'right')

-- Adicionar botões e outros elementos na seção Example
Example:AddButton('Example', function()
    print('click!')
end)

Example:AddToggle('Toggle', false, function(value)
    print('click!', value)
end)

Example:AddKeybind('Keybind', Enum.KeyCode.E, function(value)
    print('bind!', value)
end)

Example:AddSlider('Keybind', {Min = 0, Max = 100, Default = 50, ValueT = '%'}, function(value)
    print('number is', value)
end)

Example:AddDropdown('Dropdown', {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, 5, function(value)
    print('select', value)
end)

-- Adicionar toggles na seção RightSection
RightSection:AddToggle('Aimbot', false, function(value)
    print('Aimbot:', value)
    if value then
        EnableAimbot()
    else
        DisableAimbot()
    end
end)

RightSection:AddToggle('Esp', false, function(value)
    print('ESP:', value)
    if value then
        EnableESP()
    else
        DisableESP()
    end
end)

RightSection:AddToggle('XRay', false, function(value)
    print('XRay:', value)
    if value then
        EnableXRay()
    else
        DisableXRay()
    end
end)

-- Funções para habilitar e desabilitar ESP
function EnableESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESPHighlight"
            highlight.Adornee = player.Character
            highlight.Parent = player.Character
        end
    end
    game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESPHighlight"
            highlight.Adornee = character
            highlight.Parent = character
        end)
    end)
    print("ESP habilitado.")
end

function DisableESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("ESPHighlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
    print("ESP desabilitado.")
end

-- Funções para habilitar e desabilitar XRay
function EnableXRay()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = part.Transparency
            part.Transparency = 0.5
        end
    end
    print("XRay habilitado.")
end

function DisableXRay()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.LocalTransparencyModifier then
            part.Transparency = part.LocalTransparencyModifier
            part.LocalTransparencyModifier = nil
        end
    end
    print("XRay desabilitado.")
end

-- Funções para habilitar e desabilitar Aimbot
function EnableAimbot()
    local camera = workspace.CurrentCamera
    local aimAt = nil

    game:GetService("RunService").RenderStepped:Connect(function()
        if aimAt then
            camera.CFrame = CFrame.new(camera.CFrame.Position, aimAt.Position)
        end
    end)

    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
        if input.UserInputType == Enum.UserInputType.MouseButton2 and not gameProcessedEvent then
            local mouse = player:GetMouse()
            local target = mouse.Target
            if target and target.Parent:FindFirstChild("Humanoid") then
                aimAt = target
            end
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input, gameProcessedEvent)
        if input.UserInputType == Enum.UserInputType.MouseButton2 and not gameProcessedEvent then
            aimAt = nil
        end
    end)

    print("Aimbot habilitado.")
end

function DisableAimbot()
   
    aimAt = nil
    print("Aimbot desabilitado.")
end

print("Script carregado com sucesso.")
