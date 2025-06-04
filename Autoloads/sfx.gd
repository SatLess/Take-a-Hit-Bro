extends Node2D


var is_tweening: bool = false
@export var pallete: Array[Color]
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var timer: Timer = $Timer



func _ready() -> void:
	randomize()
	EventBus.flag_changed.connect(flag_changed)
	timer.timeout.connect(timeout)

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
			tween.tween_property(cam,"zoom", Vector2(1.5,1.5),.4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
			await  tween.finished
			var tween_2 = create_tween()
			tween_2.tween_property(cam,"zoom", Vector2.ONE,.4)
			await  tween_2.finished
			is_tweening = false
		3:
			if is_tweening: return
			$AnimationPlayer.play("roatie")
			await  $AnimationPlayer.animation_finished
			$AnimationPlayer.play("new_animation")
			timer.start()

func timeout():
	var rng = randi_range(0,3)
	if rng == 0:
			if $"../Player".can_move == false: 
				timeout()
				return
			if is_tweening: return
			is_tweening = true
			var tween := create_tween()
			var cam: Camera2D = get_viewport().get_camera_2d()
			tween = create_tween()
			tween.tween_property(cam,"zoom", Vector2(1.5,1.5),.43).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
			await  tween.finished
			var tween_2 = create_tween()
			tween_2.tween_property(cam,"zoom", Vector2.ONE,.43)
			await  tween_2.finished
			is_tweening = false
	elif rng == 1:
		if is_tweening: return
		is_tweening = true
		var a = create_tween()
		a.tween_property(canvas_modulate,"color",pallete.pick_random(),.5)
		await  a.finished
		canvas_modulate.color = Color.WHITE
		is_tweening = false
	elif  rng == 3:
		if $"../Player".can_move == false: 
			timeout()
			return
		print("oi")
		if is_tweening: return
		is_tweening = true
		var tween := create_tween()
		var cam: Camera2D = get_viewport().get_camera_2d()
		tween = create_tween()
		tween.tween_property(cam,"rotation_degrees", 350,1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
		await  tween.finished
		var tween_2 = create_tween()
		tween_2.tween_property(cam,"rotation_degrees", 0,1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
		await  tween_2.finished
		is_tweening = false
