# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flappy Bird clone built with **Godot Engine 4.5.0**, written in GDScript. The game includes a skin system, coin currency, persistent save data, audio settings, and progressive difficulty scaling.

## Common Commands

### Running the Game
- Open the project in Godot Editor and press F5, or click the "Play" button
- The main scene is `res://scenes/escena_principal/escena_principal.tscn`

### Exporting Builds
The project has export presets configured for multiple platforms in `export_presets.cfg`:

```bash
# Export for Windows
godot --headless --export-release "Windows Desktop" builds/windows/flappy-bird.exe

# Export for Linux
godot --headless --export-release "Linux" builds/linux/wing-bird.x86_64

# Export for macOS
godot --headless --export-release "macOS" builds/macos/wing-bird.zip

# Export for Web
godot --headless --export-release "Web" builds/web/index.html
```

### Development
- Scripts use static typing where possible (`: int`, `: float`, `: String`, etc.)
- Use `print()` for debug output during development
- The game auto-saves progress to `user://save_data.json`

## Architecture

### Global State Management
The **GameManager** (`scripts/game_manager.gd`) is an autoloaded singleton that manages all global game state:
- Score tracking (current score, high score)
- Coin economy and skin purchases
- Audio volume settings (music and SFX buses)
- Save/load system using JSON
- Speed progression system (increases every 10 points)

Access it from any script via `GameManager.method_name()`. All scenes rely on this singleton for persistent data.

### Audio System
The game uses **AudioBusLayout** with three separate buses:
- `Master` - Main mix bus
- `Music` - Background music (main menu)
- `SFX` - Sound effects (jumps, collisions, scoring)

Volume is controlled via `GameManager.set_music_volume()` and `GameManager.set_sfx_volume()`, which convert linear values (0.0-1.0) to decibels and apply them to the respective buses.

### Scene Flow
1. **Main Menu** (`scenes/main_menu/`) - Entry point with Play, Shop, Settings, and Exit buttons
2. **Game Scene** (`scenes/escena_principal/`) - Main gameplay, starts with countdown
3. **Countdown** (`scenes/countdown/`) - 5-second countdown before gameplay begins
4. **Game Over** (`scenes/game_over/`) - Shows score, restart/menu options
5. **Shop** (`scenes/shop/`) - Skin purchase and selection system
6. **Settings** (`scenes/settings/`) - Audio volume controls
7. **Pause Menu** (`scenes/pause_menu/`) - In-game pause overlay

### Gameplay Core Loop

**Player** (`scenes/jugador/controlador_jugador.gd`):
- `CharacterBody2D` with gravity and jump mechanics
- Disabled until countdown finishes via `enable_gameplay()`
- Loads current skin from GameManager on `_ready()`
- Rotation lerps based on vertical velocity for visual feedback

**Pipe Spawning** (`scenes/tubo_spawner/tubo_spawner.gd`):
- Timer-based spawning disabled until countdown finishes
- Instantiates pipes at random Y positions
- Controlled by `enable_spawning()` signal from countdown

**Pipes** (`scenes/tubos/tubos.gd`):
- `Area2D` nodes that scroll left at `GameManager.get_current_speed()`
- Listen to `GameManager.speed_increased` signal to adjust movement speed
- Separate collision zones for score detection and death
- `score_counted` flag prevents double-counting points
- On collision: stops spawner, plays hit sound, transitions to game over

**Speed Progression**:
- Base speed: 200.0 units/second
- Speed increases by 20.0 units every 10 points scored
- Multiplier formula: `1.0 + (level * (speed_increment / base_speed))`
- All active pipes receive `speed_increased` signal to update mid-flight

### Save System
Location: `user://save_data.json` (platform-specific, see README.md for paths)

Saved data structure:
```gdscript
{
  "total_coins": int,
  "current_skin": String,
  "unlocked_skins": Array[String],
  "music_volume": float,  # 0.0 to 1.0
  "sfx_volume": float,    # 0.0 to 1.0
  "high_score": int
}
```

Automatically saved on:
- Score changes (including new high scores)
- Skin purchases/changes
- Volume adjustments

### Skin System
Skins are PNG textures in `assets/skins/`:
- `pajaro_default.png` (free, default)
- `pajaro_rojo.png` (5 coins)
- `pajaro_verde.png` (10 coins)

Skin catalog defined in `GameManager.available_skins` array (11 total skins). Each entry contains name, path, and price. Access via helper methods:
- `get_available_skins()` - Returns all skin data
- `get_skin_price(path)` - Get price for specific skin
- `get_skin_data(path)` - Get complete skin info

Unlocked skins stored as resource paths in save data.

### Input Actions
Defined in `project.godot` under `[input]`:
- `salto` - Up Arrow (4194320) - Makes bird jump
- `pausar` - Escape (4194305) - Pauses game

Use `Input.is_action_just_pressed("salto")` for jump detection (mapped to arrow up).

## Development Notes

### Physics Layers
Defined in `project.godot`:
- Layer 1: `jugador` (player)
- Layer 2: `tubos` (pipes)

Use these layers for collision detection setup in scenes.

### Scene Naming Conventions
- Spanish naming is used throughout (jugador=player, tubos=pipes, puntaje=score)
- Main gameplay happens in `escena_principal` (main scene)
- Controllers are prefixed with `controlador_`

### Common Patterns
- Export variables for PackedScenes to connect scenes in the editor
- Use signals for inter-scene communication (e.g., `countdown_finished`)
- Scripts check for method existence with `has_method()` before calling
- Use `process_mode = Node.PROCESS_MODE_ALWAYS` for audio that should play during pause/transitions

### Gotchas
- Pipes must disconnect from `speed_increased` signal in `_exit_tree()` to prevent memory leaks
- Audio players need `PROCESS_MODE_ALWAYS` to finish playing during scene transitions
- The player is in the `"player"` global group for collision detection
