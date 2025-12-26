extends PanelContainer

@onready var rank_name_label: Label = $MarginContainer/HBoxContainer/LeftSection/RankName
@onready var rank_points_label: Label = $MarginContainer/HBoxContainer/LeftSection/RankPoints
@onready var rank_description_label: Label = $MarginContainer/HBoxContainer/RightSection/Description
@onready var current_indicator: Label = $MarginContainer/HBoxContainer/CurrentIndicator

func setup(rank_name: String, points_required: int, description: String, is_current: bool, is_unlocked: bool) -> void:
	rank_name_label.text = rank_name
	rank_points_label.text = str(points_required) + " puntos"
	rank_description_label.text = description

	# Mostrar indicador de rango actual
	current_indicator.visible = is_current

	# Estilo según si está desbloqueado o no
	if is_unlocked:
		modulate = Color(1, 1, 1, 1)  # Color normal
		if is_current:
			modulate = Color(1.0, 0.9, 0.5, 1)  # Resaltar rango actual en dorado
	else:
		modulate = Color(0.5, 0.5, 0.5, 0.7)  # Gris para rangos bloqueados
