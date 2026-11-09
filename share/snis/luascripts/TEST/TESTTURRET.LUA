-- test NPC ship turret firing

clear_all();

WOMBAT = 17;
vekkazi = 4;

set_variable("INVINCIBILITY", "1");

player_ids = get_player_ship_ids();
wombats = {};

function start_attack(cookie)
	if not player_ids[1] then
		return;
	end
	for i = 1, 3 do
		if wombats[i] then
			set_faction(wombats[i], vekkazi);
			ai_push_attack(wombats[i], player_ids[1]);
		end
	end
end

if player_ids[1] then
	set_object_orientation(player_ids[1], 0, 1, 0, 0);
	set_object_velocity(player_ids[1], 0, 0, 0);
	local x, y, z = get_object_location(player_ids[1]);
	for i = 1, 3 do
		local zoff = (i - 2) * 200;
		wombats[i] = add_ship("WOMBAT-" .. i, x + 500, y - 30, z + zoff, WOMBAT, vekkazi, 0);
		if wombats[i] then
			set_object_orientation(wombats[i], 0, 1, 0, 0);
			ai_push_catatonic(wombats[i]);
			add_npc_turret(wombats[i]);
		end
	end
	register_timer_callback("start_attack", 50, 0);
end
