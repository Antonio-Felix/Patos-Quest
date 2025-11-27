extends Control

@onready var coins_counter: Label = $container/coins_container/coins_counter as Label

func _ready() -> void:
	coins_counter.text = str("%04d" % Globals.coins)

func _process(_delta: float) -> void:
	coins_counter.text = str("%04d" % Globals.coins)
