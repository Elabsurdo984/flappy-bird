extends Control

var combo_label: Label
var multiplier_label: Label
var combo_sound: AudioStreamPlayer

# Colores para diferentes niveles de combo
const COMBO_COLORS: Array[Color] = [
	Color.WHITE,           # Sin combo
	Color(1.0, 1.0, 0.5),  # Nivel 1 - Amarillo claro
	Color(1.0, 0.8, 0.0),  # Nivel 2 - Amarillo
	Color(1.0, 0.5, 0.0),  # Nivel 3 - Naranja
	Color(1.0, 0.2, 0.0),  # Nivel 4 - Naranja rojizo
	Color(1.0, 0.0, 0.5),  # Nivel 5 - Rojo rosado
	Color(0.8, 0.0, 1.0),  # Nivel 6 - Púrpura
	Color(0.0, 1.0, 1.0),  # Nivel 7 - Cyan
]

func _ready() -> void:
	# Crear labels si no existen
	if not has_node("ComboLabel"):
		combo_label = Label.new()
		combo_label.name = "ComboLabel"
		combo_label.add_theme_font_size_override("font_size", 32)
		combo_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		add_child(combo_label)
	else:
		combo_label = $ComboLabel

	if not has_node("MultiplierLabel"):
		multiplier_label = Label.new()
		multiplier_label.name = "MultiplierLabel"
		multiplier_label.add_theme_font_size_override("font_size", 48)
		multiplier_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		multiplier_label.position = Vector2(0, 40)
		add_child(multiplier_label)
	else:
		multiplier_label = $MultiplierLabel

	# Crear sonido de combo
	if not has_node("ComboSound"):
		combo_sound = AudioStreamPlayer.new()
		combo_sound.name = "ComboSound"
		combo_sound.stream = load("res://assets/sounds/point.mp3")
		combo_sound.bus = "SFX"
		add_child(combo_sound)
	else:
		combo_sound = $ComboSound

	# Conectar a las señales del GameManager
	GameManager.combo_increased.connect(_on_combo_increased)
	GameManager.combo_reset.connect(_on_combo_reset)

	# Inicializar display
	update_display()

func update_display() -> void:
	var combo = GameManager.get_combo_count()
	var multiplier = GameManager.get_combo_multiplier()
	var level = GameManager.get_combo_level()

	if combo == 0:
		combo_label.text = ""
		multiplier_label.text = ""
		modulate.a = 0.0
	else:
		combo_label.text = "COMBO: " + str(combo)
		if multiplier > 1.0:
			multiplier_label.text = "x" + str(multiplier)
		else:
			multiplier_label.text = ""

		# Cambiar color según el nivel
		if level < COMBO_COLORS.size():
			modulate = COMBO_COLORS[level]
		modulate.a = 1.0

func _on_combo_increased(new_combo: int, multiplier: float) -> void:
	update_display()

	# Reproducir sonido con pitch variable según el nivel
	if combo_sound:
		var level = GameManager.get_combo_level()
		# Pitch aumenta con el nivel: 1.0, 1.1, 1.2, etc.
		combo_sound.pitch_scale = 1.0 + (level * 0.15)
		combo_sound.play()

	# Animación de celebración cuando sube el combo
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.1)
	tween.tween_property(self, "rotation", deg_to_rad(10), 0.1)
	tween.chain()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)
	tween.tween_property(self, "rotation", 0.0, 0.2)

	# Flash de brillo
	var flash_tween = create_tween()
	flash_tween.tween_property(multiplier_label, "modulate:a", 0.3, 0.1)
	flash_tween.tween_property(multiplier_label, "modulate:a", 1.0, 0.1)

func _on_combo_reset() -> void:
	# Animación de desvanecimiento al perder el combo
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.2)
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	tween.tween_callback(update_display)
