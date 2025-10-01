extends Node2D
class_name GameLevel

const _DIALOG_SCREEN: PackedScene = preload("res://dialog_screen.tscn")

var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://personagens/3x4_Dona_Lucia.png",
		"dialog": "Olá Gui, vá conhecer a praça hoje",
		"title": "Dona Lúcia"
	},
	1: {
		"faceset": "res://personagens/3x4_Dona_Lucia.png",
		"dialog": "Tchau!Te amo!!!",
		"title": "Dona Lúcia"
	}
}

@export_category("Objects")
@export var _hud: CanvasLayer = null
var dialogue1 = preload("res://conversa.dialogue")
var player_in_area := false
var id: int = 0
var dialog := 1
 
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	DialogueManager.show_example_dialogue_balloon(dialogue1, "bom_dia")

func _process(_delta: float) -> void: 
	if Input.is_action_just_pressed("ui_select"):
		for child in _hud.get_children():
			if child is DialogScreen:
				return
		var _new_dialog = _DIALOG_SCREEN.instantiate() as DialogScreen
		_new_dialog.data = _dialog_data
		_hud.add_child(_new_dialog)
		
	if player_in_area and Input.is_action_just_pressed("E"):
		if id == 1: DialogueManager.show_example_dialogue_balloon(dialogue1, "DG") 
		elif id == 2: DialogueManager.show_example_dialogue_balloon(dialogue1, "claraAurora") 
		elif id == 3: DialogueManager.show_example_dialogue_balloon(dialogue1, "luiza") 
		elif id == 4: DialogueManager.show_example_dialogue_balloon(dialogue1, "francisco") 
		elif id == 5: DialogueManager.show_example_dialogue_balloon(dialogue1, "miguel")

func _on_npc_1_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 1
		player_in_area = true
		
func _on_npc_2_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 2
		player_in_area = true

func _on_npc_3_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 3
		player_in_area = true

func _on_npc_4_body_entered(body: Node2D) -> void:
	
	if body.name == "gui":
		id = 4
		player_in_area = true

func _on_npc_5_body_entered(body: Node2D) -> void:

	if body.name == "gui":
		id = 5
		player_in_area = true

func _on_npc_1_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 1 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(1)
			_check_phase_change()
		id = 0
		
func _on_npc_2_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 2 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(2)
			_check_phase_change()
		id = 0

func _on_npc_3_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 3 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(3)
			_check_phase_change()
		id = 0

func _on_npc_4_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 4 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(4)
			_check_phase_change()
		id = 0

func _on_npc_5_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 5 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(5)
			_check_phase_change()
		id = 0
		
func _check_phase_change() -> void:
	if Globals.npc_dialog >= 5:
		await get_tree().create_timer(2.5).timeout
		_change_level()

func _change_level() -> void:
	get_tree().change_scene_to_file("res://cenas/level_2.tscn")
