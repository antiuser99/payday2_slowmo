function Slow_Peer(id)
	local peer = managers.network._session:peer(id)
	if peer then
		peer:send("start_timespeed_effect", "pause", "pausable", "player;game;game_animation", 0.05, 1, 3600, 1)
	end
end
if managers.network._session then
	local menu_options = {}
	for _, peer in pairs(managers.network:session():peers()) do
		if peer:rank() and peer:level() then
			menu_options[#menu_options+1] ={text = "(" .. peer:user_id() .. ") " .. peer:name(), data = peer:id(), callback = Slow_Peer}
		else
			menu_options[#menu_options+1] ={text = peer:name(), data = peer:id(), callback = Slow_Peer}
		end
	end
	menu_options[#menu_options+1] = {text = "Return", is_cancel_button = true}
	local menu = QuickMenu:new("Slow-mo", "Select who gets slow", menu_options)
	menu:Show()
end
