extends PanelContainer

signal skin_selected(skin_path: String)
signal skin_purchased(skin_path: String, price: int)

var skin_data: Dictionary
var is_unlocked: bool = false
var is_current: bool = false

@onready var skin_sprite: TextureRect = $VBoxContainer/SkinSprite
@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var action_button: Button = $VBoxContainer/ActionButton

func setup(data: Dictionary) -> void:
	skin_data = data
	
	# Cargar la textura
	var texture = load(skin_data["path"])
	skin_sprite.texture = texture
	
	# Configurar nombre
	name_label.text = skin_data["name"]
	
	# Verificar estado
	is_unlocked = GameManager.is_skin_unlocked(skin_data["path"])
	is_current = GameManager.get_current_skin() == skin_data["path"]
	
	# Configurar botón
	update_button_state()
	action_button.pressed.connect(_on_action_pressed)

func update_button_state() -> void:
	if is_current:
		action_button.text = "Equipado"
		action_button.disabled = true
		modulate = Color(0.5, 1.0, 0.5)  # Verde claro
	elif is_unlocked:
		action_button.text = "Equipar"
		action_button.disabled = false
		modulate = Color.WHITE
	else:
		action_button.text = "Comprar (" + str(skin_data["price"]) + ")"
		action_button.disabled = false
		modulate = Color(0.8, 0.8, 0.8)

func _on_action_pressed() -> void:
	if is_unlocked:
		# Equipar la skin
		skin_selected.emit(skin_data["path"])
		is_current = true
		update_button_state()
	else:
		# Comprar la skin
		skin_purchased.emit(skin_data["path"], skin_data["price"])
