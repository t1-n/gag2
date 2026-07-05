local Rayfield = loadstring(game:HttpGet('http://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local targetX = 935
local targetY = 566

getgenv().AutoClicking = false
getgenv().ClickDelay = 0.3

local Window = Rayfield:CreateWindow({
   Name = "Guild Event Farmer",
   LoadingTitle = "Keyless Carrot Auto-Farm Guild Event",
   LoadingSubtitle = "by Goat-emini",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

local Tab = Window:CreateTab("Autoclicker", 4483362458)

local Toggle = Tab:CreateToggle({
   Name = "Enable Auto-Clicker",
   CurrentValue = false,
   Flag = "AutoClickerToggle",
   Callback = function(Value)
      getgenv().AutoClicking = Value
      
      if Value then
         task.spawn(function()
            while getgenv().AutoClicking do
               -- Simulate Left Mouse Button Down
               VirtualInputManager:SendMouseButtonEvent(targetX, targetY, 0, true, game, 1)
               task.wait(0.02) -- Minute delay to register holding
               
               VirtualInputManager:SendMouseButtonEvent(targetX, targetY, 0, false, game, 1)
               
               task.wait(getgenv().ClickDelay)
            end
         end)
      end
   end,
})

local Slider = Tab:CreateSlider({
   Name = "Click Cooldown (Seconds)",
   Range = {0.05, 2},
   Increment = 0.05,
   Suffix = "s",
   CurrentValue = 0.3,
   Flag = "ClickDelaySlider",
   Callback = function(Value)
      getgenv().ClickDelay = Value
   end,
})

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CodedFrame)
    task.wait(0.5)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CodedFrame)
end)
