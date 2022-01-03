/obj/machinery/ftl_shunt
	anchored = 1
	icon = 'icons/obj/shunt_drive.dmi'
	var/initial_id_tag = "ftl"

/obj/effect/shunt_dummy
	icon = 'icons/obj/ftl_drive_96x96.dmi'
	vis_flags = VIS_INHERIT_ID
	appearance_flags = KEEP_TOGETHER
	layer = EMISSIVE_LAYER
	plane = EMISSIVE_PLANE

/obj/machinery/ftl_shunt/core
	name = "superluminal shunt core"
	desc = "An immensely powerful transdimensional superluminal bridge initiator capable of forming a micro-wormhole and shunting an entire ship through it in a nanosecond."
	base_type = /obj/machinery/ftl_shunt/core
	uncreated_component_parts = list(/obj/item/stock_parts/ftl_core = 1)
	construct_state = /decl/machine_construction/default/no_deconstruct
	icon = 'icons/obj/ftl_drive_96x96.dmi'
	icon_state = "ftl_core"
	pixel_x = -32
	pixel_y = -32
	density = TRUE

	var/list/fuel_ports = list() //We mainly use fusion fuels.
	var/charge_time //Actually, we do use power now. This is here for the console.
	var/charging = FALSE
	var/jumping = FALSE
	var/shunt_x = 1
	var/shunt_y = 1
	var/chargepercent = 0
	var/last_percent_tick = 0
	var/obj/machinery/computer/ship/ftl/ftl_computer
	var/required_charge
	var/accumulated_charge
	var/max_charge = 2000000
	var/target_charge
	var/cooldown_delay = 5 MINUTES
	var/cooldown
	var/max_jump_distance = 14 //How many overmap tiles can this move the ship?
	var/moderate_jump_distance = 8
	var/safe_jump_distance = 4
	var/sabotaged
	var/sabotaged_amt = 0 //amount of crystals used to sabotage us.
	var/max_power_usage = 5 MEGAWATTS //how much power can we POSSIBLY consume.
	var/allowed_power_usage = 150 KILOWATTS
	var/last_power_drawn
	var/jump_delay = 2 MINUTES
	var/jump_timer //used to cancel the jump.
	var/required_jump_cores = 0
	//HEARTH EXCLUSIVE
	var/cached_security_level
	//HEARTH EXCLUSIVE END
	var/datum/event/ftl_event
	var/last_stress_sound

	var/power_on_animation_played = FALSE
	var/power_off_animation_played = FALSE

	var/width = 3
	var/height = 3

	var/static/datum/announcement/priority/ftl_announcement = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/misc/notice2.ogg'))

	var/static/shunt_start_text = "Attention! Superluminal shunt warm-up initiated! ETA to subsector jump: %%TIME%%"
	var/static/shunt_cancel_text = "Attention! Subsector superluminal transition cancelled."
	var/static/shunt_entered_text = "Attention! Vessel has completed superluminal translation; FTL exit in %%TIME%% seconds."
	var/static/shunt_complete_text = "Attention! Subsector superluminal transition completed."
	var/static/shunt_spooling_text = "Attention! Superluminal shunt warm-up complete, spooling up."

	var/static/shunt_sabotage_text_minor = "Warning! Electromagnetic flux beyond safety limits - aborting shunt!"
	var/static/shunt_sabotage_text_major = "Warning! Critical electromagnetic flux in accelerator core! Dumping core and aborting shunt!"
	var/static/shunt_sabotage_text_critical = "ALERT! Critical malfunction in microsingularity containment core! Safety systems offline!"

	var/obj/effect/shunt_dummy/breakers
	var/obj/effect/shunt_dummy/conduits
	var/obj/effect/shunt_dummy/portal
	var/obj/effect/shunt_dummy/charge_indicator
	var/obj/effect/shunt_dummy/pumps

	var/static/ftl_sounds = list(
		'sound/effects/thunder/thunder1.ogg',
		'sound/effects/thunder/thunder2.ogg',
		'sound/effects/thunder/thunder3.ogg',
		'sound/effects/thunder/thunder4.ogg',
		'sound/effects/thunder/thunder5.ogg',
		'sound/effects/thunder/thunder6.ogg',
		'sound/effects/thunder/thunder7.ogg',
		'sound/effects/thunder/thunder8.ogg',
		'sound/effects/thunder/thunder9.ogg',
		'sound/effects/thunder/thunder10.ogg'
		)

	use_power = POWER_USE_OFF
	power_channel = EQUIP
	idle_power_usage = 1600
	light_color = COLOR_BLUE
	stock_part_presets = list(/decl/stock_part_preset/terminal_setup)
