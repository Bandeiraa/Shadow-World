extends Control
class_name QuestContainer

onready var animation: AnimationPlayer = get_node("Animation")

onready var left_container: TextureRect = get_node("LeftContainer")
onready var quest_name: Label = left_container.get_node("VContainer/QuestName")
onready var quest_description: Label = left_container.get_node("VContainer/QuestDescription")

onready var quest_goal: Label = left_container.get_node("VContainer/VContainer/Goal")
onready var quest_type: Label = left_container.get_node("VContainer/VContainer/QuestType")
onready var quest_current_state: Label = left_container.get_node("VContainer/VContainer/CurrentState")

onready var right_container: TextureRect = get_node("RightSidebar")
onready var quest_v_container: VBoxContainer = right_container.get_node("QuestContainer/Container/VContainer")

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
	for slot in quest_v_container.get_children():
		slot.connect("send_quest_info", self, "update_display_text")
		
	display_placeholder_text()
	
	
func display_placeholder_text() -> void:
	var random_index: int = randi() % roleplay_description_list.size()
	quest_name.text = roleplay_name_list[random_index]
	quest_description.text = roleplay_description_list[random_index]
	
	quest_goal.text = ""
	quest_type.text = ""
	quest_current_state.text = ""
	
	
func update_display_text(slot_quest_name: String, slot_quest_description: String, slot_quest_type: String, slot_quest_goal: String, slot_quest_current_state: String) -> void:
	quest_name.text = slot_quest_name
	quest_description.text = slot_quest_description
	quest_goal.text = slot_quest_goal
	quest_type.text = slot_quest_type
	quest_current_state.text = slot_quest_current_state
	
	
func populate_quest_slot(slot_quest_name: String, slot_quest_description: String, quest_info: Dictionary) -> void:
	for slot in quest_v_container.get_children():
		if slot.is_empty:
			slot.update_slot(slot_quest_name, slot_quest_description, quest_info)
			return
			
			
func play_animation(anim: String) -> void:
	animation.play(anim)
	
	
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"hide_container":
			on_action = false
			reset_slot_state()
			display_placeholder_text()
			get_tree().call_group("character", "sleep", true)
			
		"show_container":
			on_action = true
			get_tree().call_group("character", "sleep", false)
			
			
func reset_slot_state() -> void:
	for slot in quest_v_container.get_children():
		slot.reset_state()
		
		
func update_slot(target: String) -> void:
	for slot in quest_v_container.get_children():
		if slot.target == target:
			slot.update_quest_progress()
