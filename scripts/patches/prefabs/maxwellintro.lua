return function(inst)
    inst:DoTaskInTime(0, function()
        inst:Remove()
    end)
end