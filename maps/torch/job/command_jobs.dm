/datum/job/captain
	title = "Commanding Officer"
	supervisors = "the International Stellar Exploration Organization and the National Council"
	minimal_player_age = 14
	economic_power = 16
	minimum_character_age = list(SPECIES_HUMAN = 40)
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/command/CO
	primary_department = /decl/department/command
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
	)
	department_types = list(/decl/department/command)
	allowed_ranks = list(
		/datum/mil_rank/sc/s6,
	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT,
	                    SKILL_PILOT       = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)
	skill_points = 30

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/card_mod,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)
	total_positions = 1
	spawn_positions = 1

	access = list(
		access_captain, access_security, access_brig, access_armory, access_forensics_lockers, access_heads, access_medical, access_morgue, access_tox, access_tox_storage,
		access_engine, access_engine_equip, access_engine_normal_equip, access_engine_trainee_equip, access_maint_tunnels, access_external_airlocks, access_emergency_storage, access_change_ids,
		access_ai_upload, access_teleporter, access_eva, access_bridge, access_all_personal_lockers, access_chapel_office, access_tech_storage,
		access_atmospherics, access_bar, access_janitor, access_crematorium, access_kitchen, access_robotics, access_cargo, access_construction,
		access_chemistry, access_cargo_bot, access_hydroponics, access_manufacturing, access_library, access_lawyer, access_virology, access_cmo,
		access_qm, access_network, access_surgery, access_research, access_mining, access_mining_office, access_mailsorting, access_heads_vault,
		access_mining_station, access_xenobiology, access_ce, access_hop, access_hos, access_RC_announce, access_keycard_auth, access_tcomsat,
		access_gateway, access_sec_doors, access_psychiatrist, access_xenoarch, access_medical_equip, access_heads, access_hangar, access_opportunity_helm,
		access_expedition_shuttle_helm, access_perseverance, access_perseverance_helm, access_solgov_crew, access_nanotrasen,
		access_emergency_armory, access_sec_guard, access_gun, access_expedition_shuttle, access_opportunity, access_seneng, access_senmed, access_senadv,
		access_explorer, access_pathfinder, access_pilot, access_commissary, access_curiosity, access_curiosity_helm, access_curiosity_analysis, access_curiosity_phoron,
		access_curiosity_toxins, access_curiosity_chemistry, access_curiosity_security, access_curiosity_maint, access_rd, access_curiosity_rd, access_torch_fax, access_torch_helm,
		access_radio_comm, access_radio_eng, access_radio_med, access_radio_sec, access_radio_sup, access_radio_serv, access_radio_exp, access_radio_sci, access_captain
	)

	minimal_access = list(
		access_captain, access_security, access_brig, access_armory, access_forensics_lockers, access_heads, access_medical, access_morgue, access_tox, access_tox_storage,
		access_engine, access_engine_equip, access_engine_normal_equip, access_engine_trainee_equip, access_maint_tunnels, access_external_airlocks, access_emergency_storage, access_change_ids,
		access_ai_upload, access_teleporter, access_eva, access_bridge, access_all_personal_lockers, access_chapel_office, access_tech_storage,
		access_atmospherics, access_bar, access_janitor, access_crematorium, access_kitchen, access_robotics, access_cargo, access_construction,
		access_chemistry, access_cargo_bot, access_hydroponics, access_manufacturing, access_library, access_lawyer, access_virology, access_cmo,
		access_qm, access_network, access_surgery, access_research, access_mining, access_mining_office, access_mailsorting, access_heads_vault,
		access_mining_station, access_xenobiology, access_ce, access_hop, access_hos, access_RC_announce, access_keycard_auth, access_tcomsat,
		access_gateway, access_sec_doors, access_psychiatrist, access_xenoarch, access_medical_equip, access_heads, access_hangar, access_opportunity_helm,
		access_expedition_shuttle_helm, access_perseverance, access_perseverance_helm, access_solgov_crew, access_nanotrasen,
		access_emergency_armory, access_sec_guard, access_gun, access_expedition_shuttle, access_opportunity, access_seneng, access_senmed, access_senadv,
		access_explorer, access_pathfinder, access_pilot, access_commissary, access_curiosity, access_curiosity_helm, access_curiosity_analysis, access_curiosity_phoron,
		access_curiosity_toxins, access_curiosity_chemistry, access_curiosity_security, access_curiosity_maint, access_rd, access_curiosity_rd, access_torch_fax, access_torch_helm,
		access_radio_comm, access_radio_eng, access_radio_med, access_radio_sec, access_radio_sup, access_radio_serv, access_radio_exp, access_radio_sci
	)

	selection_color = "#1c4abd"
	head_position = TRUE

