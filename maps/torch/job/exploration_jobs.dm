/datum/job/pathfinder
	title = "Pathfinder"
	department_types = list(/decl/department/exploration)
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Chief Science Officer"
	selection_color = "#7c07c0"
	minimal_player_age = 1
	economic_power = 10
	minimum_character_age = list(SPECIES_HUMAN = 25)
	ideal_character_age = 35
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/exploration/pathfinder

	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/exploration/pathfinder/espatier
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s2,
		/datum/mil_rank/espatier/o3

	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_ADEPT,
	                    SKILL_SCIENCE     = SKILL_ADEPT,
	                    SKILL_PILOT       = SKILL_BASIC,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX,
	                    SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT)
	skill_points = 22

	access = list(
		access_pathfinder, access_explorer, access_eva, access_maint_tunnels, access_bridge, access_emergency_storage,
		access_opportunity_helm, access_solgov_crew, access_expedition_shuttle, access_expedition_shuttle_helm,
		access_opportunity, access_hangar, access_curiosity, access_curiosity_helm, access_curiosity_analysis, access_curiosity_phoron,
		access_curiosity_toxins, access_curiosity_chemistry, access_curiosity_maint, access_tox, access_tox_storage, access_research,
		access_xenobiology, access_xenoarch, access_torch_fax, access_radio_comm, access_radio_exp, access_radio_sci
	)

	software_on_spawn = list(/datum/computer_file/program/deck_management,
							 /datum/computer_file/program/reports)

/datum/job/pathfinder/get_description_blurb()
	return "You are the Pathfinder. Your duty is to organize and lead the expeditions to away sites, carrying out the EC's Primary Mission. You command Explorers. You make sure that expedition has the supplies and personnel it needs. You can pilot Spirit if nobody else provides a pilot. Once on the away mission, your duty is to ensure that anything of scientific interest is brought back to the ship and passed to the relevant research lab."

/datum/job/nt_pilot
	title = "Shuttle Pilot"
	supervisors = "the Pathfinder"
	department_types = list(/decl/department/exploration)
	total_positions = 1
	spawn_positions = 1
	selection_color = "#68099e"
	economic_power = 8
	minimal_player_age = 0
	minimum_character_age = list(SPECIES_HUMAN = 24)
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/exploration/pilot
	allowed_branches = list(
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/exploration/pilot/espatier,
		/datum/mil_branch/iseo_issc,
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s2,
		/datum/mil_rank/espatier/o2
	)

	access = list(
		access_mining_office, access_curiosity, access_curiosity_helm, access_curiosity_maint, access_mining_station,
		access_expedition_shuttle, access_expedition_shuttle_helm, access_opportunity, access_hangar, access_opportunity_helm,
		access_mining, access_pilot, access_solgov_crew, access_eva, access_explorer, access_research,
		access_radio_exp, access_radio_sci, access_radio_sup
	)
	min_skill = list(	SKILL_EVA   = SKILL_BASIC,
						SKILL_PILOT = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

/datum/job/explorer
	title = "Explorer"
	department_types = list(/decl/department/exploration)
	total_positions = 5
	spawn_positions = 5
	supervisors = "the Commanding Officer, Executive Officer, and Pathfinder"
	selection_color = "#68099e"
	minimum_character_age = list(SPECIES_HUMAN = 18)
	ideal_character_age = 20
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/exploration/explorer
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/exploration/explorer/espatier
	)

	allowed_ranks = list(
		/datum/mil_rank/sc/t1,
		/datum/mil_rank/sc/t2,
		/datum/mil_rank/espatier/e1,
		/datum/mil_rank/espatier/e2,
		/datum/mil_rank/espatier/e3
	)
	min_skill = list(   SKILL_EVA = SKILL_BASIC,SKILL_LITERACY = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX,
	                    SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT)

	required_role = list("Pathfinder", "Shuttle Pilot")

	access = list(
		access_explorer, access_maint_tunnels, access_eva, access_emergency_storage,
		access_opportunity_helm, access_solgov_crew, access_expedition_shuttle, access_opportunity, access_hangar,
		access_curiosity, access_curiosity_maint, access_research, access_radio_exp
	)

	software_on_spawn = list(/datum/computer_file/program/deck_management)

/datum/job/explorer/get_description_blurb()
	return "You are an Explorer. Your duty is to go on expeditions to away sites. The Pathfinder is your team leader. You are to look for anything of economic or scientific interest to the SCG - mineral deposits, alien flora/fauna, artifacts. You will also likely encounter hazardous environments, aggressive wildlife or malfunctioning defense systems, so tread carefully."
