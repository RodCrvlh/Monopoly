extends Node
class_name Tabuleiro

@export var espacos: Array[Espaco]
@onready var peoes: Array[Peao] 
@onready var timer: Timer = $Timer


func _init() -> void:
	var i = 0
	peoes.resize(DadosJogo.n_jogadores)
	espacos.resize(41)
	while i < DadosJogo.n_jogadores:
		peoes[i] = Peao.new(0, DadosJogo.container_pecas[i])
		i += 1
		
func _ready():
	var i = 0
	while i < DadosJogo.n_jogadores:
		add_child(peoes[i].sprite) #adiciona os sprites na arvore
		i += 1
		
		
func mover_peao_visual(id_peao, movimento):
	
	#irá reduzir de 1 em 1 para fazer a animação do peao se movimentando em cada casa
	#teste movimento = 1
	while movimento>0 :
		
		peoes[id_peao].posicao += 1
		movimento -=1
		
		#tamanho total do tabuleiro sem contar o espacço 40 que é prisão
		if peoes[id_peao].posicao >	 39:
			peoes[id_peao].posicao = 0
			
		await(executar_animacao_peao(id_peao)) 


func executar_animacao_peao(id_peao): 
	var peao_visual = peoes[id_peao].sprite
	var destino = espacos[peoes[id_peao].posicao].position
	
	var tween = create_tween()
	tween.tween_property(peao_visual, "position", destino, 1.0)
	timer.start()
	await timer.timeout


func set_propriedade_comprada(posicao: int, sinal: bool):
	if espacos[posicao] is Disciplina:
		espacos[posicao].set_comprada(sinal)
	elif espacos[posicao] is OrgaoBolsa:
		espacos[posicao].set_comprada(sinal)
	if espacos[posicao] is Freelance:
		espacos[posicao].set_comprada(sinal)


func get_espaco(posicao_jogador: int):
	
	return espacos[posicao_jogador]


func atualiza_valor(propriedade: Espaco, cont: int):
	var i = 0
	 
	if propriedade is Disciplina:
		while i < espacos.size():
			if espacos[i].cor == propriedade.cor:
				espacos[i].aprimorar()
	
	elif propriedade is OrgaoBolsa:
		while i < espacos.size():
			if espacos[i] is OrgaoBolsa:
				espacos[i].aprimorar(cont)
	
	elif propriedade is Freelance:
		while i < espacos.size():
			if espacos[i] is Freelance:
				espacos[i].aprimorar(cont)
