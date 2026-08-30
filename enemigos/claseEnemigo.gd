extends Resource
class_name ClaseEnemigo

## La vida máxima del enemigo
@export var vidaInicial: float = 2

## Lo rápido que avanza
@export var velocidad: float = 1

## Cuánto dinero da al morir
@export var loot: int = 1

## Cuánta vida quita si llega al final
@export var ataqueACore: int = 1

## Cuánto daño les hace a los lobitos
@export var ataqueASoldado: float = 1

## Cuántos segundos tarda entre ataque y ataque
@export var ataqueDelay: float = 1

## Cuántos segundos tarda en spawnear el siguiente del mismo tipo
@export var minSpawnDelay: float = 1

## En FALSE ataca cuerpo a cuerpo, en TRUE dispara proyectiles
@export var aDistancia: bool = false

## En TRUE sólo lo atacan las torres de proyectiles
@export var volador: bool = false

## En FALSE se detiene a atacar lobitos, en TRUE sólo avanza
@export var ignoraSoldados: bool = false

## Las animaciones están en enemigos>assets junto con los sprites. [br]
## Las de enemigos a distancia incluyen los proyectiles, se asignan automáticamente
@export var animaciones: SpriteFrames
