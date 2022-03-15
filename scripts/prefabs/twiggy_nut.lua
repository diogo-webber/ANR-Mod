require "prefabutil"

local function plant(inst, growtime)
    local sapling = SpawnPrefab(inst._spawn_prefab or "pinecone_sapling")
    sapling:StartGrowing()
    sapling.Transform:SetPosition(inst.Transform:GetWorldPosition())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst:Remove()
end

local function ondeploy(inst, pt, deployer)
    inst = inst.components.stackable:Get()
    inst.Physics:Teleport(pt:Get())
    local timeToGrow = GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
    plant(inst, timeToGrow)
end

local function OnLoad(inst, data)
    if data ~= nil and data.growtime ~= nil then
        plant(inst, data.growtime)
    end
end

local function addcone(name, spawn_prefab, bank, build, anim)
    local assets =
    {
        Asset("ANIM", "anim/"..build..".zip"),
    }
    if bank ~= build then
        table.insert(assets, Asset("ANIM", "anim/"..bank..".zip"))
    end

    local prefabs =
    {
        spawn_prefab,
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("deployedplant")
        inst:AddTag("cattoy")
        inst:AddTag("treeseed")

        --MakeInventoryFloatable(inst, "small", 0.05, 0.9)

        inst._spawn_prefab = spawn_prefab

        inst:AddComponent("tradable")

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("inspectable")

        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

        MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
        MakeSmallPropagator(inst)

        inst:AddComponent("inventoryitem")

        MakeHauntableLaunchAndIgnite(inst)

        inst:AddComponent("deployable")
        inst.components.deployable.test = TestDeploy_Ground
        inst.components.deployable.ondeploy = ondeploy

        --inst:AddComponent("forcecompostable") --Leo: Compost
        --inst.components.forcecompostable.brown = true

        -- This is left in for "save file upgrading", June 3 2015. We can remove it after some time.
        inst.OnLoad = OnLoad

        return inst
    end

    return
    Prefab(name, fn, assets, prefabs),
    MakePlacer(name.."_placer", bank, build, anim)
end

return addcone("twiggy_nut", "twiggy_nut_sapling", "twiggy_nut", "twiggy_nut", "idle_planted")

