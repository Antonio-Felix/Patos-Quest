extends Control

@onready var npc_counter: Label = $container/npc_container/npc_counter as Label

func _ready() -> void:
	npc_counter.text = str("%02d" % Globals.npc_dialog)

func _process(_delta: float) -> void:
	npc_counter.text = str("%02d" % Globals.npc_dialog)
