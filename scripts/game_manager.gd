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
	"res://assets/skins/pajaro_cyborg.png": 60,
	"res://assets/skins/pajaro_poseido.png": 80,
	"res://assets/skins/pajaro_negativo.png": 100,
	"res://assets/skins/pajaro_pro.png": 130,
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

var custom_inputs: Dictionary = {
	"salto": KEY_UP,
	"pausar": KEY_ESCAPE
}

var total_score: int = 0
var current_rank: int = 0

var ranks: Array[Dictionary] = [
	{
		"name": "Polluelo",
		"points_required": 0,
		"description": "Apenas aprendiendo a volar"
	},
	{
		"name": "Gorrion",
		"points_required": 50,
		"description": "Volando con confianza"
	},
	{
		"name": "Golondrina",
		"points_required": 100,
		"description": "Ágil entre obstáculos"
	},
	{
		"name": "Paloma",
		"points_required": 200,
		"description": "Navegando los cielos"
	},
	{
		"name": "Colibri",
		"points_required": 300,
		"description": "Maestro de la agilidad"
	},
	{
		"name": "Petirrojo",
		"points_required": 450,
		"description": "Experto del vuelo rasante"
	},
	{
		"name": "Halcon",
		"points_required": 600,
		"description": "Cazador de los aires"
	},
	{
		"name": "Buho Sabio",
		"points_required": 800,
		"description": "Ojos que ven todo peligro"
	},
	{
		"name": "Aguila Real",
		"points_required": 1000,
		"description": "Rey de las alturas"
	},
	{
		"name": "Condor",
		"points_required": 1300,
		"description": "Domador de vientos imposibles"
	},
	{
		"name": "Fenix",
		"points_required": 1700,
		"description": "Renacido de cada caída"
	},
	{
		"name": "Grifo",
		"points_required": 2200,
		"description": "Guardián de tesoros celestiales"
	},
	{
		"name": "Dragon",
		"points_required": 3000,
		"description": "Bestia legendaria del firmamento"
	},
	{
		"name": "Arcangel",
		"points_required": 4000,
		"description": "Mensajero divino de los cielos"
	},
	{
		"name": "Dios del Viento",
		"points_required": 5500,
		"description": "Perfección absoluta alcanzada"
	},
]

signal speed_increased(new_speed: float)
signal volume_changed()
signal rank_changed(new_rank: int)

func _ready() -> void:
	load_game()
	apply_audio_settings()
	apply_input_settings()

func reset_score() -> void:
	score = 0
	current_speed_multiplier = 1.0

func add_score(amount: int = 1) -> void:
	var old_score = score
	score += amount
	total_coins += amount
	total_score += amount
	
	check_rank_up()
	
	# Actualizar high score si es necesario
	if score > high_score:
		high_score = score
		save_game()  # Guardar el nuevo récord inmediatamente
	
	@warning_ignore("integer_division")
	var old_level = int(old_score / points_per_speed_increase)
	@warning_ignore("integer_division")
	var new_level = int(score / points_per_speed_increase)
	
	if new_level > old_level:
		current_speed_multiplier = 1.0 + (float(new_level) * (speed_increment / base_speed))
		var new_speed = base_speed * current_speed_multiplier
		speed_increased.emit(new_speed)
		print("¡Velocidad aumentada! Nueva velocidad: ", new_speed)
	
	save_game()

func check_rank_up() -> void:
	var old_rank = current_rank
	
	for i in range(ranks.size() - 1, -1, -1):
		if total_score >= ranks[i]["points_required"]:
			current_rank = i
			break
	
	if current_rank > old_rank:
		rank_changed.emit(current_rank)
		print("Subiste de rango, Ahora eres: ", ranks[current_rank]["name"])
	
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

func get_current_rank() -> int:
	return current_rank

func get_rank_name() -> String:
	return ranks[current_rank]["name"]

func get_rank_description() -> String:
	return ranks[current_rank]["description"]
	
func get_total_score() -> int:
	return total_score

func get_rank_progress() -> float:
	if current_rank >= ranks.size() - 1:
		return 1.0
	
	var current_rank_point = ranks[current_rank]["points_required"]
	var next_rank_points = ranks[current_rank + 1]["points_required"]
	var points_in_current_rank = total_score - current_rank_point
	var points_needed = next_rank_points - current_rank_point
	
	return float(points_in_current_rank) / float(points_needed)

func get_points_to_next_rank() -> int:
	if current_rank >= ranks.size() - 1:
		return 0
	
	return ranks[current_rank + 1]["points_required"] - total_score

func get_next_rank_name() -> String:
	if current_rank >= ranks.size() - 1:
		return "Maximo"
	return ranks[current_rank + 1]["name"]

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
	@warning_ignore("incompatible_ternary")
	var music_db = linear_to_db(music_volume) if music_volume > 0 else -80
	@warning_ignore("incompatible_ternary")
	var sfx_db = linear_to_db(sfx_volume) if sfx_volume > 0 else -80

	# Aplicar a los buses de audio
	var music_bus_idx = AudioServer.get_bus_index("Music")
	var sfx_bus_idx = AudioServer.get_bus_index("SFX")

	if music_bus_idx != -1:
		AudioServer.set_bus_volume_db(music_bus_idx, music_db)

	if sfx_bus_idx != -1:
		AudioServer.set_bus_volume_db(sfx_bus_idx, sfx_db)

	volume_changed.emit()
	
func save_input_mapping(action_name: String, key_code: int) -> void:
	custom_inputs[action_name] = key_code
	save_game()

func apply_input_settings() -> void:
	for action_name in custom_inputs.keys():
		var key_code = custom_inputs[action_name]
		
		InputMap.action_erase_events(action_name)
		
		var event = InputEventKey.new()
		event.physical_keycode = key_code
		
		InputMap.action_add_event(action_name, event)

func get_input_keycode(action_name: String) -> int:
	return custom_inputs.get(action_name, KEY_NONE)

func reset_inputs_to_default() -> void:
	custom_inputs = {
		"salto": KEY_UP,
		"pausar": KEY_ESCAPE
	}
	apply_input_settings()
	save_game()

func get_key_name(keycode: int) -> String:
	if keycode == KEY_NONE:
		return "Sin asignar"
	return OS.get_keycode_string(keycode)

func save_game() -> void:
	var save_data = {
		"total_coins": total_coins,
		"current_skin": current_skin,
		"unlocked_skins": unlocked_skins,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"high_score": high_score,
		"total_score": total_score,
		"current_rank": current_rank,
		"custom_inputs": custom_inputs
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
			total_score = save_data.get("total_score", 0)
			current_rank = save_data.get("current_rank", 0)
			
			# Cargar controles personalizados
			var loaded_inputs = save_data.get("custom_inputs", {
				"salto": KEY_UP,
				"pausar": KEY_ESCAPE
			})
			custom_inputs.clear()
			for action in loaded_inputs.keys():
				custom_inputs[action] = loaded_inputs[action]
			
			var loaded_skins = save_data.get("unlocked_skins", ["res://assets/skins/pajaro_default.png"])
			unlocked_skins.clear()
			for skin in loaded_skins:
				unlocked_skins.append(skin as String)
			
			print("Juego cargado: ", total_coins, " monedas, Rango: ", get_rank_name())
		else:
			print("Error al parsear el JSON")
	else:
		print("Error al abrir el archivo de guardado")
