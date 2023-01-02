local pearse = {}

local random = math.random
local floor = math.floor

local function permute(x, table) return table[x % 256] end

local function lerp(a,b,t) return a + t * (b - a) end

local function dot_product(ix,iy, x,y, permutate_table)
	local dx = x - ix
	local dy = y - iy
	local gx = (permute(ix + permute(iy, permutate_table), permutate_table) % 4) - 1
	local gy = (permute(iy + permute(ix, permutate_table), permutate_table) % 4) - 1
	
	return dx * gx + dy * gy
end

function pearse.new()
	local self = setmetatable({}, {__index = pearse})
	self.permutation = {}
	self:update_permutation()
	
	return self
end

function pearse:permute(x) return permute(x, self.permutation) end

function pearse:update_permutation()
	for i = 0, 255 do
    self.permutation[i] = i
	end
	for i = 0, 255 do
    local j = random(i, 255)
    self.permutation[i], self.permutation[j] = self.permutation[j], self.permutation[i]
	end
	
	return self.permutation
end

function pearse:noise(x,y)
	local x0 = floor(x)
	local y0 = floor(y)
	local x1 = x0 + 1
	local y1 = y0 + 1
	
	local sx = x - x0
	local sy = y - y0
	
	local n0 = dot_product(x0, y0, x, y)
  local n1 = dot_product(x1, y0, x, y)
  local ix0 = lerp(n0, n1, sx)
  local n2 = dot_product(x0, y1, x, y)
  local n3 = dot_product(x1, y1, x, y)
  local ix1 = lerp(n2, n3, sx)
  return lerp(ix0, ix1, sy)
end

return pearse
