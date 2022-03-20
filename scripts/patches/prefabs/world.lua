return function(inst)
	inst.IsAtrium = function() return inst:HasTag("cave") and inst:HasTag("ruin") and inst:HasTag("atrium") end  --Asura: for future 3rd world

    if not (inst:IsCave() or inst:IsRuins() or inst:IsAtrium()) then
        inst:AddComponent("forestpetrification")
        inst:AddComponent("worldmeteorshower")
    end
    
    inst:AddComponent("worldreset")
    inst:AddComponent("forestresourcespawner") 
    inst:AddComponent("regrowthmanager")
    inst:AddComponent("desolationspawner")

    inst:PushEvent("ms_enableresourcerenewal", true)
end