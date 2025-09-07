class_name Jogo
extends Node2D

@onready var peca: Sprite2D = $Peca
@onready var ferrovia: Marker2D = $Ferrovia
@export var espacos: Array[Node]
var posicao: int = 14

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_click"):
		var tween = create_tween()
		tween.tween_property(peca, "position", espacos[posicao].position, 1)
			
   
	
