extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/BotonReinciar.pressed.connect(_on_boton_reiniciar_pressed)
	$VBoxContainer/BotonMenu.pressed.connect(_on_boton_menu_pressed)
	$Puntaje.text = "Puntaje: " + str(GameManager.get_score())
	
func _on_boton_reiniciar_pressed() -> void:
	SceneManager.go_to_game()

func _on_boton_menu_pressed() -> void:
	SceneManager.go_to_main_menu()
