require("gameobject")
player = {}

function love.load()
    player.x = 200
    player.y = 200
    player.radius = 25
    player.speed = 3
    player.turningspeed = 2
    player.dir = 0
end

look = 0
function love.update(dt)
    
    look = player:lookat(love.mouse.getX(), love.mouse.getY(), dt)
    player:move()
end

function love.draw()
    love.graphics.setColor(0,1,0, 1)
    love.graphics.circle('fill', player.x, player.y, player.radius) -- player 
    local nosePosition = vectorfromangle(player.dir, player.radius)
    love.graphics.setColor(1,0,0, 1)
    love.graphics.circle('fill', nosePosition[1] + player.x, nosePosition[2] + player.y, 5) --player nose
    love.graphics.print(gameobject, 300, 300)
end

function follow() -- puts the player right on the mouse
    local x,y = love.mouse.getX(), love.mouse.getY()
    local diff = {['x'] = x - player.x, ['y'] = y - player.y}
    normalize(diff)
    player.x = player.x + diff.x * player.speed
    player.y = player.y + diff.y * player.speed
end

function normalize(vec) -- normalize a 2d vector
    local mag = math.sqrt(vec.x^2 + vec.y ^ 2)
    vec.x = vec.x / mag
    vec.y = vec.y / mag
end

function player.lookAngle(self, x, y) -- finds the angle between the player and a point
    local diff = {['x'] = x - player.x, ['y'] = y - player.y}
    local angle = math.atan(diff.x / diff.y)
    if diff.y < 0 then -- for quadrants 3,4
        angle = math.pi + angle
    else
        if diff.x < 0 then -- ensures angle is always positive (0 - 2pi)
            angle = 2 * math.pi + angle
        end
    end
    return angle
end

function player.lookat(self, x, y, delta, instant) -- rotates the player towards a point, returns the difference angle
    local look = self:lookAngle(x, y)
    if instant then -- if instant is something then the rotation is instant
        player.dir = look
        return 0
    end

    local angle = look - player.dir

    local sign = 1
    if angle < 0 then -- convert the angle to a positive
        sign = -1
        angle = angle * -1
    end

    if angle > math.pi then -- if the angle is > pi than it is faster to rotate the other way
        sign = sign * -1
    end

    if math.abs(angle) < player.turningspeed * delta then -- angle is too small
        player.dir = look
        return 0
    end

    player.dir = player.dir + player.turningspeed * delta * sign -- rotates the player based on turning speed

    if player.dir > math.pi * 2 then -- contrains player.dir to (0, 2pi)
        player.dir = player.dir - math.pi * 2
    end
    if player.dir < 0 then
        player.dir = player.dir + math.pi * 2
    end

    return angle
end

function player.move(self)
    vel = vectorfromangle(self.dir, self.speed)
    player.x = vel[1] + player.x
    player.y = vel[2] + player.y
end

function vectorfromangle(rads, mag)
    if (mag == nil) then mag = 1 end
    return {math.sin(rads) * mag, math.cos(rads) * mag}
end