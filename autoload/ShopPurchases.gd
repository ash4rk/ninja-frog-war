extends Node

signal coins_changed (new_value)

var SAVE_PATH = "user://save"

var purchases = {
	"bought_characters" : [true, false, false, false],
	"bought_skins" : [true, false, false, false]
}
var coins :int = 5000 setget _set_coins

func save_purchases():
	var file = File.new()
	file.open(SAVE_PATH, file.WRITE_READ)
	file.store_var(purchases)
	file.close()
	
func load_purchases() -> bool:
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
		return false
	file.open(SAVE_PATH, file.READ)
	purchases = file.get_var()
	file.close()
	return true

func _set_coins(new_value):
	coins = new_value
	emit_signal("coins_changed", new_value)
