extends Node2D

@export var countdown_scene: PackedScene

func _ready() -> void:
	if countdown_scene:
		var countdown = countdown_scene.instantiate()
		add_child(countdown)
		
		countdown.countdown_finished.connect(_on_countdown_finished)
		
func _on_countdown_finished() -> void:
	var player = get_node("CharacterBody2D")
	if player and player.has_method("enable_gameplay"):
		player.enable_gameplay()
	
	var spawner = $Node2D
	if spawner and spawner.has_method("enable_spawning"):
		spawner.enable_spawning()
