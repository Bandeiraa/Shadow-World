extends Node2D
class_name Blacksmith

const FACESET: Dictionary = {
	"speak": "res://resources/faceset/blacksmith/speaking.tres",
	"idle": "res://resources/faceset/blacksmith/blinking.tres"
}

var info_list: Array

var is_interacting: bool = false
var player: KinematicBody2D = null

export(Array, String) var dialog

func _ready() -> void:
	info_list.append(FACESET)
	info_list.append(dialog)
	
	
func _process(_delta: float) -> void:
	if player == null:
		return
		
	interact()
	
	
func interact() -> void:
	if Input.is_action_just_pressed("ui_interact") and not is_interacting:
		player.sleep(false)
		is_interacting = true
		get_tree().call_group("gui", "select_container", self, "dialog", info_list)
		
		
func end_interact() -> void:
	player.sleep(true)
	is_interacting = false
	
	
func on_npc_body_entered(body: CharacterTemplate) -> void:
	if not body is CharacterTemplate:
		return
		
	player = body
	
	
func on_npc_body_exited(body: CharacterTemplate) -> void:
	if not body is CharacterTemplate:
		return
		
	player = null
