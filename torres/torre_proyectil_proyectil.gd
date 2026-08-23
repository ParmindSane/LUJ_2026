extends Area2D

var target: Node2D

@export var velocidad: float

func set_target(new_target: Node2D) -> void:
	target = new_target

func _physics_process(delta: float) -> void:
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
