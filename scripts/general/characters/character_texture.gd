extends Sprite
class_name CharacterTexture

onready var parent: KinematicBody2D = get_parent()
onready var animation: AnimationPlayer = get_node("Animation")

var in_action: bool = false
var attack_suffix: String = "_right"

func animate(velocity: Vector2) -> void:
	verify_direction(velocity.x)
	if not in_action:
		move_behavior(velocity)
		
		
func verify_direction(direction: float) -> void:
	if direction > 0:
		flip_h = false
		position.x = 2
		attack_suffix = "_right"
		
	if direction < 0:
		flip_h = true
		position.x = -2
		attack_suffix = "_left"
		
		
func action_behavior(current_state: String, optional_argument: String) -> void:
	in_action = true
	match current_state:
		"attack":
			animation.play(optional_argument + attack_suffix)
			
		"hurt":
			animation.play("hurt")
			
		"death":
			animation.play("death")
			
			
func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		animation.play("run")
		return
		
	animation.play("idle")
	
	
func on_animation_finished(anim_name: String) -> void:
	in_action = false
	parent.can_move = true
	
	if anim_name == "hurt":
		parent.set_physics_process(true)
