require('building')
require('entity')
require('minebot')

function love.load()
    love.window.setTitle('Factory Defense')
    love.window.setMode(800, 600)

    mine = building:new(20, 200, 30, 30)

    factory = building:new(100, 300, 50, 50)
    factory.metal = 0

    minebot = minebot:new(mine, factory)
end

function love.update(dt)
    minebot:update(dt)
end

function love.draw()
    love.graphics.setColor(0,1,0, 1)
    mine:draw()
    factory:draw()
    love.graphics.setColor(1,0,0, 1)
    minebot:draw()

end