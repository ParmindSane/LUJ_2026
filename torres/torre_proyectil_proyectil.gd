extends Area2D

var target: Node2D
@export var timer: Timer

@export var velocidad: float
@export var duracion: float
@export var damage: float

func set_target(new_target: Node2D) -> void:
	target = new_target
	

func _ready():
	timer.start(duracion)
	

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
	area.get_parent().vidaActual -= damage
	queue_free()
	
