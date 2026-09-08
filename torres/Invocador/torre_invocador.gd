extends Torre

var soldadoRef = preload("res://torres/Invocador/torre_invocador_soldado.tscn")
var soldados: Array[Node2D]
@export var maxCantSoldados: int

func _ready():
	colShape = $CollisionShape2D
	area_entered.connect(addTarget)
	area_exited.connect(forgetTarget)
	
	if maxCantSoldados <= 0:
		maxCantSoldados = 3
	

func _process(delta):
	soldados = soldados.filter(func(s): return is_instance_valid(s))
	if timer.is_stopped() && canSpawn():
		spawnSoldado()
	
	targets = targets.filter(func(t): return is_instance_valid(t))
	if targets.size() > 0:
		for s in soldados:
			var i = soldados.find(s)
			s.setTarget(targets[i % targets.size()])
	

func addTarget(enemyArea: Area2D):
	if targets.is_empty() && !$AudioInvocar.playing:
		$AudioInvocar.play()
	
	var nuevoTarget = enemyArea.get_parent()
	if targets.find(nuevoTarget) < 0:
		targets.push_back(nuevoTarget)
	
func forgetTarget(enemyArea: Area2D):
	var salido = enemyArea.get_parent()
	targets.erase(salido)
	

func canSpawn() -> bool:
	return soldados.size() < maxCantSoldados

func spawnSoldado():
	var newSoldado = soldadoRef.instantiate()
	soldados.push_back(newSoldado)
	spawnpoint.add_child(newSoldado)
	
	timer.start(delay)
	
