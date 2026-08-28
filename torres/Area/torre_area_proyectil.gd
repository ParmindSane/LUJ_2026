extends Area2D

var target: Node2D
@export var timer: Timer

@export var velocidad: float
@export var duracion: float
@export var damage: float

var explosion: Area2D
var exploted: bool
var pExploted: bool

func set_target(new_target: Node2D) -> void:
	target = new_target
	

func _ready():
	explosion = $Explosion
	exploted = false
	pExploted = false
	
	timer.start(duracion)
	

func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		# Find direction vector from projectile to enemy
		var targetPos = target.get_node(^"AreaRecibir").global_position
		var direction = (targetPos - global_position).normalized()
		# Move the projectile toward the target
		global_position += direction * velocidad * delta
		# Optional: rotate sprite toward target
		rotation = direction.angle()
	else:
		# Delete projectile if target is destroyed or null
		queue_free()
	
	if exploted:
		if pExploted == exploted:
			queue_free()
		
		pExploted = exploted
	

func _on_timer_timeout():
	explotar()
	
func _on_area_entered(area):
	explotar()
	
func explotar():
	explosion.visible = true
	explosion.monitoring = true
	explosion.monitorable = true
	
	exploted = true
	

func _on_explosion_area_entered(area):
	area.get_parent().vidaActual -= damage
	
