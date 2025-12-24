extends Node

const SAVE_PATH = "user://save_data.json"

var score: int = 0
var current_skin: String = "res://assets/skins/pajaro_default.png"
var unlocked_skins: Array[String] = [
	"res://assets/skins/pajaro_default.png"
]

var skin_prices: Dictionary = {
	"res://assets/skins/pajaro_default.png": 0,
	"res://assets/skins/pajaro_rojo.png": 5,
	"res://assets/skins/pajaro_verde.png": 10,
	"res://assets/skins/pajaro_azul.png": 20,
	"res://assets/skins/pajaro_naranja.png": 25,
	"res://assets/skins/pajaro_rosa.png": 30,
	"res://assets/skins/pajaro_neutro.png": 50,
	"res://assets/skins/pajaro_cyborg.png": 60
}

var total_coins: int = 0

# Sistema de High Score
var high_score: int = 0

# Sistema de velocidad
var base_speed: float = 200.0
var speed_increment: float = 20.0
var points_per_speed_increase: int = 10
var current_speed_multiplier: float = 1.0

# Sistema de volumen
var music_volume: float = 0.8  # 0.0 a 1.0
var sfx_volume: float = 0.8    # 0.0 a 1.0

signal speed_increased(new_speed: float)
signal volume_changed()

func _ready() -> void:
	load_game()
	apply_audio_settings()

func reset_score() -> void:
	score = 0
	current_speed_multiplier = 1.0

func add_score(amount: int = 1) -> void:
	var old_score = score
	score += amount
	total_coins += amount
	
	# Actualizar high score si es necesario
	if score > high_score:
		high_score = score
		save_game()  # Guardar el nuevo récord inmediatamente
	
	var old_level = int(old_score / points_per_speed_increase)
	var new_level = int(score / points_per_speed_increase)
	
	if new_level > old_level:
		current_speed_multiplier = 1.0 + (float(new_level) * (speed_increment / base_speed))
		var new_speed = base_speed * current_speed_multiplier
		speed_increased.emit(new_speed)
		print("¡Velocidad aumentada! Nueva velocidad: ", new_speed)
	
	save_game()
	
func get_score() -> int:
	return score

func get_high_score() -> int:
	return high_score

func is_new_record() -> bool:
	return score == high_score and score > 0

func get_current_speed() -> float:
	return base_speed * current_speed_multiplier

func get_coins() -> int:
	return total_coins

func set_current_skin(skin_path: String) -> void:
	current_skin = skin_path
	save_game()

func get_current_skin() -> String:
	return current_skin

func is_skin_unlocked(skin_path: String) -> bool:
	return skin_path in unlocked_skins

func unlock_skin(skin_path: String, price: int) -> bool:
	if total_coins >= price and not is_skin_unlocked(skin_path):
		total_coins -= price
		unlocked_skins.append(skin_path)
		save_game()
		return true
	return false

# Funciones de volumen
func set_music_volume(value: float) -> void:
	music_volume = clamp(value, 0.0, 1.0)
	apply_audio_settings()
	save_game()

func set_sfx_volume(value: float) -> void:
	sfx_volume = clamp(value, 0.0, 1.0)
	apply_audio_settings()
	save_game()

func get_music_volume() -> float:
	return music_volume

func get_sfx_volume() -> float:
	return sfx_volume

func apply_audio_settings() -> void:
	# Convertir de 0-1 a decibelios (-80 a 0)
	# 0.0 = -80db (silencio), 1.0 = 0db (máximo)
	var music_db = linear_to_db(music_volume) if music_volume > 0 else -80
	var sfx_db = linear_to_db(sfx_volume) if sfx_volume > 0 else -80
	
	# Aplicar a los buses de audio
	var music_bus_idx = AudioServer.get_bus_index("Music")
	var sfx_bus_idx = AudioServer.get_bus_index("SFX")
	
	if music_bus_idx != -1:
		AudioServer.set_bus_volume_db(music_bus_idx, music_db)
	
	if sfx_bus_idx != -1:
		AudioServer.set_bus_volume_db(sfx_bus_idx, sfx_db)
	
	volume_changed.emit()

func save_game() -> void:
	var save_data = {
		"total_coins": total_coins,
		"current_skin": current_skin,
		"unlocked_skins": unlocked_skins,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"high_score": high_score
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(save_data)
		file.store_string(json_string)
		file.close()
	else:
		print("Error al guardar el juego")

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No hay archivo de guardado, iniciando juego nuevo")
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if parse_result == OK:
			var save_data = json.data
			total_coins = save_data.get("total_coins", 0)
			current_skin = save_data.get("current_skin", "res://assets/skins/pajaro_default.png")
			music_volume = save_data.get("music_volume", 0.8)
			sfx_volume = save_data.get("sfx_volume", 0.8)
			high_score = save_data.get("high_score", 0)
			
			var loaded_skins = save_data.get("unlocked_skins", ["res://assets/skins/pajaro_default.png"])
			unlocked_skins.clear()
			for skin in loaded_skins:
				unlocked_skins.append(skin as String)
			
			print("Juego cargado: ", total_coins, " monedas")
		else:
			print("Error al parsear el JSON")
	else:
		print("Error al abrir el archivo de guardado")
