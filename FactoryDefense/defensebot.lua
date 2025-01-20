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
        b = 200
    }
    o.radius = 4
    if(o.yvalue < 350) then
        o.ydir = -1
    end
    --stats
    o.speed = 5
    o.health = 100
    o.range = 15
    o.rangeSq = o.range * o.range
    o.damage = 25
    o.attackspeed = 1
    return o
end


function defensebot:update(dt)
    if(not self.attack()) then
        self.move()
    end
end

function move()
    if(abs(self.y - self.yvalue) > 3) then
        self.y = self.y + self.speed*dt*self.ydir
    end
    self.x = self.x + self.speed*dt
    if(self.x > 400) then
        self.delete = true
    end
end


--[[
    checks for targets in range and sets target to closest
    returns true if enemy found, otherwise false
    ** untested! **
]]
function defensebot:attack()
    target = nil
    prev = 999
    for i in ipairs(enemies) do
        x = enemies[i].x - self.x
        y = enemies[i].y - self.y
        dist = x*x + y*y
        if dist < self.rangeSq then
            if(dist < prev) then
                target = enemies[i]
                prev = dist
            end
        end
    end
    if (target) then return true 
    else return false end
    -- check for enemy in range
    -- fire at enemy
end

function defensebot:draw()
    love.graphics.setColor(love.math.colorFromBytes(self.color.r, self.color.g, self.color.b))
    love.graphics.circle('line', self.x, self.y, self.radius)
end

function abs(val)
    if val < 0 then return -val end
    return val
end