# Turn.gd
extends Node
class_name Jogada

signal jogada_terminada

enum EstadoTurno { 
	ESPERANDO_DADOS, 
	MOVENDO_PEAO, 
	ACAO_NA_CASA, 
	FINALIZADO 
}

var estado_atual = EstadoTurno.ESPERANDO_DADOS
var player_da_jogada = null
var tabuleiro = null
var resultado_dados = 0
	

func iniciar_jogada(player, board_node): # TABULEIRO VAI SER SINGLETON
	self.player_da_jogada = player
	self.tabuleiro = board_node
	
	name = "Jogada_" + player.name
	
	print("Jogada: Pronta. Esperando rolagem de dados para ", player.name)
# VOLTA PRO GAME MANAGER E FICA PARADO NA INICIAR_PROXIMO_TURNO() ATÉ QUE O BOTÃO DO DADO SEJA PRESSIONADO


func on_rolar_dados_solicitado(res1: int, res2: int):
	if estado_atual != EstadoTurno.ESPERANDO_DADOS:
		return # JÁ ROLOU OS DADOS
		
	print("Jogada: Rolando dados...")
	estado_atual = EstadoTurno.MOVENDO_PEAO
	
	
	resultado_dados = res1 + res2
	tabuleiro.mover_peao_visual(player_da_jogada.peao_id, resultado_dados)
	_on_movimento_do_peao_terminado()


func _on_movimento_do_peao_terminado():
	estado_atual = EstadoTurno.ACAO_NA_CASA
	
	player_da_jogada.mudar_posicao(resultado_dados)
	var casa_atual = player_da_jogada.indice_posicao_atual
	
	print("Jogada: ", player_da_jogada.name, " parou na casa ", casa_atual)
	
	# 2. Lógica da casa (comprar, pagar aluguel, etc.)
	# ...
	# ... (Esta é a parte complexa do Monopólio)
	# ...
	
	# 3. Quando a ação da casa terminar (ex: clicou em 'Comprar'),
	# você finalmente chama a função de término.
	_finalizar_a_jogada()


# 3. Função que termina o turno
func _finalizar_a_jogada():
	if estado_atual == EstadoTurno.FINALIZADO:
		return # Já terminou
		
	print("Jogada: Turno de ", player_da_jogada.name, " finalizado.")
	estado_atual = EstadoTurno.FINALIZADO
	
	# 1. AVISA O GAMEMANAGER
	# O GameManager está ouvindo este sinal.
	emit_signal("jogada_terminada")
	
	# 2. SE AUTODESTRÓI
	# O trabalho desta 'Jogada' acabou. Ela é removida da cena
	# para dar lugar à próxima.
	queue_free()
