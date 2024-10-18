--[[ by mada

Mada admin v1 ]]

local admin = loadstring(game:HttpGet("https://pastebin.com/raw/WPq8Cx9f"))():create({
    ["name"] = "Mada admin"; 
    ["prefix"] = ";"; -- prefix!!! 
    ["key"] = Enum.KeyCode.Semicolon; -- key code for the prefix!!! (https://create.roblox.com/docs/reference/engine/enums/KeyCode)
})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Command to teleport the administrator to a player
admin:addcmd({"view"}, function(targetUser)
    local targetPlayer = game:GetService("Players"):FindFirstChild(targetUser)
    if targetPlayer and targetPlayer.Character then
        local camera = workspace.CurrentCamera
        camera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid")
        camera.CFrame = targetPlayer.Character.PrimaryPart.CFrame
        admin:system("You are now viewing " .. targetPlayer.DisplayName)
    else
        admin:system("User not found: " .. targetUser)
    end
end)

-- Command to change the administrator's gravity
admin:addcmd({"gravity"}, function(value)
    local gravity = tonumber(value) or 196.2 -- default value
    workspace.Gravity = gravity
    admin:system("Gravity has been changed to " .. gravity .. ".")
end)

-- Command to make the administrator invisible
admin:addcmd({"invisible"}, function()
    character.HumanoidRootPart.Transparency = 1
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end
    admin:system("You are now invisible.")
end)

-- Command to make the administrator visible
admin:addcmd({"visible"}, function()
    character.HumanoidRootPart.Transparency = 0
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = 0
        end
    end
    admin:system("You are now visible.")
end)

-- Command to run a script from a URL
admin:addcmd({"run"}, function(url)
    if url and url:match("^https?://") then
        local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if success then
            admin:system("The script was executed successfully.")
        else
            admin:system("Error executing the script: " .. err)
        end
    else
        admin:system("Please provide a valid URL.")
    end
end)

-- Command to enable flight
admin:addcmd({"fly"}, function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Jfdedit3/Jfdedit3/refs/heads/main/Fly%20script%20by%20chatgpt"))()
    end)
    if success then
        admin:system("The flight script was executed successfully.")
    else
        admin:system("Error executing the flight script: " .. err)
    end
end)

-- Command to change the administrator's walking speed
admin:addcmd({"speed", "ws", "walkspeed"}, function(value)
    local speed = tonumber(value) or 16 -- default speed
    humanoid.WalkSpeed = speed
    admin:system("Your walking speed has been changed to " .. speed .. ".")
end)

-- Command to rejoin the game
admin:addcmd({"rj", "rejoin"}, function()
    local success, err = pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
    end)
    if success then
        admin:system("Rejoining the game...")
    else
        admin:system("Error attempting to rejoin the game: " .. err)
    end
end)

-- Command to exit the game
admin:addcmd({"exit", "ex"}, function()
    admin:system("You are exiting the game.")
    game:Shutdown()
end)

-- Notifications of available commands
local function notifyCommands()
    local commands = {
        ";exit - Exits the game.",
        ";fly - Enables flight for the administrator (PC only, press E to activate flight).",
        ";gravity <value> - Changes gravity for the administrator.",
        ";invisible - Makes the administrator invisible.",
        ";run <url> - Executes a script from the provided URL.",
        ";say <message> - Displays a message in the chat.",
        ";speed <value> or ;ws <value> or ;walkspeed <value> - Changes the administrator's walking speed.",
        ";view <user> - Spec a specified player.",
        ";visible - Makes the administrator visible."
    }

    for _, command in ipairs(commands) do
        admin:system(command)
    end
end

-- Call the function to notify the available commands
notifyCommands()
