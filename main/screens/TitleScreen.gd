extends "res://main/Screen.gd"

signal play_local
signal play_online

func _ready():
	ShopPurchases.connect("coins_changed", self, "_on_coins_changed")
	$Coins/HBoxContainer/CoinsValueLabel.text = str(ShopPurchases.coins)

func _on_LocalButton_pressed() -> void:
	emit_signal("play_local")

func _on_OnlineButton_pressed() -> void:
	emit_signal("play_online")

func _on_CreditsButton_pressed() -> void:
	ui_layer.show_screen("CreditsScreen")

func _on_coins_changed(new_value) -> void:
	$Coins/HBoxContainer/CoinsValueLabel.text = str(new_value)

func _on_Shop_pressed():
	var from: Vector2 
	var to: Vector2
	
	if not $HBoxContainer/VBoxContainer/Shop.pressed:
		from = Vector2(0.0, 0.0)
		to = Vector2(200.0, 0.0)
	else:
		from = Vector2(200.0, 0.0)
		to = Vector2(0.0, 0.0)
	
	$Tween.interpolate_property($ShopWindow, "rect_position", from, 
	to, 2.0, 
	Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	
