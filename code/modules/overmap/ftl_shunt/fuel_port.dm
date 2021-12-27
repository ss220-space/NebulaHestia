/obj/machinery/ftl_shunt/fuel_port
	name = "superluminal shunt fuel port"
	desc = "A fuel port for an FTL shunt."
	icon_state = "empty"
	icon = 'icons/obj/ftlshunt_fuelport.dmi'

	var/obj/item/jumpcore/fuel
	var/obj/machinery/ftl_shunt/core/master

/obj/machinery/ftl_shunt/fuel_port/on_update_icon()
	cut_overlays()
	var/image/I = image(icon, "spent_overlay")
	if(fuel)
		icon_state = "full"
	else
		icon_state = "empty"
	if(fuel)
		if(fuel.spent)
			I.color = COLOR_RED
		else
			I.color = COLOR_GREEN
		add_overlay(I)

/obj/machinery/ftl_shunt/fuel_port/Initialize()
	set_extension(src, /datum/extension/local_network_member)
	if(initial_id_tag)
		var/datum/extension/local_network_member/local_network = get_extension(src, /datum/extension/local_network_member)
		local_network.set_tag(null, initial_id_tag)
	. = ..()

/obj/machinery/ftl_shunt/fuel_port/modify_mapped_vars(map_hash)
	..()
	ADJUST_TAG_VAR(initial_id_tag, map_hash)

/obj/machinery/ftl_shunt/fuel_port/Destroy()
	. = ..()
	if(master)
		master.fuel_ports -= src
	master = null
	QDEL_NULL(fuel)

/obj/machinery/ftl_shunt/fuel_port/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/jumpcore))
		if(!fuel)
			if(!do_after(user, 2 SECONDS, src) || fuel)
				return
			if(!user || !user.unEquip(O, src))
				return
			fuel = O
			flick("insert", src)
			update_icon()
			return TRUE

	. = ..()

/obj/machinery/ftl_shunt/fuel_port/physical_attack_hand(var/mob/user)
	if(fuel)
		to_chat(user, SPAN_NOTICE("You begin to remove the fuel assembly from [src]..."))
		if(!do_after(user, 2 SECONDS, src) || !fuel || fuel.loc != src)
			return FALSE
		fuel.dropInto(loc)
		user.put_in_hands(fuel)
		fuel = null
		to_chat(user, SPAN_NOTICE("You remove the fuel assembly!"))
		update_icon()
		return TRUE

	. = ..()

/obj/machinery/ftl_shunt/fuel_port/proc/has_fuel()
	return fuel && !fuel.spent

/obj/machinery/ftl_shunt/fuel_port/proc/get_charge()
	if(fuel && !fuel.spent)
		return TRUE

/obj/machinery/ftl_shunt/fuel_port/proc/use_charge()
	if(fuel && !fuel.spent)
		fuel.use_charge()
		fuel.update_icon()

//
// Jump cores down here
//
/obj/item/jumpcore
	name = "superluminal fuel core"
	icon = 'icons/obj/ftlshunt_fuelport.dmi'
	icon_state = "rod_v2"
	desc = "A container for an exotic blend of radioactive materials utilized in going faster-than-light."
	w_class = ITEM_SIZE_LARGE
	var/spent = FALSE

/obj/item/jumpcore/Initialize(ml, material_key)
	. = ..()
	update_icon()

/obj/item/jumpcore/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/jumpcore/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(spent)
		to_chat(user, SPAN_WARNING("This one is spent."))

/obj/item/jumpcore/proc/use_charge()
	spent = TRUE
	START_PROCESSING(SSobj, src)

/obj/item/jumpcore/Process()
	if(!spent)
		return PROCESS_KILL

	if(istype(loc, /turf))
		SSradiation.radiate(src,5)

/obj/item/jumpcore/on_update_icon()
	cut_overlays()
	var/image/I = image(icon, "rod_v2_overlay")
	if(spent)
		I.color = COLOR_RED
	else
		I.color = COLOR_CYAN
	add_overlay(I)
	return

