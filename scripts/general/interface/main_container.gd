extends Control
class_name MainContainer

onready var animation: AnimationPlayer = get_node("Animation")

var on_action: bool = false

func play_animation(anim: String) -> void:
	animation.play(anim)
	
	
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"hide_container":
			on_action = false
			
		"show_container":
			on_action = true
