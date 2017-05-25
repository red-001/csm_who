# Who

A Minetest Client Side Modding [CSM] to list all online players.

![Viewing Online Players](/screenshot.jpg?raw=true "Viewing Online Players")

# Usage

This very simple mod registers a chatcommand for displaying the list:

```
.who
```

## Installation

A recent build of Minetest supporting client side modding is required. See [Paths in the documentation](https://github.com/minetest/minetest/blob/master/doc/client_lua_api.md#paths) to find out where the files need to go on your system.

Enable the mod by setting `load_mod_csm_who = true` in `/clientmods/mods.conf`. Also check that `enable_client_modding` is set in `minetest.conf` or the Advanced Settings screen of your Minetest client.

## License

MIT License. See the included `LICESNE.md` for details.
