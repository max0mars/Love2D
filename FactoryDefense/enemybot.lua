require ('bullet')
enemybot = {}

function enemybot:new(bullets)
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
    o.target = nil
    o.counter = 0  
    o.bullets = bullets

    --stats
    o.speed = 50
    o.health = 100
    o.range = 100
    o.rangeSq = o.range * o.range
    o.damage = 25
    o.bulletSpeed = 100
    o.attackspeed = 1
    o.distance = 9999

    return o
end

function enemybot:update(dt, defensebots)
    if self.delete then return end
    self.counter = self.counter + dt
    if not self:attack(defensebots) then
        self:move(dt)
    else
        if(self.counter > self.attackspeed) then
            self.counter = 0
            self:shoot()
        end
    end
end

function enemybot:move(dt)
    self.x = self.x - self.speed*dt
    if(self.x < 300) then
        self.delete = true
    end
end

function enemybot:attack(defensebots)
    self.target = nil
    prev = 999
    for i, bot in ipairs(defensebots) do
        x = bot.x - self.x
        y = bot.y - self.y
        dist = x*x + y*y
        if dist < self.rangeSq then
            if(dist < prev) then
                self.target = defensebots[i]
                prev = dist
            end
        end
    end
    if (self.target) then return true 
    else return false end
end

function enemybot:shoot()
    --create bullet
    table.insert(self.bullets, bullet:new({x = self.x, y = self.y}, self.target, self.damage, self.bulletSpeed))
    
end

function enemybot:takeDamage(damage)
    self.health = self.health - damage
    if self.health <= 0 then
        self.delete = true
    end
end

function enemybot:draw()
    love.graphics.setColor(love.math.colorFromBytes(self.color.r, self.color.g, self.color.b))
    love.graphics.circle('line', self.x, self.y, self.radius)
end