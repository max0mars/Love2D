

function love.load()
    player = {}
    player.x = 200
    player.y = 200
    player.radius = 5
    player.speed = 5
    player.turningspeed = 5
    player.dir = 0
    print ("Okay!")
    pos = {}
end

function love.update(dt)
    look = lookAngle(player, love.mouse.getX(), love.mouse.getY())
    --love.graphics.print(look, 400, 400)
end

function love.draw()
    love.graphics.circle('fill', player.x, player.y, player.radius)
    --love.graphics.setColor(0, 1, 0, 1)
    
    love.graphics.print(look, 300, 300)
    love.graphics.print(pos.x .. ", " .. pos.y, 300, 350)

end

function follow()
    local x,y = love.mouse.getX(), love.mouse.getY()
    local diff = {['x'] = x - player.x, ['y'] = y - player.y}
    normalize(diff)
    player.x = player.x + diff.x * player.speed
    player.y = player.y + diff.y * player.speed
end

function normalize(vec)
    local mag = math.sqrt(vec.x^2 + vec.y ^ 2)
    vec.x = vec.x / mag
    vec.y = vec.y / mag
end

function lookAngle(self, x, y)
    local diff = {['x'] = x - player.x, ['y'] = y - player.y}
    pos = diff
    
    -- if(diff.x == 0) then
    --     if diff.y > 0 then
    --         return 0 
    --     else
    --         return math.pi
    --     end
    -- end
    -- if(diff.y == 0) then
    --     if diff.x > 0 then
    --         return math.pi / 2
    --     else
    --         return math.pi * 3 / 2
    --     end
    -- end
    angle = math.atan(diff.x / diff.y)
    if diff.y < 0 then
        angle = math.pi + angle
    else
        if diff.x < 0 then
            angle = 2 * math.pi + angle
        end
    end
    
    return angle
end