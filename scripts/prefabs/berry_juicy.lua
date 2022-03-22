require "tuning"

local berries_juicy = {
        health = TUNING.HEALING_TINY,
        hunger = TUNING.CALORIES_SMALL,
        cooked_health = TUNING.HEALING_SMALL,
        cooked_hunger = TUNING.CALORIES_MEDSMALL,
        seed_weight = 0,
        perishtime = TUNING.PERISH_TWO_DAY,
        cooked_perishtime = TUNING.PERISH_ONE_DAY,
        sanity = 0,
        cooked_sanity = 0,
        float_settings = {"med", nil, 0.7},
        cooked_float_settings = nil,
		dryable = nil,
		secondary_foodtype = FOODTYPE.BERRY,
    }

local assets =
{
    Asset("ANIM", "anim/berries_juicy.zip"),
    Asset("INV_IMAGE", "berries_juicy"),
}

local assets_cooked =
{
    Asset("ANIM", "anim/berries_juicy.zip"),
    Asset("INV_IMAGE", "berries_juicy_cooked"),
}

local prefabs =
{
    "berries_juicy_cooked",
    "spoiled_food",
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("berries_juicy")
    inst.AnimState:SetBuild("berries_juicy")
    inst.AnimState:PlayAnimation("idle")

    --[[local float = berries_juicy.float_settings
    if float ~= nil then
        MakeInventoryFloatable(inst, float[1], float[2], float[3])
    else
        MakeInventoryFloatable(inst)
    end]]

    inst:AddComponent("edible")
    inst.components.edible.healthvalue = berries_juicy.health
    inst.components.edible.hungervalue = berries_juicy.hunger
    inst.components.edible.sanityvalue = berries_juicy.sanity or 0
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.secondaryfoodtype = berries_juicy.secondary_foodtype

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(berries_juicy.perishtime)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetANRAtlas(1)

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    ------------------------------------------------
    inst:AddComponent("tradable")

    ------------------------------------------------
    inst:AddComponent("cookable")
    inst.components.cookable.product = "berries_juicy_cooked"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

local function fn_cooked()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("berries_juicy")
    inst.AnimState:SetBuild("berries_juicy")
    inst.AnimState:PlayAnimation("cooked")

    --[[local float = berries_juicy.cooked_float_settings
    if float ~= nil then
        MakeInventoryFloatable(inst, float[1], float[2], float[3])
    else
        MakeInventoryFloatable(inst)
    end]]

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(berries_juicy.cooked_perishtime)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("edible")
    inst.components.edible.healthvalue = berries_juicy.cooked_health
    inst.components.edible.hungervalue = berries_juicy.cooked_hunger
    inst.components.edible.sanityvalue = berries_juicy.cooked_sanity or 0
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
    inst.components.edible.secondaryfoodtype = berries_juicy.secondary_foodtype

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetANRAtlas(1)

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
    ---------------------

    inst:AddComponent("tradable")

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return
       Prefab("berries_juicy", fn, assets, prefabs),
       Prefab("berries_juicy_cooked", fn_cooked, assets_cooked)



