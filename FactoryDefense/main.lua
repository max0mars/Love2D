require('building')
require('entity')
require('minebot')
require('factory')
require('defensebot')
require('enemybot')

function love.load()
    love.window.setTitle('Factory Defense')
    love.window.setMode(800, 600)

    mine = building:new(20, 200, 30, 30, {r = 139, g = 69, b = 19}, 'm')

    factory = factory:new(100, 300, 50, 100)

    minebots = {}
    m1 = minebot:new(mine, factory)

    defensebots = {}

    enemybots = {}

    spawnrate = 0.1
    counter = spawnrate
    counter2 = spawnrate

    table.insert(minebots, m1)
end

function love.update(dt)
    for i in ipairs(enemybots) do
        enemybots[i]:update(dt)
    end
    for i in ipairs(defensebots) do
        defensebots[i]:update(dt, enemybots)
    end
    for i in ipairs(minebots) do
        minebots[i]:update(dt)
    end
    

    keydown(dt) -- keyboard input for holding down a button
    -- CleanTable(defensebots)
    -- CleanTable(enemybots)
end

function love.draw()
    mine:draw()
    factory:draw()
    for i in ipairs(enemybots) do
        enemybots[i]:draw()
    end
    for i in ipairs(defensebots) do
        defensebots[i]:draw()
    end
    for i in ipairs(minebots) do
        minebots[i]:draw()
    end
    love.graphics.setColor(0,1,0)
    love.graphics.line(0, 200, 800, 200)
    love.graphics.line(0, 500, 800, 500)

end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    elseif key == "space" then
        table.insert(minebots, minebot:new(mine, factory))
    elseif key == "u" then
        m1:upgrade('capacity', 50)
    end
end

function keydown(dt)
    if love.keyboard.isDown('1') then
        counter = counter - dt
        if(counter < 0) then
            table.insert(defensebots, defensebot:new())
            counter = spawnrate
        end
    end


    if love.keyboard.isDown('2') then
        counter2 = counter2 - dt
        if(counter2 < 0) then
            table.insert(enemybots, enemybot:new())
            counter2 = spawnrate
        end
    end
end


function CleanTable(t) -- removes any elements marked for deletion
    local j = 1
    n = #t
    for i = 1, n do
        if t[i].delete then
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