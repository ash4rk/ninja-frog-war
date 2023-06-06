extends PanelContainer

const INIT_POSITION := Vector2(290.5, -53)

onready var tween := $Tween

var _is_initialized := false

var player_one_score := 0 setget _set_player_one_score
var player_two_score := 0 setget _set_player_two_score

func init():
	if not _is_initialized:
		$"../../../Game".connect("game_over", self, "_on_game_over")
		_is_initialized = true
	tween.interpolate_property(self, "rect_position", INIT_POSITION, 
	Vector2(290.5, -12), 2.0, 
	Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()

func _update_score():
	$ScoreLabel.text = str(player_one_score) + ":" + str(player_two_score)

func _on_game_over(winner):
	if winner == 1 :
		self.player_one_score += 1
	else:
		self.player_two_score += 1

func _set_player_one_score(new_value):
	player_one_score = new_value
	_update_score()
	
func _set_player_two_score(new_value):
	player_two_score = new_value
	_update_score()

func drop_score():
	tween.stop_all()
	self.player_one_score = 0
	self.player_two_score = 0
	rect_position = INIT_POSITION
