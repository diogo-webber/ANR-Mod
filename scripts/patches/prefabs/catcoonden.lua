return function(inst)
    local _onfinish = inst.components.workable.onfinish
    inst.components.workable.onfinish = function(...)
        GetWorld():PushEvent("beginregrowth", inst)
        _onfinish(...)
    end
end