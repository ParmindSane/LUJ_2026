extends TextureButton
class_name TorreSpot

var torre: Node2D
var selected: bool

var spritePoint: Node2D
var vender: BaseButton

@export var texturas: Array[Texture2D]

signal pedirTorre(spot: TorreSpot)
signal dineroTorre(precio: int)

func _ready():
	texture_normal = texturas[0]
	
	spritePoint = $SpritePoint
	vender = $Vender
	vender.pressed.connect(venderTorre)
	
	selected = false
	pressed.connect(pulsado)
	mouse_entered.connect(hoverIn)
	mouse_exited.connect(hoverOut)
	

func pulsado():
	selected = true
	if !is_instance_valid(torre):
		pedirTorre.emit(self)
	else:
		vender.show()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		if not get_global_rect().has_point(mouse_pos):
			if is_instance_valid(torre):
				vender.hide()
			
			selected = false
			hoverOut()
	

func colocarTorre(preTorre: Torre):
	torre = preTorre
	spritePoint.add_child(torre)
	
	texture_normal = texturas[1]
	selected = false
	
	dineroTorre.emit(-torre.precioComprar)
	vender.text = "Vender\n($ " + str(torre.precioVender) + ")"
	
func venderTorre():
	torre.queue_free()
	vender.hide()
	
	texture_normal = texturas[0]
	selected = false
	
	dineroTorre.emit(+torre.precioVender)
	

func hoverIn():
	modulate = Color(1.5, 1.5, 1.5)
func hoverOut():
	if !selected:
		modulate = Color(1.0, 1.0, 1.0)
