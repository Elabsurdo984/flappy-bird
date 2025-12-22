extends Control

@onready var high_score_label: Label = $HighScoreLabel

func _ready() -> void:
	$VBoxContainer/BotonJugar.pressed.connect(_on_pressed_boton_jugar)
	$VBoxContainer/BotonSalir.pressed.connect(_on_pressed_boton_salir)
	$VBoxContainer/BotonTienda.pressed.connect(_on_pressed_boton_tienda)
	$VBoxContainer/BotonConfiguracion.pressed.connect(_on_pressed_boton_configuracion)
	
	# Mostrar el high score
	update_high_score_display()

func update_high_score_display() -> void:
	var high_score = GameManager.get_high_score()
	if high_score_label:
		high_score_label.text = "Mejor Puntaje: " + str(high_score)

func _on_pressed_boton_jugar() -> void:
	get_tree().change_scene_to_file("res://scenes/escena_principal/escena_principal.tscn")

func _on_pressed_boton_salir() -> void:
	get_tree().quit()

func _on_pressed_boton_tienda() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")

func _on_pressed_boton_configuracion() -> void:
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")
