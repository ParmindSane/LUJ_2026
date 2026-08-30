extends Resource
class_name Oleada

var database = preload("res://enemigos/databaseEnemigos.tres")

## 
@export var enemigo: ClasesEnemigos.Clases
@export var cantidad: int

## Cuántos segundos va a esperar la siguiente ronda desde que esta inicia
@export var delay: float
