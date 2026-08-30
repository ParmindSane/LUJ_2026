extends CanvasLayer
class_name NivelInterfaz

@export var vidas_cartel: Label
var vidas_actuales: int
@export var monedas_cartel: Label
var monedas_actuales: int

var torres_opciones: Control
var torres_mostrando: bool
var torres_desplegando: bool
var torres_spot: Control
var torres_timer: Timer
var torres_pos: Array[Vector2]
@export var torres_butts: Array[BaseButton]
var torres_carteles: Array[Label]
var torres_pre = [preload("res://torres/Proyectil/torre_proyectil.tscn"),
preload("res://torres/Area/torre_area.tscn"),
preload("res://torres/Invocador/torre_invocador.tscn")]

@export var buttSalir: BaseButton

func _ready():
	torres_opciones = $OpcionesTorres
	torres_timer = $OpcionesTorres/Timer
	torres_mostrando = false
	torres_desplegando = false
	torres_pos.push_back(torres_opciones.position)
	torres_pos.push_back(Vector2(torres_pos[0].x + torres_opciones.size.x*1.01, torres_pos[0].y))
	torres_opciones.position = torres_pos[1]
	
	var spots = get_tree().get_nodes_in_group("TorreSpot")
	for s in spots:
		s.pedirTorre.connect(torres_vincularConSpot)
	for t in torres_pre:
		var i = torres_pre.find(t)
		torres_pre[i] = t.instantiate()
	for b in torres_butts:
		var i = torres_butts.find(b)
		var t = torres_pre[i]
		b.pressed.connect(torres_asignarTorre.bind(t))
		torres_carteles.push_back(b.get_parent().get_child(0).get_child(2))
		torres_carteles[i].text = "(💰 " + str(t.precioComprar) + ")"
	

func _process(delta):
	if !torres_timer.is_stopped():
		var lado = [torres_pos[0].x,torres_pos[1].x]
		if torres_mostrando:
			lado = [torres_pos[1].x,torres_pos[0].x]
		torres_opciones.position.x = Global.map(torres_timer.time_left, torres_timer.wait_time, 0, lado[0], lado[1])
	

func torres_vincularConSpot(nuevoSpot: Control):
	torres_spot = nuevoSpot
	torres_desplegar(true)
	
func torres_asignarTorre(t: Torre):
	torres_spot.colocarTorre(t.duplicate())
	torres_desplegar(false)
	
func torres_desplegar(abrir: bool):
	if abrir != torres_mostrando:
		torres_timer.start()
		torres_mostrando = abrir
	

func _input(event: InputEvent) -> void:
	if torres_mostrando:
		if event is InputEventMouseButton and event.pressed:
			var mouse_pos = get_viewport().get_mouse_position()
			if not torres_opciones.get_global_rect().has_point(mouse_pos):
				torres_desplegar(false)
	

func actualizarCarteles(vidas: int, coins: int):
	vidas_actuales = vidas
	vidas_cartel.text = "❤️ " + str(vidas) + " "
	
	monedas_actuales = coins
	monedas_cartel.text = "💰 " + str(coins) + " "
	
	for b in torres_butts:
			var i = torres_butts.find(b)
			var t = torres_pre[i]
			if t.precioComprar > monedas_actuales:
				b.disabled = true
				torres_carteles[i].self_modulate = Color(1.0, 0.0, 0.0, 1.0)
			else:
				b.disabled = false
				torres_carteles[i].self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	

func finDelNivel(victoria: bool):
	$GanarPerder.show()
	if victoria:
		$GanarPerder/Ganar.show()
	else:
		$GanarPerder/Perder.show()
	buttSalir.pressed.connect(salir)
	
func salir():
	get_tree().change_scene_to_file("res://menu/mapaDeNiveles.tscn")
	
