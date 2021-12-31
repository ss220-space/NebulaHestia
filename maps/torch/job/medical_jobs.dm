/datum/job/senior_doctor
	title = "Physician"
	department_types = list(/decl/department/medical)
	minimal_player_age = 2
	minimum_character_age = list(SPECIES_HUMAN = 29)
	ideal_character_age = 45
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Chief Medical Officer"
	selection_color = COMMS_COLOR_MEDICAL
	economic_power = 10
	alt_titles = list(
		"Surgeon")
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/medical/senior
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/medical/senior/fleet
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s2,
		/datum/mil_rank/sc/s3,
		/datum/mil_rank/espatier/o2,
		/datum/mil_rank/espatier/o3,
	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_EXPERT,
	                    SKILL_ANATOMY     = SKILL_EXPERT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 20

	access = list(
		access_medical, access_morgue, access_virology, access_maint_tunnels, access_emergency_storage,
		access_crematorium, access_chemistry, access_surgery,
		access_medical_equip, access_medical_doctor, access_solgov_crew, access_senmed, access_radio_med
	)

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor)

/datum/job/junior_doctor
	title = "Medical Resident"
	department_types = list(/decl/department/medical)
	minimal_player_age = 2
	minimum_character_age = list(SPECIES_HUMAN = 24)
	ideal_character_age = 45
	total_positions = 1
	spawn_positions = 1
	supervisors = "Physicians and the Chief Medical Officer"
	selection_color = "#013d3b"
	economic_power = 6
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/medical/senior
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/medical/junior/fleet
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s1,
		/datum/mil_rank/espatier/o1,
	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_EXPERT,
	                    SKILL_ANATOMY     = SKILL_EXPERT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 16

	access = list(
		access_medical, access_morgue, access_virology, access_maint_tunnels, access_emergency_storage,
		access_crematorium, access_chemistry, access_surgery,
		access_medical_equip, access_medical_doctor, access_solgov_crew, access_senmed, access_radio_med
	)

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor)
	selection_color = COMMS_COLOR_MEDICAL

/datum/job/doctor
	title = "Medical Technician"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Physicians and the Chief Medical Officer"
	economic_power = 7
	minimum_character_age = list(SPECIES_HUMAN = 19)
	department_types = list(/decl/department/medical)
	ideal_character_age = 40
	minimal_player_age = 0
	alt_titles = list(
		"Paramedic",
		"Corpsman")
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/medical/doctor
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/medical/doctor/fleet
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/t2,
		/datum/mil_rank/sc/t3,
		/datum/mil_rank/espatier/e3,
		/datum/mil_rank/espatier/e4
	)
	min_skill = list(   SKILL_EVA     = SKILL_BASIC,
	                    SKILL_MEDICAL = SKILL_BASIC,
	                    SKILL_ANATOMY = SKILL_BASIC,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)

	access = list(
		access_medical, access_morgue, access_maint_tunnels,
		access_external_airlocks, access_emergency_storage,
		access_eva, access_surgery, access_medical_equip, access_medical_doctor,
		access_solgov_crew, access_hangar, access_radio_med
	)

	minimal_access = list()

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor)
	skill_points = 22
	selection_color = COMMS_COLOR_MEDICAL

/datum/job/medical_trainee
	title = "Trainee Medical Technician"
	department_types = list(/decl/department/medical)
	department_types = list(/decl/department/medical)
	total_positions = 1
	spawn_positions = 1
	supervisors = "Medical personnel, and the Chief Medical Officer"
	selection_color = COMMS_COLOR_MEDICAL
	minimum_character_age = list(SPECIES_HUMAN = 18)
	ideal_character_age = 20
	alt_titles = list(
		"Corpsman Trainee")

	outfit_type = /decl/hierarchy/outfit/job/torch/crew/medical/doctor
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/medical/doctor/fleet
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/t1,
		/datum/mil_rank/espatier/e3
	)

	skill_points = 4
	no_skill_buffs = TRUE

	min_skill = list(   SKILL_EVA     = SKILL_ADEPT,
	                    SKILL_HAULING = SKILL_ADEPT,
	                    SKILL_MEDICAL = SKILL_EXPERT,
	                    SKILL_ANATOMY = SKILL_BASIC,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)

	access = list(
		access_medical, access_morgue, access_maint_tunnels,
		access_external_airlocks, access_emergency_storage,
		access_surgery, access_medical_equip, access_solgov_crew,
		access_radio_med
	)

	software_on_spawn = list(/datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor)

