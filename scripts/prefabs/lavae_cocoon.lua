local assets =
{
    Asset("ANIM", "anim/lavae_cocoon.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("lavae_cocoon")
    inst.AnimState:SetBuild("lavae_cocoon")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("molebait")

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    --inst.components.inventoryitem:SetSinks(true)

    MakeHauntableLaunch(inst)

    inst:AddComponent("bait")

    return inst
end

return Prefab("lavae_cocoon", fn, assets)
