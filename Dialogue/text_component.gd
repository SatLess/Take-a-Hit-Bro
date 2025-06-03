class_name TextComponent extends RichTextLabel

signal list_finished()

@onready var char_timer: Timer = $CharTimer

@export var res: DialogueResource
@export var char_speed : float = 0.01

var idx : int = 0
var total_lines: int = 0
var line_list : Array[Dialogue_Line]
var line_finished: bool = false
#var line_not_skippable: bool = false

func _ready() -> void:
	#EventBus.MovementToggled.emit()
	visible_characters = 0

func setup(dialogue_list: DialogueResource):
	line_finished = false
	idx = 0
	char_timer.wait_time = char_speed
	res = dialogue_list
	total_lines = res.get_total_lines()
	line_list = res.get_all_text()
	_show_line()

func _show_line():
	visible_characters = 0
	if idx >= total_lines: 
		list_finished.emit()
		return
	line_finished = false
	#line_not_skippable = res.get_if_not_skippable(idx)
	var line = line_list[idx].line
	text = line
	while visible_characters != line.length():
		if line_finished: 
			visible_characters = line.length()
			break
		visible_characters += 1
		char_timer.start()
		await char_timer.timeout
	idx += 1
	line_finished = true
	#if line_not_skippable: wait_for_timer()


func respond_to_input():
	if line_finished: _show_line()
	else: line_finished = true

func has_exceeded_list():
	return idx >= total_lines

#func wait_for_timer():
	#skip_timer.start()
	#await skip_timer.timeout
	#_show_line()

#func is_skippable():
	#return line_not_skippable 
