extends Button

func _process(delta):
	self.disabled = $"../HowToPlayOverlay".visible
