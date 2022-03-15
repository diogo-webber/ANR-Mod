local prefabs =
{
    "grassgekko",
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst:AddTag("herd")
    inst:AddTag("NOBLOCK")
    inst:AddTag("NOCLICK")

    inst:AddComponent("herd")
    inst.components.herd:SetMemberTag("grassgekko")
    inst.components.herd:SetGatherRange(40)
    inst.components.herd:SetUpdateRange(20)
    inst.components.herd:SetOnEmptyFn(inst.Remove)

    return inst
end

return Prefab("grassgekkoherd", fn, nil, prefabs)
