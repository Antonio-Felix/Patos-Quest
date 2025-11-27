extends Node2D

@export var player_group: StringName = "player"
@export var play_on_enter: bool = true
@export var stop_on_exit: bool = true
@export var hide_when_idle: bool = true
@export var spawn_offset: Vector2 = Vector2.ZERO
@export var animation_name: StringName = "ativar"

@onready var _area: Area2D = $Area2D
@onready var _anim: AnimationPlayer = $AnimationPlayer
@onready var _sprite: Sprite2D = $Sprite2D

func _ready() -> void:
    if is_instance_valid(_area):
        _area.body_entered.connect(_on_body_entered)
        _area.body_exited.connect(_on_body_exited)
    _sprite.position = spawn_offset
    if hide_when_idle:
        _sprite.visible = false

func _on_body_entered(body: Node) -> void:
    if not body.is_in_group(player_group):
        return
    if play_on_enter:
        if hide_when_idle:
            _sprite.visible = true
        _anim.play(animation_name)

func _on_body_exited(body: Node) -> void:
    if not body.is_in_group(player_group):
        return
    if stop_on_exit:
        _anim.stop()
        _reset_sprite_frame()
        if hide_when_idle:
            _sprite.visible = false

func _reset_sprite_frame() -> void:
    # Sprite2D em Godot 4 tem propriedade `frame` quando hframes/vframes > 1
    if _sprite.hframes > 1 or _sprite.vframes > 1:
        _sprite.frame = 0
