extends Torre

var proyectilRef: Area2D
var colShape: CollisionShape2D
var target: Node2D

func _ready():
	target = null
	
	proyectilRef = $Proyectil
	
	colShape = $CollisionShape2D
	area_entered.connect(spawnProyectil)

func spawnProyectil(enemyArea: Area2D):
	if target == null:
		target = enemyArea.get_parent()
		
		var newProyectil = proyectilRef.duplicate()
		newProyectil.set_target(target)
		add_child(newProyectil)
	
