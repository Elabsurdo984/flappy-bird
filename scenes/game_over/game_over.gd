extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/BotonReinciar.pressed.connect(_on_boton_reiniciar_pressed)

func _on_boton_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/escena_principal/escena_principal.tscn")
