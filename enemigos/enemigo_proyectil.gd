extends Area2D

var target: Node2D
var timer: Timer

@export var velocidad: float
@export var duracion: float
@export var damage: float

var sprites: AnimatedSprite2D
var animacion: SpriteFrames

func set_target(new_target: Node2D, _animacion: SpriteFrames) -> void:
	target = new_target
	animacion = _animacion
	

func _ready():
	timer = $Timer
	timer.start(duracion)
	
	sprites = $AnimatedSprite2D
	sprites.sprite_frames = animacion
	sprites.play("PROYECTIL")
	

func _process(delta):
	if is_instance_valid(target):
		# Find direction vector from projectile to enemy
		var direction = (target.global_position - global_position).normalized()
		# Move the projectile toward the target
		global_position += direction * velocidad * delta
		# Optional: rotate sprite toward target
		rotation = direction.angle()
	else:
		# Delete projectile if target is destroyed or null
		queue_free()
	

func _on_timer_timeout():
	queue_free()
	

func _on_area_entered(area):
	area.vidaActual -= damage
	queue_free()
	
