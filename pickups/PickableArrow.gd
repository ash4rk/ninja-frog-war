extends Node2D

var is_flipped_h := false

func _ready():
	$Sprite.flip_h = is_flipped_h

func _on_Area2D_body_entered(body):
	if body.is_in_group("bows"):
		if body.ammo != body.max_ammo:
			body.ammo += 1
			body.set_arrow_visible()
			queue_free()
