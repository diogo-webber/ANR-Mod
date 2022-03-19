ACTIONS.SMOTHER.priority = 7

_G.DefaultIgniteFn = function (inst)
	if inst.components.burnable then
        inst.components.burnable:StartWildfire()
    end
end

local _MakeSmallBurnable = _G.MakeSmallBurnable
_G.MakeSmallBurnable = function(inst, time, offset, structure)
    if structure then
        _MakeSmallBurnable(inst, time, offset, structure)
    else
        _MakeSmallBurnable(inst, time, offset)
    end
    inst.components.burnable:SetBurnTime(time or 10)
end

local _MakeMediumBurnable = _G.MakeMediumBurnable
_G.MakeMediumBurnable = function(inst, time, offset, structure)
    if structure then
        _MakeMediumBurnable(inst, time, offset, structure)
    else
        _MakeMediumBurnable(inst, time, offset)
    end
    inst.components.burnable:SetBurnTime(time or 20)
end

local _MakeLargeBurnable = _G.MakeLargeBurnable
_G.MakeLargeBurnable = function(inst, time, offset, structure)
    if structure then
        _MakeLargeBurnable(inst, time, offset, structure)
    else
        _MakeLargeBurnable(inst, time, offset)
    end
    inst.components.burnable:SetBurnTime(time or 30)
end

--------------------------------------------------------------------------------

local _MakeSmallPropagator = _G.MakeSmallPropagator
_G.MakeSmallPropagator = function(inst)
    _MakeSmallPropagator(inst)
    inst.components.propagator.decayrate = 0.5
    inst.components.propagator.propagaterange = 3 + math.random()*2
    inst.components.propagator.heatoutput = 3 + math.random()*2
end

local _MakeMediumPropagator = _G.MakeMediumPropagator
_G.MakeMediumPropagator = function(inst)
    _MakeMediumPropagator(inst)
    inst.components.propagator.decayrate = 0.5
    inst.components.propagator.propagaterange = 5 + math.random()*2
    inst.components.propagator.heatoutput = 5 + math.random()*3.5
end

local _MakeLargePropagator = _G.MakeLargePropagator
_G.MakeLargePropagator = function(inst)
    _MakeLargePropagator(inst)
    inst.components.propagator.decayrate = 0.5
    inst.components.propagator.propagaterange = 6 + math.random()*2
    inst.components.propagator.heatoutput = 6 + math.random()*3.5
end