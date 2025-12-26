extends Control

@onready var ranks_container: VBoxContainer = $ScrollContainer/VBoxContainer
@onready var back_button: Button = $BackButton
@onready var rank_item_scene = preload("res://scenes/ranks_list/rank_item.tscn")

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	populate_ranks()

func populate_ranks() -> void:
	# Limpiar contenedor
	for child in ranks_container.get_children():
		child.queue_free()

	var current_rank_index = GameManager.get_current_rank()
	var total_score = GameManager.get_total_score()

	# Crear un item por cada rango
	for i in range(GameManager.ranks.size()):
		var rank_data = GameManager.ranks[i]
		var rank_item = rank_item_scene.instantiate()

		ranks_container.add_child(rank_item)

		# Configurar el item
		var is_current = (i == current_rank_index)
		var is_unlocked = (total_score >= rank_data["points_required"])

		rank_item.setup(
			rank_data["name"],
			rank_data["points_required"],
			rank_data["description"],
			is_current,
			is_unlocked
		)

func _on_back_pressed() -> void:
	SceneManager.go_to_main_menu()
