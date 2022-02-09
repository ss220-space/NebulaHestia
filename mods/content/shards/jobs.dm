/datum/job/ai
	hud_icon = "hudblank"
	create_record = FALSE
	account_allowed = FALSE

/datum/job/ai/shard // DO NOT USE THIS DIRECTLY
	title = "Shard AI"
	department_types = list()
	var/shard_type //decl type

/datum/job/ai/shard/is_position_available()
	var/decl/ai_type/shard_decl = GET_DECL(shard_type)
	for(var/obj/structure/aicore/deactivated/C in empty_playable_ai_cores)
		if(C.core_type == shard_decl.department)
			return TRUE
	return FALSE

/datum/job/ai/shard/do_spawn_special(var/mob/living/character, var/mob/new_player/new_player_mob)
	var/decl/ai_type/shard_decl = GET_DECL(shard_type)
	var/obj/structure/aicore/deactivated/core
	var/area/old_area
	var/turf/T
	character = character.AIize(move=0) // AIize the character, but don't move them yet
	T = get_turf(character)
	old_area = T.loc

	// is_available for AI checks that there is an empty core available in this list
	for(var/obj/structure/aicore/deactivated/C in empty_playable_ai_cores)
		if(C.core_type == shard_decl.department)
			core = C

	character.forceMove(core.loc)
	old_area.retally_power()
	var/mob/living/silicon/ai/A = character
	shard_decl.configure_ai(A)
	A.on_mob_init()

	new_player_mob.AnnounceCyborg(character, title, "has been downloaded to the empty core in \the [character.loc.loc]")
	SSticker.mode.handle_latejoin(character)

	qdel(core)
	return TRUE
