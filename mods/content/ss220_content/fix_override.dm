/obj/item/light/tube
	b_range = 6

/obj/item/light/tube/large
	b_power = 1
	b_range = 8

/obj/machinery/artifact_analyser
	anchored = 1
	density = 1

/datum/controller/subsystem/ticker/handle_tickets()
	message_staff("<span class='warning'><b>Рестарт через [restart_timeout/10] секунд если администраторы не приостановят его.</b></span>")
	end_game_state = END_GAME_ENDING