extends PathFollow2D

var proyectilRef = preload("res://enemigos/enemigo_proyectil.tscn")

var estado: String

@export var volador: bool
@export var ignoraSoldados: bool
@export var aDistancia: bool

var ang: float
var pAng: float

@export var velocidad: float
var pPosition: Vector2

@export var vidaInicial: float
var vidaActual: float
@export var loot: int

var colAtaque: Area2D
var colRecibir: Area2D

var target: Node2D
var targets: Array[Node2D]
@export var ataqueASoldado: float
@export var ataqueDelay: float
@export var ataqueACore: float
var timer: Timer

var sprites: AnimatedSprite2D
var animar: String
@export var animaciones: SpriteFrames

signal matado(coins: int)
signal finPath(yo: PathFollow2D)
var paths: Array

func _ready():
	add_to_group("Enemigos")
	
	progress = 0
	estado = "AVANZAR"
	pPosition = position
	
	vidaActual = vidaInicial
	
	sprites = $AnimatedSprite2D
	if animaciones != null:
		sprites.sprite_frames = animaciones
	
	timer = $Timer
	colRecibir = $AreaRecibir
	colAtaque = $AreaAtacar
	
	if !ignoraSoldados && aDistancia:
		colAtaque.area_entered.connect(addTarget)
		colAtaque.area_exited.connect(forgetTarget)
	
	if volador:
		sprites.position = Vector2(25, -40)
		colRecibir.position = Vector2(25, -40)
		colRecibir.collision_layer = 512

func _process(delta):
	if vidaActual <= 0:
		matado.emit(loot)
		queue_free()
#		¿APARECE TIRADO UNOS SEGUNDOS CUANDO MUERE?
	
	if estado == "AVANZAR":
		progress += velocidad
		
		if progress_ratio == 1:
			finPath.emit(self)
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
			
			if global_position.x > target.global_position.x:
				sprites.flip_h = true
			else:
				sprites.flip_h = false
			
			if timer.is_stopped() && aDistancia:
				spawnProyectil()
	else:
		estado = "AVANZAR"
		timer.stop()
	
	if estado != sprites.animation || !sprites.is_playing():
		sprites.play(estado)
#			¿REPRODUCIR SPRITE ACOSTADO PARA SOMBRA?
	
	$Label.text = str(vidaActual)
	
	pPosition = position
	pAng = ang
	

func setRival(s: Node2D):
	if !aDistancia:
		targets.push_back(s)
	
func addTarget(soldado: Area2D):
	targets.push_back(soldado)
	
func forgetTarget(soldado: Area2D):
	targets.erase(soldado)
	

func spawnProyectil():
	var newProyectil = proyectilRef.instantiate()
	newProyectil.set_target(target, sprites.sprite_frames)
	sprites.add_child(newProyectil)
	
	timer.start(ataqueDelay)
	
