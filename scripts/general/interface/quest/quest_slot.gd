extends TextureRect
class_name QuestSlot

var quest_name: String = ""
var quest_description: String = ""

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
		
		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_click") and can_click:
		pass
