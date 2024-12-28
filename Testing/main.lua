function love.load()
test_table = {}

for i = 0, 10 do
    table.insert(test_table, i)
end
end
function love.update(dt)

end
function love.draw()
    for i in ipairs(test_table) do
        love.graphics.print(test_table[i], 50, 50*i)
    end
    
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    elseif key == "1" then
        for i = 0, 10 do
            if(i % 2 == 0) then table.remove(test_table, i)end
        end
    elseif key == "2" then
        for i in ipairs(test_table) do
            if(i % 2 == 0) then table.remove(test_table, i)end
        end
    elseif key == "3" then
        for i in pairs(test_table) do
            if(i % 2 == 0) then table.remove(test_table, i)end
        end
    end

 end