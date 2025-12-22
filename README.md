# 🐦 Flappy Bird - Godot Edition

Un clon del clásico juego Flappy Bird desarrollado en Godot 4.5 con sistema de skins personalizables, monedas coleccionables y configuración de audio.

## 📋 Descripción

Este es un juego de Flappy Bird completamente funcional con características adicionales como:
- Sistema de tienda con skins desbloqueables
- Sistema de monedas persistentes
- **Sistema de configuración de audio** (Música y Efectos de Sonido)
- Cuenta regresiva al inicio
- Efectos de sonido y música
- Sistema de guardado automático
- Aumento progresivo de dificultad

## 🎮 Características

### Jugabilidad
- **Controles simples**: Presiona `Flecha Arriba` para hacer que el pájaro salte
- **Física realista**: Gravedad y momentum precisos
- **Colisiones**: Sistema de detección de colisiones con tubos y suelo
- **Sistema de puntuación**: Gana puntos (y monedas) al pasar entre los tubos
- **Dificultad progresiva**: La velocidad aumenta cada 10 puntos

### Sistema de Skins
- **3 skins disponibles**:
  - Default (Gratis)
  - Rojo (5 monedas)
  - Verde (10 monedas)
- Las skins compradas se guardan permanentemente
- Cambia de skin en cualquier momento desde la tienda

### Sistema de Configuración 🆕
- **Control de volumen independiente**:
  - Volumen de música (0-100%)
  - Volumen de efectos de sonido (0-100%)
- Sonido de prueba para verificar el volumen de efectos
- Configuración guardada automáticamente
- Interfaz intuitiva con sliders

### Persistencia de Datos
- **Guardado automático**: Las monedas, progreso y configuración se guardan automáticamente
- **Carga automática**: Tu progreso se restaura al iniciar el juego
- Los datos se almacenan en formato JSON

## 🎯 Cómo Jugar

1. **Menú Principal**: 
   - Haz clic en "Jugar" para comenzar
   - Visita la "Tienda" para comprar skins
   - Accede a "Configuración" para ajustar el audio 🆕
   - Haz clic en "Salir" para cerrar el juego

2. **Durante el Juego**:
   - Espera la cuenta regresiva de 5 segundos
   - Presiona `Flecha Arriba` para volar
   - Evita los tubos y el suelo
   - Pasa entre los tubos para ganar puntos y monedas
   - La velocidad aumenta cada 10 puntos

3. **Game Over**:
   - Ve tu puntuación final
   - Reinicia la partida o vuelve al menú

4. **Tienda**:
   - Usa tus monedas para comprar nuevas skins
   - Equipa la skin que prefieras
   - Tus compras se guardan automáticamente

5. **Configuración** 🆕:
   - Ajusta el volumen de la música de fondo
   - Ajusta el volumen de los efectos de sonido
   - Prueba los efectos con el sonido de prueba
   - Los cambios se guardan automáticamente

## 📁 Estructura del Proyecto

```
flappy-bird/
├── assets/              # Recursos visuales y de audio
│   ├── skins/          # Texturas de las skins del pájaro
│   └── sounds/         # Efectos de sonido y música
├── scenes/             # Escenas del juego
│   ├── escena_principal/  # Escena principal del juego
│   ├── game_over/      # Pantalla de Game Over
│   ├── jugador/        # Personaje del jugador
│   ├── main_menu/      # Menú principal
│   ├── shop/           # Tienda de skins
│   ├── settings/       # Configuración de audio 🆕
│   ├── tubos/          # Obstáculos (tubos)
│   └── ...
├── scripts/            # Scripts globales
│   └── game_manager.gd # Gestor de estado del juego
├── styles/             # Estilos visuales reutilizables
└── default_bus_layout.tres  # Configuración de buses de audio 🆕
```

## 🔧 Sistema de Guardado

El juego utiliza el sistema de archivos de Godot para guardar el progreso:

**Ubicación del archivo de guardado:**
- Windows: `%APPDATA%\Godot\app_userdata\flappy-bird\save_data.json`
- Linux: `~/.local/share/godot/app_userdata/flappy-bird/save_data.json`
- MacOS: `~/Library/Application Support/Godot/app_userdata/flappy-bird`

**Datos guardados:**
- Total de monedas acumuladas
- Skins desbloqueadas
- Skin actualmente equipada
- **Volumen de música** 🆕
- **Volumen de efectos de sonido** 🆕

## 🎵 Sistema de Audio

El juego utiliza **buses de audio separados** para mejor control:

- **Bus "Master"**: Canal principal de mezcla
- **Bus "Music"**: Música de fondo (menú principal)
- **Bus "SFX"**: Efectos de sonido (saltos, colisiones, puntos)

Esto permite controlar el volumen de cada tipo de audio de forma independiente desde la configuración.

## 🛠️ Tecnologías Utilizadas

- **Motor**: Godot Engine 4.5
- **Lenguaje**: GDScript
- **Formato de guardado**: JSON
- **Sistema de físicas**: CharacterBody2D y Area2D
- **Sistema de audio**: AudioBusLayout con buses personalizados

## 📝 Controles

| Acción | Tecla |
|--------|-------|
| Saltar | Flecha Arriba |

## 🎨 Créditos

### Assets
- Fuentes: BotsmaticDemo, FlappyBirdRegular
- Sonidos: Flap, Hit, Point
- Música de fondo

## 📜 Licencia

Este proyecto está bajo la licencia GNU General Public License v3.0. Ver el archivo `LICENSE` para más detalles.

---

**¡Disfruta del juego, personaliza tu experiencia de audio y trata de conseguir el puntaje más alto! 🏆🎵**

## 📜 Licencia

Este proyecto está bajo la licencia GNU General Public License v3.0. Ver el archivo `LICENSE` para más detalles.

---

**¡Disfruta del juego y trata de conseguir el puntaje más alto! 🏆**
