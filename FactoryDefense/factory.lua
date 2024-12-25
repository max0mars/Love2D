factory = {
    metal = 0
}

function factory.new(self, x, y, w, h)
    o = {}
    setmetatable(o, self)
    self.__index = self

    o.x = x
    o.y = y
    o.w = w
    o.h = h
    return o
end

function factory.draw(self)
    love.graphics.rectangle("fill", self.x, self.y, self.w,self.h)
    love.graphics.print(self.metal, 50, 50)
end