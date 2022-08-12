extends TextureRect
class_name QuestSlot

signal send_quest_info

onready var slot_index: int = get_index()
onready var quest_name_label: Label = get_node("QuestName")

var quest_name: String = ""
var quest_description: String = ""

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
		
		
func update_slot(slot_quest_name: String, slot_quest_description: String) -> void:
	quest_name_label.text = slot_quest_name
	
	quest_name = slot_quest_name
	quest_description = slot_quest_description
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_click") and can_click:
		emit_signal("send_quest_info", quest_name, quest_description)
