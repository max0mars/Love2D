require('building')
require('entity')
require('minebot')
require('factory')

function love.load()
    love.window.setTitle('Factory Defense')
    love.window.setMode(800, 600)

    mine = building:new(20, 200, 30, 30)

    factory = factory:new(100, 300, 50, 50)

    minebots = {}
    m1 = minebot:new(mine, factory)

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
    end
 end