//Base procs

/obj/machinery/ftl_shunt/core/Initialize(mapload, d, populate_parts)
	. = ..()
	set_extension(src, /datum/extension/local_network_member)
	if(initial_id_tag)
		var/datum/extension/local_network_member/local_network = get_extension(src, /datum/extension/local_network_member)
		local_network.set_tag(null, initial_id_tag)
	target_charge = max_charge * 0.25 //Target charge set to a quarter of our maximum charge, just for weirdness prevention
	breakers = new
	breakers.icon_state = "breakers_off"
	conduits = new
	conduits.icon_state = "conduits"
	portal = new
	portal.icon_state = "loop-base"
	charge_indicator = new
	charge_indicator.icon_state = null
	pumps = new
	pumps.icon_state = "coolant_pumps_composite_off"
	pumps.layer = STRUCTURE_LAYER
	pumps.plane = DEFAULT_PLANE
	portal.add_filter("glow",1,list(type = "drop_shadow", size = 2, x = 0, y = 0, offset = 2, color = COLOR_CYAN_BLUE))
	vis_contents += breakers
	vis_contents += conduits
	vis_contents += portal
	vis_contents += charge_indicator
	vis_contents += pumps

	return INITIALIZE_HINT_LATELOAD

/obj/machinery/ftl_shunt/core/proc/SetBounds()
	bound_width = width * world.icon_size
	bound_height = height * world.icon_size

/obj/machinery/ftl_shunt/core/LateInitialize()
	. = ..()
	find_ports()

/obj/machinery/ftl_shunt/core/modify_mapped_vars(map_hash)
	..()
	ADJUST_TAG_VAR(initial_id_tag, map_hash)

/obj/machinery/ftl_shunt/core/Destroy()
	. = ..()
	for(var/obj/machinery/ftl_shunt/fuel_port/FP in fuel_ports)
		FP.master = null
		fuel_ports -= FP
	if(ftl_computer)
		ftl_computer.linked_core = null
		ftl_computer = null

