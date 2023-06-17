extends "res://main/Screen.gd"

signal play_local
signal play_online

onready var coins_label = $Coins/CoinsValueLabel
onready var anim_player = $Coins/Sprite/AnimationPlayer

func _ready():
	ShopPurchases.connect("coins_changed", self, "_on_coins_changed")
	coins_label.text = str(ShopPurchases.coins)
	anim_player.play("idle")

func _on_LocalButton_pressed() -> void:
	emit_signal("play_local")

func _on_OnlineButton_pressed() -> void:
	emit_signal("play_online")

func _on_CreditsButton_pressed() -> void:
	ui_layer.show_screen("CreditsScreen")

func _on_coins_changed(new_value) -> void:
	var coins_diff = new_value - int(coins_label.text)
	
	if coins_diff > 0:
		anim_player.play("coin_gain")
		$Coins/GainLabel.text = "+" + str(coins_diff)
		yield(anim_player, "animation_finished")
		anim_player.play("gain_popup")
	else:
		anim_player.play("coins_spend")
	coins_label.text = str(new_value)
	yield(anim_player, "animation_finished")
	anim_player.play("idle")

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

func _on_AddCoinsButton_pressed():
	YandexSdk.js_show_rewarded_ad()

func _on_HowToPlayButton_pressed():
	$HowToPlayOverlay.show()

func _on_HowToPlayOverlay_gui_input(event):
	if not event is InputEventMouseMotion:
		$HowToPlayOverlay.hide()
