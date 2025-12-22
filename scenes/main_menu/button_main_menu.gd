extends Control

func _ready() -> void:
	$VBoxContainer/BotonJugar.pressed.connect(_on_pressed_boton_jugar)
	$VBoxContainer/BotonSalir.pressed.connect(_on_pressed_boton_salir)
	$VBoxContainer/BotonTienda.pressed.connect(_on_pressed_boton_tienda)
	$VBoxContainer/BotonConfiguracion.pressed.connect(_on_pressed_boton_configuracion)

func _on_pressed_boton_jugar() -> void:
	get_tree().change_scene_to_file("res://scenes/escena_principal/escena_principal.tscn")

func _on_pressed_boton_salir() -> void:
	get_tree().quit()

func _on_pressed_boton_tienda() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")

func _on_pressed_boton_configuracion() -> void:
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")
