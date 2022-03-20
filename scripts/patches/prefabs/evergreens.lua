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

local STAGE_PETRIFY_ANIMS =
{
    "petrify_short",
    "petrify_normal",
    "petrify_tall",
    "petrify_old",
}

local function onhauntworkevergreen(inst, haunter)
    if inst.components.workable ~= nil and math.random() <= TUNING.HAUNT_CHANCE_OFTEN then
        inst.components.workable:WorkedBy(haunter, 1)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local function spawn_leif(target)
    target.noleif = true
    target.leifscale = target.components.growable.stages[target.components.growable.stage].leifscale or 1
    target:DoTaskInTime(1 + math.random()*3, function() 
        if target and not target:HasTag("stump") and not target:HasTag("burnt") and
            target.components.growable and target.components.growable.stage <= 3 then
            local leif = SpawnPrefab(target.build == "sparse" and "leif_sparse" or "leif")
            if leif then
                local scale = target.leifscale
                local r,g,b,a = target.AnimState:GetMultColour()
                leif.AnimState:SetMultColour(r,g,b,a)
                
                --we should serialize this?
                leif.components.locomotor.walkspeed = leif.components.locomotor.walkspeed*scale
                leif.components.combat.defaultdamage = leif.components.combat.defaultdamage*scale
                leif.components.health.maxhealth = leif.components.health.maxhealth*scale
                leif.components.health.currenthealth = leif.components.health.currenthealth*scale
                leif.components.combat.hitrange = leif.components.combat.hitrange*scale
                leif.components.combat.attackrange = leif.components.combat.attackrange*scale
                
                leif.Transform:SetScale(scale,scale,scale) 
                leif.components.combat:SuggestTarget(chopper)
                leif.sg:GoToState("spawn")
                target:Remove()
                
                leif.Transform:SetPosition(target.Transform:GetWorldPosition())
            end
        end
    end)
end

local function onhauntevergreen(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_SUPERRARE and
        find_leif_spawn_target(inst) and
        not (inst:HasTag("burnt") or inst:HasTag("stump")) then

        inst.leifscale = GetGrowthStages(inst)[inst.components.growable.stage].leifscale or 1
        spawn_leif(inst)

        inst.components.hauntable.hauntvalue = TUNING.HAUNT_HUGE
        inst.components.hauntable.cooldown_on_successful_haunt = false
        return true
    end
    return onhauntworkevergreen(inst, haunter)
end

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

local function onpetrifiedfn_evergreen(inst)
    if inst.components.growable ~= nil and not inst:HasTag("stump") then
        local stage = inst.components.growable.stage
        if STAGE_PETRIFY_ANIMS[stage] ~= nil then
            if POPULATING then
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
    if not POPULATING then
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

return function(inst)
    if not inst.components.hauntable then inst:AddComponent("hauntable") end
    inst.components.hauntable:SetOnHauntFn(onhauntevergreen)

    inst:AddComponent("petrifiable")
    inst.components.petrifiable:SetPetrifiedFn(onpetrifiedfn_evergreen)
    
    inst:AddComponent("plantregrowth")
    inst.components.plantregrowth:SetRegrowthRate(inst.build == "sparse" and TUNING.EVERGREEN_SPARSE_REGROWTH.OFFSPRING_TIME or TUNING.EVERGREEN_REGROWTH.OFFSPRING_TIME)
    inst.components.plantregrowth:SetProduct(inst.build == "sparse" and "lumpy_sapling" or "pinecone_sapling")
    inst.components.plantregrowth:SetSearchTag(inst.build == "sparse" and "evergreen_sparse" or "evergreen")
end