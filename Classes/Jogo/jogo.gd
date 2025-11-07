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

func _init() -> void:
	
	#Front end das labels e pecas de jogador 
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
	Events.box_acabou.connect(on_box_acabou) #conecta sinal de que a box acabou com a funcao on_box_acabou
	Events.compra_sim.connect(on_compra_sim) #conecta o sinal de que a propriedade foi comprada com a funcao on_compra_sim

	var i = 0
	while i < players.size():
		add_child(players[i]) #adiciona jogadores na arvore remoto
		i += 1
	
	turnoLabel.text = "Turno: " + players[turno].nome #adiciona o nome de cada jogador

#na jogada o objetivo  é resetar o turno, movimentar a peca 
#e mias para frente verificar se o jogador esta preso
func jogada() -> void:
	
	movimenta_peca()  #chama a funcao que lida com as questoes relacionadas a movimentacao da peca
	
	
#Faz a iteracao de cada espaco a ser andando de acordo com o resultadoTotal do movimento
func movimenta_peca() -> void:
	#Teste
	#resultadoTotal = 32
	while resultadoTotal>0 :
		
		players[turno].posicao += 1 #aumenta a posicao para desenhar a peca em um novo espaco
		resultadoTotal -=1 #diminui o resultado total até finalizar o loop
		
		if players[turno].posicao >= tabuleiro.espacos.size(): #verifica se o jogador ja deu uma volta no tabuleiro
			players[turno].posicao = 0
			encontrar_box(Tipo.Espaco.INICIO) #chama o inicio para o jogador receber o salario
			
		await(mover()) #chama a função que desenha a peça no tabueiro

	
	dado1.can_click = true  #habilita o jogador a clicar na tela para o dado rodar
	dado2.can_click = true  #habilita o jogador a clicar na tela para o dado rodar
	
	if players[turno].posicao != 0:
		encontrar_box(tabuleiro.espacos[players[turno].posicao].tipo) #verifica qual a 
		await(Events.box_acabou)
	
	resultadoTotal = 0
	turno += 1 #muda o turno para o proximo jogador
	
	if turno >= DadosJogo.n_jogadores: 
		turno = 0 #reseta o turno do jogador para o primeiro jogador se bateu o maximo de jogadores
	
	turnoLabel.text = "Turno: "+ players[turno].nome  #muda a Label do turno para o proximo jogador

	  
#Redesenha a Imagem no Tabuleiro
func mover() -> void: 
	var tween = create_tween()
	tween.tween_property(players[turno].peca, "position", tabuleiro.espacos[players[turno].posicao].position, 1.0)
	timer.start()
	await timer.timeout


#Encontra a box relacionada ao espaco especifico que o jogador parou 
func encontrar_box(tipo: Tipo.Espaco) -> void:
	dado1.can_click = false #desabilita o jogador a clicar na tela para o dado rodar
	dado2.can_click = false #desabilita o jogador a clicar na tela para o dado rodar
	
	if tipo == Tipo.Espaco.INICIO:
		var box =  boxs[3]  #inicializa a box e instancia na tela
		var box_inicio = box.instantiate()
		canvas_layer.add_child(box_inicio)	
		players[turno].receberAluguel(200)

	#verifica se o espaco é uma propriedade	
	if tipo == Tipo.Espaco.TERRENO or tipo == Tipo.Espaco.FERROVIA or tipo == Tipo.Espaco.SERVICO:
		
		var propriedade = tabuleiro.encontrarPropriedade(players[turno].posicao, tipo)
	
		#propriedade nao e comprada e é perguntado se o jogador deseja comprar
		if propriedade.comprada == false:
			if players[turno].dinheiro >= propriedade.preco_compra:
				var box =  boxs[0]  #inicializa a box e instancia na tela
				var box_compra = box.instantiate()
				canvas_layer.add_child(box_compra)
				box_compra.setMensagem(propriedade.preco_compra)
		
		#propriedade ja foi comprado e verifica se jogador nao é proprietario 
		elif players[turno].nome != propriedade.proprietario:
			
			var box =  boxs[2] #inicializa a box e instancia na tela
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
		var box =  boxs[1] #inicializa a box e instancia na tela
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
	
	
#recebe o sinal do dado e soma com o resultado total
func get_resultado1(resultado: Variant) -> void: 
	resultadoTotal += resultado

#recebe o sinal do dado2 e soma com o resultado total e chama a funcao jogada para inicar a movimentacao da peca
func get_resultado2(resultado: Variant) -> void: 
	resultadoTotal += resultado
	jogada()
	
	#O metodo é chamado quando uma box termina, possibilitando clicar para o dado rodar
func on_box_acabou() -> void:
	#impede o jogador de clicar no dado assim que ele acaba
	await get_tree().process_frame 
	dado1.can_click = true
	dado2.can_click = true
	
	#Quando o botao sim é apertado em uma compra
	#A propriedad atribui o nome do jogador ao proprietario
	#O Jogador adiciona propriedade a sua listas de propriedade
func on_compra_sim() -> void:
	var tipo = tabuleiro.espacos[players[turno].posicao].tipo #pega o tipo de propriedade
	tabuleiro.set_comprada(players[turno].posicao, tipo) #coloca ele como comprado
	var propriedade = tabuleiro.encontrarPropriedade(players[turno].posicao, tipo) #pega a propriedade em questão
	propriedade.setProprietario(players[turno].nome) #coloca o proprietoario como o jogador
	players[turno].comprar(propriedade) #comprar propriedade
	

#Ainda não implementado
func _on_propriedades_pressed() -> void:
	pass
	

#Ainda não implementado
func _on_cartas_pressed() -> void:
	pass # Replace with function body.
