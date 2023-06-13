extends "res://main/Screen.gd"

onready var tab_container := $TabContainer
onready var username_field := $TabContainer/Login/GridContainer/Username

const CREDENTIALS_FILENAME = 'user://credentials.json'

# TODO: fill user id from API
var user_id: String = "tOpLpSh7i8QG8Voh/SuPbeS4NKTj1OxATCTKQF92H4c="
var username: String = ''

var _reconnect: bool = false
var _next_screen

func _ready() -> void:
	var file = File.new()
	if file.file_exists(CREDENTIALS_FILENAME):
		file.open(CREDENTIALS_FILENAME, File.READ)
		var result := JSON.parse(file.get_as_text())
		if result.result is Dictionary:
			username = result.result['username']
#			user_id = result.result['user_id']
		file.close()

func _save_credentials() -> void:
	var file = File.new()
	file.open(CREDENTIALS_FILENAME, File.WRITE)
	var credentials = {
		username = username,
#		user_id = user_id,
	}
	file.store_line(JSON.print(credentials))
	file.close()

func _show_screen(info: Dictionary = {}) -> void:
	_reconnect = info.get('reconnect', false)
	_next_screen = info.get('next_screen', 'MatchScreen')
	
	tab_container.current_tab = 0
	
	# If we have a stored username, attempt to login straight away.
	if username != '':
		do_login()

func do_login(save_credentials: bool = false) -> void:
	visible = false
	
	if _reconnect:
		ui_layer.show_message("Session expired! Reconnecting...")
	else:
		ui_layer.show_message("Logging in...")
	
	var nakama_session = yield(Online.nakama_client.authenticate_custom_async(user_id, username, true), "completed")
	
	if nakama_session.is_exception():
		visible = true
		ui_layer.show_message("Login failed!")
		
		# Clear stored email and password, but leave the fields alone so the
		# user can attempt to correct them.
		user_id = ''
		username = ''
		
		# We always set Online.nakama_session in case something is yielding
		# on the "session_changed" signal.
		Online.nakama_session = null
	else:
		if save_credentials:
			_save_credentials()
		Online.nakama_session = nakama_session
		ui_layer.hide_message()
		
		if _next_screen:
			ui_layer.show_screen(_next_screen)

func _on_LoginButton_pressed() -> void:
	username = username_field.text.strip_edges()
	do_login($TabContainer/Login/GridContainer/SaveCheckBox.pressed)
