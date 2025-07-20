


# Compact Library

This documentation is for the stable release of CompactUI Library, a modular Roblox GUI framework with tabs, togges and even Buttons

---

## Booting the Library

```lua
local CompactGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/AzxerMan000/Smuggle-Gui-libary-/refs/heads/main/TheGui.lua"))()
```

## Creating GUI

this is the main thing so you stick this thing to your usage script.

```lua

local gui = CompactGui.new("My GUI", {

```

## key system
 this is the future i guess

```lua
    useKeySystem = true,  -- set false if you don't want the key system
    correctKey = "yourkey123", -- change to your key
    keyLink = "https://your-get-key-link.com" -- change to your URL
})

```

## Creating the TAB

this is the tab if you dont have one you cant load toggles or Button.

```lua
--Wait until the GUI is created (after correct key entered)
task.wait(9)
 

    -- Now it's safe to add tabs
    local mainTab = gui:AddTab("example")

--if you wanna add another tab you have to change the local main tab to your wish name for example local yournameTab = gui:AddTab("your wished name")
    

```

## Adding button To Your tab.


adding buttons is main thing so its highly Recommended.


```lua

mainTab:AddButton("example", function(state)
    print("example pressed.:",state)
end)

```

## toggle buttons 

this is optional so you can add or not add

```lua

mainTab:AddToggle("example", function(state)
    print("example toggled.:", state)
-- put your script here or what ever print you wanna add
end)

```

## thats all what are you lookin dude?
