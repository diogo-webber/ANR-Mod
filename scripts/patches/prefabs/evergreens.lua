return function(inst)
        local STAGE_PETRIFY_PREFABS =
    {
        "rock_petrified_tree_short",
        "rock_petrified_tree_med",
        "rock_petrified_tree_tall",
        "rock_petrified_tree_old",
    }
    local STAGE_PETRIFY_FX =
    {
        "petrified_tree_fx_short",
        "petrified_tree_fx_normal",
        "petrified_tree_fx_tall",
        "petrified_tree_fx_old",
    }
    local function dopetrify(inst, stage, instant)
        local x, y, z = inst.Transform:GetWorldPosition()
        local r, g, b = inst.AnimState:GetMultColour()
        inst:Remove()
        --remap anim
        local rock = SpawnPrefab(STAGE_PETRIFY_PREFABS[stage])
        if rock ~= nil then
            rock.AnimState:SetMultColour(r, g, b, 1)
            rock.Transform:SetPosition(x, 0, z)
            if not instant then
                local fx = SpawnPrefab(STAGE_PETRIFY_FX[stage])
                fx.Transform:SetPosition(x, y, z)
                fx:InheritColour(r, g, b)
            end
        end
    end

    local STAGE_PETRIFY_ANIMS =
    {
        "petrify_short",
        "petrify_normal",
        "petrify_tall",
        "petrify_old",
    }
    local function onpetrifiedfn_evergreen(inst)
        if inst.components.growable ~= nil and not inst:HasTag("stump") then
            local stage = inst.components.growable.stage
            if STAGE_PETRIFY_ANIMS[stage] ~= nil then
                if _G.POPULATING then
                    dopetrify(inst, stage, true)
                else
                    inst.AnimState:PlayAnimation(STAGE_PETRIFY_ANIMS[stage])
                    inst.SoundEmitter:PlaySound("dontstarve/common/together/petrified/pre")
                    inst:AddTag("NOCLICK")
                    inst.noleif = true
                    inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), dopetrify, stage)
                end
                return
            end
        end
        if not _G.POPULATING then
            local fx = SpawnPrefab("petrified_trunk_break_fx")
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
            if inst.AnimState:IsCurrentAnimation("stump_short") then
                fx.Transform:SetScale(.75, .75, .75)
            elseif inst.AnimState:IsCurrentAnimation("stump_tall") then
                fx.Transform:SetScale(1.2, 1.2, 1.2)
            end
            fx:InheritColour(inst.AnimState:GetMultColour())
        end
        inst:Remove()
    end

    inst:AddComponent("petrifiable")
    inst.components.petrifiable:SetPetrifiedFn(onpetrifiedfn_evergreen)

end