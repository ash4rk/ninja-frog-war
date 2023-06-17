extends Control

export (ButtonGroup) var group
export (NodePath) var menu_frog_scene_path

const SKIN_PRICE: int = 290

onready var _frog_scene := get_node(menu_frog_scene_path)
onready var _grid_container := $VBoxContainer/GridContainer
onready var _buy_button := $VBoxContainer/BuyButton

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
	_buy_button.visible = !ShopPurchases.is_picked_skin_owned()

func _on_GridContainer_visibility_changed():
	_update_colour_buttons()

func _on_BuyButton_pressed():
	if ShopPurchases.coins >= SKIN_PRICE:
		ShopPurchases.coins -= SKIN_PRICE
		var char_idx = ShopPurchases.picked_frog_index
		var skin_idx = group.get_pressed_button().skin_index
		ShopPurchases.save_data.skins[char_idx][skin_idx] = true
		_buy_button.hide()
		_update_colour_buttons()
		_frog_scene.check_for_ownership()
	else:
		print("You need more coins")

func _update_colour_buttons():
	for colour_button in _grid_container.get_children():
		colour_button.modulate = Color(1.0, 1.0, 1.0)
		colour_button.hide()

	for colour_button in _grid_container.get_children():
		if colour_button.colour in characters[ShopPurchases.picked_frog_index]:
			colour_button.show()
			colour_button.pressed = colour_button.skin_index == ShopPurchases.picked_skin_index
			if !ShopPurchases.is_skin_owned(colour_button.skin_index):
				colour_button.modulate = Color(0.4, 0.4, 0.4)
	
	_buy_button.visible = !ShopPurchases.is_picked_skin_owned()
