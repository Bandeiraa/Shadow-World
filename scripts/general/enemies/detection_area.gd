extends Area2D
class_name DetectionArea

onready var parent: KinematicBody2D = get_parent()

func on_body_entered(body) -> void:
	if body is CharacterTemplate:
		parent.player_ref = body
		
		
func on_body_exited(body) -> void:
	if body is CharacterTemplate:
		parent.player_ref = null
