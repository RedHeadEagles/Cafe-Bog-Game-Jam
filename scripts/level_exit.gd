extends Area2D


func _on_body_entered(body: Node2D) -> void:
	call_deferred('_next_level')


func _next_level():
	get_tree().change_scene_to_file('res://scenes/level1.tscn')
