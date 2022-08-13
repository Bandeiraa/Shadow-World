extends KinematicBody2D
class_name Enemy

onready var sprite: Sprite = get_node("Texture")

var attack_damage: int

var velocity: Vector2

var player_ref: KinematicBody2D = null

export(int) var move_speed
export(int) var distance_threshold

export(int) var min_damage
export(int) var max_damage

export(Array, String) var attack_list

func _physics_process(_delta: float) -> void:
	move()
	
	velocity = move_and_slide(velocity)
	sprite.animate(velocity)
	
	
func move() -> void:
	if not player_ref or not global_info.is_alive:
		velocity = Vector2.ZERO
		return
		
	var distance: float = global_position.distance_to(player_ref.global_position)
	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	
	velocity = direction * move_speed
	if distance < distance_threshold:
		velocity = Vector2.ZERO
		
	if distance < distance_threshold and not sprite.on_action:
		attack()
		
		
func attack() -> void:
	var current_attack: String = attack_list[randi() % attack_list.size()]
	match current_attack:
		"attack_1":
			attack_damage = randi() % max_damage + 1
			
		"attack_2":
			attack_damage = randi() % min_damage + 1
			
	sprite.action_behavior(current_attack)
	
	
func kill() -> void:
	queue_free()
