_G.CONSTRUCTION_PLANS =
{
    ["multiplayer_portal_moonrock_constr"] = { Ingredient("purplemooneye", 1), Ingredient("moonrocknugget", 20) },
	--["mermthrone_construction"] = { Ingredient("kelp", 20), Ingredient("pigskin", 10), Ingredient("beefalowool", 15) },
	--["hermithouse_construction1"] = { Ingredient("cookiecuttershell", 10), Ingredient("boards", 10) },
	--["hermithouse_construction2"] = { Ingredient("marble", 10), Ingredient("rope", 10) },
	--["hermithouse_construction3"] = { Ingredient("moonrocknugget", 5),   Ingredient("cactus_flower", 10) },

	--["moon_device_construction1"] = { Ingredient("moonstorm_static_item", 1), Ingredient("moonstorm_spark", 10), Ingredient("moonglass_charged", 10) },
	--["moon_device_construction2"] = { Ingredient("moonstorm_static_item", 1), Ingredient("moonglass_charged", 20), Ingredient("moonrockseed", 1) },
}

local function IsMarshLand(pt, rot)
	local ground_tile = GetWorld().Map:GetTileAtPoint(pt.x, pt.y, pt.z)
	return ground_tile and ground_tile == GROUND.MARSH
end

--LIGHT
-- Recipe("mushroom_light", {Ingredient("shroom_skin", 1), Ingredient("fertilizer", 1, nil, true)}, RECIPETABS.LIGHT, TECH.LOST, "mushroom_light_placer", 1.5)
-- Recipe("mushroom_light2", {Ingredient("shroom_skin", 1), Ingredient("fertilizer", 1, nil, true), Ingredient("boards", 1)}, RECIPETABS.LIGHT, TECH.LOST, "mushroom_light2_placer", 1.5)

--STRUCTURES
-- Recipe("wintersfeastoven", {Ingredient("cutstone", 1), Ingredient("marble", 1), Ingredient("log", 1)}, RECIPETABS.TOWN, TECH.WINTERS_FEAST, "wintersfeastoven_placer")
-- Recipe("table_winters_feast", {Ingredient("boards", 1), Ingredient("beefalowool", 1)}, RECIPETABS.TOWN, TECH.WINTERS_FEAST, "table_winters_feast_placer", 2.8, nil, nil, nil, nil, nil,
--     function(pt)
--        return TheWorld.Map:GetPlatformAtPoint(pt.x, 0, pt.z, 0.5) == nil
--     end)

-- Recipe("winter_treestand", {Ingredient("poop", 2), Ingredient("boards", 1)}, RECIPETABS.TOWN, TECH.WINTERS_FEAST, "winter_treestand_placer")

-- Recipe("perdshrine", {Ingredient("goldnugget", 8), Ingredient("boards", 2)}, RECIPETABS.TOWN, TECH.YOTG, "perdshrine_placer")
-- Recipe("wargshrine", {Ingredient("goldnugget", 8), Ingredient("boards", 2)}, RECIPETABS.TOWN, TECH.YOTV, "wargshrine_placer")
-- Recipe("pigshrine", {Ingredient("goldnugget", 8), Ingredient("boards", 2)}, RECIPETABS.TOWN, TECH.YOTP, "pigshrine_placer")
-- Recipe("yotc_carratshrine", {Ingredient("goldnugget", 8), Ingredient("boards", 2)}, RECIPETABS.TOWN, TECH.YOTC, "yotc_carratshrine_placer")
-- Recipe("yotb_beefaloshrine", {Ingredient("goldnugget", 8), Ingredient("boards", 2)}, RECIPETABS.TOWN, TECH.YOTB, "yotb_beefaloshrine_placer")

