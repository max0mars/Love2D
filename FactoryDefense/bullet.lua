bullet = {}
bullet.__index = bullet

function bullet:new(startspot, tar, damage, bspeed)
    local b = {
        target = tar,
        damage = damage,
        x = startspot.x,
        y = startspot.y,
        speed = bspeed,
        delete = false
    }
    setmetatable(b, bullet)
    return b
end

function bullet:update(dt)
    if self.delete then return end

    local direction_x = self.target.x - self.x
    local direction_y = self.target.y - self.y
    local distance = math.sqrt(direction_x * direction_x + direction_y * direction_y)

    if distance < self.speed * dt then
        self.x = self.target.x
        self.y = self.target.y
        self:hitTarget()
    else
        self.x = self.x + (direction_x / distance) * self.speed * dt
        self.y = self.y + (direction_y / distance) * self.speed * dt
    end
end

function bullet:draw()
    if self.delete then return end
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle('fill', self.x, self.y, 1)
end

function bullet:hitTarget()
    if self.target.takeDamage ~= nil then
        self.target:takeDamage(self.damage)
    end
    self.delete = true
end

function abs(val)
    if val < 0 then return -val end
    return val
end