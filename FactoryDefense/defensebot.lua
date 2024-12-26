--require('entity')

defensebot = {}

function defensebot:new()
    o = {}
    setmetatable(o, self)
    self.__index = entity:new()
end

function defensebot:update(dt)
    self.x = self.x + self.speed*dt
end

function defensebot:draw()

end