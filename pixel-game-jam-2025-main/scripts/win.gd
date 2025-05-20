extends Node2D


func _on_retry_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/sub_spirits_main.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")
