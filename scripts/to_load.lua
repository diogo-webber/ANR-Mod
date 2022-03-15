local ToLoad = {
	Prefabs = {
		"multiplayer_portal",
		"anr_rocks",
		"rock_break_fx",
		"twiggytree",
		"moonrocknugget",
		"twiggy_nut",
		"grassgekko",
		"grassgekkoherd",
		"juiceberrybush",
		"dug_juicyberrybush",
		"anr_veggies",
		"ghost_transform_overlay_fx",
	},
	
	Assets = {
		Asset("IMAGE", "images/colour_cubes/ghost_cc.tex"),

		Asset("IMAGE", "minimap/minimap_atlas_anr.tex" ),
		Asset("ATLAS", "minimap/minimap_data_anr.xml" ),

		Asset("ANIM", "anim/player_revive_ghosthat.zip"),
		Asset("ANIM", "anim/player_ghost_withhat.zip"),
        Asset("ANIM", "anim/player_revive_to_character.zip"),
		Asset("ANIM", "anim/player_revive_to_werebeaver.zip"),
		Asset("ANIM", "anim/player_revive_to_weremoose.zip"),
		Asset("ANIM", "anim/player_revive_to_weregoose.zip"),
		
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
	},
}

return ToLoad