extends Area2D

@export var spritesheet: Texture2D
@export var frames: int = 6
@export var frame_size: Vector2i = Vector2i.ZERO
@export var fps: float = 12.0

@export var spawn_position: Vector2 = Vector2.ZERO
@export var use_global_position: bool = false

@export var trigger_once: bool = false
@export var player_group: StringName = "player"

var _triggered := false

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if not body.is_in_group(player_group):
        return
    if trigger_once and _triggered:
        return
    _triggered = true

    if spritesheet == null:
        push_warning("spritesheet não definido")
        return

    var tex_size: Vector2i = spritesheet.get_size()
    var fs := frame_size
    if fs == Vector2i.ZERO:
        fs = Vector2i(tex_size.x / max(frames, 1), tex_size.y)

    var frames_res := SpriteFrames.new()
    frames_res.add_animation("default")
    frames_res.set_animation_loop("default", false)
    frames_res.set_animation_speed("default", fps)

    for i in range(frames):
        var region := Rect2i(i * fs.x, 0, fs.x, fs.y)
        var atlas := AtlasTexture.new()
        atlas.atlas = spritesheet
        atlas.region = region
        frames_res.add_frame("default", atlas)

    var anim := AnimatedSprite2D.new()
    anim.sprite_frames = frames_res
    anim.animation = "default"
    anim.play()
    anim.animation_finished.connect(func(_name): anim.queue_free())

    var pos := spawn_position
    if not use_global_position:
        pos = global_position + pos
    anim.global_position = pos

    get_tree().current_scene.add_child(anim)

