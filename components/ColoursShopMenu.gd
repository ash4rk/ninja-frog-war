extends Control

export (ButtonGroup) var group
export (NodePath) var menu_frog_scene_path

onready var _frog_scene := get_node(menu_frog_scene_path)

func _ready():
	$GridContainer.get_children()[_frog_scene.active_skin_index].pressed = true
	
	for button in group.get_buttons():
		button.connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	_frog_scene.change_skin(group.get_pressed_button().skin_index)
