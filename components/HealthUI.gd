extends Control

var hearts = 4 setget _set_hearts
var max_hearts = 5 setget _set_max_hearts
var player = null
var _is_initialized: bool = false

onready var full_heart_rect: TextureRect = $FullHeartUI
onready var empty_heart_rect: TextureRect = $EmptyHeartUI

func init(player_value):
	if not _is_initialized:
		player = player_value
		player.connect("health_changed", self, "_on_health_changed")
		self.show()
		self._set_hearts(player.hp)

func _set_hearts(new_value):
	hearts = clamp(new_value, 0, max_hearts)
	if full_heart_rect == null: return

	if full_heart_rect.flip_h:
		full_heart_rect.rect_position.x = 572 - hearts * 40
		full_heart_rect.rect_size.x = hearts * 40
	else:
		full_heart_rect.rect_size.x = hearts * 40

func _set_max_hearts(new_value):
	max_hearts = max(new_value, 1)
	if empty_heart_rect != null:
		empty_heart_rect.rect_size.x = max_hearts * 40

func _setup_health():
	self.hearts = player.hp
	self.max_hearts = player.max_hp
	self.player.connect("health_changed", self, "_on_health_changed")

func _on_health_changed(new_value):
	self.hearts = new_value

func _on_max_health_changed(new_value):
	self.max_hearts = new_value
