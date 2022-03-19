local assets =
{
    Asset("ANIM", "anim/bloodpump.zip"),
}

local function PlayBeatAnimation(inst)
    if not inst.ressurecting then
        inst.AnimState:PlayAnimation("idle")
    end
end

local function beat(inst)
    inst:PlayBeatAnimation()
    inst.SoundEmitter:PlaySound("dontstarve/ghost/bloodpump")
    inst.beattask = inst:DoTaskInTime(.75 + math.random() * .75, beat)
end

local function startbeat(inst)
    if inst.beat_fx ~= nil then
        inst.beat_fx:Remove()
        inst.beat_fx = nil
    end
    if inst.reviver_beat_fx ~= nil then
        inst.beat_fx = SpawnPrefab(inst.reviver_beat_fx)
        inst.beat_fx.entity:SetParent(inst.entity)
        inst.beat_fx.entity:AddFollower()
        inst.beat_fx.Follower:FollowSymbol(inst.GUID, "bloodpump01", -5, -30, 0)
    end
    inst.beattask = inst:DoTaskInTime(.75 + math.random() * .75, beat)
end

local function ondropped(inst)
    if inst.beattask ~= nil then
        inst.beattask:Cancel()
    end
    inst.beattask = inst:DoTaskInTime(0, startbeat)
end

local function onpickup(inst)
    if inst.beattask ~= nil then
        inst.beattask:Cancel()
        inst.beattask = nil
    end
    if inst.beat_fx ~= nil then
        inst.beat_fx:Remove()
        inst.beat_fx = nil
    end
end

local function OnHaunt(inst, haunter)
    inst.ressurecting = true
    inst.AnimState:SetBank("townportaltalisman")
    inst.AnimState:SetBuild("townportaltalisman")
    inst.AnimState:OverrideSymbol("townportaltalisman01", "bloodpump", "bloodpump01")
    inst.AnimState:PlayAnimation("active_shake", true)
    inst:DoTaskInTime(1, function()
        inst.AnimState:PlayAnimation("active_rise")
        inst.AnimState:PushAnimation("active_loop", true)
    end)
    return true
end

local function OnActivate(inst)
    ErodeAway(inst, 6)
    inst:RemoveComponent("inventoryitem")
    inst:RemoveComponent("inspectable")
    inst:RemoveComponent("hauntable")
    inst:RemoveComponent("tradable")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.ressurecting = false

    inst.AnimState:SetBank("bloodpump")
    inst.AnimState:SetBuild("bloodpump")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(onpickup)
    --inst.components.inventoryitem:SetSinks(true)

    inst:AddComponent("inspectable")
    inst.components.inventoryitem:SetANRAtlas(2)

    inst:AddComponent("tradable")

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    inst.beattask = nil
    inst.skin_switched = ondropped
    ondropped(inst)

    inst.DefaultPlayBeatAnimation = PlayBeatAnimation --for resetting after reskin
    inst.PlayBeatAnimation = PlayBeatAnimation

    inst:ListenForEvent("activateresurrection", OnActivate)

    return inst
end

return Prefab("reviver", fn, assets)
