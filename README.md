# 🐦 Flappy Bird - Godot Edition

Un clon del clásico juego Flappy Bird desarrollado en Godot 4.5 con sistema de skins personalizables y monedas coleccionables.

## 📋 Descripción

Este es un juego de Flappy Bird completamente funcional con características adicionales como:
- Sistema de tienda con skins desbloqueables
- Sistema de monedas persistentes
- Cuenta regresiva al inicio
- Efectos de sonido y música
- Sistema de guardado automático

## 🎮 Características

### Jugabilidad
- **Controles simples**: Presiona `Flecha Arriba` para hacer que el pájaro salte
- **Física realista**: Gravedad y momentum precisos
- **Colisiones**: Sistema de detección de colisiones con tubos y suelo
- **Sistema de puntuación**: Gana puntos (y monedas) al pasar entre los tubos

### Sistema de Skins
- **3 skins disponibles**:
  - Default (Gratis)
  - Rojo (5 monedas)
  - Verde (10 monedas)
- Las skins compradas se guardan permanentemente
- Cambia de skin en cualquier momento desde la tienda

### Persistencia de Datos
- **Guardado automático**: Las monedas y progreso se guardan automáticamente
- **Carga automática**: Tu progreso se restaura al iniciar el juego
- Los datos se almacenan en formato JSON

## 🚀 Instalación
### Desde el Release
- Ve al apartado **Release** de este repositorio
- Descarga el archivo comprimido flappy
- Descomprimelo en tu computadora
- Ejecuta el .exe
### IMPORTANTE:
- No elimines el archivo .pck y .console.exe.


### Manual
**Requisitos**
- Godot Engine 4.5 o superior
- Sistema operativo: Windows

**Pasos**
1. Clona o descarga este repositorio
2. Abre Godot Engine 4.5
3. Haz clic en "Importar" y selecciona la carpeta del proyecto
4. Abre `project.godot`
5. Presiona F5 o el botón "Play" para ejecutar el juego

## 🎯 Cómo Jugar

1. **Menú Principal**: 
   - Haz clic en "Jugar" para comenzar
   - Visita la "Tienda" para comprar skins
   - Haz clic en "Salir" para cerrar el juego

2. **Durante el Juego**:
   - Espera la cuenta regresiva de 5 segundos
   - Presiona `Flecha Arriba` para volar
   - Evita los tubos y el suelo
   - Pasa entre los tubos para ganar puntos y monedas

3. **Game Over**:
   - Ve tu puntuación final
   - Reinicia la partida o vuelve al menú

4. **Tienda**:
   - Usa tus monedas para comprar nuevas skins
   - Equipa la skin que prefieras
   - Tus compras se guardan automáticamente

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
│   ├── tubos/          # Obstáculos (tubos)
│   └── ...
├── scripts/            # Scripts globales
│   └── game_manager.gd # Gestor de estado del juego
└── styles/             # Estilos visuales reutilizables
```

## 🔧 Sistema de Guardado

El juego utiliza el sistema de archivos de Godot para guardar el progreso:

**Ubicación del archivo de guardado:**
- Windows: `%APPDATA%\Godot\app_userdata\flappy-bird\save_data.json`

**Datos guardados:**
- Total de monedas acumuladas
- Skins desbloqueadas
- Skin actualmente equipada

## 🛠️ Tecnologías Utilizadas

- **Motor**: Godot Engine 4.5
- **Lenguaje**: GDScript
- **Formato de guardado**: JSON
- **Sistema de físicas**: CharacterBody2D y Area2D

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

**¡Disfruta del juego y trata de conseguir el puntaje más alto! 🏆**
