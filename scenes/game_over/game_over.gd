extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/BotonReinciar.pressed.connect(_on_boton_reiniciar_pressed)
	$VBoxContainer/BotonMenu.pressed.connect(_on_boton_menu_pressed)
	$Puntaje.text = "Puntaje: " + str(GameManager.get_score())
	
func _on_boton_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/escena_principal/escena_principal.tscn")

func _on_boton_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
