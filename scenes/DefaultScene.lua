local Scene     = L2DBN.Scene;
local Rect      = L2DBN.Rect;
local Actor     = L2DBN.combat.Actor;
local CombatMap = L2DBN.combat.Map;
local BNTile    = L2DBN.combat.Tile;
local printf    = love.graphics.printf;
local setColor  = love.graphics.setColor;

--MAP
local BNMap     = Class { __includes = CombatMap };

function BNMap:init(config)
    CombatMap.init(self, config);
    self:setTileOccupying(
        config.Player(self),
        2,
        2
    );
end

--PLAYER
local Player = Class { __includes = Actor };

local MoveCooldownTime = 0.2;
local MoveBufferTime = 0.15;

function Player:init(map)
    Actor.init(self, {
        map = map,
        w = 26,
        h = 40
    });
    self.moveCooldown = 0;
    self.moveDirection = nil;
    self.moveBuffer = 0;
    self.stateManager:addState(
        'normal',
        nil,
        bind(self, function(self, dt)
            if love.keyboard.wasPressed('right') then
                self.moveDirection = 2;
                self.moveBuffer = MoveBufferTime;
            elseif love.keyboard.wasPressed('left') then
                self.moveDirection = 4;
                self.moveBuffer = MoveBufferTime;
            elseif love.keyboard.wasPressed('up') then
                self.moveDirection = 1;
                self.moveBuffer = MoveBufferTime;
            elseif love.keyboard.wasPressed('down') then
                self.moveDirection = 3;
                self.moveBuffer = MoveBufferTime;
            end

            if self.moveBuffer > 0 and self.moveCooldown <= 0 then
                local moved = false;
                local moveDirection = self.moveDirection;
                if moveDirection == 1 then
                    moved = self.tile:moveUp();
                elseif moveDirection == 2 then
                    moved = self.tile:moveRight();
                elseif moveDirection == 3 then
                    moved = self.tile:moveDown();
                elseif moveDirection == 4 then
                    moved = self.tile:moveLeft();
                end
                if moved then
                    self.moveCooldown = MoveCooldownTime;
                    self.moveBuffer = 0;
                end
            end
        end),
        nil,
        nil,
        true
    );
end

function Player:update(dt)
    self.moveCooldown = self.moveCooldown - dt;
    self.moveBuffer = self.moveBuffer - dt;
    self.stateManager:update(dt);
end

--SCENE

local DefaultScene = Class { __includes = Scene };

function DefaultScene:init()
    love.graphics.setFont(largeFont);
    self.map = BNMap({
        width = 8,
        height = 4,
        tileWidth = 32,
        tileHeight = 24,
        scene = self,
        padding = 10,
        CombatTile = BNTile,
        Player = Player
    });
end

function DefaultScene:update(dt)
    self.map:update(dt);
end

function DefaultScene:render()
    push:apply('start');
    --
    self.map:render();
    --
    push:apply('end');
end

return DefaultScene;
