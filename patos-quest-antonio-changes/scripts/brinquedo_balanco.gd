extends Node2D

@onready var _anim: AnimationPlayer = $AnimationPlayer
@onready var _area: Area2D = $Area2D
@onready var _sprite: Sprite2D = $Sprite2D
@onready var _indicator: InteractionIndicator = $Indicador
@onready var _sound: AudioStreamPlayer = $BalancoSound

var _player: Node = null
var _in_area: bool = false
var _active: bool = false

func _ready() -> void:
	_area.body_entered.connect(_on_body_entered)
	_area.body_exited.connect(_on_body_exited)
	_sprite.visible = false
	_indicator.hide_indicator()

func _process(_delta: float) -> void:
	if _in_area and Input.is_action_just_pressed("E"):
		if not _active:
			_start()
		else:
			_stop()

func _start() -> void:
	_active = true
	if _player:
		_player.visible = false
		if _player.has_method("set_physics_process"):
			_player.set_physics_process(false)
		if "velocity" in _player:
			_player.velocity = Vector2.ZERO
	_sprite.visible = true
	_anim.play("ativar")
	_indicator.hide_indicator()
	if _sound:
		_sound.play()

func _stop() -> void:
	_active = false
	_anim.stop()
	_sprite.frame = 0
	_sprite.visible = false
	if _player:
		_player.visible = true
		if _player.has_method("set_physics_process"):
			_player.set_physics_process(true)
	if _in_area:
		_indicator.show_indicator()
	else:
		_indicator.hide_indicator()
	if _sound and _sound.playing:
		_sound.stop()

func _on_body_entered(body: Node) -> void:
	if body.name == "gui":
		_player = body
		_in_area = true
		if not _active:
			_indicator.show_indicator()

func _on_body_exited(body: Node) -> void:
	if body == _player:
		_in_area = false
		_indicator.hide_indicator()
		if _active:
			_stop()
		_player = null
