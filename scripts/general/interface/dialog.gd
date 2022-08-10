extends Control
class_name Dialog

signal end_dialog

onready var faceset: TextureRect = get_node("Background/Faceset")
onready var dialog_label: RichTextLabel = get_node("Background/Text")

var dialog_index: int = 0
var can_interact: bool = false

var dialog_dictionary: Dictionary = {
	"faceset": {},
	"dialog": []
}

func set_info(info_list: Array) -> void:
	var faceset_info: Dictionary = info_list[0]
	var dialog_info: Array = info_list[1]
	
	dialog_dictionary["faceset"] = faceset_info
	dialog_dictionary["dialog"] = dialog_info
	
	set_texture("idle")
	update_text()
	
	
func update_text() -> void:
	can_interact = false
	
	set_texture("speak")
	dialog_label.percent_visible = 0
	dialog_label.text = dialog_dictionary["dialog"][dialog_index]
	
	while dialog_label.percent_visible < 1:
		dialog_label.percent_visible += get_process_delta_time() 
		yield(get_tree(), "idle_frame")
		
	can_interact = true
	set_texture("idle")
	
	
func set_texture(new_state: String) -> void:
	faceset.texture = load(dialog_dictionary["faceset"][new_state])
	
	
func _process(_delta: float) -> void:
	if not break_condition():
		return
		
	if dialog_index + 1 < dialog_dictionary["dialog"].size():
		dialog_index += 1
		update_text()
		return
		
	emit_signal("end_dialog")
	queue_free()
	
	
func break_condition() -> bool:
	if not Input.is_action_just_pressed("interact") or not can_interact:
		return false
		
	return true
