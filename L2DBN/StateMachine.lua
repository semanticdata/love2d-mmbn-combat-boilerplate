local _PACKAGE     = (...):match("^(.+)[%./][^%./]+") or "";
local Class        = require(_PACKAGE .. '/Class');
local StateMachine = Class {}

function StateMachine:init(table)
    self.self = table
    self.state_index = nil
    self.timer = 0
    self.states = {}
end

function StateMachine:addState(name, begin, update, coroutine_func, finish, is_default)
    is_default = is_default or false
    self.state_index = is_default and name or self.state_index
    self.states[name] = {
        ['start'] = begin or nil,
        ['update'] = update or nil,
        ['coroutine_func'] = coroutine_func or nil,
        ['end'] = finish or nil,
        ['coroutine'] = nil
    }
end

function StateMachine:getState()
    return self.states[self.state_index]
end

function StateMachine:setState(index)
    local state = self:getState()
    local func = state.finish
    if func ~= nil then func() end
    self.state_index = index
    state = self:getState()
    func = state.begin
    if func ~= nil then func() end
    if state.coroutine_func ~= nil then
        state.coroutine = coroutine.create(state.coroutine_func)
    end
    self.timer = 0
end

function StateMachine:update(dt)
    local state = self:getState()
    if state.update ~= nil then state.update(dt) end
    if state.coroutine ~= nil and coroutine.status(state.coroutine) ~= 'dead' then
        self.timer = self.timer - dt
        if self.timer <= 0 then
            local status, time = coroutine.resume(state.coroutine, dt)
            if type(time) == 'number' then self.timer = time end
        end
    end
end

return StateMachine;
