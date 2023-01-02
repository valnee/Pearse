# Pearse
Pretty simple perlin noise for Lua.

# How To Use
Just like this:
```lua
local Pearse = require "Pearse.lua"
local Noise = Pearse.new()

Noise:update_permutation() -- You can randomize it if you want.
Noise:noise(1,1) -- x, y
```
