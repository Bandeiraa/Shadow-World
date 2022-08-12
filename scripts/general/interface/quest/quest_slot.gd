extends TextureRect
class_name QuestSlot

signal send_quest_info

onready var slot_index: int = get_index()
onready var quest_name_label: Label = get_node("QuestName")

var quest_name: String = ""
var quest_description: String = ""

var quest_type: String = ""
var quest_goal: String = ""
var quest_current_state: String = ""

var kill_count: int = 0

var is_empty: bool = true
var can_click: bool = false

func _ready() -> void:
	var _exited: bool = connect("mouse_exited", self, "mouse_interaction", ["exited"])
	var _entered: bool = connect("mouse_entered", self, "mouse_interaction", ["entered"])
	
	
func mouse_interaction(state: String) -> void:
	if state == "entered":
		modulate.a = 0.5
		can_click = true
		
	if state == "exited":
		modulate.a = 1.0
		can_click = false
		
		
func update_slot(slot_quest_name: String, slot_quest_description: String, slot_quest_info: Dictionary) -> void:
	is_empty = false
	
	quest_name_label.text = slot_quest_name
	
	quest_name = slot_quest_name
	quest_description = slot_quest_description
	
	var _quest_type: String = slot_quest_info["quest_type"]
	var quest_info: Dictionary = slot_quest_info["quest_info"]
	
	match _quest_type:
		"elimination":
			var amount_to_kill: int = quest_info["amount_to_kill"]
			var monster_to_kill: String = quest_info["monster_to_kill"]
			
			quest_type = "Missão do tipo: Eliminação"
			quest_goal = "Eliminar " + str(amount_to_kill) + " " + monster_to_kill
			quest_current_state = "Monstros eliminados: " + str(kill_count) + "/" + str(amount_to_kill)
			
			
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_click") and can_click and not is_empty:
		emit_signal(
			"send_quest_info", 
			quest_name, 
			quest_description,
			quest_type,
			quest_goal,
			quest_current_state
		)
