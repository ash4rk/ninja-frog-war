extends Node2D

onready var head_sprite = $BodySprite/HeadPivot/HeadSprite

var max_dist = 1

func _ready():
	$AnimationPlayer.play("idle")

func _process(_delta):
	var mouse_pos = get_local_mouse_position()
	var dir = Vector2.ZERO.direction_to(mouse_pos)
	var dist = mouse_pos.length()
	head_sprite.position = dir * min(dist, max_dist)
	
	head_sprite.flip_h = mouse_pos.x < 0
	$BodySprite.flip_h = mouse_pos.x < 0
	
