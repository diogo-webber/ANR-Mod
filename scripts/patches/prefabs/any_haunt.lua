local HauntableLaunch = {
    "abigail_flower", "acorn_cooked", "blueamulet", "purpleamulet",
    "orangeamulet", "greenamulet", "yellowamulet", "armor_bramble",
    "armordragonfly", "armorgrass", "armorruins", "armor_sanity",
    "armorslurper", "armorsnurtleshell", "armorwood", "axe", "goldenaxe",
    "multitool_axe_pickaxe", "bandage", "batbat", "beargervest", "bearger_fur",
    "beeswax", "blowdart_sleep", "blowdart_fire", "blowdart_pipe",
    "blowdart_walrus", "blueprint", "boneshard", "book_tentacles", "book_birds",
    "book_brimstone", "book_sleep", "book_gardening", "boomerang", "brush",
    "bugnet", "cactus_flower", "cane", "chester_eyebone", "compass", "coontail",
    "cutstone", "deerclops_eyeball", "diviningrod", "dragon_scales",
    "eyeturret_item", "featherfan", "fence_gate_item", "fence_item",
    "fertilizer", "fishingrod", "glommerflower", "glommerfuel", "glommerwings",
    "goatmilk", "goose_feather", "hammer", -- "forhats",
    "hawaiianshirt", "healingsalve", "honeycomb", "horn", "houndbone",
    "lighter", "lightninggoathorn", "lucy", "lantern", "minotaurhorn",
    "nightmarefuel", "nightmare_timepiece", "nightstick", "nightsword",
    "panflute", "phlegm", "pickaxe", "goldenpickaxe", "pitchfork", "raincoat",
    "razor", "reflectivevest", "ruins_bat", "saddle_basic", "saddle_war",
    "saddle_race", "saddlehorn", "saltlick", "sewing_kit", "shovel",
    "goldenshovel", "silk", "slurtle_shellpieces", "spear", "spear_wathgrithr",
    "icestaff", "firestaff", "telestaff", "orangestaff", "greenstaff",
    "yellowstaff", "staff_tornado", "stinger", "sweatervest", "tallbirdegg",
    "tallbirdegg_cracked", "teleportato_ring", "teleportato_box",
    "teleportato_crank", "teleportato_potato", "tentaclespike", "torch",
    "transistor", "trap", "trunkvest_summer", "trunkvest_winter", "umbrella",
    "grass_umbrella", "wall_stone_item", "wall_wood_item", "wall_hay_item",
    "wall_ruins_item", "walrus_tusk"
}

local HauntableLaunchAndSmash = {
    "flint", "gears", "purplegem", "bluegem", "redgem", "orangegem",
    "yellowgem", "greengem", "goldnugget", "heatrock", "houndstooth", "marble",
    "rocks", "ice", "nitre", "thulecite", "thulecite_pieces"
}

for i = 1, 45 do table.insert(HauntableLaunchAndSmash, "trinket_" .. i) end

local HauntableWork = {
    "ancient_altar", "ancient_altar_broken", "beebox", "chessjunk",
    "chessjunk1", "chessjunk2", "chessjunk3", "evergreen", "evergreen_normal",
    "evergreen_tall", "evergreen_short", "evergreen_sparse",
    "evergreen_sparse_normal", "evergreen_sparse_tall",
    "evergreen_sparse_short", "fence_gate", "fence", "firesuppressor",
    "homesign", "lightning_rod", "marblepillar", "meatrack", "minisign",
    "mooseegg", "pighouse", "pottedfern", "rabbithouse", "rainometer", "rock1",
    "rock2", "rock_flintless", "rock_flintless_med", "rock_flintless_low",
    "rock_ice", "rubble", "rubble_med", "rubble_low", "ruins_plate",
    "ruins_bowl", "ruins_chair", "ruins_chipbowl", "ruins_vase", "ruins_table",
    "ruins_rubble_table", "ruins_rubble_chair", "ruins_rubble_vase",
    "spiderhole", "stalagmite_full", "stalagmite_med", "stalagmite_low",
    "stalagmite", "stalagmite_tall_full", "stalagmite_tall_med",
    "stalagmite_tall_low", "stalagmite_tall", "statueglommer", "statueharp",
    "statuemaxwell", "ruins_statue_head", "ruins_statue_head_nogem",
    "ruins_statue_mage", "ruins_statue_mage_nogem", "telebase", "tent",
    "siestahut", "wall_stone", "wall_wood", "wall_hay", "wall_ruins",
    "winterometer", "wall_ruins", "wall_ruins", "wall_ruins"
}

local HauntableWorkAndIgnite = {"cave_banana_burnt", "livingtree", "marsh_tree"}

local HauntableFreeze = {"eyeturret"}

local HauntableIgnite = {
    "pinecone_sapling", "lumpy_sapling", "acorn_sapling", "berrybush",
    "berrybush2", "birchnutdrake", "cactus", "catcoonden", "cave_fern",
    "eyeplant", "flower_cave", "flower_cave_double", "flower_cave_triple",
    "flower_evil", "grass", "leif", "leif_sparse", "lichen", "marsh_bush",
    "marsh_plant", "pond_algae", "reeds", "sapling", "slurtlehole",
    "wormlight_plant"
}

local HauntableLaunchAndIgnite = {
    "acorn", "beardhair", "bedroll_straw", "bedroll_furry", "beefalowool",
    "boards", "bundle", "bundlewrap", "charcoal", "compostwrap", "cutgrass",
    "cutreeds", "rottenegg", "featherpencil", "feather_crow", "feather_robin",
    "feather_robin_winter", "foliage", "guano", "lightbulb", "livinglog", "log",
    "lureplantbulb", "manrabbit_tail", "minisign_item", "minisign_drawn",
    "mosquitosack", "papyrus", "pigskin", "pinecone", "dug_berrybush",
    "dug_berrybush2", "dug_sapling", "dug_grass", "dug_marsh_bush", "poop",
    "rope", "slurtleslime", "spidereggsack", "spidergland", "spoiled_food",
    "steelwool", "tentaclespots", "poop", "twigs", "waxpaper"
    -- "turfs",
}

local HauntableLaunchOrChangePrefab = {}

local HauntablePerish = {}

local HauntableLaunchAndPerish = {
    "butter", "butterflywings", "cutlichen", "eel", "eel_cooked", "bird_egg",
    "bird_egg_cooked", "cave_banana", "cave_banana_cooked", "carrot",
    "carrot_seeds", "carrot_cooked", "corn", "corn_seeds", "corn_cooked",
    "pumpkin", "pumpkin_seeds", "pumpkin_cooked", "eggplant", "eggplant_seeds",
    "eggplant_cooked", "durian", "durian_seeds", "durian_cooked", "pomegranate",
    "pomegranate_seeds", "pomegranate_cooked", "dragonfruit",
    "dragonfruit_seeds", "dragonfruit_cooked", "berries", "berries_cooked",
    "cactus_meat", "cactus_meat_cooked", "watermelon", "watermelon_seeds",
    "watermelon_cooked", "fish", "fish_cooked", "froglegs", "froglegs_cooked",
    "hambat", -- "hats",
    "honey", "meat", "cookedmeat", "meat_dried", "monstermeat",
    "cookedmonstermeat", "monstermeat_dried", "smallmeat", "cookedsmallmeat",
    "smallmeat_dried", "drumstick", "drumstick_cooked", "batwing",
    "batwing_cooked", "plantmeat", "plantmeat_cooked", -- "food",
    "pumpkin_lantern", -- "seeds",
    "trunk_summer", "trunk_winter", "trunk_cooked"
}

