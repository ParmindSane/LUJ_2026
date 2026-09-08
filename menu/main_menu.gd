extends Node2D

@export var buttJugar: BaseButton
@export var buttSalir: BaseButton

var intro: bool
var introIndex: int
@export var introSprites: Array[Texture2D]

var musicaMenu: AudioStreamPlayer
var musicaIntro: AudioStreamPlayer

func _ready():
	buttJugar.pressed.connect(avanzarIntro)
	buttSalir.pressed.connect(Global.salir)
	
	musicaMenu = $MusicaMenu
	musicaIntro = $MusicaIntro
	

func avanzarIntro():
	if !intro:
		intro = true
		$Intro.show()
		introIndex = -1
		
		musicaMenu.stop()
		musicaIntro.play(1.7)
	
	introIndex += 1
	if introIndex < introSprites.size():
		$Intro/TextureRect.texture = introSprites[introIndex]
	else:
		Global.puntoMusica = musicaIntro.get_playback_position()
		get_tree().change_scene_to_file("res://menu/mapaDeNiveles.tscn")
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if intro:
			avanzarIntro()
	
