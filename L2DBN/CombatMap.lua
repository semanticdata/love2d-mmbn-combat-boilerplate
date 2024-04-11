local _PACKAGE  = (...):match("^(.+)[%./][^%./]+") or "";
local Class     = require(_PACKAGE .. '/Class');
local CombatMap = Class {};

function CombatMap:init(config)
    self.board        = {};
    self.width        = config.width;
    self.height       = config.height;
    self.tileWidth    = config.tileWidth;
    self.tileHeight   = config.tileHeight;
    self.scene        = config.scene;
    self.tile_padding = config.padding;
    self.board_width  = ((self.width - 1) * self.tile_padding) + self.tileWidth * self.width;
    self.board_height = ((self.height - 1) * self.tile_padding) + self.tileHeight * self.height;
    self.start_x      = math.floor(VIRTUAL_WIDTH / 2 - self.board_width / 2);
    self.start_y      = math.floor(VIRTUAL_HEIGHT / 2);
    local CombatTile  = config.CombatTile;
    local width       = self.width;
    for i = 1, width * self.height do
        table.insert(self.board, CombatTile(
            self,
            (i - 1) % width + 1,
            math.floor((i - 1) / width) + 1
        ));
    end
end

function CombatMap:setTileOccupying(obj, x, y)
    self.board[(y - 1) * self.width + x]:setOccupying(obj);
end

function CombatMap:render()
    for i = 1, #self.board do
        self.board[i]:render();
    end
end

function CombatMap:update(dt)
    for i = 1, #self.board do
        self.board[i]:update(dt);
    end
end

return CombatMap;
