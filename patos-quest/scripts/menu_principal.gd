extends Control

func _on_btn_comecar_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/game_level.tscn")
	
func _on_btn_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/tela_creditos.tscn")

func _on_btn_sobre_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/sobre.tscn")

func _on_btn_sair_pressed() -> void:
	get_tree().quit()
