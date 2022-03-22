modimport("scripts/util/action.lua")
modimport("scripts/util/animstate.lua")
modimport("scripts/util/deploy.lua")
modimport("scripts/util/finding.lua")
modimport("scripts/util/hautning.lua")
modimport("scripts/util/linkedlist.lua")
modimport("scripts/util/map.lua")
modimport("scripts/util/physics.lua")
modimport("scripts/util/specialevents.lua")

env.AddPlayerPostInit = function(fn)
    env.AddPrefabPostInitAny( function(inst)
        if inst and inst:HasTag("player") then fn(inst) end
    end)
end

function _G.ErodeAway(inst, erode_time)
    local time_to_erode = erode_time or 1
    local tick_time = TheSim:GetTickTime()

    if inst.DynamicShadow ~= nil then
        inst.DynamicShadow:Enable(false)
    end

    inst:StartThread(function()
        local ticks = 0
        while ticks * tick_time < time_to_erode do
            local erode_amount = ticks * tick_time / time_to_erode
            inst.AnimState:SetErosionParams(erode_amount, 0.1, 1.0)
            ticks = ticks + 1
            Yield()
        end
        inst:Remove()
    end)
end

function _G.ErodeCB(inst, erode_time, cb, restore)
    local time_to_erode = erode_time or 1
    local tick_time = TheSim:GetTickTime()

    if inst.DynamicShadow ~= nil then
        inst.DynamicShadow:Enable(false)
    end

    inst:StartThread(function()
        local ticks = 0
        while ticks * tick_time < time_to_erode do
            local erode_amount = ticks * tick_time / time_to_erode
            inst.AnimState:SetErosionParams(erode_amount, 0.1, 1.0)
            ticks = ticks + 1
            Yield()
        end
		if restore then
            inst.AnimState:SetErosionParams(0, 0, 0)
		end
        if cb ~= nil then
			cb(inst)
		end
    end)
end

function _G.FunctionOrValue(func_or_val, ...)
    if type(func_or_val) == "function" then
        return func_or_val(...)
    end
    return func_or_val
end
