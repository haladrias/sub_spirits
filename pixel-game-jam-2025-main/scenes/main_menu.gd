extends Node2D


var main_game_scene = preload("res://scenes/levels/sub_spirits_main.tscn")


func _ready() -> void:
	#_on_start_game_pressed()
	pass

func _start_game() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/sub_spirits_main.tscn")


func _on_start_game_pressed() -> void:
	_start_game()


func _on_exit_game_pressed() -> void:
	get_tree().quit()
