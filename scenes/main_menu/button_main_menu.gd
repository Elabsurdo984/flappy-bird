extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/BotonJugar.pressed.connect(_on_pressed_boton_jugar)
	$VBoxContainer/BotonSalir.pressed.connect(_on_pressed_boton_salir)

func _on_pressed_boton_jugar() -> void:
	get_tree().change_scene_to_file("res://scenes/escena_principal/escena_principal.tscn")

func _on_pressed_boton_salir() -> void:
	get_tree().quit()
