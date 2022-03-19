local assets =
{
    Asset("ANIM", "anim/lifepen.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("lifepen")
    inst.AnimState:SetBuild("lifepen")
    inst.AnimState:PlayAnimation("idle")

    --MakeInventoryFloatable(inst)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetANRAtlas(1)
    inst:AddComponent("maxhealer")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("lifeinjector", fn, assets)