extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.reset_score()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = "Puntaje: " + str(GameManager.get_score())
