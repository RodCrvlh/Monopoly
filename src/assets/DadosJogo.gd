extends Node

var n_jogadores: int = 2
var n_bots: int  = 0
const Imagem: Texture2D = preload("res://src/assets/art/Pecas.png")
@onready var container_pecas: Array[Sprite2D]

var regioes: Array[Rect2] = [ 
	Rect2(-1.5, 21, 146, 131),
	Rect2(170, 14, 107, 139),
	Rect2(305.5, 14, 149, 146),
	Rect2(3.5, 192, 125, 132),
	Rect2(155.5, 189, 131, 112),
	Rect2(323.5, 177, 114, 120),
	Rect2(35.5, 325, 165, 132),
	Rect2(254.5, 328, 159, 128)]

func  _init() -> void:
	instanciando_pecas()
	
func instanciando_pecas() -> void:
	var x = 1465
	var y = 950 
	var offset_x = 50
	var offset_y = 50
		
	for regiao in regioes:
		var nova_peca = Sprite2D.new()
		nova_peca.texture = Imagem
		nova_peca.region_enabled = true
		nova_peca.region_rect = regiao
		nova_peca.position = Vector2(x, y)
		nova_peca.scale = Vector2(0.25, 0.25)
		container_pecas.append(nova_peca)
		
		x += offset_x
		if x >= 1665: 
			x = 1465
			y += offset_y
			
