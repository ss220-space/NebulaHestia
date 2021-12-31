/datum/job/senior_scientist
	title = "Senior Researcher"
	department_types = list(/decl/department/science)

	total_positions = 1
	spawn_positions = 1
	supervisors = "the Chief Science Officer"
	selection_color = "#633d63"
	economic_power = 12
	minimal_player_age = 3
	minimum_character_age = list(SPECIES_HUMAN = 30)
	ideal_character_age = 50
	alt_titles = list(
		"Research Supervisor")
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/research/senior_scientist
	allowed_branches = list(
		/datum/mil_branch/iseo_issc
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s2
	)

	access = list(
		access_tox, access_tox_storage, access_maint_tunnels, access_research, access_mining_office,
		access_mining_station, access_xenobiology, access_xenoarch, access_nanotrasen, access_solgov_crew,
		access_expedition_shuttle, access_opportunity, access_hangar, access_curiosity, access_curiosity_helm, access_opportunity_helm,
		access_curiosity_analysis, access_curiosity_phoron, access_curiosity_toxins, access_curiosity_chemistry, access_curiosity_security,
		access_curiosity_maint, access_torch_fax, access_radio_sci, access_radio_exp
	)

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_FINANCE     = SKILL_BASIC,
	                    SKILL_BOTANY      = SKILL_BASIC,
	                    SKILL_ANATOMY     = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_ADEPT,
	                    SKILL_SCIENCE     = SKILL_ADEPT)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)
	skill_points = 20
	selection_color = "#633d63"

/datum/job/scientist
	title = "Scientist"
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Chief Science Officer"
	department_types = list(/decl/department/science)
	economic_power = 10
	minimum_character_age = list(SPECIES_HUMAN = 25)
	ideal_character_age = 45
	minimal_player_age = 0
	alt_titles = list(
		"Xenoarcheologist",
		"Anomalist",
		"Researcher",
		"Xenobiologist",
		"Xenobotanist"
	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	outfit_type = /decl/hierarchy/outfit/job/torch/crew/research/scientist
	allowed_branches = list(
		/datum/mil_branch/iseo_issc
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s1
	)

	access = list(
		access_tox, access_tox_storage, access_research, access_curiosity, access_curiosity_helm,
		access_mining_office, access_mining_station, access_xenobiology, access_opportunity_helm,
		access_xenoarch, access_nanotrasen, access_solgov_crew, access_expedition_shuttle, access_opportunity, access_hangar,
		access_curiosity_analysis, access_curiosity_phoron, access_curiosity_toxins, access_curiosity_chemistry, access_torch_fax,
		access_curiosity_maint, access_radio_sci, access_radio_exp
	)

	minimal_access = list()
	skill_points = 20
	selection_color = "#633d63"

/datum/job/scientist_assistant
	title = "Research Assistant"
	department_types = list(/decl/department/science)
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Chief Science Officer and science personnel"
	selection_color = "#633d63"
	economic_power = 3
	minimum_character_age = list(SPECIES_HUMAN = 18)
	ideal_character_age = 30
	alt_titles = list(
		"Custodian" = /decl/hierarchy/outfit/job/torch/passenger/research/assist/janitor,
		"Testing Assistant" = /decl/hierarchy/outfit/job/torch/passenger/research/assist/testsubject,
		"Intern",
		"Clerk",
		"Field Assistant")

	outfit_type = /decl/hierarchy/outfit/job/torch/crew/research
	allowed_branches = list(
		/datum/mil_branch/iseo_issc
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/t1,
		/datum/mil_rank/sc/t2,
		/datum/mil_rank/sc/t3
	)
	min_skill = list(SKILL_LITERACY    = SKILL_ADEPT)
	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	required_role = list("Chief Science Officer", "Senior Researcher")

	access = list(
		access_tox, access_tox_storage, access_research, access_curiosity,
		access_mining_office, access_mining_station, access_xenobiology, access_opportunity_helm,
		access_xenoarch, access_nanotrasen, access_solgov_crew, access_expedition_shuttle, access_opportunity, access_hangar,
		access_curiosity_analysis, access_curiosity_phoron, access_curiosity_toxins, access_curiosity_chemistry,
		access_radio_sci, access_radio_exp
	)
