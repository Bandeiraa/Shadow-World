extends CanvasLayer
class_name GUI

const DIALOG: PackedScene = preload("res://scenes/general/interface/dialog.tscn")

onready var quest_container: Control = get_node("QuestContainer")

func select_container(object, type: String, info_list: Array) -> void:
	var target_scene = null
	match type:
		"dialog":
			target_scene = spawn_container(DIALOG)
			target_scene.set_info(info_list)
			target_scene.connect("end_dialog", object, "end_interact")
			
			
func spawn_container(container_scene: PackedScene):
	var scene = container_scene.instance()
	add_child(scene)
	
	return scene
	
	
func _process(_delta: float) -> void:
	handle_quest_container()
	
	
func handle_quest_container() -> void:
	var on_action: bool = quest_container.on_action
	if Input.is_action_just_pressed("ui_quest") and not on_action:
		quest_container.play_animation("show_container")
		return
		
	if Input.is_action_just_pressed("ui_quest") and on_action:
		quest_container.play_animation("hide_container")
		return
