extends Node2D

var is_flipped_h := false
#onready var initial_scale = scale
#var flip_h := false setget set_flip_h

func _ready():
	$Sprite.flip_h = is_flipped_h

func _on_Area2D_body_entered(body):
	if body.is_in_group("bows"):
		if body.ammo != body.max_ammo:
			body.ammo += 1
			body.set_arrow_visible()
			queue_free()

#func set_flip_h(_flip_h: bool) -> void:
#	if flip_h != _flip_h:
#		flip_h = _flip_h
#
#		if flip_h:
#			scale.x = -initial_scale.x * sign(scale.y)
#		else:
#			scale.x = initial_scale.x * sign(scale.y)
