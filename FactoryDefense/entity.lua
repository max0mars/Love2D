entity = {}

function entity.new(self, color)
    o = {}
    setmetatable(o, self)
    self.__index = self

    o.x = 0
    o.y = 0
    o.target = nil
    o.alive = true
    o.color = {
        r = 20,
        g = 200,
        b = 20
    }

    --stats
    o.speed = 5
    o.health = 100
    o.range = 15
    o.damage = 25
    o.attackspeed = 1

    --other
    
    return o
end

function entity.clone(self, ent)
    ent = {}
    for k, v in pairs(self) do
          ent[k] = v
    end
    setmetatable(ent, self)
    return ent
end