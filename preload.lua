
-- mon_crow
-- adrenaline, 100

function pick_from_list(list)
	local rand = math.random(1, #list)
	return list[rand]
end

turn = 0

function iuse_face_of_father(item, active)

	current_turn = game:get_calendar_turn():get_turn()
	
	if current_turn - turn >= 14400 then -- 24 hours
	player:add_effect(efftype_id("adrenaline"), 100)
	game.add_msg("You remember the face of your father.")
	turn = game:get_calendar_turn():get_turn()
    
	else

-- find a bunch of locations where we might spawn
	local locs = {}
	for delta_x = -1, 1 do
		for delta_y = -1, 1 do
			local point = player:pos()
			point.x = point.x + delta_x
			point.y = point.y + delta_y
			if g:is_empty(point) then
				table.insert(locs, point )
			end
		end
    end    

	if #locs == 0 then
--		game.add_msg("You can't use this here!")
		return 0 -- 0 charges used
	end

-- okay, we got a bunch of locations, pick one and spawn
	local loc = pick_from_list(locs)
	local monster = game.create_monster(mtype_id("mon_crow"), loc)
    return 1 -- 1 charge used
    
  
--	game.add_msg("You need more time to focus and center yourself")
	end
	
end

--the syntax is
--game.register_iuse("name of isue that will be on json", function name )

game.register_iuse("IUSE_LUA_FACE_OF_FATHER", iuse_face_of_father)