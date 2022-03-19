return function(inst)
    if inst.prefab == "forest" then
        inst:AddComponent("forestpetrification")
    end
    inst:AddComponent("worldreset")
end