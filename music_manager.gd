class_name MusicManager extends AudioStreamPlayer

var should_loop := false

@export var music: AudioStream:
	set(new_val):
		music = new_val
		stream = music
		if new_val is AudioStreamWAV: should_loop = new_val.loop_mode
		elif new_val is AudioStreamOggVorbis: should_loop = new_val.loop

func _ready() -> void:
	play()
