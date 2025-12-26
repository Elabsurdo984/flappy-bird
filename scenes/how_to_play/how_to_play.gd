extends Control

@onready var back_button: Button = $BackButton
@onready var content_container: VBoxContainer = $ScrollContainer/VBoxContainer

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	setup_content()

func setup_content() -> void:
	# Limpiar contenido existente
	for child in content_container.get_children():
		child.queue_free()

	# Título principal
	add_title("¿CÓMO JUGAR?")

	# Sección: Controles
	add_section_header("✈️ CONTROLES")
	add_text("• Presiona FLECHA ARRIBA (↑) para volar")
	add_text("• Evita chocar con los tubos y el suelo")
	add_text("• Presiona ESC para pausar el juego")
	add_spacing(20)

	# Sección: Monedas
	add_section_header("💰 SISTEMA DE MONEDAS")
	add_text("• Ganas 1 moneda por cada tubo que pases")
	add_text("• Las monedas se usan para desbloquear skins en la Tienda")
	add_text("• ¡Las monedas se multiplican con los combos!")
	add_spacing(20)

	# Sección: Combos
	add_section_header("🔥 SISTEMA DE COMBOS")
	add_text("Pasa tubos consecutivos sin morir para activar multiplicadores:")
	add_spacing(10)
	add_combo_level("5 tubos", "x1.5", Color(1.0, 1.0, 0.5))
	add_combo_level("10 tubos", "x2.0", Color(1.0, 0.8, 0.0))
	add_combo_level("15 tubos", "x2.5", Color(1.0, 0.5, 0.0))
	add_combo_level("20 tubos", "x3.0", Color(1.0, 0.2, 0.0))
	add_combo_level("30 tubos", "x4.0", Color(1.0, 0.0, 0.5))
	add_combo_level("40 tubos", "x5.0", Color(0.8, 0.0, 1.0))
	add_combo_level("50+ tubos", "x6.0", Color(0.0, 1.0, 1.0))
	add_spacing(10)
	add_text("⚠️ El combo se reinicia al morir")
	add_spacing(20)

	# Sección: Tienda
	add_section_header("🎨 TIENDA DE SKINS")
	add_text("• Usa tus monedas para desbloquear nuevas apariencias")
	add_text("• Hay 11 skins diferentes para coleccionar")
	add_text("• Los precios van de 0 a 130 monedas")
	add_spacing(20)

	# Sección: Rangos
	add_section_header("🏆 SISTEMA DE RANGOS")
	add_text("• Acumula puntos totales para subir de rango")
	add_text("• Hay 15 rangos desde Polluelo hasta Dios del Viento")
	add_text("• Los puntos totales nunca se pierden")
	add_text("• Ve todos los rangos en el botón de Rangos del menú")
	add_spacing(20)

	# Sección: Dificultad
	add_section_header("⚡ DIFICULTAD PROGRESIVA")
	add_text("• El juego aumenta de velocidad cada 10 puntos")
	add_text("• ¡Pon a prueba tus reflejos!")
	add_spacing(20)

	# Consejos
	add_section_header("💡 CONSEJOS")
	add_text("• Mantén la calma y concentración")
	add_text("• Los combos altos valen mucho - ¡no te rindas!")
	add_text("• Practica para mejorar tu mejor puntaje")
	add_text("• Personaliza tu pájaro con las skins desbloqueadas")

func add_title(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 36)
	label.add_theme_color_override("font_color", Color(1.0, 1.0, 0.5))
	content_container.add_child(label)
	add_spacing(30)

func add_section_header(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 24)
	label.add_theme_color_override("font_color", Color(0.5, 1.0, 1.0))
	content_container.add_child(label)
	add_spacing(10)

func add_text(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 18)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	content_container.add_child(label)
	add_spacing(5)

func add_combo_level(threshold: String, multiplier: String, color: Color) -> void:
	var hbox = HBoxContainer.new()

	var threshold_label = Label.new()
	threshold_label.text = "  → " + threshold + ":"
	threshold_label.add_theme_font_size_override("font_size", 18)
	threshold_label.custom_minimum_size.x = 150
	hbox.add_child(threshold_label)

	var multiplier_label = Label.new()
	multiplier_label.text = multiplier + " monedas 💰"
	multiplier_label.add_theme_font_size_override("font_size", 18)
	multiplier_label.add_theme_color_override("font_color", color)
	hbox.add_child(multiplier_label)

	content_container.add_child(hbox)
	add_spacing(3)

func add_spacing(pixels: int) -> void:
	var spacer = Control.new()
	spacer.custom_minimum_size.y = pixels
	content_container.add_child(spacer)

func _on_back_pressed() -> void:
	SceneManager.go_to_main_menu()
