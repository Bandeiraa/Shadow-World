extends EnemyTexture
class_name HedgehogTexture

var texture_base_path: String = "res://assets/enemies/hedgehog/"
var current_type: String = ""

var type_list: Array = [
	"type_1",
	"type_2"
]

func _ready() -> void:
	randomize()
	current_type = type_list[randi() % type_list.size()]
	
	
func _process(_delta: float) -> void:
	texture = load(texture_base_path + current_type + texture_suffix)
