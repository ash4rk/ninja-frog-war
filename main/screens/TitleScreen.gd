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
