extends PathFollow2D

var estado: String
@export var volador: bool

var ang: float
var pAng: float

@export var velocidad: float
var pPosition: Vector2

@export var vidaInicial: float
var vidaActual: float

var sprites: AnimatedSprite2D
var animar: String
@export var animaciones: SpriteFrames

signal finPath(yo: PathFollow2D)
@export var paths: Array

func _ready():
	progress = 0
	estado = "AVANZAR"
	pPosition = position
	
	vidaActual = vidaInicial
	
	sprites = $AnimatedSprite2D
	sprites.sprite_frames = animaciones

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
	
	
	if estado != sprites.animation:
		sprites.play(estado)
#			¿REPRODUCIR SPRITE ACOSTADO PARA SOMBRA?
	
	$Label.text = str(vidaActual)
	
	pPosition = position
	pAng = ang
	
