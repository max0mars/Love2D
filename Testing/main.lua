parent = {}
function parent:new(o)
    local o = o or {}
    setmetatable(o, self)
    self.__index = self;
    return o
end
parent.yell = function()
    print("I am the parent")
end


child = parent:new()

function child:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self;
    return o
end


billy = child:new({age = 10})
billy.yell = function(self)
    print("I am "..self.age.." years old")
end

billy:yell()
billy:parent:yell()