local _PACKAGE     = (...):match("^(.+)[%./][^%./]+") or "";
local Class        = require(_PACKAGE .. '/Class');
local StateMachine = require(_PACKAGE .. '/StateMachine');
local Bounds       = require(_PACKAGE .. '/Bounds');
local rectangle    = love.graphics.rectangle;
local setColor     = love.graphics.setColor;
local CombatActor  = Class {};

function CombatActor:init(config)
    self.tile = nil;
    self.map = config.map;
    self.bounds = Bounds(
        0.5,
        1,
        config.w or 14,
        config.h or 24
    );
    self.stateManager = StateMachine();
    self.color = { 0, 0, 1, 1 };
end

function CombatActor:update(dt)

end

function CombatActor:render(x, y)
    local bounds = self.bounds;
    setColor(unpack(self.color));
    rectangle(
        'fill',
        x + bounds.left,
        y + bounds.top,
        bounds.w,
        bounds.h
    );
end

return CombatActor;