/obj/machinery/ftl_shunt/core/on_update_icon()
	cut_overlays()
	var/new_charge_color

	if(chargepercent == 0 || isnull(chargepercent))
		new_charge_color ="#fa0a0a"
	else
	#if DM_VERSION > 513
		new_charge_color = gradient("#fa0a0a", "#0de405", clamp(chargepercent/100, 0, 100))
	#endif
	#if DM_VERSION < 514
		new_charge_color = HSVtoRGB(RotateHue(hsv(0, 255, 255), 120 * (1 - chargepercent/100)))
	#endif
	animate(charge_indicator, color = new_charge_color, 1 SECOND)

	if(stat & BROKEN)
		add_overlay(image(icon, "right_breaker_malf"))
		add_overlay(image(icon, "left_breaker_malf"))
		return

	if((stat & NOPOWER) && !power_off_animation_played)
		flick("breakers_turn_off", breakers)
		breakers.icon_state = "breakers_off"
		flick("loop-turn-off", portal)
		portal.icon_state = null
		flick("charge_state_turn_off", charge_indicator)
		charge_indicator.icon_state = "null"
		if(charging)
			flick("coolant_pumps_composite_turn_off", pumps)
			pumps.icon_state = "coolant_pumps_composite_off"
		conduits.icon_state = null

		power_off_animation_played = TRUE
		power_on_animation_played = FALSE

	if(!(stat & NOPOWER) && !power_on_animation_played)
		flick("breakers_turn_on", breakers)
		breakers.icon_state = "breakers_on"
		flick("loop-turn-on", portal)
		portal.icon_state = "loop-idle-off"
		flick("charge_state_turn_on", charge_indicator)
		charge_indicator.icon_state = "charge_state"
		if(charging)
			flick("coolant_pumps_composite_turn_on", pumps)
			pumps.icon_state = "coolant_pumps_composite_on"

		power_off_animation_played = FALSE
		power_on_animation_played = TRUE

	if(charging && !(stat & NOPOWER))
		add_overlay(image(icon, "turbine_on"))
		if(!conduits.filter_data)
			conduits.add_filter("glow", 1, list(type="drop_shadow", x=0,y=0,size=2,color=COLOR_ORANGE))
		conduits.icon_state = "conduits_glow"
		pumps.icon_state = "coolant_pumps_composite_on"
		portal.icon_state = "loop-charging"

	if(!charging)
		conduits.icon_state = null

	if(jumping)
		add_overlay(image(icon, "loop-idle-on"))

	if(sabotaged)
		if(portal.filter_data)
			if(portal.filter_data["glow"]["color"] != COLOR_RED)
				portal.animate_filter("glow", list(color = COLOR_RED, time = 1))
				portal.update_filters()
			if(rand(15))
				portal.animate_filter("glow", list(size = sabotaged*3, time = 1 SECONDS, offset = sabotaged*rand(1,3)))
				addtimer(CALLBACK(src, /atom/movable/proc/animate_filter, "glow", list(size = 2, time = 1 SECONDS, offset = 2)), 2 SECONDS)

	if(!sabotaged)
		if(portal.filter_data)
			if(portal.filter_data["glow"]["color"] != COLOR_CYAN_BLUE)
				portal.animate_filter("glow", list(color = COLOR_CYAN_BLUE, time = 1))
				portal.update_filters()
			if(rand(15))
				portal.animate_filter("glow", list(size = rand(1,2)*2, time = 1 SECONDS, offset = 2*rand(1,3)))
				addtimer(CALLBACK(src, /atom/movable/proc/animate_filter, "glow", list(size = 2, time = 1 SECONDS, offset = 2)), 2 SECONDS)

/obj/machinery/ftl_shunt/core/examine(mob/user)
	. = ..()
	if(sabotaged)
		if(user.skill_check(SKILL_ENGINES, SKILL_ADEPT))
			switch(sabotaged)
				if(SHUNT_SABOTAGE_MINOR)
					to_chat(user, SPAN_WARNING("It looks like it's been tampered with in some way, and the accelerator vanes seem out of place."))
				if(SHUNT_SABOTAGE_MAJOR)
					to_chat(user, SPAN_WARNING("Light behaves oddly around the core of [src], and it looks to have been tampered with! The vanes are definitely out of place."))
				if(SHUNT_SABOTAGE_CRITICAL)
					to_chat(user, SPAN_DANGER("Light bends around the core of [src] in a manner that eerily reminds you of a singularity... the vanes look completely misaligned!"))
		else
			to_chat(user, SPAN_WARNING("It looks like it's been tampered with, but you're not sure to what extent."))

