local function OnHaunt(inst, haunter)
    return true
end

local function onattunecost(inst, player)
    --round up health to match UI display
	local amount_required = player:HasTag("health_as_oldage") and math.ceil(TUNING.EFFIGY_HEALTH_PENALTY * TUNING.OLDAGE_HEALTH_SCALE) or TUNING.EFFIGY_HEALTH_PENALTY

    if player.components.health == nil or math.ceil(player.components.health.currenthealth) <= amount_required then
		--Don't die from attunement!
        return false, "NOHEALTH"
    end
    
	player:PushEvent("consumehealthcost")
    player.components.health:DoDelta(-TUNING.EFFIGY_HEALTH_PENALTY, false, "statue_attune", true, inst, true)
    return true
end

local function onlink(inst, player, isloading)
    if not isloading then
        inst.SoundEmitter:PlaySound("dontstarve/common/together/meat_effigy_attune/on")
        inst.AnimState:PlayAnimation("attune_on")
        inst.AnimState:PushAnimation("idle", false)
    end
    player.components.attuner:RegisterAttunedSource(inst)
end

local function onunlink(inst, player, isloading)
    if not (isloading or inst.AnimState:IsCurrentAnimation("attune_on")) then
        inst.SoundEmitter:PlaySound("dontstarve/common/together/meat_effigy_attune/off")
        inst.AnimState:PlayAnimation("attune_off")
        inst.AnimState:PushAnimation("idle", false)
    end
    player.components.attuner:UnregisterAttunedSource(inst)
end

local function PlayAttuneSound(inst)
    if inst.AnimState:IsCurrentAnimation("place") or inst.AnimState:IsCurrentAnimation("attune_on") then
        inst.SoundEmitter:PlaySound("dontstarve/common/together/meat_effigy_attune/on")
    end
end

local function onbuilt(inst)
    --Hack to auto-link without triggering fx or paying the cost again
    inst.components.attunable:SetOnAttuneCostFn(nil)
    inst.components.attunable:SetOnLinkFn(nil)
    inst.components.attunable:SetOnUnlinkFn(nil)

    inst.AnimState:PlayAnimation("place")
    if inst.components.attunable:LinkToPlayer(GetPlayer()) then
        inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), PlayAttuneSound)
        inst.AnimState:PushAnimation("attune_on")
    end
    inst.AnimState:PushAnimation("idle", false)

    --End hack
    inst.components.attunable:SetOnAttuneCostFn(onattunecost)
    inst.components.attunable:SetOnLinkFn(onlink)
    inst.components.attunable:SetOnUnlinkFn(onunlink)
end

return function(inst)
    inst:RemoveComponent("resurrector")

    inst:AddComponent("attunable")
    inst.components.attunable:SetAttunableTag("remoteresurrector")
    inst.components.attunable:SetOnAttuneCostFn(onattunecost)
    inst.components.attunable:SetOnLinkFn(onlink)
    inst.components.attunable:SetOnUnlinkFn(onunlink)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    inst:ListenForEvent("activateresurrection", inst.Remove)
    inst:RemoveEventCallback("onbuilt", inst.event_listeners.onbuilt[inst][1])
    inst:ListenForEvent( "onbuilt", onbuilt)
end