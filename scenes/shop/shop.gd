extends Control

var available_skins: Array[Dictionary] = [
	{
		"name": "Default",
		"path": "res://assets/skins/pajaro_default.png",
		"price": 0
	},
	{
		"name": "Rojo",
		"path": "res://assets/skins/pajaro_rojo.png",
		"price": 5
	},
	{
		"name": "Verde",
		"path": "res://assets/skins/pajaro_verde.png",
		"price": 10
	},
	{
		"name": "Azul",
		"path": "res://assets/skins/pajaro_azul.png",
		"price": 20
	},
	{
		"name": "Naranja",
		"path": "res://assets/skins/pajaro_naranja.png",
		"price": 25
	},
	{
		"name": "Rosa",
		"path": "res://assets/skins/pajaro_rosa.png",
		"price": 30
	},
	{
		"name": "Neutro",
		"path": "res://assets/skins/pajaro_neutro.png",
		"price": 50
	},
	{
		"name": "Cyborg",
		"path": "res://assets/skins/pajaro_cyborg.png",
		"price": 60
	},
	{
		"name": "Poseido",
		"path": "res://assets/skins/pajaro_poseido.png",
		"price": 80
	},
	{
		"name": "Negativo",
		"path": "res://assets/skins/pajaro_negativo.png",
		"price": 100
	},
	{
		"name": "Pro",
		"path": "res://assets/skins/pajaro_pro.png",
		"price": 130
	},
]

@onready var skins_container: GridContainer = $ScrollContainer/GridContainer
@onready var coins_label: Label = $CoinsLabel
@onready var back_button: Button = $BackButton

# Escena del botón de skin (la crearemos después)
var skin_button_scene: PackedScene = preload("res://scenes/shop/skin_button.tscn")

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	update_coins_display()
	load_skins()

func update_coins_display() -> void:
	coins_label.text = "Monedas: " + str(GameManager.get_coins())

func load_skins() -> void:
	# Limpiar contenedor
	for child in skins_container.get_children():
		child.queue_free()
	
	# Crear un botón por cada skin
	for skin_data in available_skins:
		var skin_button = skin_button_scene.instantiate()
		skins_container.add_child(skin_button)
		
		# Configurar el botón
		skin_button.setup(skin_data)
		skin_button.skin_selected.connect(_on_skin_selected)
		skin_button.skin_purchased.connect(_on_skin_purchased)

func _on_skin_selected(skin_path: String) -> void:
	GameManager.set_current_skin(skin_path)
	print("Skin seleccionada: ", skin_path)
	# Recargar todos los botones para actualizar el estado "Equipado"
	load_skins()

func _on_skin_purchased(skin_path: String, price: int) -> void:
	if GameManager.unlock_skin(skin_path, price):
		update_coins_display()
		load_skins()  # Recargar para actualizar estados
		show_message("¡Skin comprada!", Color.GREEN)
	else:
		show_message("No tienes suficientes monedas", Color.RED)
		

func show_message(text: String, color: Color) -> void:
	var label = Label.new()
	label.text = text
	label.modulate = color
	label.position = Vector2(500, 300)
	add_child(label)
	
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.0, 1.5)
	tween.tween_callback(label.queue_free)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
		
		

 
