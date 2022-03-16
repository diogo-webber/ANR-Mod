require "tuning"

local function MakeVegStats(seedweight, hunger, health, perish_time, sanity, cooked_hunger, cooked_health, cooked_perish_time, cooked_sanity, float_settings, cooked_float_settings, dryable, secondary_foodtype, halloweenmoonmutable_settings, lure_data)
    return {
        health = health,
        hunger = hunger,
        cooked_health = cooked_health,
        cooked_hunger = cooked_hunger,
        seed_weight = seedweight,
        perishtime = perish_time,
        cooked_perishtime = cooked_perish_time,
        sanity = sanity,
        cooked_sanity = cooked_sanity,
        float_settings = float_settings,
        cooked_float_settings = cooked_float_settings,
		dryable = dryable,
		halloweenmoonmutable_settings = halloweenmoonmutable_settings,
		secondary_foodtype = secondary_foodtype,
        lure_data = lure_data,
    }
end

VEGGIES =
{
    berries_juicy = MakeVegStats(0, TUNING.CALORIES_SMALL,  TUNING.HEALING_TINY,  TUNING.PERISH_TWO_DAY, 0,
                                    TUNING.CALORIES_MEDSMALL,  TUNING.HEALING_SMALL,    TUNING.PERISH_ONE_DAY, 0,
                                    {"med", nil, 0.7}, nil,
									nil,
									FOODTYPE.BERRY,
									nil),
}

local function MakeVeggie(name)
    local assets =
    {
        Asset("ANIM", "anim/"..name..".zip"),
        Asset("INV_IMAGE", name),
    }

    local assets_cooked =
    {
        Asset("ANIM", "anim/"..name..".zip"),
        Asset("INV_IMAGE", name.."_cooked"),
    }

    local prefabs =
    {
        name .."_cooked",
        "spoiled_food",
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation("idle")

        --[[local float = VEGGIES[name].float_settings
        if float ~= nil then
            MakeInventoryFloatable(inst, float[1], float[2], float[3])
        else
            MakeInventoryFloatable(inst)
        end]]

        inst:AddComponent("edible")
        inst.components.edible.healthvalue = VEGGIES[name].health
        inst.components.edible.hungervalue = VEGGIES[name].hunger
        inst.components.edible.sanityvalue = VEGGIES[name].sanity or 0
        inst.components.edible.foodtype = FOODTYPE.VEGGIE
        inst.components.edible.secondaryfoodtype = VEGGIES[name].secondary_foodtype

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(VEGGIES[name].perishtime)
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
        inst.components.cookable.product = name.."_cooked"

        MakeHauntableLaunchAndPerish(inst)

        return inst
    end

    local function fn_cooked()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation("cooked")

        --[[local float = VEGGIES[name].cooked_float_settings
        if float ~= nil then
            MakeInventoryFloatable(inst, float[1], float[2], float[3])
        else
            MakeInventoryFloatable(inst)
        end]]

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(VEGGIES[name].cooked_perishtime)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = "spoiled_food"

        inst:AddComponent("edible")
        inst.components.edible.healthvalue = VEGGIES[name].cooked_health
        inst.components.edible.hungervalue = VEGGIES[name].cooked_hunger
        inst.components.edible.sanityvalue = VEGGIES[name].cooked_sanity or 0
        inst.components.edible.foodtype = FOODTYPE.VEGGIE
        inst.components.edible.secondaryfoodtype = VEGGIES[name].secondary_foodtype

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

    local exported_prefabs = {}

    table.insert(exported_prefabs, Prefab(name, fn, assets, prefabs))
    table.insert(exported_prefabs, Prefab(name.."_cooked", fn_cooked, assets_cooked))

    return exported_prefabs
end

local prefs = {}
for veggiename,veggiedata in pairs(VEGGIES) do
    local veggies = MakeVeggie(veggiename)
	for _, v in ipairs(veggies) do
		table.insert(prefs, v)
	end
end

return unpack(prefs)
