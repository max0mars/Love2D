minebot = {
    x = 500,
    y = 100,
    radius = 2,
    speed = 1,
    minetime = 2,
    minecount = 0,
    state = 0, -- 0 = walking to mine, 1 = mining, 2 = delivering metal
    visible = true,
    carrying = false
}

function minebot:new(mine, factory)--mx, my, fx, fy)
    local o = {}
    setmetatable(o, self)
    self.__index = self

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
    love.graphics.circle('line', self.x, self.y, self.radius)
    if(self.carrying) then
        love.graphics.circle('fill', self.x, self.y, self.radius)
    end
end

function minebot:update(dt)
    if(self.state == 0) then
        if(self.x <= self.mine_x and self.y <= self.mine_y) then
            self.state = 1
            return
        else
            self.x = self.x + self.mineDirection.x * self.speed * dt
            self.y = self.y + self.mineDirection.y * self.speed * dt
        end
    elseif(self.state == 1) then
        self.visible = false
        self.minecount = self.minecount + dt
        
        if(self.minecount >= self.minetime) then 
            self.state = 2 
            self.visible = true
            self.minecount = 0
            self.carrying = true
        end
    elseif(self.state == 2) then
        if(self.x >= self.fact_x and self.y >= self.fact_y) then
            self.state = 0
            self.carrying = false
            return
        else
            self.x = self.x + self.factoryDirection.x * self.speed * dt
            self.y = self.y + self.factoryDirection.y * self.speed * dt
        end
    end
end