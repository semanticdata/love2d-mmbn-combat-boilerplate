local function bind(t, f)
    return function(...) return f(t, ...) end
end

return bind;
