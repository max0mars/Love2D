--require('entity')

--[[
    - Spawn outside factory with a set y value
    - move diagnal until at y value then move horizontal
    - check for enemies in range, then stop and shoot
    - once reach a certain x value, get destroyed
]]

defensebot = {
    yvalue = love.math.random(250, 450)
    ydir = 1
    if(yvalue > 350) then
        ydir = -1
    end
}

function defensebot:new()
    o = {}
    setmetatable(o, self)
    self.__index = entity:new()
end

function defensebot:update(dt, dbots)
    if(abs(self.y - self.yvalue) > 3) then
        self.y = self.y + self.speed*dt*ydir
    end
    self.x = self.x + self.speed*dt
    if(self.x > 810) then
        table.remove(self)

end