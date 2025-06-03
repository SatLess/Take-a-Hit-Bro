class_name DialogueResource extends Resource

@export var line_list : Array[Dialogue_Line]

func get_total_lines():
	return line_list.size()

func get_if_not_skippable(idx: int):
	return line_list[idx].not_skippable

func get_all_text():
	return line_list
