return function(inst)
    local _onburnt = inst.components.pickable.onburnt
    inst.components.pickable.onburnt = function(...)
        GetWorld():PushEvent("beginregrowth", inst)
        _onburnt(...)
    end
end