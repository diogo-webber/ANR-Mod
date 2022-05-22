return function(inst)
    if inst.prefab == "homesign_placer" then
        inst.AnimState:Hide("WRITING")
        return
    end
    inst:AddTag("_writeable")

    inst:AddComponent("writeable")
end