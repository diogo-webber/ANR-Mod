function _G.IsSpecialEventActive(event)
    return _G.WORLD_SPECIAL_EVENT == event
end

function _G.IsAnySpecialEventActive()
    return _G.WORLD_SPECIAL_EVENT ~= _G.SPECIAL_EVENTS.NONE
end
