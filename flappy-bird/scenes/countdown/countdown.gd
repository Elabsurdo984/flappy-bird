extends CanvasLayer

signal countdown_finished

@onready var countdown_label: Label = $CountdownLabel 
@onready var timer: Timer = $Timer

var current_count: int = 5

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	
	countdown_label.text = str(current_count)
	
	timer.wait_time = 1.0
	timer.start()

func _on_timer_timeout() -> void:
	current_count -= 1
	
	if current_count > 0:
		countdown_label.text = str(current_count)
	
		var tween = create_tween()
		tween.tween_property(countdown_label, "scale", Vector2(1.5, 1.5), 0.1)
		tween.tween_property(countdown_label, "scale", Vector2(1.0, 1.0), 0.4)
	else:
		countdown_label.text = "¡GO!"
		
		var tween = create_tween()
		tween.tween_property(countdown_label, "scale", Vector2(2.0, 2.0), 0.2)
		tween.tween_property(countdown_label, "modulate:a", 0.0, 0.5)
		
		await tween.finished
		
		countdown_finished.emit()
		
		queue_free()
	
