local _PACKAGE    = (...):match("^(.+)[%./][^%./]+") or "";
local Class       = require(_PACKAGE .. '/Class');
local CombatTile  = Class {};
local setColor    = love.graphics.setColor;
local rectangle   = love.graphics.rectangle;

local tile_states = {
    normal = 'normal',
}

local function invalidMove()
    return false;
end

function CombatTile:init(map, x, y)
    self.map = map;
    self.index = (y - 1) * self.map.width + x;
    self.x = x;
    self.y = y;
    self.occupying = nil;
    self.state = tile_states.normal;
    self.state_timer = 0;
    self.color = { 1, 0, 0, 1 };

    if self.x == 1 then
        self.moveLeft = invalidMove;
    elseif self.x == self.map.width then
        self.moveRight = invalidMove;
    end

    if self.y == 1 then
        self.moveUp = invalidMove;
    elseif self.y == self.map.height then
        self.moveDown = invalidMove
    end
end

function CombatTile:setState(state, ms)
    self.state = state;
    self.state_timer = ms or 0;
end

function CombatTile:removeOccupying()
    self.occupying.tile = nil;
    self.occupying = nil;
end

function CombatTile:setOccupying(obj)
    if not self:isOccupied() then
        self.occupying = obj;
        obj.tile = self;
        return true;
    end
    return false;
end

function CombatTile:isOccupied()
    return not self.occupying == nil;
end

function CombatTile:move(n)
    local board = self.map.board;
    local move_to = board[self.index + n];
    if not move_to.occupying then
        local occupying = self.occupying;
        self:removeOccupying();
        move_to:setOccupying(occupying);
        return true;
    end
    return false;
end

function CombatTile:moveLeft()
    return self:move(-1);
end

function CombatTile:moveRight()
    return self:move(1);
end

function CombatTile:moveUp()
    return self:move(-self.map.width);
end

function CombatTile:moveDown()
    return self:move(self.map.width);
end

function CombatTile:update(dt)
    self.state_timer = self.state_timer - dt;
    if self.state_timer <= 0 then
        self.state = tile_states.normal;
    end
    local occupying = self.occupying;
    if occupying then
        occupying:update(dt);
    end
end

function CombatTile:render()
    local map        = self.map;
    local start_x    = map.start_x;
    local start_y    = map.start_y;
    local tileWidth  = map.tileWidth;
    local tileHeight = map.tileHeight;
    local padding    = map.tile_padding;
    local mult_x     = (self.x - 1);
    local mult_y     = (self.y - 1);
    local x          = start_x + (tileWidth * mult_x) + (padding * mult_x);
    local y          = start_y + (tileHeight * mult_y) + (padding * mult_y);
    setColor(unpack(self.color));
    rectangle(
        'fill',
        x,
        y,
        tileWidth,
        tileHeight
    );
    local occupying = self.occupying;
    if occupying then
        occupying:render(
            x + math.floor(tileWidth / 2),
            y + math.floor(tileHeight / 2)
        );
    end
end

return CombatTile;
