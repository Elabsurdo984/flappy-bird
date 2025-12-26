extends Node

# Scene path constants
const MAIN_MENU = "res://scenes/main_menu/main_menu.tscn"
const GAME = "res://scenes/escena_principal/escena_principal.tscn"
const GAME_OVER = "res://scenes/game_over/game_over.tscn"
const SHOP = "res://scenes/shop/shop.tscn"
const RANKS_LIST = "res://scenes/ranks_list/ranks_list.tscn"

func change_to(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)

# Helper methods for common scene transitions
func go_to_main_menu() -> void:
	change_to(MAIN_MENU)

func go_to_game() -> void:
	change_to(GAME)

func go_to_game_over() -> void:
	change_to(GAME_OVER)

func go_to_shop() -> void:
	change_to(SHOP)

func go_to_ranks_list() -> void:
	change_to(RANKS_LIST)
