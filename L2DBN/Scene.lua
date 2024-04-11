local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or "";
local Class    = require(_PACKAGE .. '/Class');
local Scene    = Class {};

function Scene:init()

end

function Scene:update() end

function Scene:dispose() end

function Scene:render() end

return Scene;
