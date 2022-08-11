extends Control
class_name QuestContainer

onready var animation: AnimationPlayer = get_node("Animation")

onready var left_container: TextureRect = get_node("LeftContainer")
onready var quest_name: Label = left_container.get_node("VContainer/QuestName")
onready var quest_description: Label = left_container.get_node("VContainer/QuestDescription")

var on_action: bool = false

var roleplay_name_list: Array = [
	"...",
	"Nenhuma missão selecionada.",
	"Meu canal do YouTube ;D"
]

var roleplay_description_list: Array = [
	"Está vazio aqui.",
	"Nenhuma Descrição no momento.",
	"youtube.com/c/DevBandeiraGodotGameDev"
]

func _ready() -> void:
	randomize()
	display_placeholder_text()
	
	
func display_placeholder_text() -> void:
	var random_index: int = randi() % roleplay_description_list.size()
	quest_name.text = roleplay_name_list[random_index]
	quest_description.text = roleplay_description_list[random_index]
	
	
func play_animation(anim: String) -> void:
	animation.play(anim)
	
	
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"hide_container":
			on_action = false
			display_placeholder_text()
			
		"show_container":
			on_action = true
