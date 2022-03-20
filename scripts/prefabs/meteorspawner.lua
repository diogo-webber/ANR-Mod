local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
    inst:AddComponent("meteorshower")

    return inst
end

return Prefab("meteorspawner", fn)