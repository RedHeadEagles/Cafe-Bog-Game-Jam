extends Control

func _ready() -> void:
	pass

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()
