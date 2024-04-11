local _PACKAGE  = (...):match("^(.+)[%./][^%./]+") or "";
local Class     = require(_PACKAGE .. '/Class');
local Bounds    = require(_PACKAGE .. '/Bounds');
local Rect      = Class { __includes = Bounds };
local rectangle = love.graphics.rectangle;
local setColor  = love.graphics.setColor;

function Rect:init(x, y, w, h, ox, oy)
    Bounds.init(self, ox, oy, w, h);
    self.x = x or 0;
    self.y = y or 0;
end

function Rect:isClicked(mx, my)
    local x = self.x;
    local y = self.y;
    if
        mx < x + self.left or
        mx > x + self.right or
        my < y + self.top or
        my > y + self.bottom
    then
        return false;
    end
    return true;
end

function Rect:renderRect()
    setColor(0, 0.5, 0, 1);
    rectangle(
        'fill',
        self.x + self.left,
        self.y + self.top,
        self.w,
        self.h
    );
end

function Rect:render()
    self:renderRect();
end

return Rect;