/obj/machinery/ftl_shunt/core/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/stack/telecrystal))
		var/obj/item/stack/telecrystal/TC = O

		if(TC.amount < 10)
			to_chat(user, SPAN_WARNING("You don't have enough telecrystals to sabotage [src]."))
			return FALSE

		var/tc_input = input(user, "How many telecrystals do you want to put in?", "TC Input", 0) as num|null


		if(QDELETED(user) || user.incapacitated() || !user.Adjacent(src) || !(TC in user.get_held_items()))
			return FALSE

		if(!tc_input)
			return FALSE

		if(TC.amount < tc_input)
			to_chat(user, SPAN_WARNING("You don't have enough telecrystals for that."))
			return FALSE

		to_chat(user, SPAN_DANGER("You begin to insert the crystals into [src]..."))

		if(!do_after(user, 6 SECONDS, src))
			return FALSE

		switch(tc_input)
			if(10 to 24)
				sabotaged = SHUNT_SABOTAGE_MINOR
			if(25 to 49)
				sabotaged = SHUNT_SABOTAGE_MAJOR
			if(50 to INFINITY)
				sabotaged = SHUNT_SABOTAGE_CRITICAL

		sabotaged_amt = tc_input
		TC.use(tc_input)
		to_chat(user, SPAN_DANGER("You successfully sabotage [src] by inserting the crystals!"))
		return TRUE
	. = ..()

/obj/machinery/ftl_shunt/core/physical_attack_hand(var/mob/user)
	if(sabotaged)
		var/mob/living/carbon/human/h_user = user
		if(!istype(h_user))
			return TRUE
		var/skill_delay = user.skill_delay_mult(SKILL_ENGINES, 0.3)
		if(!user.skill_check(SKILL_ENGINES, SKILL_BASIC))
			to_chat(user, SPAN_DANGER("You are nowhere near experienced enough to stick your hand into that thing."))
			return FALSE
		to_chat(user, SPAN_NOTICE("You reach your hand inside of [src] and slowly begin to re-align the accelerator vanes..."))
		if(!do_after(user, (4 SECOND * skill_delay), src))
			to_chat(user, SPAN_DANGER("You try to pull your hand away from the vanes, but you touch a conductor!"))
			h_user.electrocute_act(rand(150,250), src, def_zone = user.get_active_held_item_slot())
			return TRUE
		var/obj/item/stack/telecrystal/TC = new
		TC.amount = sabotaged_amt
		TC.forceMove(get_turf(user))
		user.put_in_hands(TC)
		to_chat(user, SPAN_NOTICE("You remove \the [TC] from \the [src] and realign the accelerator vanes, preventing what could have been a catastrophe."))
		sabotaged = null
		sabotaged_amt = 0
		return TRUE
	. = ..()

//Custom procs.
//Finds fuel ports.
/obj/machinery/ftl_shunt/core/proc/find_ports()
	var/datum/extension/local_network_member/network = get_extension(src, /datum/extension/local_network_member)
	var/datum/local_network/lan = network.get_local_network()
	if(lan)
		var/list/ports = lan.get_devices(/obj/machinery/ftl_shunt/fuel_port)
		fuel_ports.Cut()
		for(var/obj/machinery/ftl_shunt/fuel_port/FP in ports)
			if(!FP.master)
				FP.master = src
				fuel_ports += FP

//Starts the teleport process, returns 1-6, with 6 being the all-clear.
/obj/machinery/ftl_shunt/core/proc/start_shunt()

	var/decl/security_state/security_state = GET_DECL(global.using_map.security_state)

	if(isnull(ftl_computer))
		return

	if(isnull(ftl_computer.linked))
		return

	if(stat & BROKEN)
		return FTL_START_FAILURE_BROKEN
	if(stat & NOPOWER)
		return FTL_START_FAILURE_POWER

	if(world.time <= cooldown)
		return FTL_START_FAILURE_COOLDOWN

	if(!length(fuel_ports)) //no fuel ports
		find_ports()
		if(!length(fuel_ports))
			return FTL_START_FAILURE_OTHER

	var/calcRes  = calculate_jump_requirements()

	if(calcRes == FTL_BAD_DIST) // check for jump on departure square.  get_dist will return -1
		return FTL_BAD_DIST

	if(accumulated_charge < required_charge)
		return FTL_START_FAILURE_POWER
	if(max_charge < required_charge)
		return FTL_START_FAILURE_POWER

	if(required_jump_cores > get_charges())
		return FTL_START_FAILURE_FUEL

	if(sabotaged)
		for(var/mob/living/carbon/human/H in global.living_mob_list_) //Give engineers a hint that something might be very, very wrong.
			if(!(H.z in ftl_computer.linked.map_z))
				continue
			if(H.skill_check(SKILL_ENGINES, SKILL_EXPERT))
				to_chat(H, SPAN_DANGER("The deck vibrates with a harmonic that sets your teeth on edge and fills you with dread."))

	var/announcetxt = replacetext(shunt_start_text, "%%TIME%%", "[round(jump_delay/600)] minutes.")

	ftl_announcement.Announce(announcetxt, "FTL Shunt Management System", new_sound = sound('sound/misc/notice2.ogg'))

	cached_security_level = security_state.current_security_level
	security_state.set_security_level(GET_DECL(/decl/security_level/default/code_yellow), TRUE)
	update_icon()

	if(check_charge())
		jump_timer = addtimer(CALLBACK(src, .proc/execute_shunt), jump_delay, TIMER_STOPPABLE)
	return FTL_START_CONFIRMED

