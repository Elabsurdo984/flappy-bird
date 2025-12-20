extends Node

var score: int = 0
var current_skin: String = "res://assets/skins/pajaro_default.png"
var unlocked_skins: Array[String] = [
	"res://assets/pajaro_default"
]

var skin_prices: Dictionary = {
	"res://assets/pajaro_default.png": 0,
	"res://assets/pajaro_rojo.png": 5,
	"res://assets/pajaro_verde.png": 10
}

var total_coins: int = 0

func reset_score() -> void:
	score = 0

func add_score(amount: int = 1) -> void:
	score += amount
	total_coins += amount
	
func get_score() -> int:
	return score

func get_coins() -> int:
	return total_coins

func set_current_skin(skin_path: String) -> void:
	current_skin = skin_path

func get_current_skin() -> String:
	return current_skin

func is_skin_unlocked(skin_path: String) -> bool:
	return skin_path in unlocked_skins

func unlock_skin(skin_path: String, price: int) -> bool:
	if total_coins >= price and not is_skin_unlocked(skin_path):
		total_coins -= price
		unlocked_skins.append(skin_path)
		return true
	return false
