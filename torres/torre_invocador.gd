extends Torre

var soldadoRef: Area2D
var soldados: Array[Area2D]

func _ready():
	soldadoRef = $Soldado
	soldadoRef.process_mode = Node.PROCESS_MODE_DISABLED
	soldadoRef.visible = false
