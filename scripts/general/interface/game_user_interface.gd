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
	if not global_info.is_alive:
		return
		
	handle_quest_container()
	
	
func handle_quest_container() -> void:
	var on_action: bool = quest_container.on_action
	if Input.is_action_just_pressed("ui_quest") and not on_action:
		global_info.is_on_menu = true
		quest_container.play_animation("show_container")
		return
		
	if Input.is_action_just_pressed("ui_quest") and on_action:
		global_info.is_on_menu = false
		quest_container.play_animation("hide_container")
		return
		
		
func populate_quest_slot(quest_name: String, quest_description: String, quest_info: Dictionary) -> void:
	quest_container.populate_quest_slot(quest_name, quest_description, quest_info)
	
	
func update_quest_slot(target: String) -> void:
	quest_container.update_slot(target)