/datum/job/captain/get_description_blurb()
	return "You are the Commanding Officer. You are the top dog. You are an experienced professional officer in control of an entire ship, and ultimately responsible for all that happens onboard. Your job is to make sure [global.using_map.full_name] fulfils its space exploration mission. Delegate to your Executive Officer, your department heads, and your Senior Enlisted Advisor to effectively manage the ship, and listen to and trust their expertise."

/datum/job/captain/post_equip_rank(var/mob/person, var/alt_title)
	/*
	var/sound/announce_sound = (GAME_STATE <= RUNLEVEL_SETUP)? null : sound('sound/misc/boatswain.ogg', volume=20)
	captain_announcement.Announce("All hands, [alt_title || title] [person.real_name] on deck!", new_sound = announce_sound)
	..()
	*/

/datum/job/hop
	title = "Executive Officer"
	supervisors = "the Commanding Officer"
	department_types = list(/decl/department/command)
	minimal_player_age = 14
	economic_power = 14
	minimum_character_age = list(SPECIES_HUMAN = 35)
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/command/XO
	primary_department = /decl/department/command
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/command/XO/espatier
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s4,
		/datum/mil_rank/espatier/o5
	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_BASIC,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)
	skill_points = 30

	access = list(
		access_security, access_brig, access_armory, access_forensics_lockers, access_heads, access_medical, access_morgue, access_tox, access_tox_storage,
		access_engine, access_engine_equip, access_engine_normal_equip, access_engine_trainee_equip, access_maint_tunnels, access_external_airlocks, access_emergency_storage, access_change_ids,
		access_ai_upload, access_teleporter, access_eva, access_bridge, access_all_personal_lockers, access_chapel_office, access_tech_storage,
		access_atmospherics, access_bar, access_janitor, access_crematorium, access_kitchen, access_robotics, access_cargo, access_construction,
		access_chemistry, access_cargo_bot, access_hydroponics, access_manufacturing, access_library, access_lawyer, access_virology, access_cmo,
		access_qm, access_network, access_surgery, access_research, access_mining, access_mining_office, access_mailsorting, access_heads_vault,
		access_mining_station, access_xenobiology, access_ce, access_hop, access_hos, access_RC_announce, access_keycard_auth, access_tcomsat,
		access_gateway, access_sec_doors, access_psychiatrist, access_xenoarch, access_medical_equip, access_heads, access_hangar, access_opportunity_helm,
		access_expedition_shuttle_helm, access_perseverance, access_perseverance_helm, access_solgov_crew, access_nanotrasen,
		access_emergency_armory, access_sec_guard, access_gun, access_expedition_shuttle, access_opportunity, access_seneng, access_senmed, access_senadv,
		access_explorer, access_pathfinder, access_pilot, access_commissary, access_curiosity, access_curiosity_helm, access_curiosity_analysis, access_curiosity_phoron,
		access_curiosity_toxins, access_curiosity_chemistry, access_curiosity_security, access_curiosity_maint, access_rd, access_curiosity_rd, access_torch_fax, access_torch_helm,
		access_radio_comm, access_radio_eng, access_radio_med, access_radio_sec, access_radio_sup, access_radio_serv, access_radio_exp, access_radio_sci
	)

	minimal_access = list(
		access_security, access_brig, access_armory, access_forensics_lockers, access_heads, access_medical, access_morgue, access_tox, access_tox_storage,
		access_engine, access_engine_equip, access_engine_normal_equip, access_engine_trainee_equip, access_maint_tunnels, access_external_airlocks, access_emergency_storage, access_change_ids,
		access_ai_upload, access_teleporter, access_eva, access_bridge, access_all_personal_lockers, access_chapel_office, access_tech_storage,
		access_atmospherics, access_bar, access_janitor, access_crematorium, access_kitchen, access_robotics, access_cargo, access_construction,
		access_chemistry, access_cargo_bot, access_hydroponics, access_manufacturing, access_library, access_lawyer, access_virology, access_cmo,
		access_qm, access_network, access_surgery, access_research, access_mining, access_mining_office, access_mailsorting, access_heads_vault,
		access_mining_station, access_xenobiology, access_ce, access_hop, access_hos, access_RC_announce, access_keycard_auth, access_tcomsat,
		access_gateway, access_sec_doors, access_psychiatrist, access_xenoarch, access_medical_equip, access_heads, access_hangar, access_opportunity_helm,
		access_expedition_shuttle_helm, access_perseverance, access_perseverance_helm, access_solgov_crew, access_nanotrasen,
		access_emergency_armory, access_sec_guard, access_gun, access_expedition_shuttle, access_opportunity, access_seneng, access_senmed, access_senadv,
		access_explorer, access_pathfinder, access_pilot, access_commissary, access_curiosity, access_curiosity_helm, access_curiosity_analysis, access_curiosity_phoron,
		access_curiosity_toxins, access_curiosity_chemistry, access_curiosity_security, access_curiosity_maint, access_rd, access_curiosity_rd, access_torch_fax, access_torch_helm,
		access_radio_comm, access_radio_eng, access_radio_med, access_radio_sec, access_radio_sup, access_radio_serv, access_radio_exp, access_radio_sci
	)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/card_mod,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)
	total_positions = 1
	spawn_positions = 1

	selection_color = "#1c4abd"

