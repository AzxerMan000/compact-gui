# compact-gui


# compact gui is a compact design gui that is small.


## Booting the libary

```lua

local CompactGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/AzxerMan000/compact-gui/refs/heads/main/Source.lua"))()


```


----

## creating window


```lua

local compactGui = compactGui.new("example gui")

```

------




## creating tabs 


```lua


local tab1 = gui:CreateTab("Tab One")

```


---

## adding buttons

```lua
tab1:AddButton("Example", function()
    print("hello")
end)

```

---


## Adding toggles (optional)


```lua

tab1:AddToggle("Example", function(state)
    print("Toggled:", state)
   -- put your functions here
end)

```
---

## Adding Submit button


```lua

tab1:AddSubmit("example", function(text)
    print("You submitted:", text)
end)
```
