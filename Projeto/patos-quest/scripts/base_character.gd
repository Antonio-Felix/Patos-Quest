extends CharacterBody2D
class_name BaseCharacter

@export_category("Variables")
@export var _move_speed: float = 128.0
@export var cont: float = 0
var id: int = 0
var player_in_area := false
var dialog := 1

@export_category("Objects")
@export var _animation: AnimationPlayer

var dialogue1 = preload("res://conversa.dialogue")

func _process(_delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("E"):
		if id == 1:
			DialogueManager.show_example_dialogue_balloon(dialogue1, "DG")
		elif id == 2:
			DialogueManager.show_example_dialogue_balloon(dialogue1, "claraAurora")
		elif id == 3:
			DialogueManager.show_example_dialogue_balloon(dialogue1, "luiza")
		elif id == 4:
			DialogueManager.show_example_dialogue_balloon(dialogue1, "francisco")
		elif id == 5:
			DialogueManager.show_example_dialogue_balloon(dialogue1, "miguel")

func _physics_process(_delta: float) -> void:
	_move()
	_animate()

func _move() -> void:
	var _direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down") 
	velocity = _direction * _move_speed
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

func _check_phase_change():
	if Globals.npc_dialog >= 1:
		await get_tree().create_timer(2.5).timeout
		call_deferred("_change_level")

func _change_level():
	get_tree().change_scene_to_file("res://cenas/level_2.tscn")
	
func _on_npc_1_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 1
		player_in_area = true
		
func _on_npc_2_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 2
		player_in_area = true

func _on_npc_3_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 3
		player_in_area = true

func _on_npc_4_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 4
		player_in_area = true

func _on_npc_5_body_entered(body: Node2D) -> void:
	if body.name == "gui":
		id = 5
		player_in_area = true

func _on_npc_1_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 1 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(1)
			_check_phase_change()
		id = 0
		
func _on_npc_2_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 2 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(2)
			_check_phase_change()
		id = 0

func _on_npc_3_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 3 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(3)
			_check_phase_change()
		id = 0

func _on_npc_4_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 4 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(4)
			_check_phase_change()
		id = 0

func _on_npc_5_body_exited(body: Node2D) -> void:
	if body.name == "gui":
		player_in_area = false
		if 5 not in Globals.npc_ids_contabilizados:
			Globals.npc_dialog += 1
			Globals.npc_ids_contabilizados.append(5)
			_check_phase_change()
		id = 0
