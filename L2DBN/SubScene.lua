local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or "";
local Class    = require(_PACKAGE .. '/Class');
local SubScene = Class {};

function SubScene:init(config)
    self.scene = config.scene;
end

function SubScene:start()

end

function SubScene:update(dt)

end

function SubScene:render()

end

return SubScene;
