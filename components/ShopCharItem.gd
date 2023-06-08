extends HBoxContainer

signal char_purchased (char_index)
signal char_picked (char_index)

export (StreamTexture) var shop_icon := preload("res://icon.png")
export (bool) var is_purchased := false
export (int) var item_index := 0
export (int) var price := 10

func _ready():
	is_purchased = ShopPurchases.save_data.bought_characters[item_index]
	
	$Sprite.texture = shop_icon
	$PriceLabel.text = str(price)
	
	if is_purchased:
		$Button.text = "Pick"
		$PriceLabel.hide()

func _on_Button_pressed():
	if not is_purchased:
		_try_to_buy_character()
	else:
		emit_signal("char_picked", item_index)
	
func _try_to_buy_character():
	if ShopPurchases.coins >= price:
		ShopPurchases.coins -= price
		ShopPurchases.save_data.bought_characters[item_index] = true
		is_purchased = true
		$Button.text = "Pick"
		$PriceLabel.hide()
		emit_signal("char_purchased", item_index)
	else:
		print("You need more coins")