/obj/machinery/ftl_shunt/core/proc/calculate_jump_requirements()
	var/obj/effect/overmap/visitable/O = global.overmap_sectors["[z]"]
	if(O)
		var/shunt_distance
		var/vessel_mass = ftl_computer.linked.get_vessel_mass()
		var/shunt_turf = locate(shunt_x, shunt_y, O.z)
		shunt_distance = get_dist(get_turf(ftl_computer.linked), shunt_turf)
		if(shunt_distance == -1)
			return FTL_BAD_DIST

		required_jump_cores = max(1, round(shunt_distance / 2))
		//required_jump_cores = shunt_distance
		required_charge = ((shunt_distance * vessel_mass)* REQUIRED_CHARGE_MULTIPLIER)*1000

//Cancels the in-progress shunt.
/obj/machinery/ftl_shunt/core/proc/cancel_shunt(var/silent = FALSE)
	var/decl/security_state/security_state = GET_DECL(global.using_map.security_state)
	if(!jump_timer)
		return
	deltimer(jump_timer)
	charge_time = null
	cooldown = null
	required_jump_cores = null
	if(!silent)
		ftl_announcement.Announce(shunt_cancel_text, "FTL Shunt Management System", new_sound = sound('sound/misc/notice2.ogg'))
	update_icon()
	jump_timer = null
	//HEARTH EXCLUSIVE
	security_state.set_security_level(cached_security_level, TRUE)
	//END HEARTH EXCLUSIVE

//Starts the shunt, and then hands off to enter_shunt to finish it.
/obj/machinery/ftl_shunt/core/proc/execute_shunt()
	ftl_announcement.Announce(shunt_spooling_text, "FTL Shunt Management System", new_sound = sound('sound/misc/notice2.ogg'))
	if(sabotaged)
		cancel_shunt(TRUE)
		do_sabotage()
		ftl_computer.jump_plotted = FALSE
		return

	if(can_use_fuel(required_jump_cores))
		use_fuel(required_jump_cores)
	else
		cancel_shunt()
		return //If for some reason we don't have fuel now, just return.

	var/obj/effect/overmap/visitable/O = global.overmap_sectors["[z]"]
	if(O)
		var/destination = locate(shunt_x, shunt_y, O.z)
		var/jumpdist = get_dist(get_turf(ftl_computer.linked), destination)
		addtimer(CALLBACK(src, .proc/enter_shunt, shunt_x, shunt_y, jumpdist, destination), 6 SECONDS)
		jumping = TRUE
		update_icon()
		for(var/mob/living/carbon/M in global.living_mob_list_)
			if(!(M.z in ftl_computer.linked.map_z))
				continue
			sound_to(M, 'sound/machines/hyperspace_begin.ogg')