/datum/job/hop/get_description_blurb()
	return "You are the Executive Officer. You are an experienced senior officer, second in command of the ship, and are responsible for the smooth operation of the ship under your Commanding Officer. In their absence, you are expected to take their place. Your primary duty is directly managing department heads and all those outside a department heading. You are also responsible for the contractors and passengers aboard the ship. Consider the Senior Enlisted Advisor and Bridge Officers tools at your disposal."

/datum/job/rd
	title = "Chief Science Officer"
	supervisors = "the Commanding Officer"
	economic_power = 12
	minimal_player_age = 14
	minimum_character_age = list(SPECIES_HUMAN = 35)
	ideal_character_age = 60
	department_types = list(/decl/department/science, /decl/department/command)
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/research/cso
	primary_department = /decl/department/science
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s4,
		/datum/mil_rank/espatier/o4
	)

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_FINANCE     = SKILL_ADEPT,
	                    SKILL_BOTANY      = SKILL_BASIC,
	                    SKILL_ANATOMY     = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)
	skill_points = 30

	access = list(
		access_tox, access_tox_storage, access_emergency_storage, access_teleporter, access_bridge, access_rd,
		access_research, access_mining, access_mining_office, access_mining_station, access_xenobiology, access_perseverance,
		access_RC_announce, access_keycard_auth, access_xenoarch, access_nanotrasen, access_sec_guard, access_heads,
		access_expedition_shuttle, access_opportunity, access_hangar, access_curiosity, access_curiosity_helm, access_opportunity_helm,
		access_curiosity_analysis, access_curiosity_phoron, access_curiosity_toxins, access_curiosity_chemistry, access_curiosity_rd,
		access_curiosity_security, access_curiosity_maint, access_pathfinder, access_explorer, access_eva, access_solgov_crew,
		access_expedition_shuttle, access_expedition_shuttle_helm, access_maint_tunnels, access_torch_fax, access_radio_comm,
		access_radio_sci, access_radio_exp
	)

	minimal_access = list()

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/aidiag,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

	total_positions = 1
	spawn_positions = 1
	selection_color = "#7a3f7a"
	head_position = TRUE

/datum/job/rd/get_description_blurb()
	return "You are the Chief Science Officer. You are responsible for the research department. You handle the science aspects of the project and liase with the corporate interests of the Expeditionary Corps Organisation. Make sure science gets done, do some yourself, and get your scientists on away missions to find things to benefit the project. Advise the CO on science matters."

