require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/berrybush_juicy.zip"),
    Asset("INV_IMAGE", "dug_berrybush_juicy")
}

local function ondeploy(inst, pt, deployer)
    local tree = SpawnPrefab("berrybush_juicy")
    if tree ~= nil then
        tree.Transform:SetPosition(pt:Get())
        inst.components.stackable:Get():Remove()
        if tree.components.pickable ~= nil then
            tree.components.pickable:OnTransplant()
        end
        if deployer ~= nil and deployer.SoundEmitter ~= nil then
            deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)

    inst:AddTag("deployedplant")

    inst.AnimState:SetBank("berrybush_juicy")
    inst.AnimState:SetBuild("berrybush_juicy")
    inst.AnimState:PlayAnimation("dropped")

    --MakeInventoryFloatable(inst, {"large", 0.025, {0.65, 0.5, 0.65}})
    
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

    inst:AddComponent("inspectable")
    inst.components.inspectable.nameoverride = "dug_berrybush"
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetANRAtlas(1)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeMediumBurnable(inst, TUNING.LARGE_BURNTIME)
    MakeSmallPropagator(inst)

    MakeHauntableLaunchAndIgnite(inst)

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy
    inst.components.deployable.test = TestDeploy_Ground

    ---------------------
    return inst
end

return
    Prefab("dug_berrybush_juicy", fn, assets),
    MakePlacer("dug_berrybush_juicy_placer", "berrybush_juicy", "berrybush_juicy", "dead")



