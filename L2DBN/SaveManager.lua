local _PACKAGE    = (...):match("^(.+)[%./][^%./]+") or "";
local binser      = require(_PACKAGE .. '/binser');
local SaveManager = {};

function SaveManager:save(name, ...)
    love.filesystem.write(name .. '.txt', binser.serialize(...));
    return data;
end

function SaveManager:load(name)
    if (self:exists(name)) then
        local data, size = love.filesystem.read(name .. '.txt');
        return binser.deserialize(data);
    end
    return false;
end

function SaveManager:exists(name)
    return self:getInfo(name) ~= nil;
end

function SaveManager:getInfo(name)
    return love.filesystem.getInfo(name .. '.txt', 'file');
end

function SaveManager:deleteSave(name)
    love.filesystem.remove('save.txt');
end

return SaveManager;
