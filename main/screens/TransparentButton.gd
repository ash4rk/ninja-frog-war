extends Button

onready var OFF_ICON = preload("res://assets/ui/sound-off.png")
onready var ON_ICON = preload("res://assets/ui/sound-on.png")
onready var original_modulate = modulate

export (float) var transparency := 0.75

func _ready() -> void:
	self.connect("mouse_entered", self, "_on_mouse_entered")
	self.connect("mouse_exited", self, "_on_mouse_exited")
	_on_mouse_exited()

func _on_mouse_entered() -> void:
	modulate = original_modulate

func _on_mouse_exited() -> void:
	modulate.a = transparency


func _on_MuteButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		self.icon = OFF_ICON
	else:
		self.icon = ON_ICON
	
	AudioServer.set_bus_mute(0, button_pressed)
