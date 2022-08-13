extends Node2D
class_name Npc

var faceset: Dictionary = {}

var info_list: Array

var is_on_quest: bool = false
var is_interacting: bool = false
var can_finish_quest: bool = false
var is_quest_finished: bool = false

var player: KinematicBody2D = null

var quest_info: Array = []
var initial_dialog: Array = []
var alternative_dialog: Array = []
var finish_quest_dialog: Array = []

func _process(_delta: float) -> void:
	if player == null:
		return
		
	interact()
	
	
func interact() -> void:
	if can_finish_quest and Input.is_action_just_pressed("ui_interact") and not is_interacting:
		var finish_quest_list: Array = []
		finish_quest_list.append(faceset)
		finish_quest_list.append(finish_quest_dialog)
		finish_quest_list.append(quest_info)
		finish_quest_list.append(self)
		
		player.sleep(false)
		is_interacting = true
	
		get_tree().call_group("gui", "select_container", self, "dialog", finish_quest_list)
		
	if (is_on_quest or is_quest_finished) and Input.is_action_just_pressed("ui_interact") and not is_interacting:
		var alternative_list: Array = []
		alternative_list.append(faceset)
		alternative_list.append(alternative_dialog)
		alternative_list.append([])
		alternative_list.append(self)
		
		get_tree().call_group("gui", "select_container", self, "dialog", alternative_list)
		
		player.sleep(false)
		is_interacting = true
	
	if not is_on_quest and Input.is_action_just_pressed("ui_interact") and not is_interacting:
		get_tree().call_group("gui", "select_container", self, "dialog", info_list)
		player.sleep(false)
		is_interacting = true
		
		
func end_interact(quest_state: bool) -> void:
	if not is_on_quest:
		is_on_quest = quest_state
		
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
