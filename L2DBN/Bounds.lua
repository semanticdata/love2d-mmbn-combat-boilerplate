local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or "";
local Class    = require(_PACKAGE .. '/Class');
local Bounds   = Class {};

function Bounds:init(originX, originY, w, h)
    self.w = w;
    self.h = h;
    self:setOrigin(originX, originY);
end

function Bounds:setSize(w, h)
    self.w = w;
    self.h = h;
end

function Bounds:setOrigin(originX, originY)
    self.left   = math.floor(-(self.w * originX));
    self.right  = math.ceil(self.w + self.left);
    self.top    = math.floor(-(self.h * originY));
    self.bottom = math.ceil(self.h + self.top);
end

return Bounds;
