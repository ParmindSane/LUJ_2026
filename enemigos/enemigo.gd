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
	
	ang = pPosition.angle_to_point(position)
	if ang != pAng:
		var a45 = 0.25*PI
		if ang > -a45*3 && ang < -a45:
			mirando = "ARRIBA"
		elif ang >= -a45 && ang <= a45:
			mirando = "DERECHA"
		elif ang > a45 && ang < a45*3:
			mirando = "ABAJO"
		elif ang >= a45*3 || ang <= -a45*3:
			mirando = "IZQUIERDA"
		
		animar = estado+"_"+mirando
		if animar != sprites.animation:
			sprites.play(animar)
	
	$Label.text = str(vidaActual)
	
	
	pPosition = position
	pAng = ang
	
