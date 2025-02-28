require('building')
require('entity')
require('minebot')
require('factory')
require('defensebot')
require('enemybot')
require('bullet')
require('button')
--io.stdout:setvbuf("no") May or may not be needed for print statements

function love.load()
    love.window.setTitle('Factory Defense')
    love.window.setMode(800, 600)

    mine = building:new(20, 200, 30, 30, {r = 139, g = 69, b = 19}, 'm')

    factory = factory:new(100, 300, 50, 100)

    minebots = {}
    table.insert(minebots, minebot:new(mine, factory))

    bullets = {}

    defensebots = {}

    enemybots = {}

    buttons = {}

    spawnrate = 0.1
    waverate = 15
    holdrate = 0.1
    wavecount = 1
    spawnsremaining = 2
    counter = spawnrate
    counter2 = waverate
    counter3 = holdrate

    table.insert(minebots, m1)

    table.insert(buttons, button:new(350, 550, 100, 50, 'DefenseBot', 10, function() 
            table.insert(defensebots, defensebot:new(bullets))
        end)
    )

    table.insert(buttons, button:new(150, 550, 100, 50, 'MineBot', 250, function() 
        table.insert(minebots, minebot:new(mine, factory))
    end)
)

end

function love.update(dt)
    for i in ipairs(enemybots) do
        enemybots[i]:update(dt, defensebots, factory)
    end
    for i in ipairs(defensebots) do
        defensebots[i]:update(dt, enemybots)
    end
    for i in ipairs(minebots) do
        minebots[i]:update(dt)
    end
    for i in ipairs(bullets) do
        bullets[i]:update(dt)
    end
    waveupdate(dt)
    keydown(dt) -- keyboard input for holding down a button
    CleanTable(defensebots)
    CleanTable(enemybots)
    CleanTable(bullets)
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
    for i in ipairs(bullets) do
        bullets[i]:draw()
    end
    for i in ipairs(buttons) do
        buttons[i]:draw()
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
    elseif key == "9" then
        for i = 1, 10 do
            table.insert(defensebots, defensebot:new(bullets))
            table.insert(enemybots, enemybot:new(bullets))
        end
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then -- Left mouse button
        for i in ipairs(buttons) do
            factory.metal = buttons[i]:click(x, y, factory.metal)
        end
    end
end

function waveupdate(dt)
    counter2 = counter2 - dt
    if(counter2 < 0) then
        print("wave " .. wavecount)
        spawnsremaining = wavecount * wavecount * 0.5
        wavecount = wavecount + 1
        counter2 = waverate
    end

    counter = counter - dt
        if(counter < 0 and spawnsremaining > 0) then
            table.insert(enemybots, enemybot:new(bullets))
            spawnsremaining = spawnsremaining - 1
            counter = spawnrate
        end
end

function keydown(dt)
    if love.keyboard.isDown('1') then
        counter = counter - dt
        if(counter < 0) then
            table.insert(defensebots, defensebot:new(bullets))
            counter = spawnrate
        end
    end


    if love.keyboard.isDown('2') then
        counter2 = counter2 - dt
        if(counter2 < 0) then
            table.insert(enemybots, enemybot:new(bullets))
            counter2 = spawnrate
        end
    end

    if love.mouse.isDown(1) then
        counter3 = counter3 - dt
        if(counter3 < 0) then
            for i in ipairs(buttons) do
                local x, y = love.mouse.getPosition()
                factory.metal = buttons[i]:click(x, y, factory.metal)
            end
            counter3 = holdrate
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