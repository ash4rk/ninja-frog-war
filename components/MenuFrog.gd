extends Node2D

onready var head_sprite = $BodySprite/HeadPivot/HeadSprite
onready var shadow_sprite = $ShadowPivot/Shadow

# strictly follow this order
# "green", "purple", "red", "cyan", "pink", "orange", "blue", "yellow"

var frog_skin_resources = [
	preload("res://assets/sprites/ninja-frog/body-head-frog.png"),
	preload("res://assets/sprites/ninja-frog/body-head-frog-purple.png"),
	preload("res://assets/sprites/ninja-frog/body-head-frog-red.png"),
	preload("res://assets/sprites/ninja-frog/body-head-frog-cyan.png"),
	"pink",
	"orange",
	"blue",
	"yellow"
]

var mask_dude_resources = [
	preload("res://assets/sprites/mask-dude/mask-dude-body-head-green.png"),
	preload("res://assets/sprites/mask-dude/mask-dude-body-head-purple.png"),
	"red",
	"cyan",
	preload("res://assets/sprites/mask-dude/mask-dude-body-head-pink.png"),
	preload("res://assets/sprites/mask-dude/mask-dude-body-head-base.png"), #(this is orange)
	preload("res://assets/sprites/mask-dude/mask-dude-body-head-light-blue.png"),
	preload("res://assets/sprites/mask-dude/mask-dude-body-head-yellow.png"),
	# are not yet in use
	preload("res://assets/sprites/mask-dude/mask-dude-body-head-super-white.png"),
	#
]

var pink_man_resources = [
	preload("res://assets/sprites/pink-man/pink-man-body-head-green.png"),
	preload("res://assets/sprites/pink-man/pink-man-body-head-purple.png"),
	"red",
	"cyan",
	preload("res://assets/sprites/pink-man/pink-man-body-head-base.png"),
	"orange",
	"blue",
	preload("res://assets/sprites/pink-man/pink-man-body-head-yellow.png"),
]

var virtual_guy_resources = [
	preload("res://assets/sprites/virtual-guy/body-head-green-virtual-guy.png"),
	preload("res://assets/sprites/virtual-guy/body-head-purple-virtual-guy.png"),
	"red",
	"cyan",
	"pink",
	preload("res://assets/sprites/virtual-guy/body-head-orange-virtual-guy.png"),
	preload("res://assets/sprites/virtual-guy/body-head-base-virtual-guy.png"),
	"yellow"
]

var skins = [
	frog_skin_resources,
	mask_dude_resources,
	pink_man_resources,
	virtual_guy_resources
]

var max_dist = 1
var max_shadow_dist = Vector2(0.5, 0.1)
var preview_skin_index: int = 0

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
	
func change_skin(skin_index):
	preview_skin_index = skin_index
	$BodySprite.texture = skins[ShopPurchases.picked_frog_index][skin_index]
	$BodySprite/HeadPivot/HeadSprite.texture = skins[ShopPurchases.picked_frog_index][skin_index]
	check_for_ownership()

func change_frog(frog_index):
	ShopPurchases.picked_frog_index = frog_index
	$BodySprite.texture = skins[frog_index][0]
	$BodySprite/HeadPivot/HeadSprite.texture = skins[frog_index][0]
	change_skin(ShopPurchases.get_first_owned_skin())
	check_for_ownership()

func check_for_ownership():
	if !ShopPurchases.is_skin_owned(preview_skin_index):
		self.modulate = Color(0.25, 0.25, 0.25, 1.0)
		$LockSprite.show()
	else:
		self.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$LockSprite.hide()
		ShopPurchases.picked_skin_index = preview_skin_index
