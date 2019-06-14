extends Control

var _player_name = ""

func _on_introducir_nombre_text_changed(new_text):
	_player_name = new_text

func _on_crear_pressed():
	if _player_name == "":
		return
	Network.create_server(_player_name)
	_load_game()

func _on_unirse_pressed():
	if _player_name == "":
		return
	Network.connect_to_server(_player_name)
	_load_game()

func _load_game():
	get_tree().change_scene('res://Game.tscn')



	







