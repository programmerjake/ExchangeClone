exchangeclone = {}

if (not minetest.get_modpath("mcl_core")) and (not minetest.get_modpath("default")) then
    error("ExchangeClone requires 'default' or 'mcl_core,' but Minetest doesn't let me mark one or the other as a dependency.")
else
	exchangeclone.mcl = minetest.get_modpath("mcl_core")
end
exchangeclone.mineclonia = minetest.get_game_info().id == "mineclonia" -- if exchangeclone.mineclonia, exchangeclone.mcl will also be defined.


exchangeclone.orb_max = 51200000 -- Max capacity of Klein Star Omega in ProjectE

local modpath = minetest.get_modpath("exchangeclone")

exchangeclone.collector_speed = minetest.settings:get("exchangeclone.energy_collector_speed") or 5

dofile(modpath.."/lib.lua")
dofile(modpath.."/constructor.lua")
dofile(modpath.."/deconstructor.lua")
dofile(modpath.."/energy_collector.lua")
dofile(modpath.."/orb.lua")
dofile(modpath.."/craftitems.lua")
if exchangeclone.mcl or minetest.get_modpath("3d_armor") then
	dofile(modpath.."/armor.lua")
end
if exchangeclone.mcl then
	mcl_item_id.set_mod_namespace("exchangeclone")
	dofile(modpath.."/shears.lua")
end
dofile(modpath.."/multidig.lua")
dofile(modpath.."/swords.lua")
dofile(modpath.."/axes.lua")
dofile(modpath.."/hoes.lua")
dofile(modpath.."/pickaxes.lua")
dofile(modpath.."/hammers.lua")
dofile(modpath.."/shovels.lua")
dofile(modpath.."/red_matter_multitools.lua")
if exchangeclone.mcl then
	dofile(modpath.."/tool_upgrades.lua")
end
dofile(modpath.."/philosophers_stone.lua")
dofile(modpath.."/pesa.lua")
dofile(modpath.."/transmutation_table.lua")
dofile(modpath.."/furnaces.lua")