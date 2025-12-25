extends Control


@onready var rank_label: Label = $VBoxContainer/RankLabel
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var progress_label: Label = $VBoxContainer/ProgressLabel

func _ready() -> void:
	update_display()
	
	GameManager.rank_changed.connect(_on_rank_changed)
	
func _process(_delta: float) -> void:
	update_progress()

func update_display() -> void:
	rank_label.text = GameManager.get_rank_name()

	update_progress()

func update_progress() -> void:
	var progress = GameManager.get_rank_progress()
	progress_bar.value = progress * 100
	
	var points_to_next = GameManager.get_points_to_next_rank()
	if points_to_next > 0:
		progress_label.text = str(points_to_next) + " pts para " + GameManager.get_next_rank_name()
	else:
		progress_label.text = "¡Rango Maximo!"

func _on_rank_changed(_new_rank: int) -> void:
	print("¡Cambio de rango detectado!")
	update_display()
	
	var tween = create_tween()
	tween.tween_property(rank_label, "scale", Vector2(1.3, 1.3), 0.2)
	tween.tween_property(rank_label, "scale", Vector2(1.0, 1.0), 0.2)
