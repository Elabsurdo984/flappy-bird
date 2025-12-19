extends Area2D

@export var speed: float = 200.0
@export var game_over_scene: PackedScene

var score_counted: bool = false

func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -600:
		queue_free()


func _on_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_packed(game_over_scene)

func _on_score_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not score_counted:
		score_counted = true
		GameManager.add_score()
		print("Se te añadio un punto")
		
