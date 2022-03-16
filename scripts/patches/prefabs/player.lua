local ex_fns = require "prefabs/player_common_extensions"

return function(inst)
    inst.skeleton_prefab = "skeleton"
    inst.ghostenabled = true
    
    inst:AddComponent("colourtweener")

    inst:AddComponent("bloomer")
    inst:AddComponent("debuffable")

    if inst.ghostenabled then
        inst:DoTaskInTime(0, function()
            while inst.event_listeners.death[inst][2] do
                inst:RemoveEventCallback("death", inst.event_listeners.death[inst][2])
            end
            inst:ListenForEvent("death", ex_fns.OnPlayerDeath)
            inst:ListenForEvent("makeplayerghost", ex_fns.OnMakePlayerGhost)
            inst:ListenForEvent("respawnfromghost", ex_fns.OnRespawnFromGhost)
            inst:ListenForEvent("ghostdissipated", ex_fns.OnPlayerDied)
        end)
    end

	local _OnSave = inst.OnSave
    inst.OnSave = function(inst, data, ...)
		if data then
            data.isghost = inst:HasTag("playerghost")
		end
		return _OnSave(inst, data, ...)
	end
	local _OnLoad = inst.OnLoad
	inst.OnLoad = function(inst, data, ...)
		local val = _OnLoad(inst, data, ...)
		if data then
            inst.isghost = data.isghost or false
            if inst.isghost then
                inst:DoTaskInTime(FRAMES, function()
                    inst.deathcause = "file_load"
                    ex_fns.OnMakePlayerGhost(inst)

                    inst.HUD.controls.inv:Hide()
                    inst.HUD.controls.crafttabs:Hide()                
                end)
            end
		end
		return val
	end
end