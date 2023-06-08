extends Node

signal coins_changed (new_value)

var SAVE_PATH = "user://save"

func _ready():
	load_data()

var save_data = {
	"coins_value" : 0,
	"bought_characters" : [true, false, false, false],
	"bought_skins" : [true, false, false, false]
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
