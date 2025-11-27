extends Node2D
class_name level_2

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

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	# DialogueManager.show_example_dialogue_balloon(dialogue1, "bom_dia")
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		for child in _hud.get_children():
			if child is DialogScreen:
				return
		var _new_dialog = _DIALOG_SCREEN.instantiate() as DialogScreen
		_new_dialog.data = _dialog_data
		_hud.add_child(_new_dialog)
