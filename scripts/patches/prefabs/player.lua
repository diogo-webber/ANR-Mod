local ex_fns = require "prefabs/player_common_extensions"

local function SetCameraZoomed(inst, iszoomed)
    if iszoomed then
        if inst._prevcameradistance == nil then
            inst._prevcameradistance = TheCamera.distance
            inst._prevcameradistancegain = TheCamera.distancegain
            if inst._prevcameradistance > 18 then
                TheCamera:SetDistance(18)
                TheCamera.distancegain = 3
                TheCamera:SetControllable(false)
            end
        end
    elseif inst._prevcameradistance ~= nil then
        TheCamera:SetDistance(iszoomed > 0 and iszoomed or inst._prevcameradistance)
        TheCamera.distancegain = inst._prevcameradistancegain
        inst._prevcameradistance = nil
        inst._prevcameradistancegain = nil
        TheCamera:SetControllable(true)
    elseif iszoomed > 0 then
        TheCamera:SetDistance(iszoomed)
    else
        TheCamera:SetDefault()
    end
end

local function SnapCamera(inst, resetrot)
    if resetrot then
        TheCamera:SetHeadingTarget(45)
    end
    TheCamera:Snap()
end

local function ScreenFade(inst, isfadein, time, iswhite)
    time = time and math.min(31, math.floor(time * 10 + .5)) or 0

    if time > 0 then
        TheFrontEnd:Fade(isfadein, time / 10, nil, nil, nil, iswhite and "white" or "black")
    else
        TheFrontEnd.fade_type = iswhite and "white" or "black"
        TheFrontEnd:SetFadeLevel(isfadein and 0 or 1)
    end
end


--NOTE: On server we always get before lose attunement when switching effigies.
local function OnGotNewAttunement(inst, data)
    --can safely assume we are attuned if we just "got" an attunement
    if not inst._isrezattuned and
        data.source:HasTag("remoteresurrector") then
        --NOTE: parenting automatically handles visibility
        SpawnPrefab("attune_out_fx").entity:SetParent(inst.entity)
        inst._isrezattuned = true
    end
end

local function OnAttunementLost(inst, data)
    --cannot assume that we are no longer attuned
    --to a type when we lose a single attunement!
    if inst._isrezattuned and
        data.source:HasTag("remoteresurrector") and
        not inst.components.attuner:HasAttunement("remoteresurrector") then
        --remoterezsource flag means we're currently performing remote resurrection,
        --so we will lose attunement in the process, but we don't really want an fx!
        if not inst.remoterezsource then
            --NOTE: parenting automatically handles visibility
            SpawnPrefab(inst:HasTag("playerghost") and "attune_ghost_in_fx" or "attune_in_fx").entity:SetParent(inst.entity)
        end
        inst._isrezattuned = false
    end
end

return function(inst)
    inst.skeleton_prefab = "skeleton"
    inst.ghostenabled = true
    
    inst:AddComponent("colourtweener")

    inst:AddComponent("bloomer")
    inst:AddComponent("debuffable")
    inst:AddComponent("attuner")
    
    inst:ListenForEvent("gotnewattunement", OnGotNewAttunement)
    inst:ListenForEvent("attunementlost", OnAttunementLost)
    inst._isrezattuned = inst.components.attuner:HasAttunement("remoteresurrector")

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

    inst.SetCameraDistance = SetCameraZoomed
    inst.SetCameraZoomed = SetCameraZoomed
    inst.SnapCamera = SnapCamera
    inst.ScreenFade = ScreenFade
    --inst.ScreenFlash = ScreenFlash

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
                    
                    inst:DoTaskInTime(FRAMES, function()
                        inst.SoundEmitter:KillSound("talk")
                    end)

                    inst.HUD.controls.inv:Hide()
                    inst.HUD.controls.crafttabs:Hide()                
                end)
            end
		end
		return val
	end
end