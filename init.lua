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

minetest.register_on_connect(function()
	localplayer = minetest.localplayer
end)

local function show_players()

	local player_names = minetest.get_player_names()
	local formspec = "size[3,6]" ..
		"bgcolor[#080808BB;true]" ..
		"background[5,5;1,1;gui_formbg.png;true]" ..
		"label[0.27,0;Players Currently Online: " .. #player_names .. "]" ..
		"button_exit[0,5.6;1.5,0.25;close;Close]" ..
		"tableoptions[background=#314D4F]" ..
		"tablecolumns[color;text,align=center,width=10]" ..
		"table[0,0.6;2.8,4.5;Players Online;"

	for _, player in ipairs(player_names) do
		if player == localplayer:get_name() then
			-- use muted color for localplayer
			formspec = formspec .. "#569784," .. player .. ","
		else
			formspec = formspec .. "#EEEEEE," .. player .. ","
		end
	end

	formspec = formspec .. ";]"

	minetest.show_formspec("who", formspec)

end

minetest.register_chatcommand("who", {
	func = function(param)
		show_players()
	end,
})

minetest.display_chat_message("[CSM] loaded Who")
