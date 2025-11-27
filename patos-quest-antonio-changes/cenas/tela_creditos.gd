extends ScrollContainer

@export var text_node : RichTextLabel
@export_range(1, 10000, 0.1) var credits_time : float = 10
@export_range(0, 10000, 0.1) var margin_increment : float = 0

@onready var margin : MarginContainer = $MarginContainer

func _ready() -> void:
	await get_tree().process_frame

	var text_box_size = text_node.size.y
	var window_size = DisplayServer.window_get_size().y

	margin.add_theme_constant_override("margin_top", window_size + margin_increment)
	margin.add_theme_constant_override("margin_bottom", window_size + margin_increment)
	
	
	var scroll_amount : int = ceil(text_box_size * 1/4 + window_size * 1.5 + margin_increment)
	var tween = create_tween()
	tween.tween_property(
		self,
		"scroll_vertical",
		scroll_amount,
		credits_time
	)
	tween.finished.connect(_acabou)

func _acabou() -> void:
	get_tree().change_scene_to_file("res://cenas/menu_principal.tscn")
