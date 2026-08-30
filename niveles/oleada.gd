extends Resource
class_name Oleada

var database = preload("res://enemigos/databaseEnemigos.tres")

@export var enemigo: ClasesEnemigos.Clases
@export var cantidad: int = 10

## Cuántos segundos va a esperar la siguiente oleada desde que esta inicia
@export var delay: float = 30

## Cuántas monedas regala al iniciar
@export var monedas: int = 5
