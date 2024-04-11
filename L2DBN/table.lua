local Result = {};

function Result.concatTables(...)
    local i = 1;
    local result = args[1];
    i = i + 1;
    while i <= #args do
        local _tmp = args[i];
        for k, v in ipairs(_tmp) do
            table.insert(result, v);
        end
        i = i + 1;
    end
    return result;
end

function Result.shuffleTable(tbl)
    local i = #tbl;
    while i > 1 do
        local rand = math.floor(math.random(1, i));
        local tmp = tbl[i];
        tbl[i] = tbl[rand];
        tbl[rand] = tmp;
        i = i - 1;
    end
end

return Result;
