extends Area2D

@export var speed: float = 200.0
@export var game_over_scene: PackedScene

var score_counted: bool = false  # Para evitar contar el puntaje múltiples veces
var has_collided: bool = false  # Para evitar múltiples colisiones

func _ready() -> void:
	# Asegurarse de que el tubo se procese incluso cuando el juego está pausado
	# para que termine su animación de muerte
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -600:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Evitar múltiples colisiones
	if has_collided:
		return
	
	if body.is_in_group("player"):
		has_collided = true
		
		# Detener el movimiento del jugador
		body.set_physics_process(false)
		
		# Detener el spawner de tubos
		var spawner = get_tree().get_first_node_in_group("tubo_spawner")
		if spawner:
			spawner.set_physics_process(false)
		
		# Reproducir sonido de choque
		if has_node("HitSound"):
			$HitSound.process_mode = Node.PROCESS_MODE_ALWAYS
			$HitSound.play()
			# Esperar a que termine el sonido
			await $HitSound.finished
		else:
			# Si no hay sonido, esperar un poco de todos modos
			await get_tree().create_timer(0.3).timeout
		
		# Cambiar a la escena de Game Over
		get_tree().change_scene_to_packed(game_over_scene)

func _on_score_area_body_entered(body: Node2D) -> void:
	# Cuando el jugador pasa por el área de puntaje
	if body.is_in_group("player") and not score_counted:
		score_counted = true
		GameManager.add_score()
		
		# Reproducir sonido de punto si existe
		if has_node("ScoreSound"):
			$ScoreSound.play()
		
		print("¡Punto! Puntaje actual: ", GameManager.get_score())
