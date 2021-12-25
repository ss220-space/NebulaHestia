#define EVAC_CHAIR(varName) var/obj/structure/bed/chair/shuttle/##varName

// Rewrited files start

/datum/computer/file/embedded_program/docking/simple/escape_pod_berth
	var/arming = FALSE

/datum/shuttle/autodock/ferry/escape_pod
	var/need_people	= 0

/datum/computer/file/embedded_program/docking/simple/escape_pod_berth/arm()
	if(!armed)
		armed = 1
		arming = FALSE
		toggleDoor(memory["door_status"], tag_door, TRUE, "open")

/datum/shuttle/autodock/ferry/escape_pod/can_force()
	if (arming_controller && arming_controller.master.emagged)
		return (next_location && next_location.is_valid(src) && !current_location.cannot_depart(src) && moving_status == SHUTTLE_IDLE && !location && arming_controller && arming_controller.armed)
	if (arming_controller.eject_time && world.time < arming_controller.eject_time + 50)
		return 0	//dont allow force launching until 5 seconds after the arming controller has reached it's countdown
	return ..()

/obj/machinery/embedded_controller/radio/on_update_icon()
	overlays.Cut()
	if(!on || !istype(program))
		return
	if(emagged)
		overlays += image(icon, "screen_drain")
		overlays += image(icon, "indicator_active")
		overlays += image(icon, "indicator_forced")
		overlays += image(icon, "indicator_done")
		return
	if(!program.memory["processing"])
		overlays += image(icon, "screen_standby")
		overlays += image(icon, "indicator_done")
	else
		overlays += image(icon, "indicator_active")
	var/datum/computer/file/embedded_program/docking/airlock/docking_program = program
	var/datum/computer/file/embedded_program/airlock/airlock_program = program
	if(istype(docking_program))
		if(docking_program.override_enabled)
			overlays += image(icon, "indicator_forced")
		airlock_program = docking_program.airlock_program

	if(istype(airlock_program) && airlock_program.memory["processing"])
		if(airlock_program.memory["pump_status"] == "siphon")
			overlays += image(icon, "screen_drain")
		else
			overlays += image(icon, "screen_fill")

/obj/machinery/embedded_controller/radio/simple_docking_controller/escape_pod/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data[0]
	var/datum/computer/file/embedded_program/docking/simple/docking_program = program

	data = list(
		"docking_status" = docking_program.get_docking_status(),
		"override_enabled" = docking_program.override_enabled,
		"door_state" = 	docking_program.memory["door_status"]["state"],
		"door_lock" = 	docking_program.memory["door_status"]["lock"],
		"can_force" = pod.can_force() || (SSevac.evacuation_controller?.has_evacuated() && pod.can_launch()),	//allow players to manually launch ahead of time
		"is_armed" = pod.arming_controller.armed,
	)

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)

	if (!ui)
		ui = new(user, src, ui_key, "escape_pod_console.tmpl", name, 470, 290)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/embedded_controller/radio/simple_docking_controller/escape_pod_berth/emag_act(var/remaining_charges, var/mob/user)
	if (!emagged)
		to_chat(user, "<font size='3'><span class='notice'>You emag the [src], arming the escape pod!</span></font>")
		emagged = TRUE
		get_global_announcer().autosay("<font size='4'><b>Несанкционированный доступ</b> к контроллеру эвакуации. Потеряно управление от <b><i>[src]</i></b>. Службе безопасности рекомендуется проследовать к этой капсуле. Местоположение капсулы: [get_area(src)]</font>", "Automatic Security System", "Security")
		state("<font size='3'>Ошибка центрального контроллера!</font>")
		sleep(5)
		state("<font size='3'>Обнаружена аварийная ситуация!</font>")
		sleep(3)
		state("<font size='3'>Взведение капсулы...</font>")
		sleep(10)
		state("<font size='3'>Ошибка стыковочных зажимов!</font>")
		sleep(5)
		state("<font size='3'>Отключение зажимов...</font>")
		sleep(20)
		state("<font size='3'>Примерное время подготовки: 3 минуты.</font>")
		if (istype(program, /datum/computer/file/embedded_program/docking/simple/escape_pod_berth))
			var/datum/computer/file/embedded_program/docking/simple/escape_pod_berth/arming_program = program
			if (!arming_program.armed)
				arming_program.arming = TRUE
				addtimer(CALLBACK(arming_program, /datum/computer/file/embedded_program/docking/simple/escape_pod_berth/proc/arm), 3 MINUTES)
		return 1

