extends Sprite
class_name EnemyTexture

onready var parent: KinematicBody2D = get_parent()
onready var animation: AnimationPlayer = get_node("%Animation")

var on_action: bool = false

var texture_suffix: String
var attack_suffix: String = "_right"

export(int) var position_offset
 
func animate(velocity: Vector2) -> void:
	set_character_orientation(velocity.x)
	if on_action:
		return
		
	move_behavior(velocity)
	
	
func set_character_orientation(direction: float) -> void:
	if direction > 0:
		flip_h = false
		attack_suffix = "_right"
		position.x = position_offset
		
	if direction < 0:
		flip_h = true
		attack_suffix = "_left"
		position.x = -position_offset
		
		
func action_behavior(action: String) -> void:
	on_action = true
	parent.set_physics_process(false)
	set_texture_suffix("/" + action + ".png")
	
	if action == "attack_1" or action == "attack_2":
		animation.play(action + attack_suffix)
		return
		
	animation.play(action)
	
	
func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		set_texture_suffix("/run.png")
		animation.play("run")
		return
		
	set_texture_suffix("/idle.png")
	animation.play("idle")
	
	
func set_texture_suffix(_texture_suffix: String) -> void:
	texture_suffix = _texture_suffix
	
	
func on_animation_finished(anim_name: String) -> void:
	var action_state: bool = anim_name == "attack_1" + attack_suffix or anim_name == "attack_2" + attack_suffix or anim_name == "hurt"
	
	if anim_name == "death":
		parent.kill()
		
	if action_state:
		on_action = false
		parent.set_physics_process(true)
