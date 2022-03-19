--require("worldsettingsutil")

local assets =
{
	Asset("ANIM", "anim/batcave.zip"),
}

local prefabs =
{
	"bat"
}

local function onnear(inst)
    if inst.components.childspawner.childreninside >= inst.components.childspawner.maxchildren then
        local tries = 10
        while inst.components.childspawner:CanSpawn() and tries > 0 do
            local bat = inst.components.childspawner:SpawnChild()
            if bat ~= nil then
                bat:DoTaskInTime(0, function() bat:PushEvent("panic") end)
            end
            tries = tries - 1
        end
        inst.SoundEmitter:PlaySound("dontstarve/cave/bat_cave_explosion")
        inst.SoundEmitter:PlaySound("dontstarve/creatures/bat/taunt")
    end
end

local function onaddchild( inst, count )
    if inst.components.childspawner.childreninside == inst.components.childspawner.maxchildren then
        inst.AnimState:PlayAnimation("eyes",true)
        inst.SoundEmitter:PlaySound("dontstarve/cave/bat_cave_warning", "full")
    end
end

local function onspawnchild( inst, child )
    inst.AnimState:PlayAnimation("idle",true)
    inst.SoundEmitter:KillSound("full")
    inst.SoundEmitter:PlaySound("dontstarve/cave/bat_cave_bat_spawn")
end

local function OnPreLoad(inst, data)
    --WorldSettings_ChildSpawner_PreLoad(inst, data, TUNING.BATCAVE_SPAWN_PERIOD, TUNING.BATCAVE_REGEN_PERIOD)
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()

    inst.MiniMapEntity:SetIcon("batcave.png")

    inst.AnimState:SetBuild("batcave")
    inst.AnimState:SetBank("batcave")
    inst.AnimState:PlayAnimation("idle")

    MakeObstaclePhysics(inst, 1.3)

	inst:AddComponent("childspawner")
	inst.components.childspawner:SetRegenPeriod(TUNING.BATCAVE_REGEN_PERIOD)
	inst.components.childspawner:SetSpawnPeriod(TUNING.BATCAVE_SPAWN_PERIOD)
	inst.components.childspawner:SetMaxChildren(TUNING.BATCAVE_MAX_CHILDREN)
    --WorldSettings_ChildSpawner_SpawnPeriod(inst, TUNING.BATCAVE_SPAWN_PERIOD, TUNING.BATCAVE_ENABLED)
    --WorldSettings_ChildSpawner_RegenPeriod(inst, TUNING.BATCAVE_REGEN_PERIOD, TUNING.BATCAVE_ENABLED)
    if not TUNING.BATCAVE_ENABLED then
        inst.components.childspawner.childreninside = 0
    end
	inst.components.childspawner.childname = "bat"
    inst.components.childspawner:StartSpawning()
    inst.components.childspawner:StartRegen()
    inst.components.childspawner:SetOnAddChildFn( onaddchild )
    inst.components.childspawner:SetSpawnedFn( onspawnchild )
    -- initialize with no children
    inst.components.childspawner.childreninside = 0

    inst:AddComponent("inspectable")

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetDist(6, 40)

    if GetWorld():IsCave() then
        inst:ListenForEvent("daytime", function(data) inst.components.childspawner:StopSpawning() end, GetWorld())
        inst:ListenForEvent("dusktime", function(data) inst.components.childspawner:StartSpawning() end, GetWorld())
    end

    inst.OnPreLoad = OnPreLoad

	return inst
end

return Prefab("batcave", fn, assets, prefabs)
