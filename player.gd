extends CharacterBody2D

@export var speed := 300.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactCast: RayCast2D = $Interactable
var can_move: bool = true

func _ready() -> void:
	EventBus.player_stopped.connect(func(): can_move = false)
	EventBus.player_happy.connect(func(): can_move = true)

func _physics_process(delta: float) -> void:
	_move()
	move_and_slide()

func _process(delta: float) -> void:
	if velocity:
		sprite.flip_h = true if velocity.x < 0 else false
		sprite.play("walking")
	else: sprite.play("idle")
	if not interactCast.is_colliding(): 
		$AnimatedSprite2D.material = null
		return
	$AnimatedSprite2D.material = load("res://pqp.tres")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_handle_raycast()

func _move():
	var direction := Input.get_vector("ui_left", "ui_right","ui_up","ui_down") if can_move else Vector2.ZERO
	if(direction.length() == 1): interactCast.rotation = direction.angle()
	velocity = direction * speed if direction  else Vector2.ZERO

func _handle_raycast():
	if not interactCast.is_colliding(): 
		modulate = Color.WHITE
		return
	modulate = Color.PURPLE
	var collider : Interactable = interactCast.get_collider()
	collider.interact.call()
