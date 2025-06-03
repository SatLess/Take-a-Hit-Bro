extends NinePatchRect

@onready var text_component : TextComponent  = $TextComponent
@export var res: DialogueResource

func _ready() -> void:
	#text_component.setup(res)
	hide()
	text_component.list_finished.connect(func():
		#
		hide()
		EventBus.player_happy.emit()
		#EventBus.Dialogue_Finished.emit()
		
		)

func _input(event: InputEvent) -> void:
	#if text_component.is_skippable(): 
		#accept_event()
		#return
	if Input.is_action_just_pressed("ui_accept") and visible: #TODO THIS SUCKS
		accept_event()
		text_component.respond_to_input()

func dialogue_start(dialog: DialogueResource):
	show()
	EventBus.player_stopped.emit()
	text_component.setup(dialog)
