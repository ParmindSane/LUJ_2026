extends Node2D

var UI: Node
@export var vidas_iniciales: int
var vidas_cantidad: int
@export var monedas_iniciales: int
var monedas_cantidad: int

var enemigos: Array[Node]

func _ready():
	UI = $UI
	
	enemigos = get_tree().get_nodes_in_group("Enemigos")
	

func _process(delta):
	pass
	

func enemigoLlega(damage: int):
	vidas_cantidad -= damage
func enemigoMuerto(coins: int):
	monedas_cantidad += coins
	
