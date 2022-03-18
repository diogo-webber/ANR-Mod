ACTIONS.SMOTHER.priority = 7

ACTIONS.SMOTHER.fn = function(act)
	if act.target.components.burnable and act.target.components.burnable:IsSmoldering() then
		local smotherer = act.invobject or act.doer
		act.target.components.burnable:SmotherSmolder(smotherer)
        act.target:DoTaskInTime(3, function()
            act.target.components.propagator.currentheat = 0
            act.target.components.propagator.acceptsheat = true
        end)
		return true
	end
end

_G.DefaultIgniteFn = function (inst)
	if inst.components.burnable then
        inst.components.burnable:StartWildfire()
    end
end

local _oldMakeSmallBurnable = _G.MakeSmallBurnable
_G.MakeSmallBurnable = function(inst, time, offset, structure)
    if structure then
        _oldMakeSmallBurnable(inst, time, offset, structure)
    else
        _oldMakeSmallBurnable(inst, time, offset)
    end
    inst.components.burnable:SetBurnTime(time or 10)
end

local _oldMakeMediumBurnable = _G.MakeMediumBurnable
_G.MakeMediumBurnable = function(inst, time, offset, structure)
    if structure then
        _oldMakeMediumBurnable(inst, time, offset, structure)
    else
        _oldMakeMediumBurnable(inst, time, offset)
    end
    inst.components.burnable:SetBurnTime(time or 20)
end

local _oldMakeLargeBurnable = _G.MakeLargeBurnable
_G.MakeLargeBurnable = function(inst, time, offset, structure)
    if structure then
        _oldMakeLargeBurnable(inst, time, offset, structure)
    else
        _oldMakeLargeBurnable(inst, time, offset)
    end
    inst.components.burnable:SetBurnTime(time or 30)
end

--------------------------------------------------------------------------------

local _oldMakeSmallPropagator = _G.MakeSmallPropagator
_G.MakeSmallPropagator = function(inst)
    _oldMakeSmallPropagator(inst)
    inst.components.propagator.decayrate = 0.5
    inst.components.propagator.propagaterange = 3 + math.random()*2
    inst.components.propagator.heatoutput = 3 + math.random()*2
end

local _oldMakeMediumPropagator = _G.MakeMediumPropagator
_G.MakeMediumPropagator = function(inst)
    _oldMakeMediumPropagator(inst)
    inst.components.propagator.decayrate = 0.5
    inst.components.propagator.propagaterange = 5 + math.random()*2
    inst.components.propagator.heatoutput = 5 + math.random()*3.5
end

local _oldMakeLargePropagator = _G.MakeLargePropagator
_G.MakeLargePropagator = function(inst)
    _oldMakeLargePropagator(inst)
    inst.components.propagator.decayrate = 0.5
    inst.components.propagator.propagaterange = 6 + math.random()*2
    inst.components.propagator.heatoutput = 6 + math.random()*3.5
end