/obj/machinery/embedded_controller/radio/simple_docking_controller/escape_pod/OnTopic(user, href_list)
	if(href_list["command"] == "manual_arm")
		if(pod.arming_controller.arming)
			to_chat(user, "<font size='3'><span class='notice'>Ошибка! Подготовка капсулы уже производится, ожидайте.</span></font>")
		else
			pod.arming_controller.arm()
		return TOPIC_REFRESH

	if(href_list["command"] == "force_launch")
		if (pod.can_force())
			get_global_announcer().autosay("<font size='4'>Несанкционированный запуск капсулы <b>[pod]</b>! Возможна разгерметизация!</font>", "Evacuation Controller")
			pod.force_launch(src)
		else if (SSevac.evacuation_controller?.has_evacuated() && pod.can_launch())	//allow players to manually launch ahead of time if the shuttle leaves
			pod.launch(src)
		return TOPIC_REFRESH

// Rewrited files end
// New files start
/datum/shuttle/autodock/ferry/escape_pod/proc/toggle_bds(var/CLOSE = FALSE)
	for(var/obj/machinery/door/blast/regular/escape_pod/ES in world)
		if(ES.id_tag == shuttle_docking_controller.id_tag)
			if(CLOSE)
				INVOKE_ASYNC(ES, /obj/machinery/door/blast/proc/force_close)
			else
				INVOKE_ASYNC(ES, /obj/machinery/door/blast/proc/force_open)

/datum/computer/file/embedded_program/docking/simple/escape_pod_berth/proc/unarm()
	if(armed)
		armed = 0
		arming = FALSE
		toggleDoor(memory["door_status"], tag_door, TRUE, "close")

/datum/computer/file/embedded_program/docking/simple/proc/signal_door(var/command)
	var/datum/signal/signal = new
	signal.data["tag"] = tag_door
	signal.data["command"] = command
	post_signal(signal)

/datum/computer/file/embedded_program/docking/simple/proc/close_door()
	if(memory["door_status"]["state"] == "open")
		signal_door("secure_close")
	else if(memory["door_status"]["lock"] == "unlocked")
		signal_door("lock")

/datum/shuttle/autodock/ferry/escape_pod/proc/check_load()
	var/list/counted = list()
	var/i = 0
	EVAC_CHAIR(temp)
	for(temp in shuttle_area[1])
		if(temp.buckled_mob)
			counted += temp.buckled_mob
			if(counted.len >= need_people)
				return TRUE
		i++
	if(i < need_people)	// someone broke a chair
		for(var/mob/living/M in shuttle_area[1])
			if(M in counted)
				continue
			counted += M
			if(counted.len >= need_people)
				return TRUE
	return FALSE

/obj/machinery/embedded_controller/radio/simple_docking_controller/escape_pod_berth/attackby(var/obj/item/T, var/mob/living/carbon/human/user)
	if(emagged)
		if(isWrench(T) && user.skill_check(SKILL_ELECTRICAL, SKILL_ADEPT))     // позже нужно поменять на мультиметр, но для этого его нужно добавить в игру
			to_chat(user, "<font size='3'><span class='notice'>Ты начал сбрасывать настройки [src], чтобы починить его.</span></font>")
			if(do_after(user, 100, src))
				emagged = FALSE
				state("<font size='3'>Сброс до заводских настроек завершен!</font>")
				sleep(5)
				state("<font size='3'>Поиск центрального контроллера...</font>")
				sleep(10)
				state("<font size='3'>Найдено!")
				sleep(10)
				state("<font size='3'>Первичная настройка капсулы...</font>")
				sleep(20)
				state("<font size='3'>Успешно!</font>")
				if (istype(program, /datum/computer/file/embedded_program/docking/simple/escape_pod_berth))
					var/datum/computer/file/embedded_program/docking/simple/escape_pod_berth/arming_program = program
					for(var/datum/shuttle/autodock/ferry/escape_pod/pod in escape_pods)
						if(pod.arming_controller == arming_program)
							pod.toggle_bds(TRUE)
							break
					if (arming_program.armed || arming_program.arming)
						arming_program.unarm()
				return
		else
			to_chat(user, "<font size='3'><span class='notice'>Ты не понимаешь что произошло с [src], но он выглядит не как обычно.</span></font>")

// New files end

#undef EVAC_CHAIR