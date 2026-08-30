extends Node2D

@export var botones: Array[BaseButton]
var niveles = [
	"res://niveles/nivel_1.tscn",
	"res://niveles/nivel_2.tscn"
	]

func _ready():
	for b in botones:
		var i = botones.find(b)
		b.pressed.connect(irANivel.bind(niveles[i]))

func irANivel(n: String):
	get_tree().change_scene_to_file(n)
	
