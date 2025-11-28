extends TextureRect

@export var action_name: String = "E"

var touch_id: int = -1
var is_pressed: bool = false

signal pressed
signal released


func _ready() -> void:
	# Igual ao joystick: se não for touchscreen, some da tela (opcional)
	if not DisplayServer.is_touchscreen_available():
		visible = false


func _input(event: InputEvent) -> void:
	# Toque na tela (pressionar / soltar)
	if event is InputEventScreenTouch:
		# Pressionou um dedo
		if event.pressed and touch_id == -1 and get_global_rect().has_point(event.position):
			touch_id = event.index
			is_pressed = true
			_on_button_pressed()

		# Soltou o mesmo dedo
		elif not event.pressed and event.index == touch_id:
			is_pressed = false
			touch_id = -1
			_on_button_released()


func _on_button_pressed() -> void:
	# Dispara ação do InputMap (como se fosse uma tecla apertada)
	if action_name != "":
		Input.action_press(action_name)

	# Aqui você pode mudar a aparência (efeito de "apertado")
	# Exemplo: escurecer um pouco o botão
	modulate = Color(0.667, 0.667, 0.667, 1.0)

	emit_signal("pressed")


func _on_button_released() -> void:
	# Solta a action
	if action_name != "":
		Input.action_release(action_name)

	# Volta a aparência normal
	modulate = Color(1, 1, 1, 1)

	emit_signal("released")
