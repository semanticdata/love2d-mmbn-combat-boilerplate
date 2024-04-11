local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or "";
local Class    = require(_PACKAGE .. '/Class');
local Rect     = require(_PACKAGE .. '/Rect');
local Button   = Class { __includes = Rect };
local printf   = love.graphics.printf;
local setFont  = love.graphics.setFont;

function invalidOnClick()
    assert('No onClick function provided.');
end

function Button:init(config)
    Rect.init(self, config.x, config.y, config.w, config.h, config.ox, config.oy);
    self.color = config.color or { 1, 1, 1, 1 };
    self.hoverColor = config.hoverColor or { 1, 1, 1, 0.5 };
    self.onClick = config.onClick or invalidOnClick;
    self.hover = false;
    self.text = config.text or '';
    self.textColor = config.textColor or { 0, 0, 0, 1 };
end

function Button:update()
    self.hover = self:isClicked(love.mouse.mx, love.mouse.my);
    local pressed = love.mouse.pressed;
    if pressed and pressed[3] == 1 and self.hover then
        self.onClick();
        return true;
    end
end

function Button:render()
    if self:isClicked(love.mouse.mx, love.mouse.my) then
        setColor(unpack(self.hoverColor));
    else
        setColor(unpack(self.color));
    end
    rectangle(
        'fill',
        self.x + self.left,
        self.y + self.top,
        self.w,
        self.h
    );
    setColor(unpack(self.textColor));
    printf(
        self.text,
        self.x + self.left,
        math.floor(self.y + self.top + self.h / 2) - 8,
        self.w,
        'center'
    );
end

return Button;
