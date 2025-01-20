enemybot = {}

function enemybot:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.x = 800

    o.delete = false
    o.y = love.math.random(200, 500)
    if(o.y < 300) then o.y = o.y + 50
    elseif o.y > 400 then o.y = o.y - 50 end
    o.speed = 50
    o.color = {
        r = 200,
        g = 20,
        b = 20
    }
    o.radius = 4

    return o
end

function enemybot:update(dt)
    self.x = self.x - self.speed*dt
    if(self.x > 400) then
        self.delete = true
    end
end

function enemybot:draw()
    love.graphics.setColor(love.math.colorFromBytes(self.color.r, self.color.g, self.color.b))
    love.graphics.circle('line', self.x, self.y, self.radius)
end