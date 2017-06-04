# Who Plus

A Minetest Client Side Mod [CSM] for listing online players and 

![Viewing Online Players](/screenshot.png?raw=true "Viewing Online Players")
![Moderator actions](/screenshot2.png?raw=true "Moderator actions")

# Usage

This very simple mod registers this chatcommand to display the list:

```
.who
```

Your own username is included, but in a muted color. The player list is sorted alphabetically with lua's `table.sort()`.

## Installation

A recent build of Minetest supporting client side modding is required. See [Paths in the documentation](https://github.com/minetest/minetest/blob/master/doc/client_lua_api.md#paths) to find out where the files need to go on your system.

Enable the mod by setting `load_mod_csm_who = true` in `/clientmods/mods.conf`. Also check that `enable_client_modding` is set in `minetest.conf` or the Advanced Settings screen of your Minetest client.

## License

MIT License. See the included `LICESNE.md` for details.
