class_name Jogo
extends Node2D

@onready var peca: Sprite2D = $Peca
@onready var ferrovia: Marker2D = $Ferrovia
@export var espacos: Array[Node]
var posicao: int = 0
var numero_espacos: int 

func _ready() -> void:
	numero_espacos = espacos.size()
	print(numero_espacos)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_click") and posicao <= (numero_espacos-1):
		var tween = create_tween()
		tween.tween_property(peca, "position", espacos[posicao].position, 1)
		posicao += 1
	elif posicao == numero_espacos:
		posicao =0
		

   
	
