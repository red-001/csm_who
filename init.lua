--[[

Minetest Client Mod: Who

Copyright (C) 2017 tjnenrtn <tjnenrtn@protonmail.com>

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

]]


local localplayer
local player_names
local selected_player = ""

minetest.register_on_connect(function()
	localplayer = minetest.localplayer
	minetest.display_chat_message("[CSM] loaded Who")
end)

local function show_main_dialog()

	player_names = minetest.get_player_names()
	table.sort(player_names)

	local size = "size[3,6]"
	if selected_player ~= "" then
		size = "size[4.5,6]"
	end
	local formspec = size ..
		"bgcolor[#080808BB;true]" ..
		"background[5,5;1,1;gui_formbg.png;true]" ..
		"label[0.27,0;Players Currently Online: " .. #player_names .. "]" ..
		"button_exit[0,5.6;1.5,0.25;close;Close]" ..
		"tableoptions[background=#314D4F]" ..
		"tablecolumns[color;text,align=center,width=10]" ..
		"table[0,0.6;2.8,4.5;player_list;"
	local formspec_table = {}
	for index, player in ipairs(player_names) do
		if player == localplayer:get_name() then
			-- use muted color for localplayer
			formspec_table[index] = "#569784," .. player
		else
			formspec_table[index] = "#EEEEEE," .. player
		end
	end
	formspec = formspec .. table.concat(formspec_table, ",") .. ";]"
	
	if selected_player ~= "" then
		formspec = formspec .. "button[3.05,1;1.5,0.25;kick;Kick]"
			.. "button[3.05,2;1.5,0.25;ban;Ban]"

	end
	minetest.show_formspec("who_plus:player_list", formspec)

end

minetest.register_chatcommand("who", {
	func = function(param)
		show_main_dialog()
	end,
})

core.register_on_formspec_input(function(formname, fields)
	if formname ~= "who_plus:player_list" then return false end
	if fields.player_list then
		local selected = fields.player_list
		if selected:sub(1,3) == "CHG" then
			local index = tonumber(string.match(selected, "%d+"))
			selected_player = player_names[tonumber(index)]
			show_main_dialog()
		end
		return true
	end
	if fields.quit then
		-- Run cleanup code
		selected_player = ""
		return true
	end
	if fields.kick then
		minetest.run_server_chatcommand("kick", selected_player)
		show_main_dialog()
		return true
	end

	if fields.ban then
		minetest.run_server_chatcommand("ban", selected_player)
		show_main_dialog()
		return true
	end
end)

