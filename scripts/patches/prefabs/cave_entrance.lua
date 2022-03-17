return function(inst)
    inst.AnimState:SetLayer(_G.LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
    
    -- Add this to func Open in cave_entrance.lua

    --inst.AnimState:SetBank("cave_entrance")
    --inst.AnimState:SetBuild("cave_entrance")
    --inst.AnimState:PlayAnimation("open", true)
end