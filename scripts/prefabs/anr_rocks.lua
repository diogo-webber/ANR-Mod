
local rock_moon_assets =
{
    Asset("ANIM", "anim/rock7.zip"),
    Asset("MINIMAP_IMAGE", "rock_moon"),
}

local rock_moon_shell_assets =
{
    Asset("ANIM", "anim/moonrock_shell.zip"),
    Asset("MINIMAP_IMAGE", "rock_moon"),
}

local rock_petrified_tree_assets =
{
    Asset("ANIM", "anim/petrified_tree.zip"),
    Asset("ANIM", "anim/petrified_tree_tall.zip"),
    Asset("ANIM", "anim/petrified_tree_short.zip"),
    Asset("ANIM", "anim/petrified_tree_old.zip"),
    Asset("MINIMAP_IMAGE", "petrified_tree"),
}

local prefabs =
{
    "rocks",
    "nitre",
    "flint",
    "moonrockseed",
    "moonrocknugget",
    "rock_break_fx",
    "collapse_small",
}


SetSharedLootTable( 'rock_moon',
{
    {'rocks',           1.00},
    {'flint',           1.00},
    {'moonrocknugget',  1.00},
    {'moonrocknugget',  1.00},
    {'moonrocknugget',  0.6},
    {'moonrocknugget',  0.3},
})

SetSharedLootTable( 'rock_moon_shell',
{
    {'rocks',           1.00},
    {'flint',           1.00},
    {'moonrocknugget',  1.00},
    {'moonrocknugget',  1.00},
    {'moonrocknugget',  1.00},
    {'moonrocknugget',  0.3},
})

SetSharedLootTable( 'rock_petrified_tree',
{
    {'rocks',  1.00},
    {'rocks',  0.75},
    {'nitre',  0.4},
    {'flint',  0.25},
})
SetSharedLootTable( 'rock_petrified_tree_tall',
{
    {'rocks',  1.00},
    {'rocks',  1.00},
    {'rocks',  0.35},
    {'nitre',  0.65},
    {'flint',  0.75},
})
SetSharedLootTable( 'rock_petrified_tree_short',
{
    {'rocks',  1.00},
    {'rocks',  0.35},
    {'nitre',  0.25},
    {'flint',  0.25},
})
SetSharedLootTable( 'rock_petrified_tree_old',
{
    {'rocks',  0.50},
    {'rocks',  0.50},
    {'nitre',  0.25},
    {'flint',  0.75},
})

local function OnWork(inst, worker, workleft)
    if workleft <= 0 then
        local pt = inst:GetPosition()
        SpawnPrefab("rock_break_fx").Transform:SetPosition(pt:Get())
        inst.components.lootdropper:DropLoot(pt)

        if inst.showCloudFXwhenRemoved then
            local fx = SpawnPrefab("collapse_small")
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end

		if not inst.doNotRemoveOnWorkDone then
	        inst:Remove()
		end
    else
        inst.AnimState:PlayAnimation(
            (workleft < TUNING.ROCKS_MINE / 3 and "low") or
            (workleft < TUNING.ROCKS_MINE * 2 / 3 and "med") or
            "full"
        )
    end
end

local function setPetrifiedTreeSize(inst)
    if inst.treeSize == 4 then
        inst.AnimState:SetBuild("petrified_tree_old")
        inst.AnimState:SetBank("petrified_tree_old")
        inst.components.lootdropper:SetChanceLootTable('rock_petrified_tree_old')
        inst.components.workable:SetWorkLeft(TUNING.PETRIFIED_TREE_OLD)
        inst.Physics:SetCapsule(.25, 2)
    elseif inst.treeSize == 3 then
        inst.AnimState:SetBuild("petrified_tree_tall")
        inst.AnimState:SetBank("petrified_tree_tall")
        inst.components.lootdropper:SetChanceLootTable('rock_petrified_tree_tall')
        inst.components.workable:SetWorkLeft(TUNING.PETRIFIED_TREE_TALL)
        inst.Physics:SetCapsule(1, 2)
    elseif inst.treeSize == 1 then
        inst.AnimState:SetBuild("petrified_tree_short")
        inst.AnimState:SetBank("petrified_tree_short")
        inst.components.lootdropper:SetChanceLootTable('rock_petrified_tree_short')
        inst.components.workable:SetWorkLeft(TUNING.PETRIFIED_TREE_SMALL)
        inst.Physics:SetCapsule(.25, 2)
    else
        inst.AnimState:SetBuild("petrified_tree")
        inst.AnimState:SetBank("petrified_tree")
        inst.components.lootdropper:SetChanceLootTable('rock_petrified_tree')
        inst.components.workable:SetWorkLeft(TUNING.PETRIFIED_TREE_NORMAL)
        inst.Physics:SetCapsule(.65, 2)
    end
