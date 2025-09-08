class_name Jogo
extends Node2D

@onready var peca: Sprite2D = $Peca
@onready var ferrovia: Marker2D = $Ferrovia
@export var espacos: Array[Node]
var posicao: int = 0
var numero_espacos: int 
@onready var dado1 := $Dado 


func _ready() -> void:
	numero_espacos = espacos.size()
	print(numero_espacos)
		
func _on_dado_dado_foi_rolado(resultado: Variant) -> void:
	print(resultado)
	while resultado!=0 :
		var tween = create_tween()
		tween.tween_property(peca, "position", espacos[posicao].position, 1) 
		posicao += 1
		resultado -=1
		
		if posicao >= numero_espacos:
			posicao = 0
