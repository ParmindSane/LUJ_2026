extends PathFollow2D

var estado: String
@export var volador: bool

var ang: float
var pAng: float

@export var velocidad: float
var pPosition: Vector2

@export var vidaInicial: float
var vidaActual: float

var peleandoCon: Node2D
var venganDeAUno: Array[Node2D]
@export var ataqueASoldado: float
@export var ataqueDelay: float
@export var ataqueACore: float
var timer: Timer

var sprites: AnimatedSprite2D
var animar: String
@export var animaciones: SpriteFrames

signal finPath(yo: PathFollow2D)
var paths: Array

func _ready():
	progress = 0
	estado = "AVANZAR"
	pPosition = position
	
	vidaActual = vidaInicial
	
	sprites = $AnimatedSprite2D
	if sprites.sprite_frames == null && animaciones != null:
		sprites.sprite_frames = animaciones
	
	timer = $Timer

func _process(delta):
	if vidaActual <= 0:
		queue_free()
#		¿APARECE TIRADO UNOS SEGUNDOS CUANDO MUERE?
	
	if estado == "AVANZAR":
		progress += velocidad
		
		if progress_ratio == 1:
			finPath.emit(self)
	
		if pPosition != position:
			ang = pPosition.angle_to_point(position)
			
			var a90 = 0.5*PI
			if ang < -a90 || ang >= a90:
				sprites.flip_h = true
			else:
				sprites.flip_h = false
	
	venganDeAUno = venganDeAUno.filter(func(s): return is_instance_valid(s))
	if venganDeAUno.size() > 0:
		peleandoCon = venganDeAUno[0]
		
		if is_instance_valid(peleandoCon):
			if estado != "ATACAR":
				timer.start(ataqueDelay)
				estado = "ATACAR"
			if global_position.x > peleandoCon.global_position.x:
				sprites.flip_h = true
			else:
				sprites.flip_h = false
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
	venganDeAUno.push_back(s)
	

func _on_timer_timeout():
	if estado == "ATACAR" && is_instance_valid(peleandoCon):
		peleandoCon.vidaActual -= ataqueASoldado
	
