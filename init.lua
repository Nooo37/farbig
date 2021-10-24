local path = ...
local M = {}
M.mt = {}
M.names = nil

function M.get(colorscheme)
    if type(colorscheme) == 'table' then
        colorscheme = table.concat(colorscheme, "-")
    end
    local colors = require(path .. '.colors.' .. colorscheme)
    if M.names then
        for idx, fieldname in ipairs(M.names) do
            local basename = "base" .. string.format("%02X", idx)
            colors[fieldname] = colors[basename]
        end
    end
    return colors
end

function M.set_names(names)
    if type(names) == 'table' and #names == 16 then
        M.names = names
    end
end

function M.mt:__call(...)
    return M.get(...)
end

return setmetatable(M, M.mt)
