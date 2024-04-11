local _PACKAGE     = (...):match("^(.+)[%./][^%./]+") or "";
local Class        = require(_PACKAGE .. '/Class');
local SceneManager = Class {}

function SceneManager:init(scenes, default_scene)
    self.activeScene = scenes[1]();
    self.scenes = scenes;
end

function SceneManager:update(dt)
    self.activeScene:update(dt)
end

function SceneManager:render()
    self.activeScene:render()
end

function SceneManager:setScene(index)
    print('Setting-Scene: ' .. index)
    if self.activeScene ~= nil then
        self.activeScene:dispose();
    end
    self.activeScene = self.scenes[index]()
end

return SceneManager;
