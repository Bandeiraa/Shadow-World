extends Node2D
class_name Blacksmith

const FACESET: Dictionary = {
	"speak": "res://resources/faceset/blacksmith/speaking.tres",
	"idle": "res://resources/faceset/blacksmith/blinking.tres"
}

var info_list: Array

var is_on_quest: bool = false
var is_interacting: bool = false

var player: KinematicBody2D = null

var initial_dialog: Array = [
	[
		"Olá, aventureiro...", 
		false, 
		"", 
		"",
		false,
		["", -1]
	],
	
	[
		"Precisa de Algo?",
		false,
		"",
		"",
		false,
		["", -1]
	],
	
	[
		"",
		true,
		"Você teria alguma missão?",
		"Refinar",
		true,
		["upgrade", 1]
	],
	
	[
		"Agora que você perguntou, recentemente, monstros tem atacado a nossa vila...",
		false,
		"",
		"",
		false,
		["", -1]
	],
	
	[
		"Se possível, gostaria que você eliminasse alguns monstros para instaurar a paz no nosso vilarejo...",
		false,
		"",
		"",
		false,
		["", -1]
	],
	
	[
		"E então... o que você diz?",
		false,
		"",
		"",
		false,
		["", -1]
	],
	
	[
		"",
		true,
		"Tô dentro!",
		"Não tenho tempo!",
		true,
		["quest", 0]
	]
]

var alternative_dialog: Array = [
	[
		"Olá, aventureiro...", 
		false, 
		"", 
		"",
		false,
		["", -1]
	],
	
	[
		"Precisa de Algo?",
		false,
		"",
		"",
		false,
		["", -1]
	],
	
	[
		"",
		true,
		"Refinar",
		"Sair",
		true,
		["upgrade", 0]
	]
]

var quest_info: Array = [
	"Ajudando o Vilarejo!",
	"O Ferreiro lhe deu uma missão para eliminar alguns monstros que estão atacando a vila!",
	{
		"quest_type": "elimination",
		"quest_info": {
			"monster_to_kill": "hedgehog",
			"amount_to_kill": 10
		}
	}
]

export(Array, String) var dialog

func _ready() -> void:
	info_list.append(FACESET)
	info_list.append(initial_dialog)
	info_list.append(quest_info)
	
	
func _process(_delta: float) -> void:
	if player == null:
		return
		
	interact()
	
	
func interact() -> void:
	if is_on_quest and Input.is_action_just_pressed("ui_interact") and not is_interacting:
		var alternative_list: Array = []
		alternative_list.append(FACESET)
		alternative_list.append(alternative_dialog)
		alternative_list.append([])
		
		player.sleep(false)
		is_interacting = true
		
		get_tree().call_group("gui", "select_container", self, "dialog", alternative_list)
		
	if not is_on_quest and Input.is_action_just_pressed("ui_interact") and not is_interacting:
		player.sleep(false)
		is_interacting = true
		
		get_tree().call_group("gui", "select_container", self, "dialog", info_list)
		
		
func end_interact(quest_state: bool) -> void:
	if not is_on_quest:
		is_on_quest = quest_state
		
	player.sleep(true)
	is_interacting = false
	
	
func on_npc_body_entered(body: CharacterTemplate) -> void:
	if not body is CharacterTemplate:
		return
		
	player = body
	
	
func on_npc_body_exited(body: CharacterTemplate) -> void:
	if not body is CharacterTemplate:
		return
		
	player = null
