-- Load the Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local coords = {
    swcSelect = {x = 913, y = 508},
    swcBuy    = {x = 917, y = 631},
    ssSelect  = {x = 915, y = 745},
    ssBuy     = {x = 921, y = 843}
}


getgenv().AutoClicking = false
getgenv().CycleDelay = 0.5  


local Window = Rayfield:CreateWindow({
   Name = "Dheena Smells Like Shit",
   LoadingTitle = "SuperGearFarmer",
   LoadingSubtitle = "by mark",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local Tab = Window:CreateTab("Autoclicker", 4483362458)


local function click(x, y)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
    task.wait(0.01)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
end


local function spamClick(x, y)

    for i = 1, 10 do
        if not getgenv().AutoClicking then break end
        click(x, y)
        task.wait(0.02) 
    end
end


local Toggle = Tab:CreateToggle({
   Name = "Enable Auto-Buyer Loop",
   CurrentValue = false,
   Flag = "AutoClickerToggle",
   Callback = function(Value)
      getgenv().AutoClicking = Value
      
      if Value then
         task.spawn(function()
            while getgenv().AutoClicking do
               

               click(coords.swcSelect.x, coords.swcSelect.y)
               task.wait(0.1)

               spamClick(coords.swcBuy.x, coords.swcBuy.y)
               task.wait(0.1)

               click(coords.swcSelect.x, coords.swcSelect.y)
               task.wait(getgenv().CycleDelay)
               
               if not getgenv().AutoClicking then break end


               click(coords.ssSelect.x, coords.ssSelect.y)
               task.wait(0.1)
               

               spamClick(coords.ssBuy.x, coords.ssBuy.y)
               task.wait(0.1)
               

               click(coords.ssSelect.x, coords.ssSelect.y)
               task.wait(getgenv().CycleDelay)
               
            end
         end)
      end
   end,
})


local Slider = Tab:CreateSlider({
   Name = "Cycle Cooldown (Seconds)",
   Range = {0.1, 2},
   Increment = 0.05,
   Suffix = "s",
   CurrentValue = 0.5,
   Flag = "ClickDelaySlider",
   Callback = function(Value)
      getgenv().CycleDelay = Value
   end,
})


LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CodedFrame)
    task.wait(0.5)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CodedFrame)
end)