/datum/job/cmo
	title = "Chief Medical Officer"
	supervisors = "the Commanding Officer and the Executive Officer"
	economic_power = 14
	minimal_player_age = 14
	minimum_character_age = list(SPECIES_HUMAN = 35)
	ideal_character_age = 48
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/command/cmo
	department_types = list(/decl/department/medical, /decl/department/command)
	primary_department = /decl/department/medical
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/command/cmo/espatier
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s4,
		/datum/mil_rank/espatier/o4
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
	skill_points = 26

	access = list(
		access_medical, access_morgue, access_maint_tunnels, access_external_airlocks, access_emergency_storage,
		access_teleporter, access_eva, access_bridge, access_heads,
		access_chapel_office, access_crematorium, access_chemistry, access_virology, access_perseverance,
		access_cmo, access_surgery, access_RC_announce, access_keycard_auth, access_psychiatrist,
		access_medical_equip, access_solgov_crew, access_senmed, access_hangar, access_torch_fax, access_radio_comm,
		access_radio_med
	)

	minimal_access = list()

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

	total_positions = 1
	spawn_positions = 1
	selection_color = "#03b4b4"
	head_position = TRUE

/datum/job/cmo/get_description_blurb()
	return "You are the Chief Medical Officer. You manage the medical department. You ensure all members of medical are skilled, tasked and handling their duties. Ensure your doctors are staffing your infirmary and your corpsman/paramedics are ready for response. Act as a second surgeon or backup pharmacist in the absence of either. You are expected to know medical very well, along with general regulations."

/datum/job/chief_engineer
	title = "Chief Engineer"
	supervisors = "the Commanding Officer and the Executive Officer"
	economic_power = 12
	minimum_character_age = list(SPECIES_HUMAN = 27)
	ideal_character_age = 40
	minimal_player_age = 14
	department_types = list(/decl/department/engineering, /decl/department/command/)
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/command/chief_engineer
	primary_department = /decl/department/engineering
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/command/chief_engineer/espatier
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s4,
		/datum/mil_rank/espatier/o4
	)
	min_skill = list(   SKILL_BUREAUCRACY  = SKILL_BASIC,
	                    SKILL_COMPUTER     = SKILL_ADEPT,
	                    SKILL_EVA          = SKILL_ADEPT,
	                    SKILL_CONSTRUCTION = SKILL_ADEPT,
	                    SKILL_ELECTRICAL   = SKILL_ADEPT,
	                    SKILL_ATMOS        = SKILL_ADEPT,
	                    SKILL_ENGINES      = SKILL_EXPERT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)
	skill_points = 30

	access = list(
		access_engine, access_engine_equip, access_engine_normal_equip, access_engine_trainee_equip, access_maint_tunnels, access_external_airlocks, access_emergency_storage,
		access_ai_upload, access_teleporter, access_eva, access_bridge, access_heads,
		access_tech_storage, access_robotics, access_atmospherics, access_janitor, access_construction,
		access_network, access_ce, access_RC_announce, access_keycard_auth, access_tcomsat,
		access_solgov_crew, access_perseverance, access_seneng, access_hangar, access_torch_fax, access_torch_helm, access_radio_comm,
		access_radio_eng
		)


	minimal_access = list(
		access_engine, access_engine_equip, access_engine_normal_equip, access_engine_trainee_equip, access_maint_tunnels, access_external_airlocks, access_emergency_storage,
		access_ai_upload, access_teleporter, access_eva, access_bridge, access_heads,
		access_tech_storage, access_atmospherics, access_janitor, access_construction,
		access_network, access_ce, access_RC_announce, access_keycard_auth, access_tcomsat,
		access_solgov_crew, access_seneng, access_hangar, access_robotics, access_torch_fax, access_torch_helm, access_radio_comm,
		access_radio_eng
	)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/network_monitor,
							 /datum/computer_file/program/power_monitor,
							 /datum/computer_file/program/supermatter_monitor,
							 /datum/computer_file/program/alarm_monitor,
							 /datum/computer_file/program/atmos_control,
							 /datum/computer_file/program/rcon_console,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/shields_monitor,
							 /datum/computer_file/program/reports)

	total_positions = 1
	spawn_positions = 1
	selection_color = "#cc7c05"
	head_position = TRUE

