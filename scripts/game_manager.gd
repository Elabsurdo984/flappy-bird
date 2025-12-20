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
	"res://assets/skins/pajaro_verde.png": 10
}

var total_coins: int = 0

func _ready() -> void:
	load_game()

func reset_score() -> void:
	score = 0

func add_score(amount: int = 1) -> void:
	score += amount
	total_coins += amount
	save_game()  # Guardar automáticamente cuando se ganan monedas
	
func get_score() -> int:
	return score

func get_coins() -> int:
	return total_coins

func set_current_skin(skin_path: String) -> void:
	current_skin = skin_path
	save_game()  # Guardar cuando se cambia la skin

func get_current_skin() -> String:
	return current_skin

func is_skin_unlocked(skin_path: String) -> bool:
	return skin_path in unlocked_skins

func unlock_skin(skin_path: String, price: int) -> bool:
	if total_coins >= price and not is_skin_unlocked(skin_path):
		total_coins -= price
		unlocked_skins.append(skin_path)
		save_game()  # Guardar después de comprar una skin
		return true
	return false

func save_game() -> void:
	var save_data = {
		"total_coins": total_coins,
		"current_skin": current_skin,
		"unlocked_skins": unlocked_skins
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(save_data)
		file.store_string(json_string)
		file.close()
		print("Juego guardado: ", total_coins, " monedas")
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
			
			# Convertir el Array genérico a Array[String]
			var loaded_skins = save_data.get("unlocked_skins", ["res://assets/skins/pajaro_default.png"])
			unlocked_skins.clear()
			for skin in loaded_skins:
				unlocked_skins.append(skin as String)
			
			print("Juego cargado: ", total_coins, " monedas")
		else:
			print("Error al parsear el JSON")
	else:
		print("Error al abrir el archivo de guardado")
