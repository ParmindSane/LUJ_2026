extends PathFollow2D
class_name Enemigo

var claseData: ClaseEnemigo

var proyectilRef = preload("res://enemigos/enemigo_proyectil.tscn")

var estado: String

var volador: bool
var ignoraSoldados: bool
var aDistancia: bool

var ang: float
var pAng: float

var velocidad: float
var pPosition: Vector2

var minSpawnDelay: float

var vidaInicial: float
var vidaActual: float
var loot: int

var colAtaque: Area2D
var colRecibir: Area2D

var target: Node2D
var targets: Array[Node2D]
var ataqueASoldado: float
var ataqueDelay: float
var ataqueACore: float
var timer: Timer

var sprites: AnimatedSprite2D
var animar: String
var animaciones: SpriteFrames

signal matado(coins: int)
signal finPath(yo: PathFollow2D)
var paths: Array

func setClase(cn: ClasesEnemigos.Clases, c: ClaseEnemigo):
	claseData = c
	
	volador = claseData.volador
	ignoraSoldados = claseData.ignoraSoldados
	aDistancia = claseData.aDistancia
	velocidad = claseData.velocidad
	minSpawnDelay = claseData.minSpawnDelay
	vidaInicial = claseData.vidaInicial
	loot = claseData.loot
	ataqueASoldado = claseData.ataqueASoldado
	ataqueDelay = claseData.ataqueDelay
	ataqueACore = claseData.ataqueACore
	animaciones = claseData.animaciones
	
	vidaActual += vidaInicial
	
	sprites = $AnimatedSprite2D
	sprites.sprite_frames = animaciones
		
	if volador:
		aDistancia = true
	else:
		ignoraSoldados = false
	
	colAtaque = $AreaAtacar
	if !ignoraSoldados && aDistancia:
		colAtaque.area_entered.connect(addTarget)
		colAtaque.area_exited.connect(forgetTarget)
	
	colRecibir = $AreaRecibir
	if volador:
		sprites.position = Vector2(25, -40)
		colRecibir.position = Vector2(25, -40)
		colRecibir.collision_layer = 512
	
	if cn == ClasesEnemigos.Clases.Mari:
		scale = Vector2(0.2,0.2)
	

func _ready():
	add_to_group("Enemigos")
	
	progress = 0
	estado = "AVANZAR"
	pPosition = position
	
	sprites = $AnimatedSprite2D
	timer = $Timer
	colRecibir = $AreaRecibir
	colAtaque = $AreaAtacar
	

func _process(delta):
	if vidaActual <= 0:
		matado.emit(loot)
		queue_free()
	
	if estado == "AVANZAR":
		progress += velocidad
		
		if progress_ratio == 1:
			finPath.emit(ataqueACore)
			queue_free()
	
		if pPosition != position:
			ang = pPosition.angle_to_point(position)
			
			var a90 = 0.5*PI
			if ang < -a90 || ang >= a90:
				sprites.flip_h = true
			else:
				sprites.flip_h = false
	
	targets = targets.filter(func(t): return is_instance_valid(t))
	if targets.size() > 0:
		target = targets[0]
		
		if is_instance_valid(target):
			if estado != "ATACAR":
				timer.start(ataqueDelay)
				estado = "ATACAR"
				print(str(self) + " peleando con "+str(target))
			
			if global_position.x > target.global_position.x:
				sprites.flip_h = true
			else:
				sprites.flip_h = false
			
			if timer.is_stopped():
				if aDistancia:
					spawnProyectil()
				else:
					atacarRival()
	else:
		estado = "AVANZAR"
		timer.stop()
	
	if estado != sprites.animation || !sprites.is_playing():
		sprites.play(estado)
	
	$Label.text = str(vidaActual) + "\n" + str(target)
	
	pPosition = position
	pAng = ang
	

func setRival(s: Node2D):
	if !volador:
		targets.push_back(s)
	
func herir(damage: float):
	vidaActual -= damage
	

func addTarget(soldado: Area2D):
	targets.push_back(soldado)
	
func forgetTarget(soldado: Area2D):
	targets.erase(soldado)
	

func atacarRival():
	if estado == "ATACAR" && is_instance_valid(target):
		target.herir(ataqueASoldado)
	
func spawnProyectil():
	var newProyectil = proyectilRef.instantiate()
	newProyectil.set_target(target, sprites.sprite_frames)
	sprites.add_child(newProyectil)
	
	timer.start(ataqueDelay)
	
