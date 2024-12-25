minebot = {
    x = 500,
    y = 100,
    radius = 3,
    speed = 0.6,
    carryspeed = 0.2,
    minerate = 50,
    capacity = 100,
    metalcount = 0,
    state = 0, -- 0 = walking to mine, 1 = mining, 2 = delivering metal
    visible = true,
    carrying = false,
    color = {
        r = 20,
        g = 200,
        b = 20
    }
}

function minebot:new(mine, factory)--mx, my, fx, fy)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.mine = mine
    o.factory = factory

    o.mine_x = mine.x + mine.w / 2
    o.mine_y = mine.y + mine.h

    o.fact_x = factory.x
    o.fact_y = factory.y + factory.h/2

    self.x = o.fact_x
    self.y = o.fact_y

    o.mineDirection = {
        x = o.mine_x - o.fact_x,
        y = o.mine_y - o.fact_y
    }

    o.factoryDirection = {
        x = o.fact_x - o.mine_x,
        y = o.fact_y - o.mine_y
    }

    return o
end

function minebot:draw()

    if(not self.visible) then return end
    love.graphics.setColor(love.math.colorFromBytes(self.color.r, self.color.g, self.color.b))
    love.graphics.circle('line', self.x, self.y, self.radius)
    if(self.carrying) then
        love.graphics.setColor(.5, .5, .5)
        love.graphics.circle('fill', self.x, self.y, self.radius - 1)
    end
end

function minebot:update(dt)
    if(self.state == 0) then--STATE 0
        if(self.x <= self.mine_x and self.y <= self.mine_y) then
        --if(self.x <= self.mine_x and self.y <= self.mine_y) then
            self.state = 1
            return
        else
            self.x = self.x + self.mineDirection.x * self.speed * dt
            self.y = self.y + self.mineDirection.y * self.speed * dt
        end


    elseif(self.state == 1) then --STATE 1
        self.visible = false
        self.metalcount = self.metalcount + self.minerate * dt
        
        if(self.metalcount >= self.capacity) then 
            self.metalcount = self.capacity
            self.state = 2 
            self.visible = true
            self.metalcount = 0
            self.carrying = true
        end


    elseif(self.state == 2) then --STATE 2
        if(self.x >= self.fact_x and self.y >= self.fact_y) then
            self.state = 0
            self.carrying = false
            factory.metal = factory.metal + self.capacity
            return
        else
            self.x = self.x + self.factoryDirection.x * self.carryspeed * dt
            self.y = self.y + self.factoryDirection.y * self.carryspeed * dt
        end
    end
end