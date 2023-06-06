extends Area2D

export (PackedScene) var PICKABLE_ARROW_SCENE: PackedScene

onready var ray_cast := $RayCast2D
onready var trail := $Trail
onready var hitbox := $Hitbox
onready var sprite := $Sprite
onready var animation_player := $AnimationPlayer

var vector := Vector2.ZERO
var start_position := Vector2.ZERO
var max_distance := 0.0
var dud := false

func _ready():
	trail.set_as_toplevel(true)
	trail.global_position = Vector2(0, 0)

func shoot(_start_position: Vector2, _vector: Vector2, _max_distance: float, _dud: bool) -> void:
	start_position = _start_position
	vector = _vector
	max_distance = _max_distance
	dud = _dud
	
	global_position = _start_position
	
	if dud:
		hitbox.disabled = true
		hit()

func _physics_process(delta: float) -> void:
	if vector == Vector2.ZERO or dud:
		return
	
	# Add to trail before moving project, so we are using the last position
	# from the last frame.
	trail.add_point(global_position)
	while trail.get_point_count() > 5:
		trail.remove_point(0)
	
	var increment = vector * delta
	ray_cast.cast_to = increment
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding():
		global_position = ray_cast.get_collision_point()
		vector = Vector2.ZERO
	else:
		global_position += increment
	
	if start_position.distance_to(global_position) >= max_distance:
		hit()

func _on_Projectile_body_entered(body: Node) -> void:
	if not dud:
		hit()
	if not body.is_in_group("players"):
		var pickable_arrow_instance = PICKABLE_ARROW_SCENE.instance()
		get_tree().root.call_deferred("add_child", pickable_arrow_instance)
		pickable_arrow_instance.global_position = self.global_position
		pickable_arrow_instance.is_flipped_h = sprite.flip_h

func hit() -> void:
	vector = Vector2.ZERO
	animation_player.play("Hit")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == 'Hit':
		self.call_deferred("queue_free")