/datum/job/medical_trainee/get_description_blurb()
	return "You are a Trainee Medical Technician. You are learning how to treat and recover wounded crew from the more experienced medical personnel aboard. You are subordinate to the rest of the medical team."

/datum/job/chemist
	title = "Laboratory Technician"
	department_types = list(/decl/department/medical)
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Chief Medical Officer, the Corporate Liaison and Medical Personnel"
	selection_color = COMMS_COLOR_MEDICAL
	economic_power = 4
	minimum_character_age = list(SPECIES_HUMAN = 25)
	ideal_character_age = 30
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/medical/chemist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/contractor)
	min_skill = list(   SKILL_MEDICAL   = SKILL_BASIC,
	                    SKILL_CHEMISTRY = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_BASIC,
						SKILL_ANATOMY	  = SKILL_BASIC,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 16

	access = list(
		access_medical, access_maint_tunnels, access_emergency_storage,
		access_medical_equip, access_solgov_crew, access_chemistry,
	 	access_virology, access_morgue, access_crematorium, access_radio_med
	)

	minimal_access = list()

/datum/job/chemist/get_description_blurb()
	return "You are a Laboratory Technician. You make medicine. You are not a doctor or medic, but have surface level knowledge in those fields. You should not be treating patients, but rather providing the the medicine to do so. You are subordinate to Physicians and Medical Techncians."

/datum/job/psychiatrist
	title = "Counselor"
	total_positions = 1
	spawn_positions = 1
	ideal_character_age = 40
	economic_power = 5
	minimum_character_age = list(SPECIES_HUMAN = 24)
	department_types = list(/decl/department/medical)
	minimal_player_age = 0
	supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/medical/counselor
	alt_titles = list(
		"Psychiatrist",
		"Psionic Counselor" = /decl/hierarchy/outfit/job/torch/crew/medical/counselor/mentalist,
		"Mentalist" = /decl/hierarchy/outfit/job/torch/crew/medical/counselor/mentalist

	)

	allowed_branches = list(
		/datum/mil_branch/iseo_issc = /decl/hierarchy/outfit/job/torch/crew/medical/counselor/fleet,
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ,
		/datum/mil_rank/sc/s1
	)
	min_skill = list(
		SKILL_BUREAUCRACY = SKILL_BASIC,
		SKILL_MEDICAL     = SKILL_BASIC,
		SKILL_LITERACY    = SKILL_ADEPT
	)
	max_skill = list(
		SKILL_MEDICAL     = SKILL_MAX
	)
	access = list(
		access_medical, access_psychiatrist,
		access_solgov_crew, access_medical_equip, access_radio_med
	)

	minimal_access = list()

	software_on_spawn = list(
		/datum/computer_file/program/suit_sensors,
		/datum/computer_file/program/camera_monitor
	)
	give_psionic_implant_on_join = FALSE
	selection_color = COMMS_COLOR_MEDICAL

/datum/job/psychiatrist/equip(var/mob/living/carbon/human/H)
	if(H.mind.role_alt_title == "Psionic Counselor")
		psi_faculties = list("[PSI_REDACTION]" = PSI_RANK_OPERANT)
	if(H.mind.role_alt_title == "Mentalist")
		psi_faculties = list("[PSI_COERCION]" = PSI_RANK_OPERANT)
	return ..()


/datum/job/psychiatrist/get_description_blurb()
		return "You are the Counselor. Your main responsibility is the mental health and wellbeing of the crew. You are subordinate to the Chief Medical Officer."
