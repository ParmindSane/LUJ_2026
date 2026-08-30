extends Area2D
class_name Torre

@export var delay: float
@export var precioComprar: int
@export var precioVender: int

var target: Enemigo
var targets: Array[Enemigo]

var colShape: CollisionShape2D
var sprites: AnimatedSprite2D
var spawnpoint: Node2D
var timer: Timer

func _init():
	target = null
	
	sprites = $AnimatedSprite2D
	timer = $Timer
	spawnpoint = $SpawnPoint
	
