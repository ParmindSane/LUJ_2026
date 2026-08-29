extends CanvasLayer

var torres_opciones: Control
var torres_mostrando: bool
var torres_desplegando: bool
var torres_spot: Control
var torres_timer: Timer
var torres_pos: Array[Vector2]
@export var torres_butts: Array[Control]
var torres_pre = [preload("res://torres/Proyectil/torre_proyectil.tscn"),
preload("res://torres/Area/torre_area.tscn"),
preload("res://torres/Invocador/torre_invocador.tscn")]

func _ready():
	torres_opciones = $OpcionesTorres
	torres_timer = $OpcionesTorres/Timer
	
	torres_mostrando = false
	torres_desplegando = false
	
	torres_pos.push_back(torres_opciones.position)
	torres_pos.push_back(Vector2(torres_pos[0].x + torres_opciones.size.x, torres_pos[0].y))
	torres_opciones.position = torres_pos[1]
	
	Global.pedirTorre.connect(torres_vincularConSpot)
	
	for b in torres_butts:
		var i = torres_butts.find(b)
		b.pressed.connect(torres_asignarTorre.bind(i))
	

func _process(delta):
	if !torres_timer.is_stopped():
		var lado = [torres_pos[0].x,torres_pos[1].x]
		if torres_mostrando:
			lado = [torres_pos[1].x,torres_pos[0].x]
		torres_opciones.position.x = Global.map(torres_timer.time_left, torres_timer.wait_time, 0, lado[0], lado[1])
	

func torres_vincularConSpot(nuevoSpot: Control):
	torres_spot = nuevoSpot
	torres_desplegar(true)
	
func torres_asignarTorre(i: int):
	torres_spot.colocarTorre(torres_pre[i])
	torres_desplegar(false)
	

func _input(event: InputEvent) -> void:
	if torres_mostrando:
		# Check if the left mouse button was pressed
		if event is InputEventMouseButton and event.pressed:
			# Get the global mouse position
			var mouse_pos = get_viewport().get_mouse_position()
			# Check if the mouse is outside the button's global rect
			if not torres_opciones.get_global_rect().has_point(mouse_pos):
				torres_desplegar(false)
	

func torres_desplegar(abrir: bool):
	print(str(abrir) + " " + str(torres_mostrando))
	if abrir != torres_mostrando:
		torres_timer.start()
		torres_mostrando = abrir
	
