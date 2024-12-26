require('building')
require('entity')
require('minebot')
require('factory')
require('defensebot')

function love.load()
    love.window.setTitle('Factory Defense')
    love.window.setMode(800, 600)

    mine = building:new(20, 200, 30, 30, {r = 139, g = 69, b = 19}, 'm')

    factory = factory:new(100, 300, 50, 50)

    minebots = {}
    m1 = minebot:new(mine, factory)

    test = defensebot:new()

    table.insert(minebots, m1)
end

function love.update(dt)
    for i in ipairs(minebots) do
        minebots[i]:update(dt)
    end
end

function love.draw()
    mine:draw()
    factory:draw()
    for i in ipairs(minebots) do
        minebots[i]:draw()
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    elseif key == "space" then
        table.insert(minebots, minebot:new(mine, factory))
    end
 end