extends PathFollow2D
class_name SpawnerEnemigo

var DB = preload("res://enemigos/databaseEnemigos.tres")

@export var oleadas: Array[Oleada]
var oleada = Oleada
var tiempoOleadas: Timer
var tiempoEnemigos: Timer
var terminado: bool

signal iniciaOleada(i: int, o: Oleada)
signal enemigoSpawneado(enemigo: Enemigo)
signal finDeSpawns()

func _ready():
	oleada = oleadas[0]
	tiempoOleadas = $TiempoEntreOleadas
	tiempoEnemigos = $TiempoEntreEnemigos
	

func _process(delta):
	pass
	

func empezarOleada():
	pass
	

func spawnearEnemigo():
	pass
	
