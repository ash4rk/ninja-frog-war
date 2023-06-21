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

signal coins_changed (new_value)

var picked_skin_index : int = 0
var picked_frog_index : int = 0

var SAVE_PATH = "user://save"

func _ready():
	load_data()

var save_data = {
	"coins_value" : 0,
	"bought_characters" : [true, false, false, false],
	"skins" : skins
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

func is_skin_owned(skin_index: int) -> bool:
	return save_data.skins[picked_frog_index][skin_index]

func get_first_owned_skin() -> int:
	var idx: int = 0
	for is_skin_owned in save_data.skins[picked_frog_index]:
		if is_skin_owned:
			return idx
		idx += 1
	
	assert(false, "Could not find even 1 owned skin")
	return -1
