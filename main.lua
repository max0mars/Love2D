
player = {}

function love.load()
    player.x = 200
    player.y = 200
    player.radius = 25
    player.speed = 2
    player.turningspeed = 3
    player.dir = 0
    print ("Okay!")
    pos = {}
end

look = 0
function love.update(dt)
    
    look = player:lookat(love.mouse.getX(), love.mouse.getY(), dt)
    player:move()
    --love.graphics.print(look, 400, 400)
end

function love.draw()
    love.graphics.setColor(0,1,0, 1)
    love.graphics.circle('fill', player.x, player.y, player.radius)
    local nosePosition = vectorfromangle(player.dir, player.radius)
    love.graphics.setColor(1,0,0, 1)
    love.graphics.print(look, 300, 300)
    love.graphics.print(player.dir, 300, 350)
    love.graphics.circle('fill', nosePosition[1] + player.x, nosePosition[2] + player.y, 5)
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

function player.lookAngle(self, x, y)
    local diff = {['x'] = x - player.x, ['y'] = y - player.y}
    local angle = math.atan(diff.x / diff.y)
    if diff.y < 0 then
        angle = math.pi + angle
    else
        if diff.x < 0 then
            angle = 2 * math.pi + angle
        end
    end
    
    return angle
end

function player.lookat(self, x, y, delta, instant)
    local look = self:lookAngle(x, y)
    if instant then 
        player.dir = look
        return 0
    end
    local angle = look - player.dir
    if math.abs(angle) < 0.04 then
        return 0
    end
    local sign = 1
    if angle < 0 then 
        sign = -1
        angle = angle * -1
    end
    if angle > math.pi then
        sign = sign * -1
    end
    if math.abs(angle) < player.turningspeed * delta then
        player.dir = look
        return "small!"
    end
    player.dir = player.dir + player.turningspeed * delta * sign
    if player.dir > math.pi * 2 then
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