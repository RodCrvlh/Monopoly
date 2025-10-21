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

#Faz a iteracao de cada espaco a ser andando de acordo com o resultadoTotal do movimento
func movimenta_peca() -> void:
	while resultadoTotal>0 : 
		await(mover(player.get_posicao()))
		player.posicao += 1	
		resultadoTotal -=1
		if player.posicao >=tabuleiro.espacos.size():
			player.posicao = 0
	
	dado1.can_click = true 
	dado2.can_click = true 
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
	if tipo == Tipo.Espaco.TERRENO or tipo == Tipo.Espaco.FERROVIA or tipo == Tipo.Espaco.SERVICO:
		var box =  boxs[0] 
		var box_compra = box.instantiate()
		canvas_layer.add_child(box_compra)
		
	if tipo == Tipo.Espaco.CADEIA:
		var box =  boxs[1] 
		var box_compra = box.instantiate()
		canvas_layer.add_child(box_compra)
		
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
		
	#Estava dando erro fazer polimorfirsmo com espaco
	#Ela só ve se o espaco é uma propriedade
	#var pos: int = tabuleiro.espacos[player.posicao].espacoDados.posicao
	#if tabuleiro.propriedades[pos].comprada == false: 
	#	if player.comprar(tabuleiro.espacos[player.posicao].precoCompra):
	#		tabuleiro.propriedades[pos].comprada = true 
	#	else :
			#instancia a classe leilao
			#print("leilao") 
	
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
	
