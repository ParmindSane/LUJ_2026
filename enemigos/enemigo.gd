extends PathFollow2D

var estado: String
var mirando: String

var ang: float
var pAng: float

@export var velocidad: float
var pPosition: Vector2

@export var vidaInicial: float
var vidaActual: float

var sprites: AnimatedSprite2D
var animar: String

signal finPath(yo: )

func _ready():
	progress = 0
	estado = "AVANZAR"
	pPosition = position
	
	vidaActual = vidaInicial
	
	sprites = $AnimatedSprite2D

func _process(delta):
	if vidaActual <= 0:
		queue_free()
	
	if estado == "AVANZAR":
		progress += velocidad
		
		if progress_ratio == 1:
			queue_free()
	
	if pPosition != position:
		ang = pPosition.angle_to_point(position)

		var a45 = 0.25*PI
		if ang > -a45*3 && ang < -a45:
			mirando = "ARRIBA"
		elif ang >= -a45 && ang <= a45:
			mirando = "DERECHA"
			sprites.flip_h = false
		elif ang > a45 && ang < a45*3:
			mirando = "ABAJO"
		elif ang >= a45*3 || ang <= -a45*3:
			mirando = "IZQUIERDA"
			sprites.flip_h = true
		
		animar = estado+"_"+mirando
		if animar != sprites.animation:
			sprites.play(animar)
	
	$Label.text = str(vidaActual)
	
	pPosition = position
	pAng = ang
	
