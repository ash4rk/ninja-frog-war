extends Control

export (ButtonGroup) var group
export (NodePath) var menu_frog_scene_path

onready var _frog_scene := get_node(menu_frog_scene_path)
onready var _grid_container := $VBoxContainer/GridContainer

# "green", "purple", "red", "cyan", "pink", "orange", "blue", "yellow"
const _frog_colours : Array = ["green", "purple", "red", "cyan"]
const _dude_mask_colours : Array = ["green", "pink", "orange", "blue"]
const _pink_man_colours : Array = ["green", "purple", "pink", "yellow"]
const _virtual_guy_colours : Array = ["green", "orange", "purple", "blue"]

const characters : Array = [
	_frog_colours,
	_dude_mask_colours,
	_pink_man_colours,
	_virtual_guy_colours
]

func _ready():
	_update_colour_buttons()
	
	for button in group.get_buttons():
		button.connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	_frog_scene.change_skin(group.get_pressed_button().skin_index)

func _on_GridContainer_visibility_changed():
	_update_colour_buttons()

func _on_BuyButton_pressed():
	pass # Replace with function body.

func _update_buy_button_state():
	pass

func _update_colour_buttons():
	for colour_button in _grid_container.get_children():
		colour_button.hide()

	for colour_button in _grid_container.get_children():
		if colour_button.colour in characters[ShopPurchases.picked_frog_index]:
			colour_button.show()

	_grid_container.get_children()[_frog_scene.active_skin_index].pressed = true