/obj/machinery/ftl_shunt/core/proc/enter_shunt(var/shunt_x, var/shunt_x, var/jumpdist, var/destination)
	var/announcetxt = replacetext(shunt_entered_text, "%%TIME%%", "[round((jumpdist*JUMP_TIME_PER_TILE)/10)]")
	var/datum/event_meta/EM = new(EVENT_LEVEL_MUNDANE, "FTL", /datum/event/ftl, add_to_queue = FALSE, is_one_shot = TRUE)
	ftl_event = new /datum/event/ftl(EM)
	ftl_event.startWhen = 0
	ftl_event.endWhen = INFINITY
	ftl_event.affecting_z = ftl_computer.linked.map_z
	ftl_computer.linked.forceMove(null)
	ftl_computer.linked.halted = TRUE

	ftl_announcement.Announce(announcetxt, "FTL Shunt Management System", new_sound = sound('sound/misc/notice2.ogg'))
	addtimer(CALLBACK(src, .proc/end_shunt, shunt_x, shunt_y, jumpdist, destination),jumpdist*JUMP_TIME_PER_TILE)

/obj/machinery/ftl_shunt/core/proc/end_shunt(var/turfx, var/turfy, var/jumpdist, var/destination) //this does the actual teleportation, execute_shunt is there to give us time to do our fancy effects
	var/decl/security_state/security_state = GET_DECL(global.using_map.security_state)
	ftl_computer.linked.forceMove(destination)
	ftl_computer.linked.halted = FALSE
	ftl_announcement.Announce(shunt_complete_text, "FTL Shunt Management System", new_sound = sound('sound/misc/notice2.ogg'))
	cooldown = world.time + cooldown_delay
	do_effects(jumpdist)
	deltimer(jump_timer)
	jumping = FALSE
	update_use_power(POWER_USE_IDLE)
	accumulated_charge -= required_charge
	jump_timer = null
	ftl_computer.jump_plotted = FALSE
	//HEARTH EXCLUSIVE
	addtimer(CALLBACK(security_state, /decl/security_state/.proc/set_security_level, cached_security_level, TRUE), 4 SECONDS)
	//END HEARTH EXCLUSIVE
	if(ftl_event)
		ftl_event.kill()
		ftl_event = null

//Handles all the effects of the jump.
/obj/machinery/ftl_shunt/core/proc/do_effects(var/distance) //If we're jumping too far, have some !!FUN!! with people and ship systems.
	var/shunt_sev
	switch(distance)
		if(1 to safe_jump_distance)
			shunt_sev = SHUNT_SEVERITY_MINOR
		if(safe_jump_distance to moderate_jump_distance)
			shunt_sev = SHUNT_SEVERITY_MAJOR
		if(moderate_jump_distance to INFINITY)
			shunt_sev = SHUNT_SEVERITY_CRITICAL

	for(var/mob/living/carbon/human/H in global.living_mob_list_) //Affect mobs, skip synthetics.
		sound_to(H, 'sound/machines/hyperspace_end.ogg')

		if(!(H.z in ftl_computer.linked.map_z))
			continue

		handle_spacefloat(H)

		if(isnull(H) || QDELETED(H))
			continue

		if(H.isSynthetic())
			continue //We don't affect synthetics.

		switch(shunt_sev)
			if(SHUNT_SEVERITY_MINOR)
				to_chat(H, SPAN_NOTICE("You feel your insides flutter about inside of you as you are briefly shunted into an alternate dimension.")) //No major effects.
				shake_camera(H, 3, 3)

			if(SHUNT_SEVERITY_MAJOR)
				to_chat(H, SPAN_WARNING("You feel your insides twisted inside and out as you are violently shunted between dimensions, and you feel like something is watching you!"))
				if(prob(25))
					H.set_hallucination(50, 50)
				if(prob(15))
					H.vomit()
				shake_camera(H, 3, 3)

			if(SHUNT_SEVERITY_CRITICAL)
				to_chat(H, SPAN_DANGER("You feel an overwhelming sense of nausea and vertigo wash over you, your instincts screaming that something is wrong!"))
				if(prob(50))
					H.set_hallucination(100, 100)
				if(prob(45))
					H.vomit()
				shake_camera(H, 5, 4)

	for(var/obj/machinery/light/L in SSmachines.machinery) //Fuck with and or break lights.
		if(!(L.z in ftl_computer.linked.map_z))
			continue
		switch(shunt_sev)
			if(SHUNT_SEVERITY_MINOR)
				if(prob(25))
					L.flicker()
			if(SHUNT_SEVERITY_MAJOR)
				if(prob(45))
					L.flicker()

	for(var/obj/machinery/power/apc/A in SSmachines.machinery)
		if(!(A.z in ftl_computer.linked.map_z))
			continue
		switch(shunt_sev)
			if(SHUNT_SEVERITY_MAJOR)
				if(prob(25))
					A.energy_fail(rand(30, 80))
				if(prob(35))
					A.overload_lighting(25)

			if(SHUNT_SEVERITY_CRITICAL)
				if(prob(35))
					A.energy_fail(rand(60, 150))
				if(prob(50))
					A.overload_lighting(50)

