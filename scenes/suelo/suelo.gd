extends Area2D

@onready var hit_sound: AudioStreamPlayer = $HitSound

func _on_body_entered(_body: Node2D) -> void:
	if has_node("HitSound"):
		$HitSound.process_mode = Node.PROCESS_MODE_ALWAYS
		$HitSound.play()
		# Esperar a que termine el sonido
		await $HitSound.finished
	get_tree().change_scene_to_file("res://scenes/game_over/game_over.tscn")
