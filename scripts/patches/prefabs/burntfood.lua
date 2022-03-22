return function(inst)
    if not inst.components.edible then 
        inst:AddComponent("edible") 
    end

    if not inst.components.tradable then 
        inst:AddComponent("tradable") 
    end

    inst.components.edible.foodtype = FOODTYPE.BURNT
    inst.components.edible.hungervalue = 20
    inst.components.edible.healthvalue = 20
end