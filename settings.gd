extends Control

@onready var music_slider: HSlider = $VBoxContainer/MusicContainer/MusicSlider
@onready var sfx_slider: HSlider = $VBoxContainer/SFXContainer/SFXSlider
@onready var music_label: Label = $VBoxContainer/MusicContainer/MusicLabel
@onready var sfx_label: Label = $VBoxContainer/SFXContainer/SFXLabel
@onready var back_button: Button = $BackButton
@onready var test_sfx: AudioStreamPlayer = $TestSFX

func _ready() -> void:
	# Configurar sliders
	music_slider.min_value = 0.0
	music_slider.max_value = 1.0
	music_slider.step = 0.01
	music_slider.value = GameManager.get_music_volume()
	
	sfx_slider.min_value = 0.0
	sfx_slider.max_value = 1.0
	sfx_slider.step = 0.01
	sfx_slider.value = GameManager.get_sfx_volume()
	
	# Actualizar etiquetas
	update_labels()
	
	# Conectar señales
	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	back_button.pressed.connect(_on_back_pressed)

func update_labels() -> void:
	music_label.text = "Música: " + str(int(music_slider.value * 100)) + "%"
	sfx_label.text = "Efectos: " + str(int(sfx_slider.value * 100)) + "%"

func _on_music_slider_changed(value: float) -> void:
	GameManager.set_music_volume(value)
	update_labels()

func _on_sfx_slider_changed(value: float) -> void:
	GameManager.set_sfx_volume(value)
	update_labels()
	# Reproducir sonido de prueba
	if test_sfx and not test_sfx.playing:
		test_sfx.play()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
