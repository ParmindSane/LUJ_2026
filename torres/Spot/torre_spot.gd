extends TextureButton

var torre: Node2D
var selected: bool

var spritePoint: Node2D
var vender: Button

@export var texturas: Array[Texture2D]

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
		Global.pedirTorre.emit(self)
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
	

func colocarTorre(preTorre):
	torre = preTorre.instantiate()
	spritePoint.add_child(torre)
	
	texture_normal = texturas[1]
	selected = false
	
func venderTorre():
	torre.queue_free()
	vender.hide()
	
	texture_normal = texturas[0]
	selected = false
	

func hoverIn():
	modulate = Color(1.5, 1.5, 1.5)
func hoverOut():
	if !selected:
		modulate = Color(1.0, 1.0, 1.0)
