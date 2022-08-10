extends CanvasLayer
class_name GUI

const DIALOG: PackedScene = preload("res://scenes/general/interface/dialog.tscn")

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
