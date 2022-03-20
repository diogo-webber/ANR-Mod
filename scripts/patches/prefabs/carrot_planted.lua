return function(inst)
    local _onpicked = inst.components.pickable.onpickedfn
    inst.components.pickable.onpickedfn = function(...)
        GetWorld():PushEvent("beginregrowth", inst)
        _onpicked(...)
    end
end