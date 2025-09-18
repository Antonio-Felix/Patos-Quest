extends Control

@onready var coins_counter: Label = $container/coins_container/coins_counter as Label
@onready var npc_counter: Label = $container/npc_container/npc_counter as Label

func _ready() -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	npc_counter.text = str("%02d" % Globals.npc_dialog)

func _process(_delta: float) -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	npc_counter.text = str("%02d" % Globals.npc_dialog)
