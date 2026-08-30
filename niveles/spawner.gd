extends PathFollow2D

@export var oleadas: Array[Oleada]
var oleada = Oleada
var tiempoOleadas: Timer
var tiempoEnemigos: Timer

func _ready():
	oleada = oleadas[0]
	tiempoOleadas = $TiempoEntreOleadas
	tiempoEnemigos = $TiempoEntreEnemigos
	

func _process(delta):
	pass
	
