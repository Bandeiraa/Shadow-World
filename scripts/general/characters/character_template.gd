extends KinematicBody2D
class_name CharacterTemplate

onready var stats: Node = get_node("Stats")
onready var texture: Sprite = get_node("Texture")

var attack_damage: int

var can_move: bool = true

var velocity: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	move()
	attack()
	texture.animate(velocity)
	
	
func move() -> void:
	velocity = Vector2.ZERO
	if can_move:
		velocity = stats.move_speed * get_direction()
		velocity = move_and_slide(velocity)
		
		
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	
func attack() -> void:
	if Input.is_action_just_pressed("ui_attack") and not texture.in_action:
		can_move = false
		attack_damage = stats.get_attack_damage()
		texture.action_behavior("attack", stats.current_attack)
		
		
func sleep(state: bool) -> void:
	can_move = state
	velocity = Vector2.ZERO
	texture.animate(velocity)
	set_physics_process(state)
