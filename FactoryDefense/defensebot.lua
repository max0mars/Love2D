--require('entity')

--[[
    - Spawn outside factory with a set y value
    - move diagnal until at y value then move horizontal
    - check for enemies in range, then stop and shoot
    - once reach a certain x value, get destroyed
]]

defensebot = {}

function defensebot:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.x = 150
    o.y = 350

    o.delete = false
    o.yvalue = love.math.random(200, 500)
    if(o.yvalue < 300) then o.yvalue = o.yvalue + 50
    elseif o.yvalue > 400 then o.yvalue = o.yvalue - 50 end
    o.ydir = 1
    o.speed = 50
    o.color = {
        r = 20,
        g = 200,
        b = 20
    }
    o.radius = 4
    if(o.yvalue < 350) then
        o.ydir = -1
    end

    return o
end


function defensebot:update(dt) -- error: bot is going out of bounds
    if(abs(self.y - self.yvalue) > 3) then
        self.y = self.y + self.speed*dt*self.ydir
    end
    self.x = self.x + self.speed*dt
    if(self.x > 400) then
        self.delete = true
    end
end

function defensebot:tt()
    self.x = 500
end

function defensebot:draw()
    love.graphics.setColor(love.math.colorFromBytes(self.color.r, self.color.g, self.color.b))
    love.graphics.circle('line', self.x, self.y, self.radius)
end

function abs(val)
    if val < 0 then return -val end
    return val
end