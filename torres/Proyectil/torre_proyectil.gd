extends Torre

var proyectilRef = preload("res://torres/Proyectil/torre_proyectil_proyectil.tscn")


func _ready():
	colShape = $CollisionShape2D
	area_entered.connect(addTarget)
	area_exited.connect(forgetTarget)
	

func _process(delta):
	targets = targets.filter(func(t): return is_instance_valid(t))
	if targets.size() > 0:
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
	sprites.play("ATACAR")
	

func _on_animated_sprite_2d_animation_finished():
	sprites.play("IDLE")
	