/datum/job/chief_engineer/get_description_blurb()
	return "You are the Chief Engineer. You manage the Engineering Department. You are responsible for the Senior engineer, who is your right hand and (should be) an experienced, skilled engineer. Delegate to and listen to them. Manage your engineers, ensure vessel power stays on, breaches are patched and problems are fixed. Advise the CO on engineering matters. You are also responsible for the maintenance and control of any vessel synthetics. You are an experienced engineer with a wealth of theoretical knowledge. You should also know vessel regulations to a reasonable degree."

/datum/job/hos
	title = "Chief of Security"
	supervisors = "the Commanding Officer and the Executive Officer"
	economic_power = 10
	minimal_player_age = 14
	minimum_character_age = list(SPECIES_HUMAN = 25)
	ideal_character_age = 35
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/command/cos
	department_types = list(/decl/department/security, /decl/department/command)
	primary_department = /decl/department/security
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/command/cos/espatier
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s4,
		/datum/mil_rank/espatier/o4
	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_ADEPT,
	                    SKILL_FORENSICS   = SKILL_BASIC,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_MAX,
	                    SKILL_WEAPONS     = SKILL_MAX,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 28

	access = list(
		access_security, access_brig, access_armory, access_forensics_lockers,
		access_maint_tunnels, access_external_airlocks, access_emergency_storage,
		access_teleporter, access_eva, access_bridge, access_heads, access_perseverance,
		access_hos, access_RC_announce, access_keycard_auth, access_sec_doors,
		access_solgov_crew, access_gun, access_emergency_armory, access_hangar, access_torch_fax,
		access_radio_comm, access_radio_sec
	)

	minimal_access = list()

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)

	total_positions = 1
	spawn_positions = 1
	selection_color = "#bb0606"
	head_position = TRUE

/datum/job/hos/get_description_blurb()
	return "You are the Chief of Security. You manage ship security. The Masters at Arms and the Military Police, as well as the Brig Chief and the Forensic Technician. You keep the vessel safe. You handle both internal and external security matters. You are the law. You are subordinate to the CO and the XO. You are expected to know the SCMJ and Sol law and Alert Procedure to a very high degree along with general regulations."

/datum/job/representative
	title = "National Council Representative"
	department_types = list(/decl/department/support)
	total_positions = 1
	spawn_positions = 1
	supervisors = "the National Council and the ISEO Charter"
	selection_color = "#2f2f7f"
	economic_power = 16
	minimal_player_age = 0
	department_types = list(/decl/department/command)
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/representative
	allowed_branches = list(/datum/mil_branch/government)
	allowed_ranks = list(/datum/mil_rank/government/gov)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_EXPERT,
	                    SKILL_FINANCE     = SKILL_BASIC,
						SKILL_LITERACY    = SKILL_ADEPT)
	skill_points = 20
	minimum_character_age = list(SPECIES_HUMAN = 27)

	access = list(
		access_representative, access_security, access_medical,
		access_bridge, access_cargo, access_solgov_crew,
		access_hangar, access_torch_fax, access_radio_comm
	)

	software_on_spawn = list(/datum/computer_file/program/reports)
	selection_color = COMMS_COLOR_COMMAND

/datum/job/representative/get_description_blurb()
	return "You are the National Council Representative. You are a civilian assigned as both a diplomatic liaison for first contact and foreign affair situations on board. You are also responsible for monitoring for any serious missteps of justice or other ethical or legal issues aboard and informing and advising the Commanding Officer of them. You are a mid-level bureaucrat. You liaise between the crew and corporate interests on board. Send faxes back to Sol on mission progress and important events."

