extends Torre

var proyectilRef = preload("res://torres/torre_area_proyectil.tscn")

var colShape: CollisionShape2D
var target: Node2D
var targets: Array[Node2D]

func _ready():
	target = null
	
	colShape = $CollisionShape2D
	area_entered.connect(addTarget)
	area_exited.connect(forgetTarget)
	

func _process(delta):
	if targets.size() > 0:
		for t in targets:
			if !is_instance_valid(t):
				targets.erase(t)
		
		target = targets[0]
		
		if is_instance_valid(target) && timer.is_stopped():
			spawnProyectil()
	else:
		target = null
	

func addTarget(enemyArea: Area2D):
	var nuevoTarget = enemyArea.get_parent()
	if targets.find(nuevoTarget) < 0:
		targets.push_back(nuevoTarget)
	
func forgetTarget(enemyArea: Area2D):
	var salido = enemyArea.get_parent()
	targets.erase(salido)
	

func spawnProyectil():
	var newProyectil = proyectilRef.instantiate()
	newProyectil.set_target(target)
	spawnpoint.add_child(newProyectil)
	
	timer.start(delay)
	
