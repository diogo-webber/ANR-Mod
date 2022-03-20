return function(inst)
    if inst.prefab == "forest" then
        inst:AddComponent("forestpetrification")
        inst:AddComponent("worldmeteorshower")
    end
    inst:AddComponent("worldreset")
end