local HauntablePanic = {
    "babybeefalo", "bat", "bishop", "bunnyman", "frog", "glommer", "knight",
    "knight_nightmare", "koalefant_summer", "koalefant_winter", "krampus",
    "lightninggoat", "merm", "molebat", "mossling", "penguin", "perd", "rabbit",
    "rook", "rook_nightmare", "slurper", "smallbird", "teenbird", "tallbird",
    "spider", "spider_warrior", "spider_hider", "spider_spitter",
    "spider_dropper", "walrus", "little_walrus"
}

local HauntablePanicAndIgnite = {"butterfly", "catcoon"}

local HauntablePlayAnim = {}

local HauntableDropFirstItem = {}

local HauntableLaunchAndDropFirstItem = {
    "backpack", "candybag", "icepack", "krampus_sack", "piggyback", "spicepack"
}

local HauntableDropItemOrWork = {"dragonflychest", "icebox"}

local function OnHauntLurePlant(inst)
    -- if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
    HideBait(inst)
    inst.components.hauntable.hauntvalue = TUNING.HAUNT_TINY
    return true
    -- end
    -- return false
end

local function OnSpawnedFromHauntHound(inst)
    if inst.components.hauntable ~= nil then
        inst.components.hauntable:Panic()
    end
end

local function OnHauntCapOrCooked(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE then
        local x, y, z = inst.Transform:GetWorldPosition()
        SpawnPrefab("small_puff").Transform:SetPosition(x, y, z)
        local prefab = pickswitchprefab(inst)
        local new = prefab ~= nil and SpawnPrefab(prefab) or nil
        if new ~= nil then
            new.Transform:SetPosition(x, y, z)
            if new.components.stackable ~= nil and inst.components.stackable ~=
                nil and inst.components.stackable:IsStack() then
                new.components.stackable:SetStackSize(
                    inst.components.stackable:StackSize())
            end
            if new.components.inventoryitem ~= nil and
                inst.components.inventoryitem ~= nil then
                new.components.inventoryitem:InheritMoisture(inst.components
                                                                 .inventoryitem:GetMoisture(),
                                                             inst.components
                                                                 .inventoryitem:IsWet())
            end
            if new.components.perishable ~= nil and inst.components.perishable ~=
                nil then
                new.components.perishable:SetPercent(
                    inst.components.perishable:GetPercent())
            end
            new:PushEvent("spawnedfromhaunt",
                          {haunter = haunter, oldPrefab = inst})
            inst:PushEvent("despawnedfromhaunt",
                           {haunter = haunter, newPrefab = new})
            inst.persists = false
            inst.entity:Hide()
            inst:DoTaskInTime(0, inst.Remove)
        end
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
        return true
    end
    return false
end

local function OnSpawnedFromHauntCap(inst, data)
    Launch(inst, data.haunter, TUNING.LAUNCH_SPEED_SMALL)
end

local function OnHauntFlower(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_HALF then
        local x, y, z = inst.Transform:GetWorldPosition()
        SpawnPrefab("small_puff").Transform:SetPosition(x, y, z)
        local new = SpawnPrefab("petals_evil")
        if new ~= nil then
            new.Transform:SetPosition(x, y, z)
            if new.components.stackable ~= nil and inst.components.stackable ~=
                nil and inst.components.stackable:IsStack() then
                new.components.stackable:SetStackSize(
                    inst.components.stackable:StackSize())
            end
            if new.components.inventoryitem ~= nil and
                inst.components.inventoryitem ~= nil then
                new.components.inventoryitem:InheritMoisture(inst.components
                                                                 .inventoryitem:GetMoisture(),
                                                             inst.components
                                                                 .inventoryitem:IsWet())
            end
            if new.components.perishable ~= nil and inst.components.perishable ~=
                nil then
                new.components.perishable:SetPercent(
                    inst.components.perishable:GetPercent())
            end
            new:PushEvent("spawnedfromhaunt",
                          {haunter = haunter, oldPrefab = inst})
            inst:PushEvent("despawnedfromhaunt",
                           {haunter = haunter, newPrefab = new})
            inst.persists = false
            inst.entity:Hide()
            inst:DoTaskInTime(0, inst.Remove)
        end
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local function OnSpawnedFromHauntKillerBee(inst)
    if inst.components.hauntable ~= nil then
        inst.components.hauntable:Panic()
    end
end

local function CustomOnHauntBeefalo(inst)
    inst.components.periodicspawner:TrySpawn()
    return true
end

local function CustomOnHauntPig(inst)
    if not inst:HasTag("werepig") and math.random() <=
        TUNING.HAUNT_CHANCE_OCCASIONAL then
        local remainingtime = TUNING.TOTAL_DAY_TIME -- * (1 - TheWorld.state.time)
        local mintime = TUNING.SEG_TIME
        inst.components.werebeast:SetWere(
            math.max(mintime, remainingtime) + math.random() * TUNING.SEG_TIME)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
    end
end

local function grow(inst, dt)
    if inst.components.scaler.scale < TUNING.ROCKY_MAX_SCALE then
        local new_scale = math.min(inst.components.scaler.scale +
                                       TUNING.ROCKY_GROW_RATE * dt,
                                   TUNING.ROCKY_MAX_SCALE)
        inst.components.scaler:SetScale(new_scale)
    elseif inst.growtask ~= nil then
        inst.growtask:Cancel()
        inst.growtask = nil
    end
end

local function CustomOnHauntRocky(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
        grow(inst, 500)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
        if inst.growtask ~= nil then
            inst.growtask:Cancel()
            local dt = 60 + math.random() * 10
            inst.growtask = inst:DoPeriodicTask(dt, grow, nil, dt)
        end
        return true
    end
    return false
end

local function OnHauntChester(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
        inst.components.hauntable.panic = true
        inst.components.hauntable.panictimer = TUNING.HAUNT_PANIC_TIME_SMALL
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local BLUE_HAUNT_MUST_TAGS = {"freezable"}
local BLUE_HAUNT_CANT_TAGS = {"FX", "NOCLICK", "DECOR", "INLIMBO"}
local function OnHauntBlue(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 10, BLUE_HAUNT_MUST_TAGS,
                                         BLUE_HAUNT_CANT_TAGS)
        for i, v in ipairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(.67)
                v.components.freezable:SpawnShatterFX()
            end
        end
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
    end
end

local function OnHauntBerrybush(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
        if inst.components.pickable ~= nil and
            not inst.components.pickable:CanBePicked() and
            inst.components.pickable:IsBarren() then
            inst.AnimState:PlayAnimation("shake_dead")
            inst.AnimState:PushAnimation("dead", false)
        else
            inst.AnimState:PlayAnimation("shake")
            inst.AnimState:PushAnimation("idle")
        end
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_COOLDOWN_TINY
        return true
    end
    return false
end

local function OnHauntBluePrint(inst, haunter)
    if not inst.is_rare and math.random() <= TUNING.HAUNT_CHANCE_HALF then
        local recipes = {}
        local old =
            inst.recipetouse ~= nil and GetValidRecipe(inst.recipetouse) or nil
        for k, v in pairs(AllRecipes) do
            if IsRecipeValid(v.name) and old ~= v and
                (old == nil or old.tab == v.tab) and CanBlueprintRandomRecipe(v) and
                not haunter.components.builder:KnowsRecipe(v) and
                haunter.components.builder:CanLearn(v.name) then
                table.insert(recipes, v)
            end
        end
        if #recipes > 0 then
            inst.recipetouse = recipes[math.random(#recipes)].name or "unknown"
            inst.components.teacher:SetRecipe(inst.recipetouse)
            inst.components.named:SetName(
                STRINGS.NAMES[string.upper(inst.recipetouse)] .. " " ..
                    STRINGS.NAMES.BLUEPRINT)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
            return true
        end
    end
    return false
end

local function CustomOnHauntLucy(inst)
    if inst.components.sentientaxe ~= nil then
        inst.components.sentientaxe:Say(STRINGS.LUCY.on_haunt)
        return true
    end
    return false
end

local function AddMonsterMeatChange(inst, prefab)
    AddHauntableCustomReaction(inst, function(inst, haunter)
        if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
            local x, y, z = inst.Transform:GetWorldPosition()
            SpawnPrefab("small_puff").Transform:SetPosition(x, y, z)
            local new = SpawnPrefab(prefab)
            if new ~= nil then
                new.Transform:SetPosition(x, y, z)
                if new.components.stackable ~= nil and inst.components.stackable ~=
                    nil and inst.components.stackable:IsStack() then
                    new.components.stackable:SetStackSize(inst.components
                                                              .stackable:StackSize())
                end
                if new.components.inventoryitem ~= nil and
                    inst.components.inventoryitem ~= nil then
                    new.components.inventoryitem:InheritMoisture(
                        inst.components.inventoryitem:GetMoisture(),
                        inst.components.inventoryitem:IsWet())
                end
                if new.components.perishable ~= nil and
                    inst.components.perishable ~= nil then
                    new.components.perishable:SetPercent(inst.components
                                                             .perishable:GetPercent())
                end
                new:PushEvent("spawnedfromhaunt",
                              {haunter = haunter, oldPrefab = inst})
                inst:PushEvent("despawnedfromhaunt",
                               {haunter = haunter, newPrefab = new})
                inst.persists = false
                inst.entity:Hide()
                inst:DoTaskInTime(0, inst.Remove)
            end
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
            return true
        end
        return false
    end, false, true, false)
end

local TARGET_MUST_TAGS = {"combat", "health"}
local TARGET_CANT_TAGS = {"playerghost", "spider", "INLIMBO"}
local function CustomOnHauntSpiderHole(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_HALF then
        local target =
            FindEntity(inst, 25, CanTarget, TARGET_MUST_TAGS, -- see entityreplica.lua
                       TARGET_CANT_TAGS)
        if target ~= nil then
            spawner_onworked(inst, target)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
            return true
        end
    end
end

local REDHAUNTTARGET_MUST_TAGS = {"canlight"}
local REDHAUNTTARGET_CANT_TAGS = {"fire", "burnt", "INLIMBO"}
local function onhauntred(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE then
        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 6, REDHAUNTTARGET_MUST_TAGS,
                                         REDHAUNTTARGET_CANT_TAGS)
        if #ents > 0 then
            for i, v in ipairs(ents) do
                if v:IsValid() and not v:IsInLimbo() then
                    onattack_red(inst, haunter, v, true)
                end
            end
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
    end
    return false
end

local BLUEHAUNTTARGET_MUST_TAGS = {"freezable"}
local BLUEHAUNTTARGET_CANT_TAGS = {"INLIMBO"}
local function onhauntblue(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE then
        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 6, BLUEHAUNTTARGET_MUST_TAGS,
                                         BLUEHAUNTTARGET_CANT_TAGS)
        if #ents > 0 then
            for i, v in ipairs(ents) do
                if v:IsValid() and not v:IsInLimbo() then
                    onattack_blue(inst, haunter, v, true)
                end
            end
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
    end
    return false
end

local function getrandomposition(inst)
    local ground = GetWorld()
    local centers = {}
    for i, node in ipairs(ground.topology.nodes) do
        local tile = GetWorld().Map:GetTileAtPoint(node.x, 0, node.y)
        if tile and tile ~= GROUND.IMPASSABLE then
            table.insert(centers, {x = node.x, z = node.y})
        end
    end
    if #centers > 0 then
        local pos = centers[math.random(#centers)]
        return Point(pos.x, 0, pos.z)
    else
        return GetPlayer():GetPosition()
    end
end

local function canteleport(inst, caster, target)
    if target then return target.components.locomotor ~= nil end

    return true
end

local function teleport_thread(inst, caster, teletarget, loctarget)
    local ground = GetWorld()

    local t_loc = nil
    if loctarget then
        t_loc = loctarget:GetPosition()
    else
        t_loc = getrandomposition()
    end

    local teleportee = teletarget
    local pt = teleportee:GetPosition()
    if teleportee.components.locomotor then
        teleportee.components.locomotor:StopMoving()
    end

    inst.components.finiteuses:Use(1)

    if ground.topology.level_type == "cave" then
        TheCamera:Shake("FULL", 0.3, 0.02, .5, 40)
        ground.components.quaker:MiniQuake(3, 5, 1.5, teleportee)
        return
    end

    if teleportee.components.health then
        teleportee.components.health:SetInvincible(true)
    end

    GetSeasonManager():DoLightningStrike(pt)
    teleportee:Hide()

    if teleportee == GetPlayer() then
        TheFrontEnd:Fade(false, 2)
        Sleep(3)
    end

    if caster.components.sanity then
        caster.components.sanity:DoDelta(-TUNING.SANITY_HUGE)
    end

    if ground.components.seasonmanager then
        ground.components.seasonmanager:ForcePrecip()
    end

    teleportee.Transform:SetPosition(t_loc.x, 0, t_loc.z)

    if teleportee == GetPlayer() then
        TheCamera:Snap()
        TheFrontEnd:DoFadeIn(1)
        Sleep(1)
    end

    if loctarget and loctarget.onteleto then loctarget.onteleto(loctarget) end

    GetSeasonManager():DoLightningStrike(t_loc)
    teleportee:Show()

    if teleportee.components.health then
        teleportee.components.health:SetInvincible(false)
    end

    if teleportee == GetPlayer() then
        teleportee.sg:GoToState("wakeup")
        teleportee.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
    end
end

local function teleport_func(inst, target)
    local mindistance = 1
    local caster = inst.components.inventoryitem.owner
    local tar = target or caster
    local pt = tar:GetPosition()
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 9000, {"telebase"})

    if #ents <= 0 then
        -- There's no bases, active or inactive. Teleport randomly.
        inst.task = inst:StartThread(function()
            teleport_thread(inst, caster, tar)
        end)
        return
    end

    local targets = {}
    for k, v in pairs(ents) do
        local v_pt = v:GetPosition()
        if distsq(pt, v_pt) >= mindistance * mindistance then
            table.insert(targets, {base = v, distance = distsq(pt, v_pt)})
        end
    end

    table.sort(targets, function(a, b) return (a.distance) < (b.distance) end)
    for i = 1, #targets do
        local teletarget = targets[i]
        if teletarget.base and teletarget.base.canteleto(teletarget.base) then
            inst.task = inst:StartThread(function()
                teleport_thread(inst, caster, tar, teletarget.base)
            end)
            return
        end
    end

    inst.task = inst:StartThread(function()
        teleport_thread(inst, caster, tar)
    end)
end

local function onhauntpurple(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE then
        local target = FindEntity(inst, 20, nil, TELEPORT_MUST_TAGS,
                                  TELEPORT_CANT_TAGS)
        if target ~= nil then
            teleport_func(inst, target)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
    end
    return false
end

local ORANGEHAUNT_MUST_TAGS = {"locomotor"}
local ORANGEHAUNT_CANT_TAGS = {"playerghost", "INLIMBO"}

local function onhauntorange(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
        local target = FindEntity(inst, 20, nil, ORANGEHAUNT_MUST_TAGS,
                                  ORANGEHAUNT_CANT_TAGS)
        if target ~= nil then
            local pos = target:GetPosition()
            local start_angle = math.random() * 2 * PI
            local offset = FindWalkableOffset(pos, start_angle,
                                              math.random(8, 12), 16, false,
                                              true)
            if offset ~= nil then
                pos.x = pos.x + offset.x
                pos.y = 0
                pos.z = pos.z + offset.z
                inst.components.blinkstaff:Blink(pos, target)
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
                return true
            end
        end
    end
    return false
end

local function HasRecipe(guy)
    return guy.prefab ~= nil and GetRecipe[guy.prefab] ~= nil
end

local DESTSOUNDS = {
    { -- magic
        soundpath = "dontstarve/common/destroy_magic",
        ing = {"nightmarefuel", "livinglog"}
    }, { -- cloth
        soundpath = "dontstarve/common/destroy_clothing",
        ing = {"silk", "beefalowool"}
    }, { -- tool
        soundpath = "dontstarve/common/destroy_tool",
        ing = {"twigs"}
    }, { -- gem
        soundpath = "dontstarve/common/gem_shatter",
        ing = {
            "redgem", "bluegem", "greengem", "purplegem", "yellowgem",
            "orangegem"
        }
    }, { -- wood
        soundpath = "dontstarve/common/destroy_wood",
        ing = {"log", "board"}
    }, { -- stone
        soundpath = "dontstarve/common/destroy_stone",
        ing = {"rocks", "cutstone"}
    }, { -- straw
        soundpath = "dontstarve/common/destroy_straw",
        ing = {"cutgrass", "cutreeds"}
    }
}

local function candestroy(staff, caster, target)
    if not target then return false end

    local recipe = GetRecipe(target.prefab)

    return recipe ~= nil
end

local function SpawnLootPrefab(inst, lootprefab)
    if lootprefab then
        local loot = SpawnPrefab(lootprefab)
        if loot then

            local pt = Point(inst.Transform:GetWorldPosition())

            loot.Transform:SetPosition(pt.x, pt.y, pt.z)

            if loot.Physics then

                local angle = math.random() * 2 * PI
                loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))

                if loot.Physics and inst.Physics then
                    pt = pt + Vector3(math.cos(angle), 0, math.sin(angle)) *
                             (loot.Physics:GetRadius() +
                                 inst.Physics:GetRadius())
                    loot.Transform:SetPosition(pt.x, pt.y, pt.z)
                end

                loot:DoTaskInTime(1, function()
                    if not (loot.components.inventoryitem and
                        loot.components.inventoryitem:IsHeld()) then
                        if not loot:IsOnValidGround() then
                            local fx = SpawnPrefab("splash_ocean")
                            local pos = loot:GetPosition()
                            fx.Transform:SetPosition(pos.x, pos.y, pos.z)
                            -- PlayFX(loot:GetPosition(), "splash", "splash_ocean", "idle")
                            if loot:HasTag("irreplaceable") then
                                loot.Transform:SetPosition(
                                    GetPlayer().Transform:GetWorldPosition())
                            else
                                loot:Remove()
                            end
                        end
                    end
                end)
            end

            return loot
        end
    end
end

local function getsoundsforstructure(inst, target)

    local sounds = {}

    local recipe = GetRecipe(target.prefab)

    if recipe then
        for k, soundtbl in pairs(DESTSOUNDS) do
            for k2, ing in pairs(soundtbl.ing) do
                for k3, rec_ingredients in pairs(recipe.ingredients) do
                    if rec_ingredients.type == ing then
                        table.insert(sounds, soundtbl.soundpath)
                    end
                end
            end
        end
    end

    return sounds

end

local function destroystructure(staff, target)

    local ingredient_percent = 1

    if target.components.finiteuses then
        ingredient_percent = target.components.finiteuses:GetPercent()
    elseif target.components.fueled and target.components.inventoryitem then
        ingredient_percent = target.components.fueled:GetPercent()
    elseif target.components.armor and target.components.inventoryitem then
        ingredient_percent = target.components.armor:GetPercent()
    end

    local recipe = GetRecipe(target.prefab)

    local caster = staff.components.inventoryitem.owner

    local loot = {}

    if recipe then
        for k, v in ipairs(recipe.ingredients) do
            if not string.find(v.type, "gem") then
                local amt = math.ceil(v.amount * ingredient_percent)
                for n = 1, amt do table.insert(loot, v.type) end
            end
        end
    end

    if #loot <= 0 then return end

    local sounds = {}
    sounds = getsoundsforstructure(staff, target)
    for k, v in pairs(sounds) do staff.SoundEmitter:PlaySound(v) end

    for k, v in pairs(loot) do SpawnLootPrefab(target, v) end

    if caster.components.sanity then
        caster.components.sanity:DoDelta(-TUNING.SANITY_MEDLARGE)
    end

    staff.SoundEmitter:PlaySound("dontstarve/common/staff_star_dissassemble")

    staff.components.finiteuses:Use(1)

    if target.components.inventory then
        target.components.inventory:DropEverything()
    end

    if target.components.container then
        target.components.container:DropEverything()
    end

    if target.components.stackable then
        -- if it's stackable we only want to destroy one of them.
        target = target.components.stackable:Get()
    end

    target:Remove()

    if target.components.resurrector and not target.components.resurrector.used then
        local player = GetPlayer()
        if player then player.components.health:RecalculatePenalty() end
    end
end

local GREENHAUNT_CANT_TAGS = {"INLIMBO"}
local function onhauntgreen(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE then
        local target =
            FindEntity(inst, 20, HasRecipe, nil, GREENHAUNT_CANT_TAGS)
        if target ~= nil then
            destroystructure(inst, target)
            SpawnPrefab("collapse_small").Transform:SetPosition(
                target.Transform:GetWorldPosition())
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
    end
    return false
end

local function createlight(staff, target, pos)
    local light = SpawnPrefab("stafflight")
    light.Transform:SetPosition(pos:Get())
    staff.components.finiteuses:Use(1)

    local caster = staff.components.inventoryitem.owner
    if caster ~= nil then
        if caster.components.staffsanity then
            caster.components.staffsanity:DoCastingDelta(-TUNING.SANITY_MEDLARGE)
        elseif caster.components.sanity ~= nil then
            caster.components.sanity:DoDelta(-TUNING.SANITY_MEDLARGE)
        end
    end
end

local function onhauntlight(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE then
        local pos = inst:GetPosition()
        local start_angle = math.random() * 2 * PI
        local offset = FindWalkableOffset(pos, start_angle, math.random(3, 12),
                                          60, false, true)
        if offset ~= nil then
            createlight(inst, nil, pos + offset)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
    end
    return false
end

local function CustomOnHauntTentArm(inst, haunter)
    if math.random() < TUNING.HAUNT_CHANCE_HALF and
        not inst.components.health:IsDead() then
        inst.components.health:Kill()
        return true
    end
    return false
end

local function CustomOnHauntTentPillar(inst, haunter)
    if math.random() < TUNING.HAUNT_CHANCE_RARE and
        not (inst.components.health:IsDead() or inst:HasTag("notarget")) then
        DoRetract(inst)
        return true
    end
    return false
end

local function CustomOnHauntWorm(inst, haunter)
    if inst:HasTag("lure") then
        if math.random() < TUNING.HAUNT_CHANCE_ALWAYS then
            inst.sg:GoToState("lure_exit")
            return true
        end
    else
        if inst.components.sleeper ~= nil then -- Wake up, there's a ghost!
            inst.components.sleeper:WakeUp()
        end

        if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
            inst.components.hauntable.panic = true
            inst.components.hauntable.panictimer = TUNING.HAUNT_PANIC_TIME_SMALL
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
            return true
        end
    end
    return false
end

-- Really Returning {Key Word: APPLY}

return function(inst)
    if table.contains(HauntableLaunch, tostring(inst.prefab)) then
        MakeHauntableLaunch(inst)

    elseif table.contains(HauntableLaunchAndSmash, tostring(inst.prefab)) then
        MakeHauntableLaunchAndSmash(inst)

    elseif table.contains(HauntableWork, tostring(inst.prefab)) then
        MakeHauntableWork(inst)

    elseif table.contains(HauntableWorkAndIgnite, tostring(inst.prefab)) then
        MakeHauntableWorkAndIgnite(inst)

    elseif table.contains(HauntableFreeze, tostring(inst.prefab)) then
        MakeHauntableFreeze(inst)

    elseif table.contains(HauntableIgnite, tostring(inst.prefab)) then
        MakeHauntableIgnite(inst)

    elseif table.contains(HauntableLaunchAndIgnite, tostring(inst.prefab)) then
        MakeHauntableLaunchAndIgnite(inst)

    elseif table.contains(HauntableLaunchOrChangePrefab, tostring(inst.prefab)) then
        MakeHauntableLaunchOrChangePrefab(inst)

    elseif table.contains(HauntablePerish, tostring(inst.prefab)) then
        MakeHauntablePerish(inst)

    elseif table.contains(HauntableLaunchAndPerish, tostring(inst.prefab)) then
        MakeHauntableLaunchAndPerish(inst)

    elseif table.contains(HauntablePanic, tostring(inst.prefab)) then
        MakeHauntablePanic(inst)

    elseif table.contains(HauntablePanicAndIgnite, tostring(inst.prefab)) then
        MakeHauntablePanicAndIgnite(inst)

    elseif table.contains(HauntablePlayAnim, tostring(inst.prefab)) then
        MakeHauntablePlayAnim(inst)

    elseif table.contains(HauntableDropFirstItem, tostring(inst.prefab)) then
        MakeHauntableDropFirstItem(inst)

    elseif table.contains(HauntableLaunchAndDropFirstItem, tostring(inst.prefab)) then
        MakeHauntableLaunchAndDropFirstItem(inst)

    elseif table.contains(HauntableDropItemOrWork, tostring(inst.prefab)) then
        AddHauntableDropItemOrWork(inst)
    end

    -- Unique
    if inst.prefab == "lureplant" then
        MakeHauntableIgnite(inst, TUNING.HAUNT_CHANCE_OCCASIONAL)
        AddHauntableCustomReaction(inst, OnHauntLurePlant, false, false, true)

    elseif inst.prefab == "bee" then
        MakeHauntableChangePrefab(inst, "killerbee")
        inst.components.hauntable.panicable = true

    elseif inst.prefab == "flower" then
        MakeHauntableChangePrefab(inst, "flower_evil")

    elseif inst.prefab == "hound" or inst.prefab == "icehound" or inst.prefab ==
        "firehound" then
        if inst.prefab == "hound" then
            MakeHauntableChangePrefab(inst, {"icehound", "firehound"})
        elseif inst.prefab == "icehound" then
            MakeHauntableChangePrefab(inst, {"hound", "firehound"})
        elseif inst.prefab == "firehound" then
            MakeHauntableChangePrefab(inst, {"icehound", "hound"})
        end
        inst.components.hauntable.panicable = true
        inst:ListenForEvent("spawnedfromhaunt", OnSpawnedFromHauntHound)

    elseif inst.prefab == "red_cap" or inst.prefab == "red_cap_cooked" or
        inst.prefab == "green_cap" or inst.prefab == "green_cap_cooked" or
        inst.prefab == "blue_cap" or inst.prefab == "blue_cap_cooked" then
        MakeHauntableLaunchAndPerish(inst)
        AddHauntableCustomReaction(inst, OnHauntCapOrCooked, true, false, true)
        inst:ListenForEvent("spawnedfromhaunt", OnSpawnedFromHauntCap)

    elseif inst.prefab == "petals" then
        MakeHauntableLaunchAndPerish(inst)
        AddHauntableCustomReaction(inst, OnHauntFlower, false, true, false)

    elseif inst.prefab == "petals_evil" then
        MakeHauntableLaunchAndPerish(inst)
        inst:ListenForEvent("spawnedfromhaunt", OnSpawnedFromHauntCap)

    elseif inst.prefab == "killerbee" then
        MakeHauntablePanic(inst)
        inst:ListenForEvent("spawnedfromhaunt", OnSpawnedFromHauntKillerBee)

    elseif inst.prefab == "beefalo" or inst.prefab == "monkey" or inst.prefab ==
        "slurtle" or inst.prefab == "snurtle" or inst.prefab == "spat" then
        MakeHauntablePanic(inst)
        AddHauntableCustomReaction(inst, CustomOnHauntBeefalo, true, false, true)

    elseif inst.prefab == "pigman" then
        MakeHauntablePanic(inst)
        AddHauntableCustomReaction(inst, CustomOnHauntPig, true, nil, true)

    elseif inst.prefab == "rocky" then
        MakeHauntablePanic(inst)
        AddHauntableCustomReaction(inst, CustomOnHauntRocky, true, false, true)

    elseif inst.prefab == "warg" then
        MakeHauntableGoToState(inst, "howl", TUNING.HAUNT_CHANCE_OCCASIONAL,
                               TUNING.HAUNT_COOLDOWN_MEDIUM,
                               TUNING.HAUNT_CHANCE_LARGE)

    elseif inst.prefab == "spiderqueen" then
        MakeHauntableGoToState(inst, "poop", TUNING.HAUNT_CHANCE_OCCASIONAL,
                               TUNING.HAUNT_COOLDOWN_MEDIUM,
                               TUNING.HAUNT_CHANCE_LARGE)

    elseif inst.prefab == "chester" then
        MakeHauntableDropFirstItem(inst)
        AddHauntableCustomReaction(inst, OnHauntChester, false, false, true)

    elseif inst.prefab == "blueamulet" then
        AddHauntableCustomReaction(inst, OnHauntBlue, true, nil, true)

    elseif inst.prefab == "amulet" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)

    elseif inst.prefab == "berrybush" or inst.prefab == "berrybush2" then
        AddHauntableCustomReaction(inst, OnHauntBerrybush, false, false, true)

    elseif inst.prefab == "blueprint" then
        AddHauntableCustomReaction(inst, OnHauntBluePrint, true, false, true)

    elseif inst.prefab == "lucy" then
        AddHauntableCustomReaction(inst, CustomOnHauntLucy, true, false, true)

    elseif inst.prefab == "meat" then
        AddMonsterMeatChange(inst, "monstermeat")

    elseif inst.prefab == "cookedmeat" then
        AddMonsterMeatChange(inst, "cookedmonstermeat")

    elseif inst.prefab == "meat_dried" then
        AddMonsterMeatChange(inst, "monstermeat_dried")

    elseif inst.prefab == "mole" then
        AddHauntableCustomReaction(inst, function(inst, haunter)
            if math.random() < TUNING.HAUNT_CHANCE_OFTEN then
                local action = BufferedAction(inst, nil, ACTIONS.MOLEPEEK)
                inst.components.locomotor:PushAction(action, true)
                return true
            end
            return false
        end, nil, true, true)

    elseif inst.prefab == "mosquito" then
        AddHauntableCustomReaction(inst, function(inst, haunter)
            if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
                inst.sg:GoToState("splat")
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
                return true
            end
            return false
        end, true, false, true)

    elseif inst.prefab == "spiderhole" then
        AddHauntableCustomReaction(inst, CustomOnHauntSpiderHole, false)

    elseif inst.prefab == "firestaff" then
        AddHauntableCustomReaction(inst, onhauntred, true, false, true)

    elseif inst.prefab == "icestaff" then
        AddHauntableCustomReaction(inst, onhauntblue, true, false, true)

    elseif inst.prefab == "telestaff" then
        AddHauntableCustomReaction(inst, onhauntpurple, true, false, true)

    elseif inst.prefab == "orangestaff" then
        AddHauntableCustomReaction(inst, onhauntorange, true, false, true)

    elseif inst.prefab == "greenstaff" then
        AddHauntableCustomReaction(inst, onhauntgreen, true, false, true)

    elseif inst.prefab == "yellowstaff" then
        AddHauntableCustomReaction(inst, onhauntlight, true, false, true)

    elseif inst.prefab == "tentacle_pillar_arm" then
        AddHauntableCustomReaction(inst, CustomOnHauntTentArm)

    elseif inst.prefab == "tentacle_pillar" then
        AddHauntableCustomReaction(inst, CustomOnHauntTentPillar)

    elseif inst.prefab == "worm" then
        AddHauntableCustomReaction(inst, CustomOnHauntWorm)

    elseif inst.prefab == "ash" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable.cooldown_on_successful_haunt = false
        inst.components.hauntable.usefx = false
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
        inst.components.hauntable:SetOnHauntFn(function()
            inst.components.disappears:Disappear()
            return true
        end)

    elseif inst.prefab == "balloons_empty" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
        inst.components.hauntable:SetOnHauntFn(function()
            if inst.components.balloonmaker ~= nil and math.random() <=
                TUNING.HAUNT_CHANCE_OFTEN then
                inst.components.balloonmaker:MakeBalloon(
                    inst.Transform:GetWorldPosition())
                return true
            end
            return false
        end)

    elseif inst.prefab == "beehive" or inst.prefab == "wasphive" then
        local HAUNTTARGET_MUST_TAGS = {"combat"}
        local HAUNTTARGET_CANT_TAGS = {"insect", "playerghost", "INLIMBO"}
        local HAUNTTARGET_ONEOF_TAGS = {"character", "animal", "monster"}

        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(function()
            if inst.components.childspawner == nil or
                not inst.components.childspawner:CanSpawn() or math.random() >
                TUNING.HAUNT_CHANCE_HALF then return false end

            local target = FindEntity(inst, 25, function(guy)
                return inst.components.combat:CanTarget(guy)
            end, HAUNTTARGET_MUST_TAGS, -- See entityreplica.lua (re: "_combat" tag)
                                      HAUNTTARGET_CANT_TAGS,
                                      HAUNTTARGET_ONEOF_TAGS)

            if target ~= nil then
                if inst.components.childspawner ~= nil then
                    inst.components.childspawner:ReleaseAllChildren(target,
                                                                    "killerbee")
                end
                if not inst.components.health:IsDead() then
                    inst.SoundEmitter:PlaySound("dontstarve/bee/beehive_hit")
                    inst.AnimState:PlayAnimation("cocoon_small_hit")
                    inst.AnimState:PushAnimation("cocoon_small", true)
                end
                return true
            end
            return false
        end)

    elseif inst.prefab == "beemine" then
        local function MineRattle(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.AnimState:PushAnimation("idle", false)
            inst.SoundEmitter:PlaySound("dontstarve/bee/beemine_rattle")
            inst.rattletask = inst:DoTaskInTime(4 + math.random(), MineRattle)
        end

        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetOnHauntFn(function()
            if inst.components.mine == nil or inst.components.mine.inactive then
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_TINY
                Launch(inst, haunter, TUNING.LAUNCH_SPEED_SMALL)
                return true
            elseif inst.components.mine.issprung then
                return false
            elseif math.random() <= TUNING.HAUNT_CHANCE_RARE then
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
                inst.components.mine:Explode(nil)
                return true
            elseif inst.rattletask ~= nil then
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_TINY
                inst.rattletask:Cancel()
                MineRattle(inst)
                return true
            end
            return false
        end)

    elseif inst.prefab == "crow" or inst.prefab == "robin" or inst.prefab ==
        "robin_winter" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
        inst.components.hauntable.panicable = true

    elseif inst.prefab == "buzzard" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                local action = BufferedAction(inst, nil, ACTIONS.GOHOME)
                inst.components.locomotor:PushAction(action)
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
                return true
            end)

    elseif inst.prefab == "campfire" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_HUGE
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                if inst.components.fueled ~= nil and
                    inst.components.fueled.accepting and math.random() <=
                    TUNING.HAUNT_CHANCE_OCCASIONAL then
                    inst.components.fueled:DoDelta(TUNING.TINY_FUEL)
                    inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
                    return true
                end
                return false
            end)

    elseif inst.prefab == "carrot_planted" or inst.prefab == "cookpot" or
        inst.prefab == "fireflies" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    elseif inst.prefab == "dirtpile" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                local pt = Vector3(inst.Transform:GetWorldPosition())
                if GetWorld().components.hunter then
                    GetWorld().components.hunter:OnDirtInvestigated(pt)
                end

                local fx = SpawnPrefab("small_puff")
                local pos = inst:GetPosition()
                fx.Transform:SetPosition(pos.x, pos.y, pos.z)
                inst:Remove()
                return true
            end)

    elseif inst.prefab == "slow_farmplot" or inst.prefab == "fast_farmplot" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_SMALL
        inst.components.hauntable:SetOnHauntFn(function()
            if inst.components.grower ~= nil and
                inst.components.grower.cycles_left > 0 and math.random() <=
                TUNING.HAUNT_CHANCE_ALWAYS then
                inst.components.grower.cycles_left =
                    math.max(0, inst.components.grower.cycles_left - 1)
                local fert_percent = inst.components.grower.cycles_left /
                                         inst.components.grower.max_cycles_left
                if not inst:HasTag("burnt") then
                    inst.AnimState:PlayAnimation(
                        (fert_percent <= 0 and "empty") or
                            (fert_percent <= .33 and "med2") or
                            (fert_percent <= .66 and "med1") or "full")
                end
                inst.components.hauntable.hauntvalue =
                    TUNING.HAUNT_COOLDOWN_TINY
                return true
            end
            return false
        end)

    elseif inst.prefab == "firepit" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_HUGE
        inst.components.hauntable:SetOnHauntFn(function(inst)
            if math.random() <= TUNING.HAUNT_CHANCE_RARE and
                inst.components.fueled ~= nil and
                not inst.components.fueled:IsEmpty() then
                inst.components.fueled:DoDelta(TUNING.MED_FUEL)
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
                return true
                -- #HAUNTFIX
                -- elseif math.random() <= TUNING.HAUNT_CHANCE_HALF and
                -- inst.components.workable ~= nil and
                -- inst.components.workable:CanBeWorked() then
                -- inst.components.workable:WorkedBy(haunter, 1)
                -- inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
                -- return true
            end
            return false
        end)

    elseif inst.prefab == "gravestone" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetOnHauntFn(function(inst)
            if inst.setepitaph == nil and #STRINGS.EPITAPHS > 1 then
                -- change epitaph (if not a set custom epitaph)
                -- guarantee it's not the same as b4!
                local oldepitaph = inst.components.inspectable.description
                local newepitaph = STRINGS.EPITAPHS[math.random(
                                       #STRINGS.EPITAPHS - 1)]
                if newepitaph == oldepitaph then
                    newepitaph = STRINGS.EPITAPHS[#STRINGS.EPITAPHS]
                end
                inst.components.inspectable:SetDescription(newepitaph)
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
            else
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_TINY
            end
            return true
        end)

    elseif inst.prefab == "houndmound" then

        local HAUNTTARGET_MUST_TAGS = {"combat"}
        local HAUNTTARGET_CANT_TAGS = {
            "wall", "playerghost", "houndmound", "hound", "houndfriend",
            "INLIMBO"
        }

        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(function(inst)
            if inst.components.childspawner == nil or
                not inst.components.childspawner:CanSpawn() or math.random() >
                TUNING.HAUNT_CHANCE_HALF then return false end

            local target = FindEntity(inst, 25, function(guy)
                return inst.components.combat:CanTarget(guy)
            end, HAUNTTARGET_MUST_TAGS, -- See entityreplica.lua (re: "_combat" tag)
                                      HAUNTTARGET_CANT_TAGS)

            if target ~= nil then
                if inst.components.childspawner ~= nil then
                    inst.components.childspawner:ReleaseAllChildren(target)
                end
                return true
            end
            return false
        end)

    elseif inst.prefab == "researchlab" or inst.prefab == "researchlab2" or
        inst.prefab == "researchlab3" or inst.prefab == "researchlab4" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    elseif inst.prefab == "mermhouse" then
        local HAUNT_TARGET_MUST_TAGS = {"character"}
        local HAUNT_TARGET_CANT_TAGS = {"merm", "playerghost", "INLIMBO"}

        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(function()
            if inst.components.childspawner == nil or
                not inst.components.childspawner:CanSpawn() or math.random() >
                TUNING.HAUNT_CHANCE_HALF then return false end

            local target = FindEntity(inst, 25, nil, HAUNT_TARGET_MUST_TAGS,
                                      HAUNT_TARGET_CANT_TAGS)
            if target == nil then return false end

            if not inst:HasTag("burnt") then
                if inst.components.childspawner ~= nil then
                    inst.components.childspawner:ReleaseAllChildren(worker)
                end
                inst.AnimState:PlayAnimation("hit")
                inst.AnimState:PushAnimation("idle")
            end
        end)

    elseif inst.prefab == "molebathill" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(function()
            return inst.components.spawner ~= nil and
                       inst.components.spawner:IsOccupied() and
                       inst.components.spawner:ReleaseChild()
        end)

    elseif inst.prefab == "monkeybarrel" then
        local TARGET_MUST_TAGS = {"combat"}
        local TARGET_CANT_TAGS = {"playerghost", "INLIMBO"}
        local TARGET_ONEOF_TAGS = {"character", "monster"}
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(function()
            if inst.components.childspawner == nil or
                not inst.components.childspawner:CanSpawn() or math.random() >
                TUNING.HAUNT_CHANCE_HALF then return false end

            local target = FindEntity(inst, 25, nil, TARGET_MUST_TAGS,
                                      TARGET_CANT_TAGS, TARGET_ONEOF_TAGS)

            if target ~= nil then
                if inst.components.childspawner ~= nil then
                    inst.components.childspawner:ReleaseAllChildren(target)
                end
                inst.AnimState:PlayAnimation("hit")
                inst.AnimState:PushAnimation("idle", false)

                return true
            end

            return false
        end)

    elseif inst.prefab == "mound" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(function()
            -- #HAUNTFIX
            -- return spawnghost(inst, TUNING.HAUNT_CHANCE_HALF)
            return true
        end)

    elseif inst.prefab == "onemanband" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                if inst.components.equippable.onequipfn then
                    inst.components.equippable.onequipfn(self.inst)
                end
                inst.hauntsfxtask = inst:DoPeriodicTask(.3, function(inst)
                    inst.SoundEmitter:PlaySound(inst.foleysound)
                end)
                return true
            end)
        inst.components.hauntable:SetOnUnHauntFn(function(inst)
            if inst.components.equippable.onunequip then
                inst.components.equippable.onunequip(self.inst)
            end
            if inst.hauntsfxtask then
                inst.hauntsfxtask:Cancel()
                inst.hauntsfxtask = nil
            end
        end)

    elseif inst.prefab == "pigking" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
        inst.components.hauntable:SetOnHauntFn(function()
            if inst.components.trader ~= nil and inst.components.trader.enabled then
                inst.sg:GoToState("unimpressed")
                return true
            end
            return false
        end)

    elseif inst.prefab == "pigtorch" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(function()
            inst.components.fueled:TakeFuelItem(SpawnPrefab("pigtorch_fuel"))
            inst.components.spawner:ReleaseChild()
            return true
        end)

    elseif inst.prefab == "plant_normal" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                if inst.components.crop ~= nil then -- and math.random() <= TUNING.HAUNT_CHANCE_OFTEN then
                    if not (inst.components.crop:IsReadyForHarvest() or
                        inst:HasTag("withered")) then
                        local fert = SpawnPrefab("spoiled_food")
                        if fert.components.fertilizer ~= nil then
                            fert.components.fertilizer.fertilize_sound = nil
                        end
                        inst.components.crop:Fertilize(fert, haunter)
                    elseif inst.components.workable ~= nil then
                        inst.components.workable:Destroy(haunter)
                    end
                    return true
                end
                return false
            end)

    elseif inst.prefab == "pond" or inst.prefab == "pond_mos" or inst.prefab ==
        "pond_cave" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    elseif inst.prefab == "rabbithole" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                return not inst.spring and inst.components.spawner ~= nil and
                           inst.components.spawner:IsOccupied() and
                           inst.components.spawner:ReleaseChild()
            end)

    elseif inst.prefab == "spiderden" or inst.prefab == "spiderden_2" or
        inst.prefab == "spiderden_3" then
        local function CanTarget(guy)
            return not guy.components.health:IsDead()
        end
        local TARGET_MUST_TAGS = {"_combat", "_health", "character"}
        local TARGET_CANT_TAGS = {"player", "spider", "INLIMBO"}
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_MEDIUM
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                if math.random() <= TUNING.HAUNT_CHANCE_HALF then
                    local target =
                        FindEntity(inst, 25, CanTarget, TARGET_MUST_TAGS, -- see entityreplica.lua
                                   TARGET_CANT_TAGS)
                    if target ~= nil then
                        if inst.components.combat.onhitfn then
                            inst.components.combat.onhitfn(inst, haunter)
                        end
                        inst.components.hauntable.hauntvalue =
                            TUNING.HAUNT_MEDIUM
                        return true
                    end
                end

                if inst.data.stage == 3 and math.random() <=
                    TUNING.HAUNT_CHANCE_RARE and
                    inst.components.growable.stages["queen"].growfn(inst) then
                    inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
                    return true
                end

                return false
            end)

    elseif inst.prefab == "stafflight" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                if inst.components.timer:TimerExists("extinguish") then
                    inst.components.timer:StopTimer("extinguish")
                    inst.AnimState:PlayAnimation("disappear")
                    inst:ListenForEvent("animover", function()
                        inst.SoundEmitter:KillSound("staff_star_loop")
                    end)
                    inst:DoTaskInTime(1, inst.Remove) -- originally 0.6, padded for network
                    inst.persists = false
                    inst._killed = true
                end
                return true
            end)

    elseif inst.prefab == "pighead" or inst.prefab == "mermhead" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_MEDIUM
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)

                local function OnFinishHaunt(inst)
                    if inst.awake and
                        not (GetClock() and GetClock():GetMoonPhase() == "full" and
                            GetClock():IsNight() or inst:HasTag("burnt")) then
                        inst.awake = nil
                        inst.AnimState:PlayAnimation("sleep")
                        inst.AnimState:PushAnimation("idle_asleep", false)
                    end
                end

                -- #HAUNTFIX
                -- if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL and
                -- inst.components.workable ~= nil and
                -- inst.components.workable:CanBeWorked() then
                -- inst.components.workable:WorkedBy(haunter, 1)
                -- inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
                -- return true
                -- else
                if not (inst.awake or inst:HasTag("burnt")) then
                    inst.awake = true
                    inst.AnimState:PlayAnimation("wake")
                    inst.AnimState:PushAnimation("idle_awake")
                    inst:DoTaskInTime(4, OnFinishHaunt)
                    inst.components.hauntable.hauntvalue = TUNING.HAUNT_TINY
                    return true
                end
                return false
            end)

    elseif inst.prefab == "tallbirdnest" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    elseif inst.prefab == "gemsocket" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_MEDIUM)
        inst.components.hauntable:SetOnHauntFn(function()
            -- #HAUNTFIX
            -- if inst.components.trader ~= nil and not inst.components.trader.enabled and math.random() <= TUNING.HAUNT_CHANCE_RARE then
            -- DestroyGem(inst)
            -- return true
            -- end
            return false
        end)

    elseif inst.prefab == "trap_teeth" or inst.prefab == "trap_bramble" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetOnHauntFn(function()
            if inst.components.mine == nil or inst.components.mine.inactive then
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_TINY
                Launch(inst, haunter, TUNING.LAUNCH_SPEED_SMALL)
                return true
            elseif not inst.components.mine.issprung then
                return false
            elseif math.random() <= TUNING.HAUNT_CHANCE_OFTEN then
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
                inst.components.mine:Reset()
                return true
            end
            return false
        end)

    elseif inst.prefab == "treasurechest" or inst.prefab == "pandoraschest" or
        inst.prefab == "minotaurchest" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    elseif inst.prefab == "tumbleweed" then
        if not inst.components.hauntable then
            inst:AddComponent("hauntable")
        end
        inst.components.hauntable:SetOnHauntFn(
            function(inst, haunter)
                if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
                    if inst.components.pickable.onpickedfn then
                        inst.components.pickable.onpickedfn(inst)
                    end
                    inst:Remove()
                end
                return true
            end)
    end
end