/datum/job/sea
	title = "Senior Enlisted Advisor"
	department_types = list(/decl/department/support)
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Commanding Officer and the Executive Officer"
	selection_color = "#2f2f7f"
	minimal_player_age = 14
	economic_power = 11
	minimum_character_age = list(SPECIES_HUMAN = 35)
	department_types = list(/decl/department/command)
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/command/sea/espatier
	allowed_branches = list(
		/datum/mil_branch/espatier_corps
	)
	allowed_ranks = list(
		/datum/mil_rank/espatier/e8,
		/datum/mil_rank/espatier/e9_alt1,
		/datum/mil_rank/espatier/e9
	)
	min_skill = list(   SKILL_EVA        = SKILL_BASIC,
	                    SKILL_COMBAT     = SKILL_BASIC,
	                    SKILL_WEAPONS    = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(	SKILL_PILOT        = SKILL_ADEPT,
	                    SKILL_COMBAT       = SKILL_EXPERT,
	                    SKILL_WEAPONS      = SKILL_EXPERT,
	                    SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX)
	skill_points = 24


	access = list(
		access_security, access_medical, access_engine, access_maint_tunnels, access_external_airlocks, access_emergency_storage,
		access_teleporter, access_eva, access_bridge, access_all_personal_lockers, access_janitor,
		access_kitchen, access_cargo, access_RC_announce, access_keycard_auth, access_perseverance, access_opportunity_helm,
		access_solgov_crew, access_gun, access_expedition_shuttle, access_opportunity, access_senadv, access_hangar, access_torch_fax,
		access_radio_comm, access_radio_eng, access_radio_med, access_radio_sec, access_radio_serv, access_radio_sup, access_radio_exp
		)

	software_on_spawn = list(/datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/reports)
	selection_color = COMMS_COLOR_COMMAND

/datum/job/sea/get_description_blurb()
	return "You are the Senior Enlisted Advisor. You are the highest enlisted person on the ship. You are directly subordinate to the CO. You advise them on enlisted concerns and provide expertise and advice to officers. You are responsible for ensuring discipline and good conduct among enlisted, as well as notifying officers of any issues and \"advising\" them on mistakes they make. You also handle various duties on behalf of the CO and XO. You are an experienced enlisted person, very likely equal only in experience to the CO and XO. You know the regulations better than anyone."

/datum/job/bridgeofficer
	title = "Bridge Officer"
	department_types = list(/decl/department/support)
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Commanding Officer and heads of staff"
	selection_color = "#2f2f7f"
	minimal_player_age = 0
	economic_power = 8
	minimum_character_age = list(SPECIES_HUMAN = 22)
	department_types = list(/decl/department/command)
	ideal_character_age = 24
	outfit_type = /decl/hierarchy/outfit/job/torch/crew/command/bridgeofficer
	allowed_branches = list(
		/datum/mil_branch/iseo_issc,
		/datum/mil_branch/espatier_corps = /decl/hierarchy/outfit/job/torch/crew/command/bridgeofficer/espatier
	)
	allowed_ranks = list(
		/datum/mil_rank/sc/s1,
		/datum/mil_rank/sc/s2,
		/datum/mil_rank/espatier/o1,
		/datum/mil_rank/espatier/o2
	)
	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_ADEPT,
						SKILL_LITERACY    = SKILL_ADEPT)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX)
	skill_points = 20


	access = list(
		access_security, access_medical, access_engine, access_maint_tunnels, access_emergency_storage,
		access_bridge, access_janitor, access_kitchen, access_cargo, access_mailsorting, access_RC_announce, access_keycard_auth,
		access_solgov_crew, access_perseverance, access_perseverance_helm, access_opportunity, access_opportunity_helm, access_external_airlocks,
		access_eva, access_hangar, access_cent_creed, access_explorer, access_expedition_shuttle, access_expedition_shuttle_helm, access_teleporter,
		access_torch_fax, access_torch_helm, access_radio_comm, access_radio_eng, access_radio_exp, access_radio_serv, access_radio_sci, access_radio_sup
	)

	software_on_spawn = list(/datum/computer_file/program/comm,
							 /datum/computer_file/program/suit_sensors,
							 /datum/computer_file/program/power_monitor,
							 /datum/computer_file/program/supermatter_monitor,
							 /datum/computer_file/program/alarm_monitor,
							 /datum/computer_file/program/camera_monitor,
							 /datum/computer_file/program/shields_monitor,
							 /datum/computer_file/program/reports,
							 /datum/computer_file/program/deck_management)
	selection_color = COMMS_COLOR_COMMAND

/datum/job/bridgeofficer/get_description_blurb()
	return "You are a Bridge Officer. You are a very junior officer. You do not give orders of your own. You are subordinate to all of command. You handle matters on the bridge and report directly to the CO and XO. You take the Torch's helm and pilot the Perseverance if needed. You monitor bridge computer programs and communications and report relevant information to command."
