extends Area2D


func _on_body_entered(body: Node2D) -> void:
	$"Perspective Prompt".visible = true


# remove popup and area from memory
func _on_perspective_prompt_confirmed() -> void:
	queue_free()


# remove popup and area from memory
func _on_perspective_prompt_canceled() -> void:
	queue_free()
