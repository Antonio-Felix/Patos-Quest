extends Node2D
class_name GameLevel

const _DIALOG_SCREEN: PackedScene = preload("res://dialog_screen.tscn")

@onready var move_joystick: Control = %move_joystick
@onready var touch_screen_button: TouchScreenButton = %TouchScreenButton

@export_category("Objects")
var dialogue1 = preload("res://conversa.dialogue")
var player_in_area := false
var id: int = 0
var dialog := 1
var interaction_used := false

@onready var _npc_indicators := {
	1: $"npcs/NPC1/Indicador",
	2: $"npcs/NPC2/Indicador",
	3: $"npcs/NPC3/Indicador",
	4: $"npcs/NPC4/Indicador",
	5: $"npcs/NPC5/Indicador",
}

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	DialogueManager.show_example_dialogue_balloon(dialogue1, "bom_dia")
	DialogueManager.dialogue_started.connect(_on_dialog_start)
	DialogueManager.dialogue_ended.connect(_on_dialog_end)

func _on_dialog_start(_resource: DialogueResource):
	Globals.dialog_active = true
	if move_joystick:
		move_joystick.visible = false
		touch_screen_button.visible = false

func _on_dialog_end(_resource: DialogueResource):
	Globals.dialog_active = false
	if move_joystick:
		move_joystick.visible = true
		touch_screen_button.visible = true
	
func _process(_delta: float) -> void: 
	if player_in_area and not interaction_used and Input.is_action_just_pressed("E"):
		interaction_used = true
		Globals.dialog_active = true
		_set_indicator(id, false)

		if id == 1: DialogueManager.show_example_dialogue_balloon(dialogue1, "DG") 
		elif id == 2: DialogueManager.show_example_dialogue_balloon(dialogue1, "claraAurora") 
		elif id == 3: DialogueManager.show_example_dialogue_balloon(dialogue1, "luiza") 
		elif id == 4: DialogueManager.show_example_dialogue_balloon(dialogue1, "francisco") 
		elif id == 5: DialogueManager.show_example_dialogue_balloon(dialogue1, "miguel")

func _set_indicator(npc_id: int, active: bool) -> void:
	if npc_id in _npc_indicators:
		var indicator: InteractionIndicator = _npc_indicators[npc_id]
		if indicator:
			if active:
				indicator.show_indicator()
			else:
				indicator.hide_indicator()

func _on_npc_1_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 1
		player_in_area = true
		interaction_used = false
		_set_indicator(1, true)

func _on_npc_2_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 2
		player_in_area = true
		interaction_used = false
		_set_indicator(2, true)

func _on_npc_3_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 3
		player_in_area = true
		interaction_used = false
		_set_indicator(3, true)

func _on_npc_4_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 4
		player_in_area = true
		interaction_used = false
		_set_indicator(4, true)

func _on_npc_5_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 5
		player_in_area = true
		interaction_used = false
		_set_indicator(5, true)

func _on_npc_1_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		interaction_used = false
		_set_indicator(1, false)
		if 1 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(1)
			_check_phase_change()
		id = 0

func _on_npc_2_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		interaction_used = false
		_set_indicator(2, false)
		if 2 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(2)
			_check_phase_change()
		id = 0

func _on_npc_3_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		interaction_used = false
		_set_indicator(3, false)
		if 3 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(3)
			_check_phase_change()
		id = 0

func _on_npc_4_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		interaction_used = false
		_set_indicator(4, false)
		if 4 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(4)
			_check_phase_change()
		id = 0

func _on_npc_5_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		interaction_used = false
		_set_indicator(5, false)
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
