function love.load()
    start()
end

wins1 = 0
wins2 = 0
total = 10000
auto = -1
totalturns = 0
simover = 0

function start()
    player1 = {
        inhand = {},
        hand = 0,
        onTable = {},
        table = 0,
        lose = 0
    }
    player2 = {
        inhand = {},
        hand = 0,
        onTable = {},
        table = 0,
        lose = 0
    }
    turn = 0

    deck = {}
    for i = 2, 14 do
        for j = 1, 4 do
            table.insert(deck, i)
        end
    end

    for i = 1, 100 do
        shuffle(deck)
    end

    for i = 1, 26 do
        table.insert(player1.inhand, deck[i])
        player1.hand = player1.hand + 1
        table.insert(player2.inhand, deck[53-i])
        player2.hand = player2.hand + 1
    end

    gameover = false

    play = 0
end

function love.update(dt)   
    if(gameover) then
        return
    end     
    if(play == 1 or love.keyboard.isDown('p') or auto == 1) then
        turn = turn + 1
        playhand()
        play = 0
    end
end

function simulate()
    while(wins1 + wins2 < total) do
        start()
        while(not gameover) do
            playhand()
            totalturns = totalturns + 1
        end
        if(player1.lose == 1) then
            wins2 = wins2 + 1
        else
            wins1 = wins1 + 1
        end
    end
    simover = 1
end

function love.draw()
    love.graphics.print('Player 1 wins: ' .. wins1, 500, 50)
    love.graphics.print('Player 2 wins: ' .. wins2, 500, 100)
    if(simover == 1) then
        love.graphics.print('Turns played: ' .. totalturns, 100, 100)
        return
    end
    if(gameover) then
        if(player1.lose == 1)then
            love.graphics.print("PLAYER 2 WINS!!!!!", 100, 100)
        else
            love.graphics.print("PLAYER 1 WINS!!!!!", 100, 100)
        end
        love.graphics.print('turns played = '.. turn, 100, 200)
        return
    end
    
    love.graphics.print('Player 1: ' .. player1.hand .. ', ' .. player2.table, 100, 10)
    love.graphics.print('Player 2: ' .. player2.hand .. ', ' .. player2.table, 300, 10)
    for i = 1, #player1.inhand do
        love.graphics.print(player1.inhand[i], 100, i * 12 + 20)
    end
    for i = 1, #player1.onTable do
        love.graphics.print(player1.onTable[i], 150, i * 12 + 20)
    end

    for i = 1, #player2.inhand do
        love.graphics.print(player2.inhand[i], 300, i * 12 + 20)
    end
    for i = 1, #player2.onTable do
        love.graphics.print(player2.onTable[i], 350, i * 12 + 20)
    end
end

function playhand(pot)
    pot = pot or {}
    card1 = playCard(player1)
    card2 = playCard(player2)
    table.insert(pot, card1)
    table.insert(pot, card2)

    if(card1 > card2) then
        for i = 1, #pot do
            table.insert(player1.onTable, table.remove(pot))
            player1.table = player1.table + 1
        end
    elseif(card1 < card2) then
        for i = 1, #pot do
            table.insert(player2.onTable, table.remove(pot))
            player2.table = player2.table + 1
        end
    else
        for i = 1, 3 do
            table.insert(pot, playCard(player1))
            table.insert(pot, playCard(player2))
        end
        playhand(pot)
    end
end


function playCard(player)
    if(player.hand == 0) then
        if(player.table == 0) then
            gameover = true
            player.lose = 1
            return -1
        else
            while(player.table ~= 0) do
                table.insert(player.inhand, table.remove(player.onTable))
                player.hand = player.hand + 1
                player.table = player.table - 1
            end
            shuffle(player.inhand)
        end
    end
    player.hand = player.hand - 1
    return table.remove(player.inhand)
end


function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    elseif key == "space" then
        play = 1
    elseif key == 'r' then
        start()
    elseif key == 'b' then
        auto = -auto
    elseif key == 'w' then
        wins1 = 0
        wins2 = 0
        totalturns = 0
        simover = 0
    elseif key == 'o' then
        simulate()
    end
end

function shuffle(array)
    size = table.getn(array)
    for i = 1, #array do
        -- Pick a random index between 1 and i
        local j = love.math.random(i)
        -- Swap array[i] and array[j]
        array[i], array[j] = array[j], array[i]
    end
end