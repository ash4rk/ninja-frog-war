extends Pickup

onready var animation_player = $AnimationPlayer
onready var sounds = $Sounds

func use() -> void:
	
	if animation_player.is_playing():
		return

	if not GameState.online_play:
		_do_use()
	else:
		rpc("_do_use")

func _on_throw() -> void:
	if animation_player.is_playing() and animation_player.current_animation != "RESET":
		animation_player.play("RESET")

remotesync func _do_use() -> void:
	animation_player.play("Swing")
	sounds.play("Swing")

func set_internal_pickup_position() -> void:
	pass
	self.position = Vector2(-27, 30)
#	$CollisionShape2D.position = Vector2(-27, 19)
