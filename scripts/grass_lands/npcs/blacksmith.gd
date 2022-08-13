extends Npc
class_name Blacksmith

func _ready() -> void:
	npc_initial_info()
	set_info_list()
	
	
func npc_initial_info() -> void:
	faceset = {
		"speak": "res://resources/faceset/blacksmith/speaking.tres",
		"idle": "res://resources/faceset/blacksmith/blinking.tres"
	}
	
	initial_dialog = [
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
	
	alternative_dialog = [
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
	
	finish_quest_dialog = [
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
			"Eliminei os monstros que você pediu!",
			"Refinar",
			true,
			["upgrade", 1]
		],
		
		[
			"Agradeço muito a sua ajuda, aventureiro!",
			false,
			"",
			"",
			false,
			["", -1]
		],
		
		[
			"",
			true,
			"Foi bem fácil!",
			"Sair",
			true,
			["quest_finished", 0]
		]
	]
	
	quest_info = [
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
	
	
func set_info_list() -> void:
	info_list.append(faceset)
	info_list.append(initial_dialog)
	info_list.append(quest_info)
	info_list.append(self)
