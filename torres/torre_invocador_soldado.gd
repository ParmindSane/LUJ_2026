extends Area2D

var estado: String

var ang: float
var pAng: float

@export var velocidad: float
var target: Node2D
var pTarget: Node2D

@export var damage: float

@export var vidaInicial: float
var vidaActual: float

var sprites: AnimatedSprite2D
var animar: String

func _ready():
	estado = "AVANZAR"
	vidaActual = vidaInicial
	
	sprites = $AnimatedSprite2D
	
	var random = RandomNumberGenerator.new()
	var margin = 15
	position += Vector2(random.randf_range(-margin,margin), random.randf_range(0,margin))
	

func _process(delta):
	if vidaActual <= 0:
		queue_free()
	
	#print(str(self) + " va a "+ str(target))
	if is_instance_valid(target):
		if estado != "ATACAR":
			estado = "AVANZAR"
			var tgp = target.global_position
			ang = global_position.angle_to_point(tgp)
			var a90 = 0.5*PI
			if ang < -a90 || ang >= a90:
				sprites.flip_h = true
			else:
				sprites.flip_h = false
				
			var direc = (target.global_position - global_position).normalized()
			global_position += direc * velocidad * delta
	else:
		estado = "IDLE"
	
	if estado != sprites.animation:
		sprites.play(estado)
	
	pTarget = target
	
	$Label.text = str(vidaActual)
	

func setTarget(nuevoTarget: Node2D):
	if estado == "ATACAR" && is_instance_valid(target):
		target.setRival(null)
	
	target = nuevoTarget
	

func _on_area_entered(area):
	if area.get_parent() == target:
		target.setRival(self)
		estado = "ATACAR"
	

func _on_animated_sprite_2d_animation_looped():
	if estado == "ATACAR":
		if is_instance_valid(target):
			target.vidaActual -= damage
	
