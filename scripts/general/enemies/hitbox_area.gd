extends Area2D
class_name EnemyHitboxArea

onready var sprite: Sprite = get_node("%Texture")

export(int) var health

func on_area_entered(area) -> void:
	if area.is_in_group("character_attack_area"):
		var player_ref: KinematicBody2D = area.get_parent()
		update_health(player_ref.attack_damage)
		
		
func update_health(attack_damage: int) -> void:
	health -= attack_damage
	if health <= 0:
		sprite.action_behavior("death")
		return
		
	sprite.action_behavior("hurt")
