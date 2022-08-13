extends Area2D
class_name HitboxArea

onready var stats: Node = get_node("%Stats")
onready var sprite: Sprite = get_node("%Texture")

var health: int

func _ready() -> void:
	health = stats.health
	
	
func on_area_entered(area) -> void:
	if area.is_in_group("enemy_attack_area"):
		var enemy_ref: KinematicBody2D = area.get_parent()
		update_health(enemy_ref.attack_damage)
		
		
func update_health(attack_damage: int) -> void:
	health -= attack_damage
	if health <= 0:
		global_info.is_alive = false
		sprite.action_behavior("death", "")
		return
		
	sprite.action_behavior("hurt", "")
