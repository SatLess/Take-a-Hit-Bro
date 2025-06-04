class_name MusicManager extends AudioStreamPlayer

var should_loop := false
@export_flags("PartyLights", "Nausea", "Cam_Rotate" , "Color Interpolation","Ghost") var flag = 0


@export var music: AudioStream:
	set(new_val):
		music = new_val
		stream = music
		if new_val is AudioStreamWAV: should_loop = new_val.loop_mode
		elif new_val is AudioStreamOggVorbis: should_loop = new_val.loop

func _ready() -> void:
	play()

func _process(delta: float) -> void:
	var play_pos: float = get_playback_position()
	
	if play_pos >= 4.87 and flag == 0:
		flag = 1 #PartyLights
		EventBus.flag_changed.emit(flag)
		
	if play_pos >= 6 and flag == 1:
		EventBus.flag_changed.emit(flag)
		flag = 2 #PartyLights
	
	if play_pos >= 6 and flag == 2:
		EventBus.flag_changed.emit(flag)
		flag = 3
	
	if play_pos >= 8 and flag == 3:
		EventBus.flag_changed.emit(flag)
