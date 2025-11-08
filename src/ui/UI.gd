extends CanvasLayer
class_name Ui

@onready var rolar_dados: BoxContainer = $RolarDados
@onready var dados_animation_1: Node2D = $DadosAnimation/DadosAnimation1
@onready var dados_animation_2: Node2D = $DadosAnimation/DadosAnimation2
@onready var label_nome_jogadores: Array[Label]
@onready var label_dinheiro_jogadores: Array[Label]
@onready var label_sua_vez: Label


func _ready():
	rolar_dados.visible = true
	criar_labels()


func criar_labels():
	var i = 0
	var x = 1070
	var y = 420
	var offset_x = 370
	var offset_y = 340
	var dif = 40
	
	label_nome_jogadores.resize(DadosJogo.n_jogadores)
	label_dinheiro_jogadores.resize(DadosJogo.n_jogadores)
	
	label_sua_vez = Label.new()
	label_sua_vez.text = "Sua vez!"
	label_sua_vez.theme = load("res://src/assets/art/DefaultTheme.tres")
	add_child(label_sua_vez)
	
	while i < DadosJogo.n_jogadores:
		var nome_label = Label.new()
		var dinheiro_label = Label.new()
		
		add_child(nome_label)
		add_child(dinheiro_label)
		
		nome_label.position = Vector2(x,y-dif)
		nome_label.text = "Player"+str(i)
		nome_label.theme = load("res://src/assets/art/DefaultTheme.tres")
		
		dinheiro_label.position = Vector2(x,y)
		dinheiro_label.text = "Dinheiro: "+ str(1500)
		dinheiro_label.theme = load("res://src/assets/art/DefaultTheme.tres")
		
		label_nome_jogadores[i] = nome_label
		label_dinheiro_jogadores[i] = dinheiro_label 
		
		if i == 0:
			x += offset_x
		
		if i == 1:
			x -= offset_x
			y += offset_y
		
		if i == 2:
			x += offset_x
		
		i += 1


func mover_label_sua_vez(id_peao: int):
	
	var x = label_sua_vez.position.x 
	var y = label_sua_vez.position.y
	
	var offset_x = 370
	var offset_y = 350
	
	if id_peao == 0:
		x = label_nome_jogadores[0].position.x
		y = label_nome_jogadores[0].position.y-40
	
	if id_peao == 1:
		x += offset_x
	
	elif id_peao == 2:
		x -= offset_x 
		y += offset_y
	
	elif id_peao == 3:
		x += offset_x
		
	label_sua_vez.position = Vector2(x, y)


func set_rolar_dados_visibility(b: bool):
	rolar_dados.set_button_visibility(b)
	rolar_dados.visible = b 


func animacao_rolar(res1: int, res2: int):
	dados_animation_1.animacao_rolar(res1)
	dados_animation_2.animacao_rolar(res2)
