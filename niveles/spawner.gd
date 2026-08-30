extends PathFollow2D
class_name SpawnerEnemigo

var DB = preload("res://enemigos/databaseEnemigos.tres")
var preEnemigo = preload("res://enemigos/enemigo.tscn")

@export var oleadas: Array[Oleada]
var oleada: Oleada
var tiempoOleadas: Timer
var tiempoEnemigos: Timer
var terminado: bool
var spawnsRestantes: int

signal iniciaOleada(i: int, o: Oleada)
signal terminaOleada(i: int, o: Oleada)
signal enemigoSpawneado(enemigo: Enemigo)
signal finDeSpawns()

func _ready():
	if !oleadas.is_empty():
		oleada = oleadas[0]
	
		tiempoEnemigos = $TiempoEntreEnemigos
		tiempoEnemigos.timeout.connect(spawnearEnemigo)
		
		tiempoOleadas = $TiempoEntreOleadas
		tiempoOleadas.timeout.connect(empezarOleada)
		tiempoOleadas.start(10)
	else:
		finDeSpawns.emit()
		terminado = true
	

func empezarOleada():
	spawnsRestantes = oleada.cantidad
	iniciaOleada.emit(oleadas.find(oleada), oleada)
	
	spawnearEnemigo()
	

func spawnearEnemigo():
	if spawnsRestantes > 0:
		var nuevoEnemigo:Enemigo = preEnemigo.instantiate()
		nuevoEnemigo.setClase(oleada.enemigo, DB.databaseEnemigos[oleada.enemigo])
		get_parent().add_child(nuevoEnemigo)
		
		tiempoEnemigos.start(nuevoEnemigo.minSpawnDelay)
		spawnsRestantes -= 1
		
		enemigoSpawneado.emit(nuevoEnemigo)
	else:
		if oleadas.find(oleada)+1 < oleadas.size():
			terminaOleada.emit(oleadas.find(oleada), oleada)
			tiempoOleadas.start(oleada.delay)
			oleada = oleadas[oleadas.find(oleada)+1]
		else:
			finDeSpawns.emit()
			terminado = true
	
