extends Node2D

onready var head_sprite = $BodySprite/HeadPivot/HeadSprite
onready var shadow_sprite = $ShadowPivot/Shadow

var max_dist = 1
var max_shadow_dist = Vector2(0.5, 0.1)

func _ready():
	$AnimationPlayer.play("idle")

func _process(_delta):
	var mouse_pos = get_local_mouse_position()
	var dir = Vector2.ZERO.direction_to(mouse_pos)
	var dist = mouse_pos.length()
	head_sprite.position = dir * min(dist, max_dist)
	shadow_sprite.position.x = dir.x * min(dist, max_shadow_dist.x)
	shadow_sprite.position.y = dir.y * min(dist, max_shadow_dist.y)
	
	head_sprite.flip_h = mouse_pos.x < 0
	$BodySprite.flip_h = mouse_pos.x < 0
	