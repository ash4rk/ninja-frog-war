extends Node

# "green", "purple", "red", "cyan", "pink", "orange", "blue", "yellow"

var frog_skins = [
	true, # green
	false, # purple
	false, # red
	false, # cyan
	false, # pink
	false, # orange
	false, # blue
	false, # yellow
]

var mask_dude_skins = [
	false, # green
	false, # purple
	false, # red
	false, # cyan
	false, # pink
	true, # orange
	false, # blue
	false, # yellow
	false, # super-white
]

var pink_man_skins = [
	false, # green
	false, # purple
	false, # red
	false, # cyan
	true, # pink
	false, # orange
	false, # blue
	false, # yellow
]

var virtual_guy_skins = [
	false, # green
	false, # purple
	false, # red
	false, # cyan
	false, # pink
	false, # orange
	true, # blue
	false, # yellow
]

var skins = [
	frog_skins,
	mask_dude_skins,
	pink_man_skins,
	virtual_guy_skins
]


#var skins = {
#	"frog_green" : true,
#	"frog_pink" : false,
#	"frog_red" : false,
#	"frog_cyan" : false,
#
#	"dude_mask_green" : false,
#	"dude_mask_pink" : false,
#	"dude_mask_orange" : true,
#	"dude_mask_blue" : false,
#
#	"pink_man_pink" : true,
#	"pink_man_green" : false,
#	"pink_man_purple" : false,
#	"pink_man_yellow" : false,
#
#	"virtual_guy_blue" : true,
#	"virtual_guy_green" : false,
#	"virtual_guy_red" : false,
#	"virtual_guy_pink" : false,
#}

signal coins_changed (new_value)

var picked_skin_index : int = 0
var picked_frog_index : int = 0

var SAVE_PATH = "user://save"

func _ready():
	load_data()
	print(save_data)

var save_data = {
	"coins_value" : 0,
	"bought_characters" : [true, false, false, false],
	"skins" : skins
#	"bought_skins" : [true, false, false, false]
} setget _save_data

var coins :int = 5000 setget _set_coins

func save_data():
	var file = File.new()
	file.open(SAVE_PATH, file.WRITE_READ)
	file.store_var(save_data)
	file.close()
	
func load_data() -> bool:
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
		return false
	file.open(SAVE_PATH, file.READ)
	save_data = file.get_var()
	coins = save_data.coins_value
	file.close()
	return true

func _set_coins(new_value):
	coins = new_value
	save_data.coins_value =new_value
	save_data()
	emit_signal("coins_changed", new_value)

func _save_data(new_value):
	save_data = new_value
	save_data()

func is_picked_skin_owned() -> bool:
	return save_data.skins[picked_frog_index][picked_skin_index]

func is_skin_owned(skin_index) -> bool:
	return save_data.skins[picked_frog_index][skin_index]
