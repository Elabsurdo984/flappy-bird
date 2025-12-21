extends Area2D

@export var game_over_scene: PackedScene

var speed: float = 200.0
var score_counted: bool = false  # Para evitar contar el puntaje múltiples veces
var has_collided: bool = false  # Para evitar múltiples colisiones

func _ready() -> void:
	# Asegurarse de que el tubo se procese incluso cuando el juego está pausado
	# para que termine su animación de muerte
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
	# Establecer la velocidad actual basada en el GameManager
	speed = GameManager.get_current_speed()
	
	# Conectar a la señal de aumento de velocidad
	if not GameManager.speed_increased.is_connected(_on_speed_increased):
		GameManager.speed_increased.connect(_on_speed_increased)

func _on_speed_increased(new_speed: float) -> void:
	speed = new_speed
	print("Tubo actualizó velocidad a: ", new_speed)

func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -600:
		queue_free()



func _on_score_area_body_entered(body: Node2D) -> void:
	# Cuando el jugador pasa por el área de puntaje
	if body.is_in_group("player") and not score_counted:
		score_counted = true
		GameManager.add_score()
		
		# Reproducir sonido de punto si existe
		if has_node("ScoreSound"):
			$ScoreSound.play()
		
		print("¡Punto! Puntaje actual: ", GameManager.get_score())


func _on_body_entered(body: Node2D) -> void:
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
		
	# Cambiar a la escena de Game Over
	get_tree().change_scene_to_packed(game_over_scene)
	
func _exit_tree() -> void:
	if GameManager.speed_increased.is_connected(_on_speed_increased):
		GameManager.speed_increased.disconnect(_on_speed_increased)
