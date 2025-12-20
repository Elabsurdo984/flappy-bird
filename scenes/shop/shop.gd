extends Control

var aviable_skins: Array[Dictionary] = [
	{
		"name": "Default",
		"path": "res://assets/skins/pajaro_default.png",
		"price": 0
	},
	{
		"name": "Rojo",
		"path": "res://assets/skins/pajaro_rojo.png",
		"price": 5
	}
]

@onready var skins_container: GridContainer = $ScrollContainer/GridContainer
@onready var coins_label: Label = $CoinsLabel
@onready var back_button: Button = $BackButton

var skin_button_scene: PackedScene = preload("res://scenes/shop/skin_button.tscn")

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	update_coins_display()
	load_skins()

func update_coins_display() -> void:
	coins_label.text = "monedas: " + str(GameManager.get_coins())

func load_skins() -> void:
	for child in skins_container.get_children():
		child.queue_free()
	
	for skin_data in aviable_skins:
		var skin_button = skin_button_scene.instantiate()
		skins_container.add_child(skin_button)
		
		skin_button.setup(skin_data)
		skin_button.skin_selected.connect(_on_skin_selected)
		skin_button.skin_purchased.connect(_on_skin_pucharsed)

func _on_skin_selected(skin_path: String) -> void:
	GameManager.set_current_skin(skin_path)
	print("Skin Seleccionada: ", skin_path)

func _on_skin_pucharsed(skin_path: String, price: int) -> void:
	if GameManager.unlock_skin(skin_path, price):
		update_coins_display()
		load_skins()
		print("skin COmprada")
	else:
		print("No te alcanza")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
		
		
		

 
