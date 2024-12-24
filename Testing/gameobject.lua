gameobject = {}

function gameobject.init(self)
    self.x = 0
    self.y = 0
    self.speed = 0
    self.turningspeed = 0
    self.dir = 0
end

function gameobject.clone(self, go)
    self = {}
    for k, v in pairs(go) do
          self[k] = v
    end
    setmetatable(self, go)
end