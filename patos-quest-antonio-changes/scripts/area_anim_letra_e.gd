extends Node2D
class_name InteractionIndicator

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide_indicator()

func show_indicator() -> void:
	_sprite.visible = true
	if not _anim.is_playing():
		_anim.play("loop")

func hide_indicator() -> void:
	_anim.stop()
	_sprite.frame = 0
	_sprite.visible = false
