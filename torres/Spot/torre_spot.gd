extends TextureButton

var torre: Node2D
var spritePoint: Node2D

@export var texturas: Array[Texture2D]

func _ready():
	texture_normal = texturas[0]
	
	spritePoint = $SpritePoint
	
	pressed.connect(pulsado)
	

func pulsado():
	if !is_instance_valid(torre):
		GlobalSignals.pedirTorre.emit(self)
	else:
		pass
	

func colocarTorre(preTorre: Resource):
	torre = preTorre.instanciate()
	spritePoint.add_child(torre)
	
	texture_normal = texturas[1]
	
