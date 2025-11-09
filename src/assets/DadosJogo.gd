extends Node

var n_jogadores: int = 2
var n_bots: int  = 0
@onready var container_pecas: Array[Sprite2D]


func instanciando_pecas() -> void:
	
	var x = 870
	var y = 950
	var offset_x = 30
	var offset_y = 30
	
	var i = 0
	while i < n_jogadores:
		
		var nova_imagem = Sprite2D.new()
		
		if i == 0:
			var textura: Texture2D = load("res://src/assets/art/peças/peças/PawnsA1.png")
			nova_imagem.texture = textura
		
		elif i == 1:
			x += offset_x 
			var textura: Texture2D = preload("res://src/assets/art/peças/peças/PawnsA2.png")
			nova_imagem.texture = textura
			
		elif i == 2:
			x -= offset_x
			y += offset_y
			var textura: Texture2D = preload("res://src/assets/art/peças/peças/PawnsA3.png")
			nova_imagem.texture = textura
		
		elif i == 3:
			x += offset_x
			var textura: Texture2D = preload("res://src/assets/art/peças/peças/PawnsA4.png")
			nova_imagem.texture = textura
		
		nova_imagem.position = Vector2(x,y)
		nova_imagem.scale = Vector2(0.5, 0.5)
		nova_imagem.z_index = 2
		add_child(nova_imagem)
		container_pecas.append(nova_imagem)
		
		i += 1
	
