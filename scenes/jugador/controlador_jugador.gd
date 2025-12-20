extends CharacterBody2D

var gravity: float = 900.0
var jump_force: float = -280.0  # Negativo porque en Godot el eje Y crece hacia abajo
var can_play: bool = false

@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var sprite: Sprite2D = $Pajaro

func _ready() -> void:
	var skin_texture = load(GameManager.get_current_skin())
	if skin_texture:
		sprite.texture = skin_texture
		
		
func enable_gameplay() -> void:
	can_play = true
	
func _physics_process(delta: float) -> void:
	if not can_play:
		return
	
	# Aplicar gravedad (que lo hace caer)
	velocity.y += gravity * delta

	# Saltar al presionar la flecha arriba
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_force
		
		jump_sound.play()

	# Mover el pájaro con la velocidad calculada
	move_and_slide()
