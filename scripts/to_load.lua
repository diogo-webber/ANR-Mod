local ToLoad = {
	Prefabs = {

	-- Modded:
		"puppet_cutscene",
		"explode_shadow_skin",

	-- DST General:
		"multiplayer_portal",
		"reviver",
		"reviver",
		"ghost_transform_overlay_fx",
		"lifeinjector",
		"twiggytree",
		"twiggy_nut",
		"grassgekko",
		"grassgekkoherd",
		"juiceberrybush",
		"dug_juicyberrybush",
		"berry_juicy",
		"petrify_fx",
		"petrify_announce",
		"flower_withered",
		"depleted_grass",
		"rose",
		"anr_batcave",
		"planted_tree",
		"fan_wheel",
		"minifan",
		"dragonfly_spawner",
		"lavae_tooth",
		"lavae_egg",
		"lavae",
		"lavae_pet",
		"lavae_move_fx",
		"lavae_cocoon",
		"anr_fx",
		"twiggytree",
		"twiggy_nut",
		"hutch_fishbowl",
		"hutch",
		"fan_wheel",
		"minifan",
		"anr_fx",

	-- Ghost System:
		"multiplayer_portal",
		"ghost_transform_overlay_fx",
		"lifeinjector",
		"reviver",

			
	-- DF Setpeice:
		"lava_pond",
		"scorched_skeleton",
		"scorchedground",
		"burnt_marsh_bush",

	-- Meteors Showers:
		"meteorspawner",
		"meteorwarning",
		"shadowmeteor",
		"burntground",
	
	-- A New Reign:
		"anr_rocks",
		"rock_break_fx",
		"moonrocknugget",
	},
	
	Assets = {
		Asset("IMAGE", "images/colour_cubes/ghost_cc.tex"),

		Asset("IMAGE", "images/fepanel_fills.tex"),
		Asset("ATLAS", "images/fepanel_fills.xml"),

		Asset("IMAGE", "images/fepanels_anr.tex"),
		Asset("ATLAS", "images/fepanels_anr.xml"),

		Asset("IMAGE", "images/avatars.tex"),
		Asset("ATLAS", "images/avatars.xml"),

		Asset("IMAGE", "images/hud_anr.tex" ),
		Asset("ATLAS", "images/hud_anr.xml" ),
		Asset("IMAGE", "images/hud2_anr.tex" ),
		Asset("ATLAS", "images/hud2_anr.xml" ),

		Asset("IMAGE", "images/inventoryimages1_anr.tex" ),
		Asset("ATLAS", "images/inventoryimages1_anr.xml" ),
		Asset("IMAGE", "images/inventoryimages2_anr.tex" ),
		Asset("ATLAS", "images/inventoryimages2_anr.xml" ),

		Asset("IMAGE", "minimap/minimap_atlas_anr.tex" ),
		Asset("ATLAS", "minimap/minimap_data_anr.xml" ),

		Asset("ANIM", "anim/resurrection_stone_fx.zip"),
		Asset("ANIM", "anim/status_health.zip"),
		Asset("ANIM", "anim/status_meter.zip"), 
		Asset("ANIM", "anim/townportaltalisman.zip"), --TODO
		
		Asset("ANIM", "anim/cave_clock.zip"),
		Asset("ANIM", "anim/swap_compass.zip"),
		Asset("ANIM", "anim/compass_bg.zip"),
		Asset("ANIM", "anim/compass_needle.zip"),
		Asset("ANIM", "anim/compass_hud.zip"),
		
		Asset("ANIM", "anim/player_actions_cowbell.zip"),
		Asset("ANIM", "anim/player_actions_cowbell.zip"),
		Asset("ANIM", "anim/player_actions_farming.zip"),
		Asset("ANIM", "anim/player_actions_feast_eat.zip"),
		Asset("ANIM", "anim/player_actions_fishing_ocean.zip"),
		Asset("ANIM", "anim/player_actions_fishing_ocean_new.zip"),
		Asset("ANIM", "anim/player_actions_pocket_scale.zip"),
		Asset("ANIM", "anim/player_actions_reversedeath.zip"),
		Asset("ANIM", "anim/player_actions_slingshot.zip"),
		Asset("ANIM", "anim/player_actions_till.zip"),
		Asset("ANIM", "anim/player_actions_whip.zip"),
		Asset("ANIM", "anim/player_attack_prop.zip"),
		Asset("ANIM", "anim/player_boat.zip"),
		Asset("ANIM", "anim/player_boat_channel.zip"),
		Asset("ANIM", "anim/player_boat_hook.zip"),
		Asset("ANIM", "anim/player_boat_jump.zip"),
		Asset("ANIM", "anim/player_boat_jumpheavy.zip"),
		Asset("ANIM", "anim/player_boat_net.zip"),
		Asset("ANIM", "anim/player_boat_plank.zip"),
		Asset("ANIM", "anim/player_boat_sink.zip"),
		Asset("ANIM", "anim/player_book_attack.zip"),
		Asset("ANIM", "anim/player_bow.zip"),
		Asset("ANIM", "anim/player_channel.zip"),
		Asset("ANIM", "anim/player_cointoss.zip"),
		Asset("ANIM", "anim/player_construct.zip"),
		Asset("ANIM", "anim/player_emote_extra.zip"),
		Asset("ANIM", "anim/player_emotes.zip"),
		Asset("ANIM", "anim/player_emotes_dance0.zip"),
		Asset("ANIM", "anim/player_emotes_dance2.zip"),
		Asset("ANIM", "anim/player_emotes_sit.zip"),
		Asset("ANIM", "anim/player_emotesxl.zip"),
		Asset("ANIM", "anim/player_ghost_withhat.zip"),
		Asset("ANIM", "anim/player_hatdance.zip"),
		Asset("ANIM", "anim/player_hideseek.zip"),
		Asset("ANIM", "anim/player_revive_ghosthat.zip"),
		Asset("ANIM", "anim/player_hit_darkness.zip"),
		Asset("ANIM", "anim/player_hit_spike.zip"),
		Asset("ANIM", "anim/player_idles_lunacy.zip"),
		Asset("ANIM", "anim/player_idles_walter.zip"),
		Asset("ANIM", "anim/player_idles_wanda.zip"),
		Asset("ANIM", "anim/player_idles_warly.zip"),
		Asset("ANIM", "anim/player_idles_wathgrithr.zip"),
		Asset("ANIM", "anim/player_idles_webber.zip"),
		Asset("ANIM", "anim/player_idles_wendy.zip"),
		Asset("ANIM", "anim/player_idles_wes.zip"),
		Asset("ANIM", "anim/player_idles_willow.zip"),
		Asset("ANIM", "anim/player_idles_winona.zip"),
		Asset("ANIM", "anim/player_idles_wolfgang.zip"),
		Asset("ANIM", "anim/player_idles_wolfgang_mighty.zip"),
		Asset("ANIM", "anim/player_idles_wolfgang_skinny.zip"),
		Asset("ANIM", "anim/player_idles_woodie.zip"),
		Asset("ANIM", "anim/player_idles_wormwood.zip"),
		Asset("ANIM", "anim/player_idles_wortox.zip"),
		Asset("ANIM", "anim/player_idles_wurt.zip"),
		Asset("ANIM", "anim/player_lunge.zip"),
		Asset("ANIM", "anim/player_mighty_gym.zip"),
		Asset("ANIM", "anim/player_mount_boat_jump.zip"),
		Asset("ANIM", "anim/player_mount_boat_sink.zip"),
		Asset("ANIM", "anim/player_mount_bow.zip"),
		Asset("ANIM", "anim/player_mount_cointoss.zip"),
		Asset("ANIM", "anim/player_mount_emotes.zip"),
		Asset("ANIM", "anim/player_mount_emotes_dance0.zip"),
		Asset("ANIM", "anim/player_mount_emotes_dance2.zip"),
		Asset("ANIM", "anim/player_mount_emotes_extra.zip"),
		Asset("ANIM", "anim/player_mount_emotes_sit.zip"),
		Asset("ANIM", "anim/player_mount_emotesxl.zip"),
		Asset("ANIM", "anim/player_mount_hit_darkness.zip"),
		Asset("ANIM", "anim/player_mount_sandstorm.zip"),
		Asset("ANIM", "anim/player_mount_slingshot.zip"),
		Asset("ANIM", "anim/player_oar.zip"),
		Asset("ANIM", "anim/player_pocketwatch_portal.zip"),
		Asset("ANIM", "anim/player_revive_fx.zip"),
		Asset("ANIM", "anim/player_sandstorm.zip"),
		Asset("ANIM", "anim/player_skin_change.zip"),
		Asset("ANIM", "anim/player_spooked.zip"),
		Asset("ANIM", "anim/player_strum.zip"),
		Asset("ANIM", "anim/player_superjump.zip"),
		Asset("ANIM", "anim/player_townportal.zip"),
		Asset("ANIM", "anim/player_transform_merm.zip"),
		Asset("ANIM", "anim/player_wardrobe.zip"),
		Asset("ANIM", "anim/player_wendy_commune.zip"),
		Asset("ANIM", "anim/player_wendy_mount_commune.zip"),
		Asset("ANIM", "anim/player_wolfgang_dumbbell.zip"),
        Asset("ANIM", "anim/player_revive_to_character.zip"),
		Asset("ANIM", "anim/player_revive_to_werebeaver.zip"),
		Asset("ANIM", "anim/player_revive_to_weremoose.zip"),
		Asset("ANIM", "anim/player_revive_to_weregoose.zip"),
		Asset("ANIM", "anim/player_skin_change.zip"),
		
		Asset("ANIM", "anim/ghost_wathgrithr_build.zip"),
		Asset("ANIM", "anim/ghost_waxwell_build.zip"),
		Asset("ANIM", "anim/ghost_webber_build.zip"),
		Asset("ANIM", "anim/ghost_wendy_build.zip"),
		Asset("ANIM", "anim/ghost_werebeaver_build.zip"),
		Asset("ANIM", "anim/ghost_wes_build.zip"),
		Asset("ANIM", "anim/ghost_wickerbottom_build.zip"),
		Asset("ANIM", "anim/ghost_willow_build.zip"),
		Asset("ANIM", "anim/ghost_wilson_build.zip"),
		Asset("ANIM", "anim/ghost_winona_build.zip"),
		Asset("ANIM", "anim/ghost_wolfgang_build.zip"),
		Asset("ANIM", "anim/ghost_woodie_build.zip"),
		Asset("ANIM", "anim/ghost_wx78_build.zip"),

		Asset("SHADER", "shaders/anim_bloom_ghost.ksh"),

		Asset("ANIM", "anim/cave_exit.zip"),

		Asset("SOUNDPACKAGE", "sound/sound_mod_tutorial.fev"),
		--Asset("SOUND", "sound/together.fsb"),
	},
}

return ToLoad