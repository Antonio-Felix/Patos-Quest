extends CharacterBody2D
class_name BaseCharacter

@export var _move_speed: float = 128.0
@export var _animation: AnimationPlayer
@export var cont: float = 0


func _physics_process(_delta: float) -> void:
	_move()
	_animate()

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
