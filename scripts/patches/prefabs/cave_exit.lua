return function(inst)
    MakeObstaclePhysics(inst, 1.5)
    inst.AnimState:SetBank("cave_stairs")
    inst.AnimState:SetBuild("cave_exit")
    inst.AnimState:PlayAnimation("open")
    inst:RemoveComponent("playerprox")
end