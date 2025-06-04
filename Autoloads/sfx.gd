extends Node2D


var is_tweening: bool = false
@export var pallete: Array[Color]
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

func _ready() -> void:
	EventBus.flag_changed.connect(flag_changed)

func flag_changed(flag: int):
	match flag:
		1: #Party lights:
			canvas_modulate.color = pallete.pick_random()
			await get_tree().create_timer(.24).timeout
			canvas_modulate.color = Color.WHITE
			is_tweening = false
			
		2:
			if is_tweening: return
			is_tweening = true
			var tween := create_tween()
			var cam: Camera2D = get_viewport().get_camera_2d()
			tween = create_tween()
			tween.tween_property(cam,"zoom", Vector2(1.5,1.5),.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
			await  tween.finished
			var tween_2 = create_tween()
			tween_2.tween_property(cam,"zoom", Vector2.ONE,.25)
			await  tween_2.finished
			is_tweening = false
		3:
			if is_tweening: return
			is_tweening = true
			var tween := create_tween()
			var cam: Camera2D = get_viewport().get_camera_2d()
			tween.tween_property(cam,"offset", 358,.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
			#await  tween.finished
			#var tween_2 = create_tween()
			#tween_2.tween_property(cam,"rotation_degrees", 0,.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
			#await  tween_2.finished
			#is_tweening = false