/obj/machinery/ftl_shunt/core/proc/handle_spacefloat(var/mob/living/carbon/human/H)
	if(!H.check_space_footing())
		 //Flip a coin ...
		to_chat(H, SPAN_WARNING("Being untethered from a ship entering FTL is a bad idea, but you roll the dice..."))
		if(prob(50))
			to_chat(H, SPAN_NOTICE("and win, surviving the energy dancing over your body. Not unharmed, however."))
			H.apply_damage(300, IRRADIATE, damage_flags = DAM_DISPERSED)
			return
		else
			to_chat(H, SPAN_DANGER("and lose, being ripped apart in a nanosecond by energies beyond comprehension."))
			H.gib()

/obj/machinery/ftl_shunt/core/proc/do_sabotage()
	var/announcetxt

	switch(sabotaged)
		if(SHUNT_SABOTAGE_MINOR)
			announcetxt = shunt_sabotage_text_minor
			for(var/mob/living/carbon/human/H in view(7))
				to_chat(H, SPAN_DANGER("[src] emits a flash of incredibly bright, searing light!"))
				H.flash_eyes(FLASH_PROTECTION_NONE)
			empulse(src, 8, 10)

		if(SHUNT_SABOTAGE_MAJOR)
			announcetxt = shunt_sabotage_text_major

			for(var/mob/living/carbon/human/H in view(7)) //Effect One: scary text.
				to_chat(H, SPAN_DANGER("[src] hisses and sparks, before coolant lines burst and spew superheated coolant!"))

			explosion(get_turf(src),-1,-1,8,10) //Effect Two: blow the windows out.

			for(var/obj/machinery/power/apc/A in SSmachines.machinery) //Effect Three: shut down power across the ship.
				if(!(A.z in ftl_computer.linked.map_z))
					continue
				A.energy_fail(rand(60,80))

		if(SHUNT_SABOTAGE_CRITICAL)
			announcetxt = shunt_sabotage_text_critical

			for(var/obj/machinery/power/apc/A in SSmachines.machinery) //Effect One: shut down power across the ship.
				if(!(A.z in ftl_computer.linked.map_z))
					continue
				A.energy_fail(rand(100,120))

			for(var/mob/living/carbon/human/H in view(7)) //scary text if you're in view, because you're fucked now boy.
				to_chat(H, SPAN_DANGER("The light around [src] warps before it emits a flash of incredibly bright, searing light!"))
				H.flash_eyes(FLASH_PROTECTION_NONE)

			new /obj/singularity/(get_turf(src))


	ftl_announcement.Announce(announcetxt, "FTL Shunt Management System", new_sound = sound('sound/misc/ftlsiren.ogg'))

//Returns status to ftl computer.
/obj/machinery/ftl_shunt/core/proc/get_status()
	if(stat & (BROKEN|NOPOWER))
		return FTL_STATUS_OFFLINE
	if(world.time <= cooldown)
		return FTL_STATUS_COOLDOWN
	if(jump_timer)
		return FTL_STATUS_SPOOLING_UP
	else
		return FTL_STATUS_GOOD

