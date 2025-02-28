upgrademenu = {}
upgrademenu.__index = upgrademenu

-- This is the constructor for the upgrademenu class.
-- It will fill the whole screen and pause the game
-- ideally it will be a tree-like shape with upgrades having to be purchased in order
-- u button to toggle the menu

-- maybe make it scrollable or some ability to navigate it so it can be larger than the screen
-- or maybe just make it have multiple pages

function upgrademenu:new(x, y, width, height, buttons)
    local u = {}
    setmetatable(u, upgrademenu)
    return u
end

-- simple initial design:
-- 3 collumns, each is a different category (miner, defensebot, ???)
-- upgrades must be purchased top to bottom
-- each collumn is independant of the others
-- each upgrade has a cost and a description
-- 2 buttons at bottom to switch between pages

-- 11 buttons in total