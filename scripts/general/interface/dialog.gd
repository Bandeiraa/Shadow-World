extends Control
class_name Dialog

signal end_dialog

enum QUEST_INFO {
	QUEST_NAME,
	QUEST_DESCRIPTION,
	QUEST_DICTIONARY
}

enum LIST_INFO {
	DIALOG,
	SHOW_BUTTON,
	FIRST_BUTTON_TEXT,
	SECOND_BUTTON_TEXT,
	END_DIALOG,
	STATE
}

onready var choice_container: VBoxContainer = get_node("Background/ChoiceContainer")

onready var first_choice: Label = choice_container.get_node("FirstChoiceText")
onready var second_choice: Label = choice_container.get_node("SecondChoiceText")

onready var faceset: TextureRect = get_node("Background/Faceset")
onready var dialog_label: RichTextLabel = get_node("Background/Text")

var choice_index: int = -1

var dialog_index: int = 0

var can_click: bool = false
var can_interact: bool = false
var can_kill_dialog: bool = false

var dialog_dictionary: Dictionary = {
	"faceset": {},
	"dialog": [],
	"quest_info": [],
	"npc": null
}

func _ready() -> void:
	for choice_slot in choice_container.get_children():
		choice_slot.connect("mouse_exited", self, "mouse_interaction", [choice_slot, "exited"])
		choice_slot.connect("mouse_entered", self, "mouse_interaction", [choice_slot, "entered"])
		
		
func set_info(info_list: Array) -> void:
	var faceset_info: Dictionary = info_list[0]
	var dialog_info: Array = info_list[1]
	var quest_info: Array = info_list[2]
	var npc: Node2D = info_list[3]
	
	dialog_dictionary["faceset"] = faceset_info
	dialog_dictionary["dialog"] = dialog_info
	dialog_dictionary["quest_info"] = quest_info
	dialog_dictionary["npc"] = npc
	
	set_texture("idle")
	update_text()
	
	
func update_text() -> void:
	can_interact = false
	
	set_texture("speak")
	
	var dialog_list: Array = dialog_dictionary["dialog"][dialog_index]
	
	dialog_label.percent_visible = 0
	dialog_label.text = dialog_list[LIST_INFO.DIALOG]
	
	if dialog_list[LIST_INFO.SHOW_BUTTON]:
		can_kill_dialog = true
		choice_container.show()
		first_choice.text = dialog_list[LIST_INFO.FIRST_BUTTON_TEXT]
		second_choice.text = dialog_list[LIST_INFO.SECOND_BUTTON_TEXT]
		
		can_interact = true
		set_texture("idle")
		
		return
		
	while dialog_label.percent_visible < 1:
		dialog_label.percent_visible += get_process_delta_time() 
		yield(get_tree(), "idle_frame")
		
	can_interact = true
	set_texture("idle")
	
	
func set_texture(new_state: String) -> void:
	faceset.texture = load(dialog_dictionary["faceset"][new_state])
	
	
func _process(_delta: float) -> void:
	if can_click and Input.is_action_just_pressed("ui_click"):
		check_choice()
		return
		
	if not break_condition():
		return
		
	if can_kill_dialog:
		end_dialog(false)
		return
		
	if dialog_index + 1 < dialog_dictionary["dialog"].size():
		update_dialog()
		return
		
	end_dialog(false)
	
	
func check_choice() -> void:
	reset_mouse_state()
	
	var dialog_list: Array = dialog_dictionary["dialog"][dialog_index]
	
	var end_dialog_list: Array = dialog_list[LIST_INFO.STATE]
	var dialog_state: String = end_dialog_list[0]
	var _index: int = end_dialog_list[1]
	
	if dialog_list[LIST_INFO.END_DIALOG] and _index == choice_index:
		match dialog_state:
			"quest":
				var quest_info: Array = dialog_dictionary["quest_info"]
				var quest_name: String = quest_info[QUEST_INFO.QUEST_NAME]
				var quest_description: String = quest_info[QUEST_INFO.QUEST_DESCRIPTION]
				var quest_dictionary_info: Dictionary = quest_info[QUEST_INFO.QUEST_DICTIONARY]
				var quest_npc: Node2D = dialog_dictionary["npc"]
				
				get_tree().call_group("gui", "populate_quest_slot", quest_name, quest_description, quest_dictionary_info, quest_npc)
				end_dialog(true)
				return
				
			"upgrade":
				end_dialog(false)
				return
				
			"quest_finished":
				dialog_dictionary["npc"].is_quest_finished = true
				dialog_dictionary["npc"].can_finish_quest = false
				
				var quest_info: Array = dialog_dictionary["quest_info"]
				get_tree().call_group("gui", "reset_quest_slot", quest_info[QUEST_INFO.QUEST_NAME])
				end_dialog(false)
				return
				
	if dialog_index + 1 == dialog_dictionary["dialog"].size():
		end_dialog(false)
		return
		
	choice_container.hide()
	
	can_click = false
	can_kill_dialog = false
	
	update_dialog()
	
	
func update_dialog() -> void:
	dialog_index += 1
	update_text()
	
	
func end_dialog(quest_state: bool) -> void:
	emit_signal("end_dialog", quest_state)
	queue_free()
	
	
func break_condition() -> bool:
	if not Input.is_action_just_pressed("ui_interact") or not can_interact:
		return false
		
	return true
	
	
func mouse_interaction(slot: Label, state: String) -> void:
	match state:
		"entered":
			can_click = true
			slot.modulate.a = 0.5
			choice_index = slot.get_index()
			
		"exited":
			choice_index = -1
			can_click = false
			slot.modulate.a = 1.0
			
			
func reset_mouse_state() -> void:
	for button in choice_container.get_children():
		button.modulate.a = 1.0
