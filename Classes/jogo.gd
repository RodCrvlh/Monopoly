class_name Jogo
extends Node2D

@onready var timer: Timer = $Timer
@onready var tabuleiro: Node = $Tabuleiro 
@onready var dado1 := $Dado 
@onready var dado2: Dado = $Dado2
@onready var canvas_layer: CanvasLayer = $CanvasLayer 
@export var boxs: Array[PackedScene]
var players: Array[Player]
var numero_espacos: int
var resultadoTotal: int 
var turno: int = 0
@onready var turnoLabel: Label = $CanvasLayer/Turno

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
	
func _ready() -> void:
	Events.box_acabou.connect(on_box_acabou)
	Events.compra_sim.connect(on_compra_sim)
	var i = 0
	while i < players.size():
		add_child(players[i])
		i += 1
	
	turnoLabel.text = "Turno: " + players[turno].nome


func jogada() -> void:
	movimenta_peca()
	
	if turno >= DadosJogo.n_jogadores:
		turno = 0
	
#Faz a iteracao de cada espaco a ser andando de acordo com o resultadoTotal do movimento
func movimenta_peca() -> void:
	#Teste
	#resultadoTotal = 1
	while resultadoTotal>0 :
		players[turno].posicao += 1
		resultadoTotal -=1
		await(mover())
		if players[turno].posicao >=tabuleiro.espacos.size():
			players[turno].posicao = 0
	
	dado1.can_click = true 
	dado2.can_click = true 
	encontrar_box(tabuleiro.espacos[players[turno].posicao].tipo)
	await(Events.box_acabou)
	resultadoTotal = 0
	turno += 1
	
	if(turno >= DadosJogo.n_jogadores):
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
	
	if tipo == Tipo.Espaco.TERRENO or tipo == Tipo.Espaco.FERROVIA or tipo == Tipo.Espaco.SERVICO:
		var preco_compra: int = tabuleiro.encontrarPrecoCompra(players[turno].posicao, tipo)
		if players[turno].dinheiro >= preco_compra:
			var box =  boxs[0] 
			var box_compra = box.instantiate()
			canvas_layer.add_child(box_compra)
			box_compra.setMensagem(preco_compra)
		
	if tipo == Tipo.Espaco.CADEIA:
		var box =  boxs[1] 
		var box_prisao = box.instantiate()
		canvas_layer.add_child(box_prisao)
		
	if tipo == Tipo.Espaco.COFRE:
		dado1.can_click = true 
		dado2.can_click = true 	
		pass
			
	if tipo == Tipo.Espaco.SORTE:
		dado1.can_click = true 
		dado2.can_click = true 	
		pass
	
	if tipo == Tipo.Espaco.IMPOSTODERENDA:
		dado1.can_click = true 
		dado2.can_click = true 	
		pass
		
	if tipo == Tipo.Espaco.TAXADERIQUEZA: 
		dado1.can_click = true 
		dado2.can_click = true 	
		pass
	
	if tipo == Tipo.Espaco.VAPARACADEIA:
		dado1.can_click = true 
		dado2.can_click = true 	
		pass
		
	
func get_resultado1(resultado: Variant) -> void:
	resultadoTotal += resultado

func get_resultado2(resultado: Variant) -> void:
	resultadoTotal += resultado
	jogada()
	
func on_box_acabou() -> void:
	#impede o jogador de clicar no dado assim que ele acaba
	await get_tree().process_frame 
	dado1.can_click = true
	dado2.can_click = true
	
func on_compra_sim() -> void:
	var tipo = tabuleiro.espacos[players[turno].posicao].tipo
	var preco_compra = tabuleiro.encontrarPrecoCompra(players[turno].posicao, tipo)
	players[turno].dinheiro -= preco_compra 
	players[turno].dinheiroLabel.text = str(players[turno].dinheiro)
	
