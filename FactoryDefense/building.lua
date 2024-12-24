building = {}

function building.new(self, x, y, w, h)
    o = {}
    setmetatable(o, self)
    self.__index = self

    o.x = x
    o.y = y
    o.w = w
    o.h = h
    return o
end

function building.draw(self)
    love.graphics.rectangle("fill", self.x, self.y, self.w,self.h)

end