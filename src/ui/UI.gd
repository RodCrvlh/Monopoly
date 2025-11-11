extends CanvasLayer
class_name Ui

signal vender(valor_a_ser_pago)
signal venda_acabou(propriedades_vendidas)

@onready var rolar_dados: BoxContainer = $RolarDados
@onready var dados_animation_1: Node2D = $DadosAnimation/DadosAnimation1
@onready var dados_animation_2: Node2D = $DadosAnimation/DadosAnimation2
@onready var label_nome_jogadores: Array[Label]
@onready var label_dinheiro_jogadores: Array[Label]
@onready var label_sua_vez: Label
@onready var box_container: Array[PackedScene]


func _ready():
	rolar_dados.visible = true
	criar_labels()
	box_container.resize(9)
	box_container[0] = preload("res://src/assets/Box/Comprarbox.tscn")
	box_container[1] = preload("res://src/assets/Box/AluguelBox.tscn")
	box_container[2] = preload("res://src/assets/Box/LeilaoBox.tscn")
	box_container[3] = preload("res://src/assets/Box/ic_box.tscn")
	box_container[4] = preload("res://src/assets/Box/VendaBox.tscn")
	box_container[5] = preload("res://src/assets/Box/CompraNegadaBox.tscn")
	box_container[6] = preload("res://src/assets/Box/BoxFim.tscn")
	box_container[7] = preload("res://src/assets/Box/AprimoraBox.tscn")
	box_container[8] = preload("res://src/assets/Box/AprimorarNegada.tscn")
	
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


func ativar_box(espaco: Espaco, player_atual: Player) -> CenterContainer: 
	
	if espaco is Disciplina or espaco is OrgaoBolsa or espaco is Freelance:
		
		if espaco.comprada == false:
		
			if player_atual.dinheiro > espaco.precoCompra:
	
				var box = box_container[0]
				var box_compra = box.instantiate()
				add_child(box_compra)
				box_compra.set_mensagem(espaco.precoCompra)
				box_compra.set_espaco(espaco)
		
				return box_compra
			
			else:
				var box = box_container[5]
				var box_compra_negada = box.instantiate()
				add_child(box_compra_negada)
				return
				
				
		if espaco.proprietario != player_atual.nome_jogador:
			print(player_atual.nome_jogador+" esta pagando aluguel")
			var box = box_container[1]
			var box_aluguel = box.instantiate()
			add_child(box_aluguel)
			box_aluguel.set_mensagem(espaco.aluguel_atual)
			box_aluguel.set_espaco(espaco)
			box_aluguel.set_player_atual(player_atual)
			return box_aluguel
		
		elif espaco.proprietario == player_atual.nome_jogador and espaco is Disciplina:
			if player_atual.dinheiro > espaco.valor_casa:
				print("Acionando aprimorarCredito")
				var box = box_container[7]
				var box_aprimora = box.instantiate()
				add_child(box_aprimora)
				box_aprimora.set_mensagem(espaco.valor_casa)
				box_aprimora.set_espaco(espaco)
				box_aprimora.set_player(player_atual)
			
			else:
				var box = box_container[8]
				var box_aprimora_negada = box.instantiate()
				add_child(box_aprimora_negada)
				
				
			return  
	
	if espaco is IC or espaco is Sorte:
		var box = box_container[3]
		var box_ic = box.instantiate()
		add_child(box_ic) 
		espaco.realizar_acao(player_atual)
		var textoBox = Baralho.getText(espaco.carta_atual)
		box_ic.set_mensagem(textoBox)  
		
		if player_atual.divida > 0:
			emit_signal("vender", player_atual.divida)
		
		return
		
	if espaco is Imposto:
		var box = box_container[3]
		var box_ic = box.instantiate()
		add_child(box_ic) 
		espaco.pagarImposto(player_atual)
		box_ic.set_mensagem("Você teve que pagar R$200 de imposto.")
		
		if player_atual.divida > 0:
			emit_signal("vender", player_atual.divida)
		
		return

	return null


func ativar_box_leilao(nome_jogador: String) -> CenterContainer:
	var box = box_container[2]
	var box_leilao = box.instantiate()
	add_child(box_leilao)
	box_leilao.name = "Box_Leilao"
	box_leilao.set_nome_jogador_atual(nome_jogador)
	
	return box_leilao


func ativar_box_venda(player:Player, divida: int, valores_propriedades: Array[int]) -> CenterContainer:
	var box = box_container[4]
	var box_venda = box.instantiate()
	add_child(box_venda)
	
	box_venda.set_nome_jogador(player.nome_jogador)
	box_venda.set_propriedades_possuidas(player.propriedades_possuidas, valores_propriedades)
	box_venda.set_divida(divida)
	


	return box_venda


func ativar_box_fim(player:Player):
	var box = box_container[6]
	var box_fim = box.instantiate()
	add_child(box_fim)
	
	box_fim.set_label(player.nome_jogador)
	return box_fim


func set_label_dinheiro(precoCompra: int, id_jogador_atual:int):
	label_dinheiro_jogadores[id_jogador_atual].text = "Dinheiro: R$"+ str(precoCompra)
