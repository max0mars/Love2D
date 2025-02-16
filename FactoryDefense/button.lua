button = {}
button.__index = button

function button:new(x, y, width, height, text, cost, callback)
    local b = {
        x = x,
        y = y,
        width = width,
        height = height,
        text = text,
        callback = callback,
        progress = 0,
        progressMax = 100,
        cost = cost
    }
    setmetatable(b, button)
    return b
end

function button:test()
    print('test')
end

function button:draw()
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.text, self.x, self.y + 10, self.width, "center")
    love.graphics.printf(self.cost, self.x, self.y + 25, self.width, "center")

    local progressWidth = (self.progress / self.progressMax) * self.width
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', self.x, self.y + self.height + 5, progressWidth, 10)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('line', self.x, self.y + self.height + 5, self.width, 10)
end

function button:isClicked(x, y, metal)
    if x > self.x and x < self.x + self.width and y > self.y and y < self.y + self.height then
        return true
    end
    return false
end

function button:click(x, y, metal)
    if self:isClicked(x, y) and self.callback then
        if metal >= self.cost and self:isClicked(x, y) and self.callback then
            self.callback()
            metal = metal - self.cost
        end
    end
    return metal
end

function button:updateProgress(amount)
    self.progress = math.min(self.progress + amount, self.progressMax)
end