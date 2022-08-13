extends Node
class_name Spawn

onready var layered_objects: YSort = get_node("%LayeredObjects")

onready var timer: Timer = get_node("Timer")
onready var left_position: Position2D = get_node("Position1")
onready var right_position: Position2D = get_node("Position2")

var enemies_amount: int = 0

export(int) var max_spawn_amount
export(float) var spawn_cooldown

export(Array, PackedScene) var enemies

func _ready() -> void:
	randomize()
	timer.start(spawn_cooldown)
	var _timer = timer.connect("timeout", self, "on_timer_timeout")
	
	
func spawn() -> void:
	var random_index: int = randi() % enemies.size()
	var enemy: Enemy = enemies[random_index].instance()
	var _killed = enemy.connect("killed", self, "on_enemy_killed")
	
	enemy.global_position = Vector2(
		rand_range(left_position.global_position.x, right_position.global_position.x),
		rand_range(left_position.global_position.y, right_position.global_position.y)
	)
	
	layered_objects.add_child(enemy)
	
	enemies_amount += 1
	if enemies_amount < max_spawn_amount:
		timer.start(spawn_cooldown)
		
		
func on_timer_timeout() -> void:
	spawn()
	
	
func on_enemy_killed() -> void:
	enemies_amount -= 1
	if timer.is_stopped():
		timer.start(spawn_cooldown)