-- Recipe("mermhouse_crafted", {Ingredient("boards", 4), Ingredient("cutreeds", 3), Ingredient("pondfish", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_ONE, "mermhouse_crafted_placer", nil, nil, nil, "merm_builder", nil, nil, IsMarshLand)
-- Recipe("mermthrone_construction", {Ingredient("boards", 5), Ingredient("rope", 5)}, RECIPETABS.TOWN, TECH.SCIENCE_ONE, "mermthrone_construction_placer", nil, nil, nil, "merm_builder", nil, nil, IsMarshLand)
-- Recipe("mermwatchtower", {Ingredient("boards", 5), Ingredient("tentaclespots", 1), Ingredient("spear", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "mermwatchtower_placer", nil, nil, nil, "merm_builder", nil, nil, IsMarshLand)
-- Recipe("turf_marsh", {Ingredient("cutreeds", 1), Ingredient("spoiled_food", 2)}, RECIPETABS.TOWN,  TECH.SCIENCE_TWO, nil, nil, nil, nil, "merm_builder")

-- Recipe("sisturn", {Ingredient("cutstone", 3), Ingredient("boards", 3), Ingredient("ash", 1)}, RECIPETABS.TOWN, TECH.NONE, "sisturn_placer", nil, nil, nil, "ghostlyfriend")

local arrowsign_post = Recipe("arrowsign_post", {Ingredient("boards", 1)}, RECIPETABS.TOWN, TECH.SCIENCE_ONE, "arrowsign_post_placer")
arrowsign_post.atlas = "images/inventoryimages1_anr.xml"
-- Recipe("wall_moonrock_item", {Ingredient("moonrocknugget", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,nil,nil,nil,4)

-- Recipe("wardrobe", {Ingredient("boards", 4), Ingredient("cutgrass", 3)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "wardrobe_placer")
-- Recipe("beefalo_groomer", {Ingredient("boards", 4), Ingredient("beefalowool", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "beefalo_groomer_item_placer")
-- Recipe("scarecrow", {Ingredient("pumpkin", 1), Ingredient("boards", 3), Ingredient("cutgrass", 3)}, RECIPETABS.TOWN, TECH.SCIENCE_ONE, "scarecrow_placer", 1.5)
-- Recipe("tacklestation", {Ingredient("driftwood_log", 1), Ingredient("transistor", 1), Ingredient("boneshard", 1)}, RECIPETABS.TOWN, TECH.SCIENCE_ONE, "tacklestation_placer")
-- Recipe("trophyscale_fish", {Ingredient("ice", 4), Ingredient("boards", 2), Ingredient("cutstone", 1)}, RECIPETABS.TOWN,  TECH.SCIENCE_TWO, "trophyscale_fish_placer")
-- Recipe("trophyscale_oversizedveggies", {Ingredient("boards", 4), Ingredient("cutgrass", 4)}, RECIPETABS.TOWN,  TECH.SCIENCE_TWO, "trophyscale_oversizedveggies_placer")

-- Recipe("turf_dragonfly", {Ingredient("dragon_scales", 1), Ingredient("cutstone", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 6)
-- Recipe("turf_shellbeach", {Ingredient("slurtle_shellpieces", 3)}, RECIPETABS.TOWN,  TECH.LOST)

-- Recipe("succulent_potted", {Ingredient("succulent_picked", 5), Ingredient("cutstone", 1)}, RECIPETABS.TOWN, TECH.LOST, "succulent_potted_placer", 0.9)
-- Recipe("endtable", {Ingredient("marble", 2), Ingredient("boards", 2), Ingredient("turf_carpetfloor", 2)}, RECIPETABS.TOWN, TECH.LOST, "endtable_placer", 1.5)

-- Recipe("ruinsrelic_plate", {Ingredient("cutstone", 1)}, RECIPETABS.TOWN, TECH.LOST, "ruinsrelic_plate_placer", 0.5)
-- Recipe("ruinsrelic_chipbowl", {Ingredient("cutstone", 1)}, RECIPETABS.TOWN, TECH.LOST, "ruinsrelic_chipbowl_placer", 0.5)
-- Recipe("ruinsrelic_bowl", {Ingredient("cutstone", 2)}, RECIPETABS.TOWN, TECH.LOST, "ruinsrelic_bowl_placer", 2)
-- Recipe("ruinsrelic_vase", {Ingredient("cutstone", 2)}, RECIPETABS.TOWN, TECH.LOST, "ruinsrelic_vase_placer", 2)
-- Recipe("ruinsrelic_chair", {Ingredient("cutstone", 3)}, RECIPETABS.TOWN, TECH.LOST, "ruinsrelic_chair_placer", 2)
-- Recipe("ruinsrelic_table", {Ingredient("cutstone", 4)}, RECIPETABS.TOWN, TECH.LOST, "ruinsrelic_table_placer")

-- Recipe("dragonflyfurnace", {Ingredient("dragon_scales", 1), Ingredient("redgem", 2), Ingredient("charcoal", 10)}, RECIPETABS.TOWN, TECH.LOST, "dragonflyfurnace_placer")

-- Recipe("archive_resonator_item", {Ingredient("moonrocknugget", 1), Ingredient("thulecite", 1)}, RECIPETABS.TOWN, TECH.LOST)

--FOOD (FARM)
-- Recipe("cookbook", {Ingredient("papyrus", 1), Ingredient("carrot", 1)}, RECIPETABS.FARM, TECH.SCIENCE_ONE)

-- Recipe("saltbox", {Ingredient("saltrock", 10), Ingredient("bluegem", 1), Ingredient("cutstone", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "saltbox_placer", 1.5)

-- Recipe("farm_plow_item", {Ingredient("boards", 3), Ingredient("rope", 2), Ingredient("flint", 2)}, RECIPETABS.FARM,  TECH.SCIENCE_ONE)
-- Recipe("fertilizer", {Ingredient("poop", 3), Ingredient("boneshard", 2), Ingredient("log", 4)}, RECIPETABS.FARM, TECH.SCIENCE_TWO)
-- Recipe("soil_amender", {Ingredient("messagebottleempty", 1), Ingredient("kelp", 1), Ingredient("ash", 1)}, RECIPETABS.FARM, TECH.SCIENCE_TWO)
-- Recipe("treegrowthsolution", {Ingredient("fig", 2), Ingredient("glommerfuel", 1)}, RECIPETABS.FARM, TECH.SCIENCE_TWO)
-- Recipe("compostingbin", {Ingredient("boards", 3), Ingredient("spoiled_food", 1), Ingredient("cutgrass", 1)}, RECIPETABS.FARM, TECH.SCIENCE_TWO, "compostingbin_placer")
-- Recipe("plantregistryhat", {Ingredient("fertilizer", 1), Ingredient("seeds", 3), Ingredient("transistor", 1)}, RECIPETABS.FARM, TECH.SCIENCE_ONE)

-- Recipe("mushroom_farm", {Ingredient("spoiled_food", 8),Ingredient("poop", 5),Ingredient("livinglog", 2)}, RECIPETABS.FARM, TECH.SCIENCE_ONE, "mushroom_farm_placer", 2.5)
--NOTE: add portable cookware to UNCRAFTABLE section as well!
-- Recipe("portablecookpot_item", {Ingredient("goldnugget", 2), Ingredient("charcoal", 6), Ingredient("twigs", 6)}, RECIPETABS.FARM, TECH.NONE, nil, nil, nil, nil, "masterchef")
-- Recipe("portableblender_item", {Ingredient("goldnugget", 2), Ingredient("transistor", 2), Ingredient("twigs", 4)}, RECIPETABS.FARM, TECH.NONE, nil, nil, nil, nil, "masterchef")
-- Recipe("portablespicer_item",  {Ingredient("goldnugget", 2), Ingredient("cutstone", 3), Ingredient("twigs", 6)}, RECIPETABS.FARM, TECH.NONE, nil, nil, nil, nil, "masterchef")
-- 

--SURVIVAL
local reviver = Recipe("reviver", {Ingredient("cutgrass", 3), Ingredient("spidergland", 1), Ingredient(_G.CHARACTER_INGREDIENT.HEALTH, 40)}, RECIPETABS.SURVIVAL,  TECH.NONE)
reviver.atlas = "images/inventoryimages2_anr.xml"
-- Recipe("tillweedsalve", {Ingredient("tillweed", 4), Ingredient("petals", 4), Ingredient("charcoal", 1)}, RECIPETABS.SURVIVAL,  TECH.SCIENCE_TWO)
local lifeinjector = Recipe("lifeinjector", {Ingredient("spoiled_food", 8), Ingredient("nitre", 2), Ingredient("stinger",1)}, RECIPETABS.SURVIVAL,  TECH.SCIENCE_TWO)
lifeinjector.atlas = "images/inventoryimages1_anr.xml"
-- Recipe("bernie_inactive", {Ingredient("beardhair", 2), Ingredient("beefalowool", 2), Ingredient("silk", 2)}, RECIPETABS.SURVIVAL,  TECH.NONE, nil, nil, nil, nil, "pyromaniac")
-- Recipe("oceanfishingrod", {Ingredient("boards", 1),Ingredient("silk", 6)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_ONE)
-- Recipe("miniflare", {Ingredient("twigs", 1), Ingredient("cutgrass", 1), Ingredient("nitre", 1)}, RECIPETABS.SURVIVAL, TECH.NONE)
-- Recipe("waterballoon", {Ingredient("mosquitosack", 2), Ingredient("ice", 1)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_ONE, nil, nil, nil, 4)
-- Recipe("giftwrap", {Ingredient("papyrus", 1), Ingredient("petals", 1)}, RECIPETABS.SURVIVAL, TECH.WINTERS_FEAST, nil, nil, nil, 4)
-- Recipe("candybag", {Ingredient("cutgrass", 6)}, RECIPETABS.SURVIVAL, TECH.HALLOWED_NIGHTS)
-- Recipe("seedpouch", {Ingredient("slurtle_shellpieces", 2), Ingredient("cutgrass", 4), Ingredient("seeds", 2)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_TWO)
-- Recipe("portabletent_item", {Ingredient("bedroll_straw", 1), Ingredient("twigs", 4), Ingredient("rope", 2)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_ONE, nil, nil, nil, nil, "pinetreepioneer")
local minifan = Recipe("minifan", {Ingredient("twigs", 3), Ingredient("petals",1)}, RECIPETABS.SURVIVAL, TECH.NONE)
minifan.atlas = "images/inventoryimages1_anr.xml"
--minifan.sortkey = 2
--TOOLS

-- Recipe("farm_hoe", {Ingredient("twigs", 2), Ingredient("flint", 2)}, RECIPETABS.TOOLS,  TECH.SCIENCE_ONE)
-- Recipe("golden_farm_hoe", {Ingredient("twigs", 4),Ingredient("goldnugget", 2)}, RECIPETABS.TOOLS,  TECH.SCIENCE_TWO)

-- Recipe("wateringcan", {Ingredient("boards", 2), Ingredient("rope", 1)}, RECIPETABS.TOOLS, TECH.SCIENCE_ONE)
-- Recipe("premiumwateringcan", {Ingredient("driftwood_log", 2), Ingredient("rope", 1), Ingredient("malbatross_beak", 1)}, RECIPETABS.TOOLS, TECH.LOST)

-- Recipe("pocket_scale", {Ingredient("log", 1), Ingredient("cutstone", 1), Ingredient("goldnugget", 1)}, RECIPETABS.TOOLS,  TECH.SCIENCE_ONE)
-- Recipe("beef_bell", {Ingredient("goldnugget", 3), Ingredient("flint", 1)}, RECIPETABS.TOOLS, TECH.SCIENCE_ONE)


--SCIENCE
-- Recipe("madscience_lab", {Ingredient("cutstone", 2), Ingredient("transistor", 2)}, RECIPETABS.SCIENCE, TECH.HALLOWED_NIGHTS, "madscience_lab_placer")
-- Recipe("seafaring_prototyper", {Ingredient("boards", 4)}, RECIPETABS.SCIENCE, TECH.SCIENCE_ONE, "seafaring_prototyper_placer")
-- Recipe("cartographydesk", {Ingredient("compass", 1),Ingredient("boards", 4)}, RECIPETABS.SCIENCE, TECH.SCIENCE_ONE, "cartographydesk_placer")
-- Recipe("sculptingtable", {Ingredient("cutstone", 2), Ingredient("boards", 2), Ingredient("twigs", 4) }, RECIPETABS.SCIENCE, TECH.SCIENCE_ONE, "sculptingtable_placer")
-- Recipe("turfcraftingstation", {Ingredient("thulecite", 1), Ingredient("cutstone", 3), Ingredient("wetgoop", 1)}, RECIPETABS.SCIENCE,  TECH.LOST, "turfcraftingstation_placer")
-- Recipe("moon_device_construction1", {Ingredient("moonstorm_static_item", 1),Ingredient("moonstorm_spark", 5),Ingredient("transistor", 2)}, RECIPETABS.SCIENCE, TECH.LOST, {placer = "moon_device_construction1_placer", no_deconstruction = true}, 0)

--MAGIC
-- Recipe("abigail_flower", {Ingredient("ghostflower", 1), Ingredient("nightmarefuel", 1)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "ghostlyfriend")
-- Recipe("wereitem_goose", {Ingredient("monstermeat", 3), Ingredient("seeds", 3)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "werehuman")
-- Recipe("wereitem_beaver", {Ingredient("monstermeat", 3), Ingredient("log", 2)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "werehuman")
-- Recipe("wereitem_moose", {Ingredient("monstermeat", 3), Ingredient("cutgrass", 2)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "werehuman")

-- Recipe("sentryward", {Ingredient("purplemooneye", 1), Ingredient("compass", 1), Ingredient("boards", 2)}, RECIPETABS.MAGIC, TECH.MAGIC_TWO, "sentryward_placer", 1.5)
-- Recipe("moondial", {Ingredient("bluemooneye", 1), Ingredient("moonrocknugget", 2), Ingredient("ice", 2)}, RECIPETABS.MAGIC,  TECH.MAGIC_TWO, "moondial_placer")
-- Recipe("townportal", {Ingredient("orangemooneye", 1), Ingredient("townportaltalisman", 1), Ingredient("cutstone", 3)}, RECIPETABS.MAGIC, TECH.LOST, "townportal_placer")
-- Recipe("reskin_tool", {Ingredient("livinglog", 3), Ingredient("petals_evil", 6)}, RECIPETABS.MAGIC, TECH.MAGIC_THREE)

--REFINE
-- Recipe("marblebean", {Ingredient("marble", 1)}, RECIPETABS.REFINE, TECH.SCIENCE_TWO)
-- Recipe("bearger_fur", {Ingredient("furtuft", 90)}, RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, 3)
-- Recipe("moonrockcrater", {Ingredient("moonrocknugget", 3)}, RECIPETABS.REFINE, TECH.SCIENCE_TWO)
-- Recipe("malbatross_feathered_weave", {Ingredient("malbatross_feather", 6), Ingredient("silk", 1)}, RECIPETABS.REFINE, TECH.LOST)
-- Recipe("refined_dust", {Ingredient("saltrock", 1), Ingredient("rocks", 2), Ingredient("nitre", 1)}, RECIPETABS.REFINE, TECH.LOST)

--WAR
-- Recipe("slingshot", {Ingredient("twigs", 1), Ingredient("mosquitosack", 2)}, RECIPETABS.WAR, TECH.NONE, nil, nil, nil, nil, "pebblemaker")
-- Recipe("whip", {Ingredient("coontail", 3), Ingredient("tentaclespots", 1)}, RECIPETABS.WAR,  TECH.SCIENCE_TWO)
-- Recipe("cookiecutterhat", {Ingredient("cookiecuttershell", 4), Ingredient("rope", 1)}, RECIPETABS.WAR,  TECH.SCIENCE_TWO)
-- Recipe("sleepbomb", {Ingredient("shroom_skin", 1), Ingredient("canary_poisoned", 1)}, RECIPETABS.WAR, TECH.LOST, nil, nil, nil, 4)
-- Recipe("blowdart_yellow", {Ingredient("cutreeds", 2),Ingredient("goldnugget", 1),Ingredient("feather_canary", 1) }, RECIPETABS.WAR,  TECH.SCIENCE_ONE)
-- Recipe("trident", {Ingredient("gnarwail_horn", 3), Ingredient("kelp", 4), Ingredient("twigs", 2)}, RECIPETABS.WAR, TECH.LOST)

--DRESSUP

-- Recipe("mermhat", {Ingredient("pondfish", 1), Ingredient("cutreeds", 1), Ingredient("twigs", 2)}, RECIPETABS.DRESS, TECH.NONE, nil, nil, nil, nil, "merm_builder")
-- Recipe("walterhat", {Ingredient("silk", 4)}, RECIPETABS.DRESS, TECH.NONE, nil, nil, nil, nil, "pinetreepioneer")

-- Recipe("kelphat", {Ingredient("kelp", 12)}, RECIPETABS.DRESS, TECH.NONE)
-- Recipe("goggleshat", {Ingredient("goldnugget", 1), Ingredient("pigskin", 1)}, RECIPETABS.DRESS, TECH.LOST)
-- Recipe("deserthat", {Ingredient("goggleshat", 1), Ingredient("pigskin", 1)}, RECIPETABS.DRESS, TECH.LOST)
-- Recipe("moonstorm_goggleshat", {Ingredient("moonglass", 2),Ingredient("potato", 1)}, RECIPETABS.DRESS, TECH.LOST)
-- Recipe("red_mushroomhat", {Ingredient("red_cap", 6)}, RECIPETABS.DRESS, TECH.LOST)
-- Recipe("green_mushroomhat", {Ingredient("green_cap", 6)}, RECIPETABS.DRESS, TECH.LOST)
-- Recipe("blue_mushroomhat", {Ingredient("blue_cap", 6)}, RECIPETABS.DRESS, TECH.LOST)

----GEMS----


----ANCIENT----

--Recipe("nutrientsgoggleshat", {Ingredient("plantregistryhat", 1), Ingredient("thulecite_pieces", 4), Ingredient("purplegem", 1)}, RECIPETABS.ANCIENT, TECH.ANCIENT_TWO, nil, nil, true)

-- ----CELESTIAL----
-- Recipe("moonrockidol", {Ingredient("moonrocknugget", 1), Ingredient("purplegem", 1)}, RECIPETABS.CELESTIAL, TECH.CELESTIAL_ONE, nil, nil, true)
-- Recipe("multiplayer_portal_moonrock_constr_plans", {Ingredient("boards", 1), Ingredient("rope", 1)}, RECIPETABS.CELESTIAL, TECH.CELESTIAL_ONE, nil, nil, true)


-- ----MOON_ALTAR-----
-- Recipe("moonglassaxe",					{Ingredient("twigs", 2),  				Ingredient("moonglass", 3)},	RECIPETABS.CELESTIAL, TECH.CELESTIAL_THREE, nil, nil, true)
-- Recipe("glasscutter",					{Ingredient("boards", 1), 				Ingredient("moonglass", 6) },	RECIPETABS.CELESTIAL, TECH.CELESTIAL_THREE, nil, nil, true)
-- Recipe("turf_meteor",					{Ingredient("moonrocknugget", 1),		Ingredient("moonglass", 2)},	RECIPETABS.CELESTIAL, TECH.CELESTIAL_THREE, nil, nil, true, 6)
-- Recipe("turf_fungus_moon",				{Ingredient("moonrocknugget", 1),		Ingredient("moon_cap", 3)},		RECIPETABS.CELESTIAL, TECH.CELESTIAL_THREE, nil, nil, true, 6)
-- Recipe("bathbomb", 						{Ingredient("moon_tree_blossom", 6),	Ingredient("nitre", 1)}, 		RECIPETABS.CELESTIAL, TECH.CELESTIAL_THREE, nil, nil, true)
-- Recipe("chesspiece_butterfly_sketch",	{Ingredient("papyrus", 1)},												RECIPETABS.CELESTIAL, TECH.CELESTIAL_THREE, nil, nil, true)
-- Recipe("chesspiece_moon_sketch", 		{Ingredient("papyrus", 1)},												RECIPETABS.CELESTIAL, TECH.CELESTIAL_THREE, nil, nil, true)

-- ----BOOK----
-- Recipe("book_birds", 		{Ingredient("papyrus", 2), Ingredient("bird_egg", 2)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
-- Recipe("book_horticulture",	{Ingredient("papyrus", 2), Ingredient("seeds", 5), Ingredient("poop", 5)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_ONE, nil, nil, nil, nil, "bookbuilder")
-- Recipe("book_silviculture", {Ingredient("papyrus", 2), Ingredient("livinglog", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_THREE, nil, nil, nil, nil, "bookbuilder")
-- Recipe("book_sleep", 		{Ingredient("papyrus", 2), Ingredient("nightmarefuel", 2)}, CUSTOM_RECIPETABS.BOOKS, TECH.MAGIC_TWO, nil, nil, nil, nil, "bookbuilder")
-- Recipe("book_brimstone",	{Ingredient("papyrus", 2), Ingredient("redgem", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.MAGIC_THREE, nil, nil, nil, nil, "bookbuilder")
-- Recipe("book_tentacles",	{Ingredient("papyrus", 2), Ingredient("tentaclespots", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_THREE, nil, nil, nil, nil, "bookbuilder")

-- ----SHADOW----
-- Recipe("waxwelljournal", 		{Ingredient("papyrus", 2), 		 Ingredient("nightmarefuel", 2), Ingredient(CHARACTER_INGREDIENT.HEALTH, 50)}, CUSTOM_RECIPETABS.SHADOW, TECH.NONE, nil, nil, nil, nil, "shadowmagic")
-- Recipe("shadowlumber_builder",  {Ingredient("nightmarefuel", 2), Ingredient("axe", 1), 			 Ingredient(CHARACTER_INGREDIENT.MAX_SANITY, TUNING.SHADOWWAXWELL_SANITY_PENALTY.SHADOWLUMBER)},  CUSTOM_RECIPETABS.SHADOW, TECH.SHADOW_TWO, nil, nil, true, nil, "shadowmagic")
-- Recipe("shadowminer_builder",   {Ingredient("nightmarefuel", 2), Ingredient("pickaxe", 1), 		 Ingredient(CHARACTER_INGREDIENT.MAX_SANITY, TUNING.SHADOWWAXWELL_SANITY_PENALTY.SHADOWMINER)},   CUSTOM_RECIPETABS.SHADOW, TECH.SHADOW_TWO, nil, nil, true, nil, "shadowmagic")
-- Recipe("shadowdigger_builder",  {Ingredient("nightmarefuel", 2), Ingredient("shovel", 1),  		 Ingredient(CHARACTER_INGREDIENT.MAX_SANITY, TUNING.SHADOWWAXWELL_SANITY_PENALTY.SHADOWDIGGER)},  CUSTOM_RECIPETABS.SHADOW, TECH.SHADOW_TWO, nil, nil, true, nil, "shadowmagic")
-- Recipe("shadowduelist_builder", {Ingredient("nightmarefuel", 2), Ingredient("spear", 1),   		 Ingredient(CHARACTER_INGREDIENT.MAX_SANITY, TUNING.SHADOWWAXWELL_SANITY_PENALTY.SHADOWDUELIST)}, CUSTOM_RECIPETABS.SHADOW, TECH.SHADOW_TWO, nil, nil, true, nil, "shadowmagic")

-- ----ENGINEERING----
-- Recipe("sewing_tape", 	      {Ingredient("silk", 1), 		 Ingredient("cutgrass", 3)}, CUSTOM_RECIPETABS.ENGINEERING, TECH.NONE, nil, nil, nil, nil, "handyperson")
-- Recipe("winona_catapult",     {Ingredient("sewing_tape", 1), Ingredient("twigs", 3), 	  Ingredient("rocks", 15)}, 	CUSTOM_RECIPETABS.ENGINEERING, TECH.NONE, "winona_catapult_placer",     TUNING.WINONA_ENGINEERING_SPACING, nil, nil, "handyperson")
-- Recipe("winona_spotlight",    {Ingredient("sewing_tape", 1), Ingredient("goldnugget", 2), Ingredient("fireflies", 1)},  CUSTOM_RECIPETABS.ENGINEERING, TECH.NONE, "winona_spotlight_placer",    TUNING.WINONA_ENGINEERING_SPACING, nil, nil, "handyperson")
-- Recipe("winona_battery_low",  {Ingredient("sewing_tape", 1), Ingredient("log", 2), 		  Ingredient("nitre", 2)}, 	    CUSTOM_RECIPETABS.ENGINEERING, TECH.NONE, "winona_battery_low_placer",  TUNING.WINONA_ENGINEERING_SPACING, nil, nil, "handyperson")
-- Recipe("winona_battery_high", {Ingredient("sewing_tape", 1), Ingredient("boards", 2), 	  Ingredient("transistor", 2)}, CUSTOM_RECIPETABS.ENGINEERING, TECH.NONE, "winona_battery_high_placer", TUNING.WINONA_ENGINEERING_SPACING, nil, nil, "handyperson")

-- ----elixirbrewing----
-- Recipe("ghostlyelixir_slowregen",	{Ingredient("spidergland", 1), 	Ingredient("ghostflower", 1)}, CUSTOM_RECIPETABS.ELIXIRBREWING, TECH.NONE, nil, nil, nil, nil, "elixirbrewer")
-- Recipe("ghostlyelixir_fastregen",	{Ingredient("reviver", 1),		Ingredient("ghostflower", 3)}, CUSTOM_RECIPETABS.ELIXIRBREWING, TECH.NONE, nil, nil, nil, nil, "elixirbrewer")
-- Recipe("ghostlyelixir_shield",		{Ingredient("log", 1),			Ingredient("ghostflower", 1)}, CUSTOM_RECIPETABS.ELIXIRBREWING, TECH.NONE, nil, nil, nil, nil, "elixirbrewer")
-- Recipe("ghostlyelixir_retaliation",	{Ingredient("livinglog", 1),	Ingredient("ghostflower", 3)}, CUSTOM_RECIPETABS.ELIXIRBREWING, TECH.NONE, nil, nil, nil, nil, "elixirbrewer")
-- Recipe("ghostlyelixir_attack",		{Ingredient("stinger", 1), 		Ingredient("ghostflower", 3)}, CUSTOM_RECIPETABS.ELIXIRBREWING, TECH.NONE, nil, nil, nil, nil, "elixirbrewer")
-- Recipe("ghostlyelixir_speed",		{Ingredient("honey", 1), 		Ingredient("ghostflower", 1)}, CUSTOM_RECIPETABS.ELIXIRBREWING, TECH.NONE, nil, nil, nil, nil, "elixirbrewer")

-- ---- BATTLESONGS ----
-- Recipe("battlesong_durability",			{Ingredient("papyrus", 1), 	Ingredient("featherpencil", 1), Ingredient("sewing_kit", 1)},								CUSTOM_RECIPETABS.BATTLESONGS, TECH.NONE, nil, nil, nil, nil, "battlesinger")
-- Recipe("battlesong_healthgain",			{Ingredient("papyrus", 1), 	Ingredient("featherpencil", 1), Ingredient("amulet", 1)}, 									CUSTOM_RECIPETABS.BATTLESONGS, TECH.NONE, nil, nil, nil, nil, "battlesinger")
-- Recipe("battlesong_sanitygain",			{Ingredient("papyrus", 1), 	Ingredient("featherpencil", 1), Ingredient("moonbutterflywings", 1)}, 						CUSTOM_RECIPETABS.BATTLESONGS, TECH.NONE, nil, nil, nil, nil, "battlesinger")
-- Recipe("battlesong_sanityaura",			{Ingredient("papyrus", 1), 	Ingredient("featherpencil", 1), Ingredient("nightmare_timepiece", 1)}, 						CUSTOM_RECIPETABS.BATTLESONGS, TECH.NONE, nil, nil, nil, nil, "battlesinger")
-- Recipe("battlesong_fireresistance",		{Ingredient("papyrus", 1), 	Ingredient("featherpencil", 1), Ingredient("oceanfish_small_9_inv", 1)}, 					CUSTOM_RECIPETABS.BATTLESONGS, TECH.NONE, nil, nil, nil, nil, "battlesinger")
-- Recipe("battlesong_instant_taunt",		{Ingredient("papyrus", 1), 	Ingredient("featherpencil", 1), Ingredient("tomato", 1, nil, nil, "quagmire_tomato.tex")}, 	CUSTOM_RECIPETABS.BATTLESONGS, TECH.NONE, nil, nil, nil, nil, "battlesinger")
-- Recipe("battlesong_instant_panic",		{Ingredient("papyrus", 1), 	Ingredient("featherpencil", 1), Ingredient("purplegem", 1)}, 								CUSTOM_RECIPETABS.BATTLESONGS, TECH.NONE, nil, nil, nil, nil, "battlesinger")


-- ----- SPIDER -----
-- Recipe("spidereggsack", 		{ Ingredient("silk", 12),  Ingredient("spidergland", 4), Ingredient("papyrus", 3)}, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.NONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("spiderden_bedazzler",   { Ingredient("silk", 1),   Ingredient("papyrus", 1), 	 Ingredient("boards", 2) }, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.NONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("spider_whistle",  		{ Ingredient("silk", 3),   Ingredient("twigs", 2) }, 								CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.NONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("spider_repellent",  	{ Ingredient("boards", 2), Ingredient("goldnugget", 2),  Ingredient("rope", 1) }, 	CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.NONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("spider_healer_item",  	{ Ingredient("honey", 2),  Ingredient("ash",  2), 		 Ingredient("silk", 2) }, 	CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.NONE, nil, nil, nil, nil, "spiderwhisperer")

-- Recipe("mutator_warrior", 		{ Ingredient("monstermeat", 2), Ingredient("silk", 1), Ingredient("pigskin", 1)   	   }, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("mutator_dropper", 		{ Ingredient("monstermeat", 1), Ingredient("silk", 1), Ingredient("manrabbit_tail", 1) }, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("mutator_hider",	  		{ Ingredient("monstermeat", 1), Ingredient("silk", 2), Ingredient("cutstone", 2)  	   }, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("mutator_spitter", 		{ Ingredient("monstermeat", 1), Ingredient("silk", 2), Ingredient("nitre", 4) 	  	   }, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("mutator_moon",	  		{ Ingredient("monstermeat", 2), Ingredient("silk", 3), Ingredient("moonglass", 2) 	   }, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("mutator_healer",  		{ Ingredient("monstermeat", 2), Ingredient("silk", 2), Ingredient("honey", 2) 	  	   }, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer")
-- Recipe("mutator_water",  		{ Ingredient("monstermeat", 2), Ingredient("silk", 2), Ingredient("fig", 2) 	  	   }, CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer")

-- ----NATURE----
-- Recipe("livinglog", 	{Ingredient(CHARACTER_INGREDIENT.HEALTH, 20)}, CUSTOM_RECIPETABS.NATURE, TECH.NONE, nil, nil, nil, nil, "plantkin")
-- Recipe("armor_bramble", {Ingredient("livinglog", 2), Ingredient("boneshard", 4)}, CUSTOM_RECIPETABS.NATURE, TECH.NONE, nil, nil, nil, nil, "plantkin")
-- Recipe("trap_bramble",  {Ingredient("livinglog", 1), Ingredient("stinger", 1)}, CUSTOM_RECIPETABS.NATURE, TECH.NONE, nil, nil, nil, nil, "plantkin")
-- Recipe("compostwrap",   {Ingredient("poop", 5), Ingredient("spoiled_food", 2), Ingredient("nitre", 1)}, CUSTOM_RECIPETABS.NATURE, TECH.NONE, nil, nil, nil, nil, "plantkin")

-- -- SLINGSHOT AMMO --
-- Recipe("slingshotammo_rock",	  {Ingredient("rocks", 1)},											   CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.NONE,		  {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
-- Recipe("slingshotammo_gold",	  {Ingredient("goldnugget", 1)},									   CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.SCIENCE_ONE, {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
-- Recipe("slingshotammo_marble",	  {Ingredient("marble", 1)},										   CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.SCIENCE_TWO, {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
-- Recipe("slingshotammo_poop",	  {Ingredient("poop", 1)},											   CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.SCIENCE_ONE, {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
-- Recipe("slingshotammo_freeze",	  {Ingredient("moonrocknugget", 1), Ingredient("bluegem", 1)},		   CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.MAGIC_TWO,	  {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
-- Recipe("slingshotammo_slow",	  {Ingredient("moonrocknugget", 1), Ingredient("purplegem", 1)},	   CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.MAGIC_THREE, {no_deconstruction = true}, nil, nil, 10, "pebblemaker")
-- Recipe("slingshotammo_thulecite", {Ingredient("thulecite_pieces", 1), Ingredient("nightmarefuel", 1)}, CUSTOM_RECIPETABS.SLINGSHOTAMMO, TECH.ANCIENT_TWO, {no_deconstruction = true}, nil, true, 10, "pebblemaker")

-- -- CLOCKMAKER --
-- local function pocketwatch_no_deconstruction_fn(inst) return not inst:HasTag("pocketwatch_inactive") end

-- Recipe("pocketwatch_dismantler",	{Ingredient("goldnugget", 1), Ingredient("flint", 1), Ingredient("twigs", 3)},						CUSTOM_RECIPETABS.CLOCKMAKER, TECH.NONE,		{no_deconstruction = pocketwatch_no_deconstruction_fn}, nil, nil, nil, "clockmaker")
-- Recipe("pocketwatch_parts",			{Ingredient("pocketwatch_dismantler", 0), Ingredient("thulecite_pieces", 8), Ingredient("nightmarefuel", 2)},				CUSTOM_RECIPETABS.CLOCKMAKER, TECH.NONE,		nil, nil, nil, nil, "clockmaker")
-- Recipe("pocketwatch_heal",			{Ingredient("pocketwatch_parts", 1), Ingredient("marble", 2), Ingredient("redgem", 1)},				CUSTOM_RECIPETABS.CLOCKMAKER, TECH.NONE,		{no_deconstruction = pocketwatch_no_deconstruction_fn}, nil, nil, nil, "clockmaker")
-- Recipe("pocketwatch_revive",		{Ingredient("pocketwatch_parts", 1), Ingredient("livinglog", 2), Ingredient("boneshard", 4)},		CUSTOM_RECIPETABS.CLOCKMAKER, TECH.NONE,		{no_deconstruction = pocketwatch_no_deconstruction_fn}, nil, nil, nil, "clockmaker")
-- Recipe("pocketwatch_warp",			{Ingredient("pocketwatch_parts", 1), Ingredient("goldnugget", 2)},									CUSTOM_RECIPETABS.CLOCKMAKER, TECH.NONE,		{no_deconstruction = pocketwatch_no_deconstruction_fn}, nil, nil, nil, "clockmaker")
-- Recipe("pocketwatch_recall",		{Ingredient("pocketwatch_parts", 2), Ingredient("goldnugget", 2), Ingredient("walrus_tusk", 1)},	CUSTOM_RECIPETABS.CLOCKMAKER, TECH.MAGIC_TWO,	{no_deconstruction = pocketwatch_no_deconstruction_fn}, nil, nil, nil, "clockmaker")
-- Recipe("pocketwatch_portal",		{Ingredient("pocketwatch_recall", 1, nil, true), Ingredient("purplegem", 1)},						CUSTOM_RECIPETABS.CLOCKMAKER, TECH.MAGIC_TWO,	{no_deconstruction = pocketwatch_no_deconstruction_fn, actionstr = "SOCKET"}, nil, nil, nil, "clockmaker")
-- Recipe("pocketwatch_weapon",		{Ingredient("pocketwatch_parts", 3), Ingredient("marble", 4), Ingredient("nightmarefuel", 8)},		CUSTOM_RECIPETABS.CLOCKMAKER, TECH.MAGIC_THREE, nil, nil, nil, nil, "clockmaker")



-- ----CARTOGRAPHY----
-- Recipe("mapscroll", {Ingredient("featherpencil", 1), Ingredient("papyrus", 1)}, RECIPETABS.CARTOGRAPHY, TECH.CARTOGRAPHY_TWO, nil, nil, true, nil, nil, nil, function() return TheWorld.worldprefab == "forest" and "mapscroll.tex" or ("mapscroll_"..TheWorld.worldprefab..".tex") end)

-- ----SEAFARING----
-- Recipe("boat_item", 		   {Ingredient("boards", 4)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
-- Recipe("boatpatch", 		   {Ingredient("boards", 1), Ingredient("stinger", 2)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
-- Recipe("oar", 				   {Ingredient("log", 1)}, 			 RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
-- Recipe("oar_driftwood", 	   {Ingredient("driftwood_log", 1)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
-- Recipe("anchor_item", 		   {Ingredient("boards", 2), 		Ingredient("rope", 3), Ingredient("cutstone", 3)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
-- Recipe("mast_item", 		   {Ingredient("boards", 3), 		Ingredient("rope", 3), Ingredient("silk", 8)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
-- Recipe("mast_malbatross_item", {Ingredient("driftwood_log", 3), Ingredient("rope", 3), Ingredient("malbatross_feathered_weave", 4)}, RECIPETABS.SEAFARING, TECH.LOST)
-- Recipe("steeringwheel_item",   {Ingredient("boards", 2), 		Ingredient("rope", 1)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
--Recipe("fish_box",			   {Ingredient("cutstone", 1), 		Ingredient("rope", 3)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, "fish_box_placer", 1.5, nil, nil, nil, nil, nil,
--    function(pt)
--       return TheWorld.Map:GetPlatformAtPoint(pt.x, 0, pt.z, -0.5) ~= nil
--    end)
--Recipe("winch",				   {Ingredient("boards", 2), Ingredient("cutstone", 1), Ingredient("rope", 2)}, RECIPETABS.SEAFARING, TECH.LOST, "winch_placer", 1.5)
--Recipe("mastupgrade_lamp_item", {Ingredient("boards", 1), Ingredient("rope", 2), Ingredient("flint", 4)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
--Recipe("mastupgrade_lightningrod_item", {Ingredient("goldnugget", 5)},                                      RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)
--Recipe("waterpump",            {Ingredient("boards", 2),Ingredient("oceanfish_small_9_inv", 1)},               RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, "waterpump_placer", 1.5, nil, nil, nil, nil, "waterpump_item.tex")

--Recipe("fishingnet", {Ingredient("silk", 6)}, RECIPETABS.SEAFARING, TECH.SEAFARING_ONE, nil, nil, true)
--Recipe("chesspiece_anchor_sketch", {Ingredient("papyrus", 1)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO)

----SCULPTING----
--Recipe("chesspiece_hornucopia_builder", {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.SCULPTING_ONE, nil, nil, true, nil, nil, nil, "chesspiece_hornucopia.tex")
--Recipe("chesspiece_pipe_builder", 		{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.SCULPTING_ONE, nil, nil, true, nil, nil, nil, "chesspiece_pipe.tex")
--Recipe("chesspiece_anchor_builder",     {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_anchor.tex")
--Recipe("chesspiece_pawn_builder", 		{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_pawn.tex")
--Recipe("chesspiece_rook_builder", 		{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_rook.tex")
--Recipe("chesspiece_knight_builder", 	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_knight.tex")
--Recipe("chesspiece_bishop_builder", 	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_bishop.tex")
--Recipe("chesspiece_muse_builder", 		{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_muse.tex")
--Recipe("chesspiece_formal_builder", 	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_formal.tex")
--Recipe("chesspiece_deerclops_builder",  {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_deerclops.tex")
--Recipe("chesspiece_bearger_builder", 	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)},	RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_bearger.tex")
--Recipe("chesspiece_moosegoose_builder", {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_moosegoose.tex")
--Recipe("chesspiece_dragonfly_builder", 	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_dragonfly.tex")
--Recipe("chesspiece_minotaur_builder",   {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_minotaur.tex")
--Recipe("chesspiece_toadstool_builder",	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_toadstool.tex")
--Recipe("chesspiece_beequeen_builder",	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_beequeen.tex")
--Recipe("chesspiece_klaus_builder",		{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_klaus.tex")
--Recipe("chesspiece_antlion_builder",	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_antlion.tex")
--Recipe("chesspiece_stalker_builder",	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_stalker.tex")
--Recipe("chesspiece_malbatross_builder", {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_malbatross.tex")
--Recipe("chesspiece_crabking_builder",   {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_crabking.tex")
--Recipe("chesspiece_butterfly_builder", 	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_butterfly.tex")
--Recipe("chesspiece_moon_builder", 	    {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_moon.tex")
--Recipe("chesspiece_clayhound_builder", 	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_clayhound.tex")
--Recipe("chesspiece_claywarg_builder", 	{Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_claywarg.tex")
--Recipe("chesspiece_carrat_builder",     {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_carrat.tex")
--Recipe("chesspiece_beefalo_builder",    {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_beefalo.tex")
--Recipe("chesspiece_guardianphase3_builder",    {Ingredient(TECH_INGREDIENT.SCULPTING, 2), Ingredient("rocks", 2)}, RECIPETABS.SCULPTING, TECH.LOST, nil, nil, true, nil, nil, nil, "chesspiece_guardianphase3.tex")

----CRITTERS----
--Recipe("critter_kitten_builder", 		{Ingredient("coontail", 1),      Ingredient("fishsticks", 1)}, 	   RECIPETABS.ORPHANAGE, TECH.ORPHANAGE_ONE, nil, nil, true)
--Recipe("critter_puppy_builder", 		{Ingredient("houndstooth", 4),   Ingredient("monsterlasagna", 1)}, RECIPETABS.ORPHANAGE, TECH.ORPHANAGE_ONE, nil, nil, true)
--Recipe("critter_lamb_builder", 			{Ingredient("steelwool", 1),     Ingredient("guacamole", 1)}, 	   RECIPETABS.ORPHANAGE, TECH.ORPHANAGE_ONE, nil, nil, true)
--Recipe("critter_perdling_builder", 		{Ingredient("featherhat", 1),    Ingredient("trailmix", 1)}, 	   RECIPETABS.ORPHANAGE, TECH.ORPHANAGE_ONE, nil, nil, true)
--Recipe("critter_dragonling_builder", 	{Ingredient("lavae_cocoon", 1),  Ingredient("hotchili", 1)}, 	   RECIPETABS.ORPHANAGE, TECH.ORPHANAGE_ONE, nil, nil, true)
--Recipe("critter_glomling_builder",   	{Ingredient("glommerfuel", 1),   Ingredient("taffy", 1)}, 		   RECIPETABS.ORPHANAGE, TECH.ORPHANAGE_ONE, nil, nil, true)
--Recipe("critter_lunarmothling_builder", {Ingredient("moonbutterfly", 1), Ingredient("flowersalad", 1)},    RECIPETABS.ORPHANAGE, TECH.ORPHANAGE_ONE, nil, nil, true)

----PERDSHRINE-----
--Recipe("yotb_stage_item",           {Ingredient("boards", 4), Ingredient("beefalowool", 2), Ingredient("goldnugget", 2)},   RECIPETABS.PERDOFFERING, TECH.BEEFOFFERING_THREE, nil, nil, true)
--Recipe("yotb_post_item",            {Ingredient("boards", 2), Ingredient("goldnugget", 1)},                                 RECIPETABS.PERDOFFERING, TECH.BEEFOFFERING_THREE, nil, nil, true)
--Recipe("yotb_sewingmachine_item",   {Ingredient("stinger", 1), Ingredient("goldnugget", 1), Ingredient("silk", 2)},         RECIPETABS.PERDOFFERING, TECH.BEEFOFFERING_THREE, nil, nil, true)
--Recipe("yotb_pattern_fragment_1",   {Ingredient("lucky_goldnugget", 5)},                                                    RECIPETABS.PERDOFFERING, TECH.BEEFOFFERING_THREE, nil, nil, true)
--Recipe("yotb_pattern_fragment_2",   {Ingredient("lucky_goldnugget", 5)},                                                    RECIPETABS.PERDOFFERING, TECH.BEEFOFFERING_THREE, nil, nil, true)
--Recipe("yotb_pattern_fragment_3",   {Ingredient("lucky_goldnugget", 5)},                                                    RECIPETABS.PERDOFFERING, TECH.BEEFOFFERING_THREE, nil, nil, true)
--Recipe("chesspiece_beefalo_sketch", {Ingredient("lucky_goldnugget", 8)},                                                    RECIPETABS.PERDOFFERING, TECH.BEEFOFFERING_THREE, nil, nil, true)

--Recipe("yotc_carrat_race_start_item",       {Ingredient("goldnugget", 1)},       RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_carrat_race_finish_item",      {Ingredient("goldnugget", 1)},       RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_carrat_race_checkpoint_item",  {Ingredient("lucky_goldnugget", 2)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_shrinecarrat",			        {Ingredient("goldnugget", 4)},       RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true, nil, nil, nil, nil, nil, "carrat")
--Recipe("yotc_carrat_gym_speed_item",        {Ingredient("lucky_goldnugget", 4)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_carrat_gym_reaction_item",     {Ingredient("lucky_goldnugget", 4)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_carrat_gym_stamina_item",      {Ingredient("lucky_goldnugget", 4)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_carrat_gym_direction_item",    {Ingredient("lucky_goldnugget", 4)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_carrat_scale_item",            {Ingredient("lucky_goldnugget", 1)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_seedpacket",			        {Ingredient("lucky_goldnugget", 2)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("yotc_seedpacket_rare",		        {Ingredient("lucky_goldnugget", 4)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)
--Recipe("chesspiece_carrat_sketch",          {Ingredient("lucky_goldnugget", 8)}, RECIPETABS.PERDOFFERING, TECH.CARRATOFFERING_THREE, nil, nil, true)

--Recipe("perdfan", 	                         {Ingredient("lucky_goldnugget", 3)}, RECIPETABS.PERDOFFERING, TECH.PERDOFFERING_THREE, nil, nil, true)

--Recipe("houndwhistle",                       {Ingredient("lucky_goldnugget", 3)}, RECIPETABS.PERDOFFERING, TECH.WARGOFFERING_THREE, nil, nil, true)
--Recipe("chesspiece_clayhound_sketch",        {Ingredient("lucky_goldnugget", 8) }, RECIPETABS.PERDOFFERING, TECH.WARGOFFERING_THREE, nil, nil, true)
--Recipe("chesspiece_claywarg_sketch",         {Ingredient("lucky_goldnugget", 16)}, RECIPETABS.PERDOFFERING, TECH.WARGOFFERING_THREE, nil, nil, true)

--Recipe("yotp_food3", 	                     {Ingredient("lucky_goldnugget", 4)}, RECIPETABS.PERDOFFERING, TECH.PIGOFFERING_THREE, nil, nil, true)
--Recipe("yotp_food1", 	                     {Ingredient("lucky_goldnugget", 6)}, RECIPETABS.PERDOFFERING, TECH.PIGOFFERING_THREE, nil, nil, true)
--Recipe("yotp_food2", 	                     {Ingredient("lucky_goldnugget", 1)}, RECIPETABS.PERDOFFERING, TECH.PIGOFFERING_THREE, nil, nil, true)

--Recipe("firecrackers",                       {Ingredient("lucky_goldnugget", 1)}, RECIPETABS.PERDOFFERING, TECH.PERDOFFERING_ONE, nil, nil, true, 3)
--Recipe("redlantern",                         {Ingredient("lucky_goldnugget", 3)}, RECIPETABS.PERDOFFERING, TECH.PERDOFFERING_ONE, nil, nil, true)
--Recipe("miniboatlantern",                    {Ingredient("lucky_goldnugget", 3)}, RECIPETABS.PERDOFFERING, TECH.PERDOFFERING_ONE, nil, nil, true)
--Recipe("dragonheadhat",                      {Ingredient("lucky_goldnugget", 8)}, RECIPETABS.PERDOFFERING, TECH.PERDOFFERING_ONE, nil, nil, true)
--Recipe("dragonbodyhat",                      {Ingredient("lucky_goldnugget", 8)}, RECIPETABS.PERDOFFERING, TECH.PERDOFFERING_ONE, nil, nil, true)
--Recipe("dragontailhat",                      {Ingredient("lucky_goldnugget", 8)}, RECIPETABS.PERDOFFERING, TECH.PERDOFFERING_ONE, nil, nil, true)

----MADSCIENCE-----
--Recipe("halloween_experiment_bravery",  {Ingredient("froglegs", 1),  		  Ingredient("goldnugget", 1),  	  Ingredient(CHARACTER_INGREDIENT.SANITY, 10)}, RECIPETABS.MADSCIENCE, TECH.MADSCIENCE_ONE, nil, nil, true, nil, nil, nil, "halloweenpotion_bravery_small.tex")
--Recipe("halloween_experiment_health", 	{Ingredient("mosquito", 1),  		  Ingredient("red_cap", 1),     	  Ingredient(CHARACTER_INGREDIENT.SANITY, 10)}, RECIPETABS.MADSCIENCE, TECH.MADSCIENCE_ONE, nil, nil, true, nil, nil, nil, "halloweenpotion_health_small.tex")
--Recipe("halloween_experiment_sanity", 	{Ingredient("crow", 1), 	 		  Ingredient("petals_evil", 1), 	  Ingredient(CHARACTER_INGREDIENT.SANITY, 10)}, RECIPETABS.MADSCIENCE, TECH.MADSCIENCE_ONE, nil, nil, true, nil, nil, nil, "halloweenpotion_sanity_small.tex")
--Recipe("halloween_experiment_volatile", {Ingredient("rottenegg", 1), 		  Ingredient("charcoal", 1), 		  Ingredient(CHARACTER_INGREDIENT.SANITY, 10)}, RECIPETABS.MADSCIENCE, TECH.MADSCIENCE_ONE, nil, nil, true, nil, nil, nil, "halloweenpotion_embers.tex")
--Recipe("halloween_experiment_moon", 	{Ingredient("moonbutterflywings", 1), Ingredient("moon_tree_blossom", 1), Ingredient(CHARACTER_INGREDIENT.SANITY, 10)}, RECIPETABS.MADSCIENCE, TECH.MADSCIENCE_ONE, nil, nil, true, nil, nil, nil, "halloweenpotion_moon.tex")
--Recipe("halloween_experiment_root", 	{Ingredient("batwing", 1), 			  Ingredient("livinglog", 1),		  Ingredient(CHARACTER_INGREDIENT.SANITY, 20)}, RECIPETABS.MADSCIENCE, TECH.MADSCIENCE_ONE, nil, nil, true, nil, nil, nil, "livingtree_root.tex")

----WINTERSFEASTCOOKING-----
--Recipe("wintercooking_berrysauce",		{Ingredient("wintersfeastfuel", 1), Ingredient("mosquitosack", 2)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "berrysauce.tex")
--Recipe("wintercooking_bibingka",		{Ingredient("wintersfeastfuel", 1), Ingredient("foliage", 2)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "bibingka.tex")
--Recipe("wintercooking_cabbagerolls",	{Ingredient("wintersfeastfuel", 1), Ingredient("cutreeds", 2)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "cabbagerolls.tex")
--Recipe("wintercooking_festivefish",		{Ingredient("wintersfeastfuel", 1), Ingredient("spoiled_fish_small", 1), Ingredient("petals", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "festivefish.tex")
--Recipe("wintercooking_gravy",			{Ingredient("wintersfeastfuel", 1), Ingredient("spoiled_food", 1), Ingredient("boneshard", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "gravy.tex")
--Recipe("wintercooking_latkes",			{Ingredient("wintersfeastfuel", 1), Ingredient("twigs", 1), Ingredient("cutgrass", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "latkes.tex")
--Recipe("wintercooking_lutefisk",		{Ingredient("wintersfeastfuel", 1), Ingredient("spoiled_fish", 1), Ingredient("driftwood_log", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "lutefisk.tex")
--Recipe("wintercooking_mulleddrink",		{Ingredient("wintersfeastfuel", 1), Ingredient("petals_evil", 1), Ingredient("ice", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "mulleddrink.tex")
--Recipe("wintercooking_panettone",		{Ingredient("wintersfeastfuel", 1), Ingredient("rock_avocado_fruit", 2, nil, nil, "rock_avocado_fruit_rockhard.tex")},  RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "panettone.tex")
--Recipe("wintercooking_pavlova",			{Ingredient("wintersfeastfuel", 1), Ingredient("moon_tree_blossom", 2)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "pavlova.tex")
--Recipe("wintercooking_pickledherring",	{Ingredient("wintersfeastfuel", 1), Ingredient("flint", 1), Ingredient("saltrock", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "pickledherring.tex")
--Recipe("wintercooking_polishcookie",	{Ingredient("wintersfeastfuel", 1), Ingredient("butterflywings", 2)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "polishcookie.tex")
--Recipe("wintercooking_pumpkinpie",		{Ingredient("wintersfeastfuel", 1), Ingredient("ash", 1), Ingredient("phlegm", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "pumpkinpie.tex")
--Recipe("wintercooking_roastturkey",		{Ingredient("wintersfeastfuel", 1), Ingredient("log", 1), Ingredient("charcoal", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "roastturkey.tex")
--Recipe("wintercooking_stuffing",		{Ingredient("wintersfeastfuel", 1), Ingredient("beardhair", 2)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "stuffing.tex")
--Recipe("wintercooking_sweetpotato",		{Ingredient("wintersfeastfuel", 1), Ingredient("rocks", 2)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "sweetpotato.tex")
--Recipe("wintercooking_tamales",			{Ingredient("wintersfeastfuel", 1), Ingredient("stinger", 2)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "tamales.tex")
--Recipe("wintercooking_tourtiere",		{Ingredient("wintersfeastfuel", 1), Ingredient("acorn", 1), Ingredient("pinecone", 1)}, RECIPETABS.WINTERSFEASTCOOKING, TECH.WINTERSFEASTCOOKING_ONE, nil, nil, true, nil, nil, nil, "tourtiere.tex")

----FOODPROCESSING-----
--Recipe("spice_garlic", {Ingredient("garlic", 3, nil, nil, "quagmire_garlic.tex")}, RECIPETABS.FOODPROCESSING, TECH.FOODPROCESSING_ONE, nil, nil, true, 2, "professionalchef")
--Recipe("spice_sugar",  {Ingredient("honey", 3)},    RECIPETABS.FOODPROCESSING, TECH.FOODPROCESSING_ONE, nil, nil, true, 2, "professionalchef")
--Recipe("spice_chili",  {Ingredient("pepper", 3)},   RECIPETABS.FOODPROCESSING, TECH.FOODPROCESSING_ONE, nil, nil, true, 2, "professionalchef")
--Recipe("spice_salt",   {Ingredient("saltrock", 3)}, RECIPETABS.FOODPROCESSING, TECH.FOODPROCESSING_ONE, nil, nil, true, 2, "professionalchef")

----FISHING-----
--Recipe("oceanfishingbobber_ball",			{Ingredient("log", 1)}, RECIPETABS.FISHING, TECH.FISHING_ONE, nil, nil, true)
--Recipe("oceanfishingbobber_oval",			{Ingredient("driftwood_log", 1)}, RECIPETABS.FISHING, TECH.FISHING_ONE, nil, nil, true)
--Recipe("oceanfishingbobber_crow",			{Ingredient("feather_crow", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)
--Recipe("oceanfishingbobber_robin",			{Ingredient("feather_robin", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)
--Recipe("oceanfishingbobber_robin_winter",	{Ingredient("feather_robin_winter", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)
--Recipe("oceanfishingbobber_canary",			{Ingredient("feather_canary", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)
--Recipe("oceanfishingbobber_goose",			{Ingredient("goose_feather", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)
--Recipe("oceanfishingbobber_malbatross",		{Ingredient("malbatross_feather", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)

--Recipe("oceanfishinglure_spoon_red",		{Ingredient("flint", 2), Ingredient("red_cap", 1)}, RECIPETABS.FISHING, TECH.FISHING_ONE, nil, nil, true)
--Recipe("oceanfishinglure_spoon_green",		{Ingredient("flint", 2), Ingredient("green_cap", 1)}, RECIPETABS.FISHING, TECH.FISHING_ONE, nil, nil, true)
--Recipe("oceanfishinglure_spoon_blue",		{Ingredient("flint", 2), Ingredient("blue_cap", 1)}, RECIPETABS.FISHING, TECH.FISHING_ONE, nil, nil, true)
--Recipe("oceanfishinglure_spinner_red",		{Ingredient("flint", 1), Ingredient("beefalowool", 1), Ingredient("red_cap", 1)}, RECIPETABS.FISHING, TECH.FISHING_ONE, nil, nil, true)
--Recipe("oceanfishinglure_spinner_green",	{Ingredient("flint", 1), Ingredient("beefalowool", 1), Ingredient("green_cap", 1)}, RECIPETABS.FISHING, TECH.FISHING_ONE, nil, nil, true)
--Recipe("oceanfishinglure_spinner_blue",		{Ingredient("flint", 1), Ingredient("beefalowool", 1), Ingredient("blue_cap", 1)}, RECIPETABS.FISHING, TECH.FISHING_ONE, nil, nil, true)
--Recipe("oceanfishinglure_hermit_rain",		{Ingredient("cookiecuttershell", 1), Ingredient("mosquitosack", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)
--Recipe("oceanfishinglure_hermit_snow",		{Ingredient("cookiecuttershell", 1), Ingredient("ice", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)
--Recipe("oceanfishinglure_hermit_drowsy",	{Ingredient("cookiecuttershell", 1), Ingredient("stinger", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)
--Recipe("oceanfishinglure_hermit_heavy",		{Ingredient("cookiecuttershell", 1), Ingredient("beefalowool", 1)}, RECIPETABS.FISHING, TECH.LOST, nil, nil, true)

-- Balloonomancy
--Recipe("balloons_empty",		{Ingredient("waterballoon", 4)}, CUSTOM_RECIPETABS.BALLOONOMANCY, TECH.NONE, nil, nil, nil, nil, "balloonomancer")
--Recipe("balloon",				{Ingredient("balloons_empty", 0), Ingredient(CHARACTER_INGREDIENT.SANITY, 5)}, CUSTOM_RECIPETABS.BALLOONOMANCY, TECH.NONE, {dropitem = true, buildingstate = "makeballoon"}, nil, nil, nil, "balloonomancer")
--Recipe("balloonspeed",			{Ingredient("balloons_empty", 0), Ingredient(CHARACTER_INGREDIENT.SANITY, 5)}, CUSTOM_RECIPETABS.BALLOONOMANCY, TECH.NONE, {buildingstate = "makeballoon"}, nil, nil, nil, "balloonomancer")
--Recipe("balloonparty",			{Ingredient("balloons_empty", 0), Ingredient(CHARACTER_INGREDIENT.SANITY, 5)}, CUSTOM_RECIPETABS.BALLOONOMANCY, TECH.NONE, {dropitem = true, buildingstate = "makeballoon"}, nil, nil, nil, "balloonomancer")
--Recipe("balloonvest",			{Ingredient("balloons_empty", 0), Ingredient(CHARACTER_INGREDIENT.SANITY, 5)}, CUSTOM_RECIPETABS.BALLOONOMANCY, TECH.NONE, {buildingstate = "makeballoon"}, nil, nil, nil, "balloonomancer")
--Recipe("balloonhat",			{Ingredient("balloons_empty", 0), Ingredient(CHARACTER_INGREDIENT.SANITY, 5)}, CUSTOM_RECIPETABS.BALLOONOMANCY, TECH.NONE, {buildingstate = "makeballoon"}, nil, nil, nil, "balloonomancer")

----HERMITCRABSHOP-----
--Recipe("hermitshop_hermit_bundle_shells", {Ingredient("messagebottleempty", 1)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_ONE, nil, nil, true, nil, nil, nil, "hermit_bundle.tex", nil, "hermit_bundle_shells")
--Recipe("hermitshop_winch_blueprint", {Ingredient("messagebottleempty", 1)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_ONE, nil, nil, true, nil, nil, nil, "blueprint.tex", nil, "winch_blueprint")
--Recipe("hermitshop_turf_shellbeach_blueprint", {Ingredient("messagebottleempty", 3)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_ONE, nil, nil, true, nil, nil, nil, "blueprint.tex", nil, "turf_shellbeach_blueprint")

--Recipe("hermitshop_oceanfishingbobber_crow", {Ingredient("messagebottleempty", 1)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_THREE, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishingbobber_crow")
--Recipe("hermitshop_oceanfishingbobber_robin", {Ingredient("messagebottleempty", 1)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_THREE, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishingbobber_robin")
--Recipe("hermitshop_oceanfishingbobber_robin_winter", {Ingredient("messagebottleempty", 1)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_THREE, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishingbobber_robin_winter")
--Recipe("hermitshop_oceanfishingbobber_canary", {Ingredient("messagebottleempty", 1)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_THREE, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishingbobber_canary")
--Recipe("hermitshop_tacklecontainer", {Ingredient("messagebottleempty", 3)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_THREE, nil, nil, true, nil, nil, nil, nil, nil, "tacklecontainer")

--Recipe("hermitshop_oceanfishinglure_hermit_rain", {Ingredient("messagebottleempty", 2)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_FIVE, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishinglure_hermit_rain")
--Recipe("hermitshop_oceanfishinglure_hermit_snow", {Ingredient("messagebottleempty", 2)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_FIVE, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishinglure_hermit_snow")
--Recipe("hermitshop_oceanfishinglure_hermit_drowsy", {Ingredient("messagebottleempty", 2)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_FIVE, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishinglure_hermit_drowsy")
--Recipe("hermitshop_oceanfishinglure_hermit_heavy", {Ingredient("messagebottleempty", 2)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_FIVE, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishinglure_hermit_heavy")

--Recipe("hermitshop_oceanfishingbobber_goose", {Ingredient("messagebottleempty", 3)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_SEVEN, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishingbobber_goose")
--Recipe("hermitshop_oceanfishingbobber_malbatross", {Ingredient("messagebottleempty", 3)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_SEVEN, nil, nil, true, nil, nil, nil, nil, nil, "oceanfishingbobber_malbatross")
--Recipe("hermitshop_chum", {Ingredient("messagebottleempty", 3)}, RECIPETABS.HERMITCRABSHOP, TECH.HERMITCRABSHOP_SEVEN,          nil, nil, true, nil, nil, nil, "chum.tex", nil, "chum")

--Recipe("hermitshop_supertacklecontainer", {Ingredient("messagebottleempty", 8)}, RECIPETABS.HERMITCRABSHOP, TECH.LOST, nil, nil, true, nil, nil, nil, nil, nil, "supertacklecontainer")

--Recipe("hermitshop_winter_ornament_boss_hermithouse", {Ingredient("messagebottleempty", 8)}, RECIPETABS.HERMITCRABSHOP, TECH.LOST, {require_special_event = SPECIAL_EVENTS.WINTERS_FEAST}, nil, true, nil, nil, nil, nil, nil, "winter_ornament_boss_hermithouse")
--Recipe("hermitshop_winter_ornament_boss_pearl", {Ingredient("messagebottleempty", 12)}, RECIPETABS.HERMITCRABSHOP, TECH.LOST, {require_special_event = SPECIAL_EVENTS.WINTERS_FEAST}, nil, true, nil, nil, nil, nil, nil, "winter_ornament_boss_pearl")

----TURFCRAFTING-----
--Recipe("turf_forest", {Ingredient("twigs", 1), Ingredient("pinecone", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_grass", {Ingredient("cutgrass", 1), Ingredient("petals", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_savanna", {Ingredient("cutgrass", 1), Ingredient("poop", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_deciduous", {Ingredient("twigs", 1), Ingredient("acorn", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_desertdirt", {Ingredient("rocks", 1), Ingredient("boneshard", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_rocky", {Ingredient("rocks", 1), Ingredient("flint", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_pebblebeach", {Ingredient("rocks", 1), Ingredient("driftwood_log", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)

--Recipe("turf_cave", {Ingredient("guano", 2)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_underrock", {Ingredient("rocks", 3)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_sinkhole", {Ingredient("cutgrass", 1), Ingredient("foliage", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_mud", {Ingredient("turf_desertdirt", 1), Ingredient("ice", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)

--Recipe("turf_fungus", {Ingredient("cutlichen", 1), Ingredient("spore_tall", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_fungus_red", {Ingredient("cutlichen", 1), Ingredient("spore_medium", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)
--Recipe("turf_fungus_green", {Ingredient("cutlichen", 1), Ingredient("spore_small", 1)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true)

--- summer carnival prize shop ---
--Recipe("carnival_popcorn",					{Ingredient("carnival_prizeticket", 12)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true, description = "carnival_popcorn"}, nil, true, 3, nil, nil, nil, nil, "corn_cooked")
--Recipe("carnival_seedpacket",				{Ingredient("carnival_prizeticket", 12)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivalfood_corntea",				{Ingredient("carnival_prizeticket", 12)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnival_vest_a",					{Ingredient("carnival_prizeticket", 24)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnival_vest_b",					{Ingredient("carnival_prizeticket", 48)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnival_vest_c",					{Ingredient("carnival_prizeticket", 48)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)

--Recipe("carnivaldecor_figure_kit",			{Ingredient("carnival_prizeticket", 12)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivalcannon_confetti_kit",		{Ingredient("carnival_prizeticket", 18)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivalcannon_sparkle_kit",		{Ingredient("carnival_prizeticket", 18)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivalcannon_streamer_kit",		{Ingredient("carnival_prizeticket", 18)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivaldecor_plant_kit",			{Ingredient("carnival_prizeticket", 24)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivaldecor_eggride1_kit",		{Ingredient("carnival_prizeticket", 36)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivaldecor_eggride2_kit",		{Ingredient("carnival_prizeticket", 36)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivaldecor_eggride3_kit",		{Ingredient("carnival_prizeticket", 36)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)
--Recipe("carnivaldecor_lamp_kit",			{Ingredient("carnival_prizeticket", 48)}, RECIPETABS.CARNIVAL_PRIZESHOP, TECH.CARNIVAL_PRIZESHOP_ONE, {no_deconstruction = true}, nil, true)

--- summar carnival prize, return the kit when destroyed
--Recipe("carnivaldecor_plant",				{Ingredient("carnivaldecor_plant_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivaldecor_figure",				{Ingredient("carnivaldecor_figure_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivaldecor_eggride1",			{Ingredient("carnivaldecor_eggride1_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivaldecor_eggride2",			{Ingredient("carnivaldecor_eggride2_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivaldecor_eggride3",			{Ingredient("carnivaldecor_eggride3_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivaldecor_lamp",				{Ingredient("carnivaldecor_lamp_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivalcannon_confetti",			{Ingredient("carnivalcannon_confetti_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivalcannon_sparkle",			{Ingredient("carnivalcannon_sparkle_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivalcannon_streamer",			{Ingredient("carnivalcannon_streamer_kit", 1)}, nil, TECH.LOST, nil, nil, true)

--- summer carnival host
--Recipe("carnival_plaza_kit",				{Ingredient("goldnugget", 1), Ingredient("seeds", 3)},	RECIPETABS.CARNIVAL_HOSTSHOP, TECH.CARNIVAL_HOSTSHOP_ONE,   {no_deconstruction = true}, nil, true)
--Recipe("carnival_prizebooth_kit",			{Ingredient("goldnugget", 1), Ingredient("seeds", 3)},	RECIPETABS.CARNIVAL_HOSTSHOP, TECH.CARNIVAL_HOSTSHOP_THREE, {no_deconstruction = true}, nil, true)
--Recipe("carnival_gametoken",				{Ingredient("seeds", 1)},								RECIPETABS.CARNIVAL_HOSTSHOP, TECH.CARNIVAL_HOSTSHOP_THREE, {no_deconstruction = true}, nil, true)
--Recipe("carnival_gametoken_multiple",		{Ingredient("goldnugget", 1)},							RECIPETABS.CARNIVAL_HOSTSHOP, TECH.CARNIVAL_HOSTSHOP_THREE, {no_deconstruction = true, description = "carnival_gametoken_multiple"}, nil, true, 3, nil, nil, "carnival_gametoken_multiple.tex", nil, "carnival_gametoken")
--Recipe("carnivalgame_memory_kit",			{Ingredient("goldnugget", 1), Ingredient("seeds", 3)},	RECIPETABS.CARNIVAL_HOSTSHOP, TECH.CARNIVAL_HOSTSHOP_THREE, {no_deconstruction = true}, nil, true)
--Recipe("carnivalgame_feedchicks_kit",		{Ingredient("goldnugget", 1), Ingredient("seeds", 3)},	RECIPETABS.CARNIVAL_HOSTSHOP, TECH.CARNIVAL_HOSTSHOP_THREE, {no_deconstruction = true}, nil, true)
--Recipe("carnivalgame_herding_kit",			{Ingredient("goldnugget", 1), Ingredient("seeds", 3)},	RECIPETABS.CARNIVAL_HOSTSHOP, TECH.CARNIVAL_HOSTSHOP_THREE, {no_deconstruction = true}, nil, true)

--- summar carnival host, return the kit when destroyed
--Recipe("carnival_plaza",					{Ingredient("carnival_plaza_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnival_prizebooth",				{Ingredient("carnival_prizebooth_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivalgame_memory_station",		{Ingredient("carnivalgame_memory_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivalgame_feedchicks_station",	{Ingredient("carnivalgame_feedchicks_kit", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("carnivalgame_herding_station",		{Ingredient("carnivalgame_herding_kit", 1)}, nil, TECH.LOST, nil, nil, true)

----UNCRAFTABLE----
--NOTE: These recipes are not supposed to be craftable!
--Recipe("sunkenchest", {Ingredient("slurtle_shellpieces", 5)}, nil, TECH.LOST, nil, nil, true)
--Recipe("mastupgrade_lamp", {Ingredient("boards", 1), Ingredient("rope", 2), Ingredient("flint", 4)}, nil, TECH.LOST, nil, nil, true)
--Recipe("mastupgrade_lightningrod", {Ingredient("goldnugget", 5)}, nil, TECH.LOST, nil, nil, true)

--Hermit shop material recipes
--Recipe("tacklecontainer", {Ingredient("cookiecuttershell", 2), Ingredient("rope", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("chum", {Ingredient("spoiled_food", 2)}, nil, TECH.LOST, nil, nil, true)
--Recipe("supertacklecontainer", {Ingredient("cookiecuttershell", 3), Ingredient("rope", 2)}, nil, TECH.LOST, nil, nil, true)

--this is so you can use deconstruction staff on the deployed item
--Recipe("yotb_post",  {Ingredient("boards", 2), Ingredient("goldnugget", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("portablecookpot", {Ingredient("goldnugget", 2), Ingredient("charcoal",   6), Ingredient("twigs", 6)}, nil, TECH.LOST, nil, nil, true)
--Recipe("portableblender", {Ingredient("goldnugget", 2), Ingredient("transistor", 2), Ingredient("twigs", 4)}, nil, TECH.LOST, nil, nil, true)
--Recipe("portablespicer",  {Ingredient("goldnugget", 2), Ingredient("cutstone",   3), Ingredient("twigs", 6)}, nil, TECH.LOST, nil, nil, true)
--Recipe("steeringwheel",   {Ingredient("boards", 2), Ingredient("rope", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("anchor", 		  {Ingredient("boards", 2), Ingredient("rope", 3), Ingredient("cutstone", 3)}, nil, TECH.LOST, nil, nil, true)
--Recipe("mast",   		  {Ingredient("boards", 3), Ingredient("rope", 3), Ingredient("silk",     8)}, nil, TECH.LOST, nil, nil, true)
--Recipe("mast_malbatross", {Ingredient("driftwood_log", 3), Ingredient("rope", 3), Ingredient("malbatross_feathered_weave", 4)}, nil, TECH.LOST, nil, nil, true)
--Recipe("purplemooneye",   {Ingredient("moonrockcrater", 1), Ingredient("purplegem", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("bluemooneye",     {Ingredient("moonrockcrater", 1), Ingredient("bluegem",   1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("redmooneye",      {Ingredient("moonrockcrater", 1), Ingredient("redgem",    1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("orangemooneye",   {Ingredient("moonrockcrater", 1), Ingredient("orangegem", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("yellowmooneye",   {Ingredient("moonrockcrater", 1), Ingredient("yellowgem", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("greenmooneye",    {Ingredient("moonrockcrater", 1), Ingredient("greengem",  1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("opalstaff",       {Ingredient("nightmarefuel", 4), Ingredient("livinglog", 2), Ingredient("opalpreciousgem", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("mermthrone",      {Ingredient("kelp", 20), Ingredient("pigskin", 10), Ingredient("beefalowool", 15)}, nil, TECH.LOST, nil, nil, true)
--Recipe("yotc_carrat_race_start",      	{Ingredient("goldnugget", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("yotc_carrat_race_finish",      	{Ingredient("goldnugget", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("yotc_carrat_race_checkpoint",   {Ingredient("lucky_goldnugget", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("yotc_carrat_gym_direction",     {Ingredient("lucky_goldnugget", 4)}, nil, TECH.LOST, nil, nil, true)
--Recipe("yotc_carrat_gym_speed",       	{Ingredient("lucky_goldnugget", 4)},nil, TECH.LOST, nil, nil, true)
--Recipe("yotc_carrat_gym_reaction",   	{Ingredient("lucky_goldnugget", 4)},nil, TECH.LOST, nil, nil, true)
--Recipe("yotc_carrat_gym_stamina",		{Ingredient("lucky_goldnugget", 4)},nil, TECH.LOST, nil, nil, true)
--Recipe("yotc_carrat_scale",			    {Ingredient("lucky_goldnugget", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("wall_ruins_2_item",             {Ingredient("thulecite", 1)},       nil, TECH.LOST, nil, nil, true)
--Recipe("wall_stone_2_item",             {Ingredient("cutstone", 2)},        nil, TECH.LOST, nil, nil, true)
--Recipe("archive_resonator",             {Ingredient("moonrocknugget", 1), Ingredient("thulecite", 1)},      nil, TECH.LOST, nil, nil, true)
--Recipe("alterguardianhat",              {Ingredient("alterguardianhatshard", 5)},                           nil, TECH.LOST, nil, nil, true)
--Recipe("hivehat",		{Ingredient("honeycomb", 4), Ingredient("honey", 3), Ingredient("royal_jelly", 2), Ingredient("bee", 4)}, nil, TECH.LOST, nil, nil, true)
--Recipe("spiderhat",		{Ingredient("silk", 4), Ingredient("spidergland", 2), Ingredient("monstermeat", 1)}, nil, TECH.LOST, nil, nil, true)
--Recipe("armorskeleton",	{Ingredient("boneshard", 10), Ingredient("nightmarefuel", 6)}, nil, TECH.LOST, nil, nil, true)
--Recipe("skeletonhat",	{Ingredient("boneshard", 10), Ingredient("nightmarefuel", 4)}, nil, TECH.LOST, nil, nil, true)
--Recipe("thurible",		{Ingredient("cutstone", 2), Ingredient("nightmarefuel", 6), Ingredient("ash", 1)}, nil, TECH.LOST, nil, nil, true)
