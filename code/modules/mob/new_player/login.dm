/mob/new_player/Login()

	ASSERT(loc == null)

	update_Login_details()	//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
	if(config.usewhitelist_database && config.overflow_server_url && !whitelist_check())
		src << link(config.overflow_server_url)

	if(join_motd)
		to_chat(src, "<div class=\"motd\">[join_motd]</div>")
	to_chat(src, "<div class='info'>Game ID: <div class='danger'>[game_id]</div></div>")

	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	global.using_map.show_titlescreen(client)
	my_client = client
	set_sight(sight|SEE_TURFS)
	global.player_list |= src

	if(!SScharacter_setup.initialized)
		SScharacter_setup.newplayers_requiring_init += src
	else
		deferred_login()

// This is called when the charcter setup system has been sufficiently initialized and prefs are available.
// Do not make any calls in mob/Login which may require prefs having been loaded.
// It is safe to assume that any UI or sound related calls will fall into that category.
/mob/new_player/proc/deferred_login()
	if(!client)
		return

	client.prefs?.apply_post_login_preferences()
	client.playtitlemusic()
	maybe_send_staffwarns("connected as new player")

	show_lobby_menu(TRUE)

	var/decl/security_state/security_state = GET_DECL(global.using_map.security_state)
	var/decl/security_level/SL = security_state.current_security_level
	var/alert_desc = ""
	if(SL.up_description)
		alert_desc = SL.up_description

	to_chat(src, SPAN_NOTICE("The alert level on the [station_name()] is currently: <font color=[SL.light_color_alarm]><B>[SL.name]</B></font>. [alert_desc]"))

	// bolds the changelog button on the interface so we know there are updates.
	if(client.prefs?.lastchangelog != global.changelog_hash)
		to_chat(client, SPAN_NOTICE("You have unread updates in the changelog."))
		if(config.aggressive_changelog)
			client.changes()

/mob/new_player/proc/whitelist_check()
	// Admins are immune to overflow rerouting
	if(!config.usewhitelist_database)
		return TRUE
	if(check_rights(rights_required = 0, show_msg = 0))
		return TRUE
	establish_db_connection()
	//Whitelisted people are immune to overflow rerouting.
	if(dbcon.IsConnected())
		var/dbckey = sql_sanitize_text(src.ckey)
		var/DBQuery/find_ticket = dbcon.NewQuery(
			"SELECT ckey FROM ckey_whitelist WHERE ckey='[dbckey]' AND is_valid=true AND port=[world.port] AND date_start<=NOW() AND (NOW()<date_end OR date_end IS NULL)"
		)

		if(!find_ticket.Execute())
			to_world_log(dbcon.ErrorMsg())
			return FALSE
		if(!find_ticket.NextRow())
			return FALSE
		return TRUE
	return FALSE