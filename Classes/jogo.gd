class_name Jogo
extends Node2D

@onready var timer: Timer = $Timer
@onready var tabuleiro: Tabuleiro = $Tabuleiro
@onready var dado1 := $Dado 
@onready var dado2: Dado = $Dado2
@onready var canvas_layer: CanvasLayer = $CanvasLayer 
@onready var turnoLabel: Label = $CanvasLayer/Turno
@onready var propriedadesButton: Button = $Propriedades
@export var boxs: Array[PackedScene]
var players: Array[Player]
var resultadoTotal: int 
var turno: int = 0

#Inicializa as variáveis da própria classe
func _init() -> void:
	
	var i = 0
	var x = 1660
	var y = 200
	var offset_x = 150
	var offset_y = 50
	players.resize(DadosJogo.n_jogadores) 
	while i < players.size():
		var peca = DadosJogo.container_pecas[i]
		players[i] = Player.new("Player"+str(i),peca, x, y, offset_x, offset_y)
		y += offset_y
		i += 1

#A função ready inicialiaz os nós na arvore de nos, todos nos que estao em cena
#fazem parte da arvore de nós
func _ready() -> void:
	Events.box_acabou.connect(on_box_acabou)
	Events.compra_sim.connect(on_compra_sim)

	var i = 0
	while i < players.size():
		add_child(players[i])
		i += 1
	
	turnoLabel.text = "Turno: " + players[turno].nome

#na jogada o objetivo  é resetar o turno, movimentar a peca 
#e mias para frente verificar se o jogador esta preso
func jogada() -> void:
	movimenta_peca()
	if turno >= DadosJogo.n_jogadores:
		turno = 0
	
#Faz a iteracao de cada espaco a ser andando de acordo com o resultadoTotal do movimento
func movimenta_peca() -> void:
	#Teste
	#resultadoTotal = 41
	while resultadoTotal>0 :
		
		players[turno].posicao += 1
		resultadoTotal -=1
		
		if players[turno].posicao >= tabuleiro.espacos.size():
			players[turno].posicao = 0
			encontrar_box(Tipo.Espaco.INICIO)
			
		await(mover())

	
	dado1.can_click = true 
	dado2.can_click = true 
	
	if players[turno].posicao != 0:
		encontrar_box(tabuleiro.espacos[players[turno].posicao].tipo)
		await(Events.box_acabou)
	
	resultadoTotal = 0
	turno += 1
	
	if turno >= DadosJogo.n_jogadores:
		turno = 0
	
	turnoLabel.text = "Turno: "+ players[turno].nome 

	  
#Apaga a imagem de peca e coloca ela em um novo local
func mover() -> void: 
	var tween = create_tween()
	tween.tween_property(players[turno].peca, "position", tabuleiro.espacos[players[turno].posicao].position, 1.0)
	timer.start()
	await timer.timeout


#Encontra a box relacionada ao espaco especifico que o jogador parou 
func encontrar_box(tipo: Tipo.Espaco) -> void:
	dado1.can_click = false 
	dado2.can_click = false
	
	if tipo == Tipo.Espaco.INICIO:
		var box =  boxs[3] 
		var box_inicio = box.instantiate()
		canvas_layer.add_child(box_inicio)	
		players[turno].receberAluguel(200)

	#verifica se o espaco é uma propriedade	
	if tipo == Tipo.Espaco.TERRENO or tipo == Tipo.Espaco.FERROVIA or tipo == Tipo.Espaco.SERVICO:
		
		var propriedade = tabuleiro.encontrarPropriedade(players[turno].posicao, tipo)
	
		#caso o espaco nao foi comprado
		if propriedade.comprada == false:
			if players[turno].dinheiro >= propriedade.preco_compra:
				var box =  boxs[0] 
				var box_compra = box.instantiate()
				canvas_layer.add_child(box_compra)
				box_compra.setMensagem(propriedade.preco_compra)
		
		#propriedade ja foi comprado e verifica se jogador nao é proprietario 
		elif players[turno].nome != propriedade.proprietario:
			
			var box =  boxs[2] 
			var box_aluguel = box.instantiate()
			canvas_layer.add_child(box_aluguel)
			box_aluguel.setMensagem(propriedade.aluguel)
			
			players[turno].pagarAluguel(propriedade.aluguel)
			
			var i = 0
			while true:
				if players[i].nome == propriedade.proprietario:
					players[i].receberAluguel(propriedade.aluguel)
					break;
				i += 1

	if tipo == Tipo.Espaco.CADEIA:
		var box =  boxs[1] 
		var box_prisao = box.instantiate()
		canvas_layer.add_child(box_prisao)
		
	if tipo == Tipo.Espaco.COFRE:
		pass
			
	if tipo == Tipo.Espaco.SORTE:
		pass
	
	if tipo == Tipo.Espaco.IMPOSTODERENDA:
		pass
		
	if tipo == Tipo.Espaco.TAXADERIQUEZA: 
		pass
	
	if tipo == Tipo.Espaco.VAPARACADEIA:
		pass
	
	dado1.can_click = true 
	dado2.can_click = true 	
	
#atribui o resultado do dado1 dado ao resultado total
func get_resultado1(resultado: Variant) -> void:
	resultadoTotal += resultado

#atribui o resultado do dado1 dado ao resultado total
func get_resultado2(resultado: Variant) -> void:
	resultadoTotal += resultado
	jogada()
	
	#O metodo é chamado quando uma box termina, possibilitando clicar para o dado rodar
func on_box_acabou() -> void:
	#impede o jogador de clicar no dado assim que ele acaba
	await get_tree().process_frame 
	dado1.can_click = true
	dado2.can_click = true
	
	#Quando o botao sim é apertado 
	#A propriedad atribui o nome do jogador ao proprietario
	#O Jogador adiciona propriedade a sua listas de propriedade
func on_compra_sim() -> void:
	var tipo = tabuleiro.espacos[players[turno].posicao].tipo
	tabuleiro.set_comprada(players[turno].posicao, tipo)
	var propriedade = tabuleiro.encontrarPropriedade(players[turno].posicao, tipo)
	propriedade.setProprietario(players[turno].nome)
	players[turno].comprar(propriedade)
	

#Ainda não implementado
func _on_propriedades_pressed() -> void:
	pass
	

#Ainda não implementado
func _on_cartas_pressed() -> void:
	pass # Replace with function body.
