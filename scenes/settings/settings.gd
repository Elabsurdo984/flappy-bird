extends CanvasLayer

@onready var music_slider: HSlider = $Control/VBoxContainer/AudioContainer/MusicContainer/MusicSlider
@onready var sfx_slider: HSlider = $Control/VBoxContainer/AudioContainer/SFXContainer/SFXSlider
@onready var music_label: Label = $Control/VBoxContainer/AudioContainer/MusicContainer/MusicLabel
@onready var sfx_label: Label = $Control/VBoxContainer/AudioContainer/SFXContainer/SFXLabel
@onready var back_button: Button = $Control/BackButton
@onready var test_sfx: AudioStreamPlayer = $TestSFX
@onready var jump_button: Button = $Control/VBoxContainer/ControlsContainer/JumpContainer/JumpButton
@onready var pause_button: Button = $Control/VBoxContainer/ControlsContainer/PauseContainer/PauseButton
@onready var reset_button: Button = $Control/VBoxContainer/ControlsContainer/ResetButton

var waiting_for_input: bool = false
var current_action: String = ""

func _ready() -> void:
	hide()
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
	update_control_buttons()

	# Conectar señales
	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	back_button.pressed.connect(_on_back_pressed)
	jump_button.pressed.connect(_on_jump_button_pressed)
	pause_button.pressed.connect(_on_pause_button_pressed)
	reset_button.pressed.connect(_on_reset_button_pressed)

func update_labels() -> void:
	music_label.text = "Música: " + str(int(music_slider.value * 100)) + "%"
	sfx_label.text = "Efectos: " + str(int(sfx_slider.value * 100)) + "%"

func update_control_buttons() -> void:
	var jump_key = GameManager.get_input_keycode("salto")
	var pause_key = GameManager.get_input_keycode("pausar")

	jump_button.text = GameManager.get_key_name(jump_key)
	pause_button.text = GameManager.get_key_name(pause_key)

func _on_music_slider_changed(value: float) -> void:
	GameManager.set_music_volume(value)
	update_labels()

func _on_sfx_slider_changed(value: float) -> void:
	GameManager.set_sfx_volume(value)
	update_labels()
	# Reproducir sonido de prueba
	if test_sfx and not test_sfx.playing:
		test_sfx.play()

func _on_jump_button_pressed() -> void:
	start_key_rebind("salto", jump_button)

func _on_pause_button_pressed() -> void:
	start_key_rebind("pausar", pause_button)

func _on_reset_button_pressed() -> void:
	GameManager.reset_inputs_to_default()
	update_control_buttons()

func start_key_rebind(action: String, button: Button) -> void:
	waiting_for_input = true
	current_action = action
	button.text = "Presiona una tecla..."

func _input(event: InputEvent) -> void:
	if waiting_for_input and event is InputEventKey and event.pressed:
		var key_event = event as InputEventKey

		# Guardar la nueva tecla
		GameManager.save_input_mapping(current_action, key_event.physical_keycode)
		GameManager.apply_input_settings()

		# Actualizar UI
		update_control_buttons()

		# Resetear estado
		waiting_for_input = false
		current_action = ""

		# Aceptar el input para que no se propague
		get_viewport().set_input_as_handled()

func _on_back_pressed() -> void:
	hide()

func show_settings() -> void:
	# Actualizar sliders con valores actuales
	music_slider.value = GameManager.get_music_volume()
	sfx_slider.value = GameManager.get_sfx_volume()
	update_labels()
	update_control_buttons()
	show()
