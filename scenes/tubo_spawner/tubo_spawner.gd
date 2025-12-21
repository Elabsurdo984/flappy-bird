extends Node2D

@export var PipeScene: PackedScene

var can_spawn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(_on_pipe_timer_timeout)
	$Timer.stop()
	
func enable_spawning() -> void:
	can_spawn = true
	$Timer.start()
	
func _on_pipe_timer_timeout() -> void:
	if can_spawn:
		spawn_pipe()

func spawn_pipe() -> void:
	var pipe = PipeScene.instantiate()
	add_child(pipe)
	
	# Posición X (fuera de la pantalla, a la derecha)
	pipe.position.x = 400  # pon aquí el ancho de tu viewport o un poco más
	
	# Altura aleatoria del hueco
	var min_y := 100
	var max_y := 400
	pipe.position.y = randf_range(min_y, max_y)
