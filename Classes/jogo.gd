class_name Jogo
extends Node2D

@onready var timer: Timer = $Timer
@onready var tabuleiro: Node = $Tabuleiro 
@onready var dado1 := $Dado 
@onready var dado2: Dado = $Dado2
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@export var boxs: Array[PackedScene]
@onready var player: Player = $jogadora
var numero_espacos: int
var resultadoTotal: int 


func _ready() -> void:
	Events.box_acabou.connect(on_box_acabou)
	Events.compra_sim.connect(on_compra_sim)
	
#Faz a iteracao de cada espaco a ser andando de acordo com o resultadoTotal do movimento
func movimenta_peca() -> void:
	#Teste
	resultadoTotal = 10
	while resultadoTotal>0 : 
		player.posicao += 1	
		resultadoTotal -=1
		await(mover(player.posicao))
		if player.posicao >=tabuleiro.espacos.size():
			player.posicao = 0
	
	dado1.can_click = true 
	dado2.can_click = true 
	print(player.posicao)
	print(tabuleiro.espacos[player.posicao].tipo)
	encontrar_box(tabuleiro.espacos[player.posicao].tipo)
	resultadoTotal = 0
	  
#Apaga a imagem de peca e coloca ela em um novo local
func mover(posicao) -> void: 
	var tween = create_tween()
	tween.tween_property(player.peca, "position", tabuleiro.espacos[player.posicao].position, 1.0)
	timer.start()
	await timer.timeout


#Encontra a box relacionada ao espaco especifico que o jogador parou 
func encontrar_box(tipo: Tipo.Espaco) -> void:
	dado1.can_click = false 
	dado2.can_click = false
	if tipo == Tipo.Espaco.TERRENO:
		print("oi")
	if tipo == Tipo.Espaco.TERRENO or tipo == Tipo.Espaco.FERROVIA or tipo == Tipo.Espaco.SERVICO:
		var preco_compra: int = tabuleiro.encontrarPrecoCompra(player.posicao, tipo)
		if player.dinheiro >= preco_compra:
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
	movimenta_peca()
	
func on_box_acabou() -> void:
	#impede o jogador de clicar no dado assim que ele acaba
	await get_tree().process_frame 
	dado1.can_click = true
	dado2.can_click = true
	
func on_compra_sim() -> void:
	var tipo = tabuleiro.espacos[player.posicao].tipo
	var preco_compra = tabuleiro.encontrarPrecoCompra(player.posicao, tipo)
	player.dinheiro -= preco_compra 
	player.dinheiroLabel.text = str(player.dinheiro)
	
