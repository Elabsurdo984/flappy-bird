extends CanvasLayer

@onready var resume_button: Button = $Control/VBoxContainer/ResumeButton
@onready var reiniciar_button: Button = $Control/VBoxContainer/ReiniciarButton
@onready var config_button: Button = $Control/VBoxContainer/ConfigButton
@onready var menu_button: Button = $Control/VBoxContainer/MenuButton

func _ready() -> void:
	resume_button.pressed.connect(_on_resume_pressed)
	reiniciar_button.pressed.connect(_on_reiniciar_pressed)
	config_button.pressed.connect(_on_config_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausar"):
		pause_game()

func pause_game() -> void:
	show()
	get_tree().paused = true

func resume_game():
	hide()
	get_tree().paused = false

func _on_resume_pressed() -> void:
	resume_game()

func _on_reiniciar_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_score()
	get_tree().reload_current_scene()

func _on_config_pressed() -> void:
	var settings = get_parent().get_node_or_null("Settings")
	if settings and settings.has_method("show_settings"):
		settings.show_settings()
	else:
		print("ERROR: No se pudo encontrar el nodo Settings desde PauseMenu")

func _on_menu_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_score()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
