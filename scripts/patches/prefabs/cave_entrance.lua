return function(inst)
    local _Open = UpvalueHacker.GetUpvalue(inst.OnLoad, "Open")

    local function Open(inst)
        _Open(inst)
   
        inst.AnimState:SetLayer(LAYER_BACKGROUND)
        inst.AnimState:SetSortOrder(3)

        inst.AnimState:SetBank("cave_entrance")
        inst.AnimState:SetBuild("cave_entrance")
        inst.AnimState:PlayAnimation("open", true)    
    end
    UpvalueHacker.SetUpvalue(inst.OnLoad, Open, "Open")
end