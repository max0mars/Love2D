function love.load()
    player = {}
    player.x = 200
    player.y = 200
    player.radius = 25
    player.speed = 5
    player.turningspeed = 5
    player.dir = 0
end

function love.update(dt)
    follow()
end

function love.draw()
    love.graphics.circle('fill', player.x, player.y, player.radius)
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

function player.look(self, x, y, lspeed)
    local diff = {['x'] = x - player.x, ['y'] = y - player.y}
    if(diff.x == 0) then
        if diff.y > 0 then
            return 0 
        else
            return math.pi
        end
    end
    angle = atan(diff.y / diff.x)
    if(diff.y == 0) then
        if diff.x > 0 then
            angle = math.pi / 2 
        else
            angle = math.pi * 3 / 2
        end
    end
    
    if(angle < 0)