extends Area2D

@export var speed: float = 200.0

func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -600:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	get_tree().paused = true
