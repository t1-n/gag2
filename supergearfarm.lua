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
   Name = "SuperGearFarmer",
   LoadingTitle = "SuperGearFarmer",
   LoadingSubtitle = "by mark",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local Tab = Window:CreateTab("Autoclicker", 4483362458)

local function click(x, y)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
    task.wait(0.02) -- Increased slightly to let the engine register down-press
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
end

local function spamClick(x, y)
    -- Reduced total clicks to 5 and increased wait time to 0.05s to prevent remote spam kicks
    for i = 1, 5 do
        if not getgenv().AutoClicking then break end
        click(x, y)
        task.wait(0.05) 
    end
end

local Toggle = Tab:CreateToggle({
   Name = "enable supergear farmer v67",
   CurrentValue = false,
   Flag = "AutoClickerToggle",
   Callback = function(Value)
      getgenv().AutoClicking = Value
      
      if Value then
         task.spawn(function()
            while getgenv().AutoClicking do
               -- SWC Item
               click(coords.swcSelect.x, coords.swcSelect.y)
               task.wait(0.2) -- Increased to let UI animation settle

               spamClick(coords.swcBuy.x, coords.swcBuy.y)
               task.wait(0.2)

               click(coords.swcSelect.x, coords.swcSelect.y)
               task.wait(getgenv().CycleDelay)
               
               if not getgenv().AutoClicking then break end

               -- SS Item
               click(coords.ssSelect.x, coords.ssSelect.y)
               task.wait(0.2)
               
               spamClick(coords.ssBuy.x, coords.ssBuy.y)
               task.wait(0.2)
               
               click(coords.ssSelect.x, coords.ssSelect.y)
               task.wait(getgenv().CycleDelay)
            end
         end)
      end
   end,
})

local Slider = Tab:CreateSlider({
   Name = "cycle cooldown length (seconds)",
   Range = {0.3, 2}, -- Raised minimum range from 0.1 to 0.3 for network stability
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
