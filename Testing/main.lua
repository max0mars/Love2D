function love.load()
    test_table = {}
    test_object = {}
    function test_object:new(v)
        o = {}
        setmetatable(o, self)
        self.__index = self
        o.value = v
        o.delete = 0
        return o
    end
    for i = 1, 10 do
        table.insert(test_table, test_object:new(i))
    end
end


function love.update(dt)
    
end


function love.draw()
    for i in ipairs(test_table) do
        love.graphics.print(test_table[i].value, 50, 50*i)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    elseif key == "1" then
        for i = 10, 1, -1 do
            if(i % 2 == 0) then table.remove(test_table, i)end
        end
    elseif key == "2" then
        for i = 1, #test_table do
            if i%2 == 0 then test_table[i].delete = 1 end
        end
        delete(test_table)
    end

end


function delete(t)
    local j = 1
    n = #t
    for i = 1, n do
        if t[i].delete == 1 then
            t[i] = nil --delete an item
        else
            if (i ~= j) then
                t[j] = t[i]
                t[i] = nil
            end
            j = j + 1
        end
    end
end