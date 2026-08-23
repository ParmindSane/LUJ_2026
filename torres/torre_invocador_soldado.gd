extends Area2D

@export var vidaInicial: float
var vidaActual: float

var target: Node2D

func _ready():
	vidaActual = vidaInicial
