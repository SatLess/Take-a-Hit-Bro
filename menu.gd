extends Node2D


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		const GAME = preload("uid://deiamoctdlp6g")
		var a = GAME.instantiate()
		get_parent().add_child(a)
		queue_free()
