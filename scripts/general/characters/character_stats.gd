extends Node
class_name CharacterStats

var current_attack: String = "attack_1"

export(int) var health
export(int, 60, 150, 10) var move_speed = 90

func get_attack_damage() -> int:
	match current_attack:
		"attack_1":
			return 5
			
		"attack_2":
			return 10
			
		"full_combo":
			return 5
			
	return 0