/obj/machinery/ftl_shunt/core/proc/can_use_fuel(var/charges_required)
	var/avaliable_charges
	for(var/obj/machinery/ftl_shunt/fuel_port/F in fuel_ports)
		avaliable_charges += F.get_charge()
	if(avaliable_charges >= charges_required)
		return TRUE
	else
		return FALSE

/obj/machinery/ftl_shunt/core/proc/use_fuel(var/charges_required)
	var/avaliable_charges
	var/used_charges = 0

	for(var/obj/machinery/ftl_shunt/fuel_port/F in fuel_ports)
		avaliable_charges += F.get_charge()
	if(avaliable_charges >= charges_required)
		for(var/obj/machinery/ftl_shunt/fuel_port/F in fuel_ports)
			if(F.use_charge())
				F.update_icon()
				used_charges++
				if(used_charges >= charges_required)
					break

/obj/machinery/ftl_shunt/core/proc/get_charges()
	for(var/obj/machinery/ftl_shunt/fuel_port/F in fuel_ports)
		. += F.get_charge()

/obj/machinery/ftl_shunt/core/proc/get_max_charges()
	for(var/obj/machinery/ftl_shunt/fuel_port/F in fuel_ports)
		. += 1

/obj/machinery/ftl_shunt/core/proc/get_charge_time()
	if(isnull(last_power_drawn))
		return "UNKNOWN"
	if(last_power_drawn == 0)
		return "UNKNOWN"
	return "[clamp(round((target_charge-accumulated_charge)/((last_power_drawn*CELLRATE) * 1 SECOND / SSmachines.wait), 0.1),0, INFINITY)] Seconds"

/obj/machinery/ftl_shunt/core/proc/check_charge()
	if(accumulated_charge >= required_charge)
		return TRUE

/obj/machinery/ftl_shunt/core/proc/draw_charge(var/input)
	if(stat & NOPOWER)
		return FALSE

	if(!use_power_oneoff(input,EQUIP))
		last_power_drawn = input
		accumulated_charge += input * CELLRATE

		return TRUE
	else
		return FALSE

/obj/machinery/ftl_shunt/core/Process()
	if(stat & (BROKEN|NOPOWER))
		return
	update_icon()

	if(charging)
		if(accumulated_charge < target_charge)
			draw_charge(allowed_power_usage)
			accumulated_charge = clamp(accumulated_charge, 0, max_charge)
		SSradiation.radiate(src, (active_power_usage / 1000))
	chargepercent = round(100*(accumulated_charge/max_charge), 0.1)

	if(jumping)
		if(prob(15) && last_stress_sound < world.time + 2 SECONDS)
			for(var/mob/living/carbon/M in global.living_mob_list_)
				if(!(M.z in ftl_computer.linked.map_z))
					continue
				sound_to(M, pick(ftl_sounds))
				shake_camera(M, rand(1,2), rand(1,2))
			last_stress_sound = world.time

//
// Construction MacGuffins down here.
//

/obj/item/stock_parts/circuitboard/ftl_shunt
	name = "circuit board (superluminal shunt)"
	board_type = "machine"
	build_path = /obj/machinery/ftl_shunt/core
	origin_tech = "{'programming':3,'magnets':5,'materials':5,'wormholes':5}"

/obj/item/stock_parts/ftl_core
	name = "exotic matter bridge"
	desc = "The beating heart of a superluminal shunt - without this, the power to manipulate space-time is out of reach."
	origin_tech = "{'programming':3,'magnets':5,'materials':5,'wormholes':5}"
	icon = 'icons/obj/items/stock_parts/stock_parts.dmi'
	icon_state = "smes_coil"
	color = COLOR_YELLOW
	matter = list(/decl/material/solid/exotic_matter = MATTER_AMOUNT_REINFORCEMENT, /decl/material/solid/metal/plasteel = MATTER_AMOUNT_PRIMARY)


