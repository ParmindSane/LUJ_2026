extends Node2D

var clasesEnemigos: ClasesEnemigos = preload("res://enemigos/databaseEnemigos.tres")

var UI: NivelInterfaz
@export var vidas_iniciales: int
var vidas_cantidad: int
var vidas_pCantidad: int
@export var monedas_iniciales: int
var monedas_cantidad: int
var monedas_pCantidad: int

var objetosDeJuego: Node
var spawners: Array[Node]

func _ready():
	UI = $UI
	vidas_cantidad = vidas_iniciales
	monedas_cantidad = monedas_iniciales
	UI.actualizarCarteles(vidas_cantidad, monedas_cantidad)
	
	objetosDeJuego = $ObjetosDeJuego
	spawners = get_tree().get_nodes_in_group("Spawner")
	for s in spawners:
		s.enemigoSpawneado.connect(enemigoSpawneado)
		
	var spots = get_tree().get_nodes_in_group("TorreSpot")
	for s in spots:
		s.dineroTorre.connect(dineroTorre)
	

func _process(delta):
	if vidas_pCantidad != vidas_cantidad || monedas_pCantidad != monedas_cantidad:
		UI.actualizarCarteles(vidas_cantidad, monedas_cantidad)
		
		if vidas_cantidad <= 0:
			get_tree().paused = true
			UI.finDelNivel(false)
		
		var spawnersSinTerminar = spawners.filter(func(s): return s.terminado == false)
		var enemigosVivos = get_tree().get_nodes_in_group("Enemigos")
		if spawnersSinTerminar.is_empty() && enemigosVivos.is_empty():
			UI.finDelNivel(true)
	
	vidas_pCantidad = vidas_cantidad
	monedas_pCantidad = monedas_cantidad
	

func enemigoSpawneado(enemigo: Enemigo):
	enemigo.finPath.connect(enemigoLlega)
	enemigo.matado.connect(enemigoMuerto)
func enemigoLlega(damage: int):
	vidas_cantidad -= damage
func enemigoMuerto(coins: int):
	monedas_cantidad += coins
	

func dineroTorre(coins: int):
	monedas_cantidad += coins