end

local function onsave(inst, data)
    data.treeSize = inst.treeSize
end

local function onload(inst, data)
    if data ~= nil and data.treeSize ~= nil then
        inst.treeSize = data.treeSize
        --V2C: Note that this will reset workleft as well
        --     Gotta change this if you set workable to savestate
        setPetrifiedTreeSize(inst)
    end
end

local function baserock_fn(bank, build, anim, icon, tag, multcolour)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    AddMinimapAtlas("minimap/minimap_data_anr.xml")

    MakeObstaclePhysics(inst, 1)

    if icon ~= nil then
        inst.MiniMapEntity:SetIcon(icon)
    end

    inst.AnimState:SetBank(bank)
    inst.AnimState:SetBuild(build)

    if type(anim) == "table" then
        for i, v in ipairs(anim) do
            if i == 1 then
                inst.AnimState:PlayAnimation(v)
            else
                inst.AnimState:PushAnimation(v, false)
            end
        end
    else
        inst.AnimState:PlayAnimation(anim)
    end

    inst:AddTag("boulder")
    if tag ~= nil then
        inst:AddTag(tag)
    end

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork)

    if multcolour == nil or (0 <= multcolour and multcolour < 1) then
        if multcolour == nil then
            multcolour = 0.5
        end

        local color = multcolour + math.random() * (1.0 - multcolour)
        inst.AnimState:SetMultColour(color, color, color, 1)
    end

    inst:AddComponent("inspectable")
    inst.components.inspectable.nameoverride = "ROCK"

    MakeSnowCovered(inst)
    --MakeHauntableWork(inst)

    return inst
end


local function rock_moon()
    local inst = baserock_fn("rock5", "rock7", "full", "rock_moon.png")

    inst.components.inspectable.nameoverride = "ROCK_MOON"
    inst.components.lootdropper:SetChanceLootTable('rock_moon')

    return inst
end

local function OnRockMoonCapsuleWorkFinished(inst)
    RemovePhysicsColliders(inst)

	local seed = SpawnPrefab("moonrockseed")
	seed.Transform:SetPosition(inst.Transform:GetWorldPosition())
    if seed.OnSpawned ~= nil then
        seed:OnSpawned()
    end

	inst.persists = false
    inst:AddTag("NOCLICK")

	inst.AnimState:PlayAnimation("break")
	inst:DoTaskInTime(2, ErodeAway) -- Leo: ErodeAway file?
end

local function rock_moon_shell()
    local inst = baserock_fn("moonrock_shell", "moonrock_shell", "full", "rock_moon.png", "meteor_protection")

    inst.components.inspectable.nameoverride = "ROCK_MOON"
    inst.components.lootdropper:SetChanceLootTable('rock_moon_shell')

	inst.doNotRemoveOnWorkDone = true
	inst:ListenForEvent("workfinished", OnRockMoonCapsuleWorkFinished)

    return inst
end



local function rock_petrified_tree_common(size)
    local inst = baserock_fn("petrified_tree", "petrified_tree", { "petrify_in", "full" }, "petrified_tree.png", "shelter")

    inst:SetPrefabName("rock_petrified_tree")
   
    inst.showCloudFXwhenRemoved = true

    if not size then
        local rand = math.random()
        if rand > 0.90 then
            size = 4
        elseif rand > 0.60 then
            size = 1
        elseif rand < 0.30 then
            size = 2
        else
            size = 3
        end
    end

    inst.treeSize = size

    setPetrifiedTreeSize(inst)

    inst.components.inspectable.nameoverride = "PETRIFIED_TREE"

    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

local function rock_petrified_tree()
    return rock_petrified_tree_common()
end

local function rock_petrified_tree_short()
    return rock_petrified_tree_common(1)
end

local function rock_petrified_tree_med()
    return rock_petrified_tree_common(2)
end

local function rock_petrified_tree_tall()
    return rock_petrified_tree_common(3)
end

local function rock_petrified_tree_old()
    return rock_petrified_tree_common(4)
end

return
    Prefab("rock_moon", rock_moon, rock_moon_assets, prefabs),
    --Prefab("rock_moon_shell", rock_moon_shell, rock_moon_shell_assets, prefabs),
    Prefab("rock_petrified_tree", rock_petrified_tree, rock_petrified_tree_assets, prefabs),
    Prefab("rock_petrified_tree_med", rock_petrified_tree_med, rock_petrified_tree_assets, prefabs),
    Prefab("rock_petrified_tree_tall", rock_petrified_tree_tall, rock_petrified_tree_assets, prefabs),
    Prefab("rock_petrified_tree_short", rock_petrified_tree_short, rock_petrified_tree_assets, prefabs),
    Prefab("rock_petrified_tree_old", rock_petrified_tree_old, rock_petrified_tree_assets, prefabs)
