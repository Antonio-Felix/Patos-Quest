extends CharacterBody2D
class_name BaseCharacter

@export var _move_speed: float = 128.0
@export var _animation: AnimationPlayer
@export var cont: float = 0
@onready var _step_player: AudioStreamPlayer = $StepPlayer
@export var _step_sounds: Array[AudioStream] = []
var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	_rng.randomize()

func _physics_process(_delta: float) -> void:
	_animate()
	if Globals.dialog_active:
		velocity = Vector2.ZERO
		return
	_move()
	_handle_step_sound()

func _move() -> void:
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = dir * _move_speed
	move_and_slide()

func _animate() -> void:
	if velocity.x > 0:
		_animation.play("andando_direita")
		cont = 1
		return

	if velocity.x < 0:
		_animation.play("andando_esquerda")
		cont = 2
		return

	if velocity.y > 0:
		_animation.play("andando_baixo")
		cont = 3
		return

	if velocity.y < 0:
		_animation.play("andando_cima")
		cont = 4
		return

	if cont == 1:
		_animation.play("parado_lado_direito")
		return

	if cont == 2:
		_animation.play("parado_lado_esquerdo")
		return

	if cont == 3:
		_animation.play("parado_frente")
		return

	if cont == 4:
		_animation.play("parado_costa")
		return

func _handle_step_sound() -> void:
	if velocity.length_squared() > 0.01:
		if _step_player and not _step_player.playing:
			_play_random_step()
	else:
		if _step_player and _step_player.playing:
			_step_player.stop()

func _play_random_step() -> void:
	if _step_sounds.is_empty():
		return
	var index := _rng.randi_range(0, _step_sounds.size() - 1)
	var stream: AudioStream = _step_sounds[index]
	if stream:
		_step_player.stream = stream
		_step_player.play()
