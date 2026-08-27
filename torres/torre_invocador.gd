extends Torre

var soldadoRef = preload("res://torres/torre_invocador_soldado.tscn")
var soldados: Array[Node2D]
var waitPoints: Array[Node]
@export var cantidadSoldados: int

var colShape: CollisionShape2D
var target: Node2D
var pTarget: Node2D
var targets: Array[Node2D]

func _ready():
	target = null
	pTarget = target
	
	colShape = $CollisionShape2D
	area_entered.connect(addTarget)
	area_exited.connect(forgetTarget)
	
	waitPoints = $SpawnPoint.get_children()
	
	if cantidadSoldados <= 0:
		cantidadSoldados = 3
	

func _process(delta):
	
	var canSpawn = soldados.size() < cantidadSoldados
	if canSpawn:
		for s in soldados:
			if !is_instance_valid(s):
				soldados.erase(s)
	
	if targets.size() > 0:
		for t in targets:
			if !is_instance_valid(t):
				targets.erase(t)
		
		target = targets[0]
	else:
		target = null
	
	if pTarget != target:
		for s in soldados:
			setTargetSoldado(s)
	
	if timer.is_stopped() && canSpawn:
		spawnSoldado()
	
	pTarget = target
	

func addTarget(enemyArea: Area2D):
	var nuevoTarget = enemyArea.get_parent()
	if targets.find(nuevoTarget) < 0:
		targets.push_back(nuevoTarget)
	
func forgetTarget(enemyArea: Area2D):
	var salido = enemyArea.get_parent()
	targets.erase(salido)
	

func spawnSoldado():
	var newSoldado = soldadoRef.instantiate()
	soldados.push_back(newSoldado)
	setTargetSoldado(newSoldado)
	spawnpoint.add_child(newSoldado)
	
	timer.start(delay)
	

func setTargetSoldado(s: Node2D):
	var t = target
	var e = target != null
	if !e:
		var i = soldados.find(s)
		t = waitPoints[i]
	
	s.setTarget(t, e)
	
