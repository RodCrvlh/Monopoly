extends Node
class_name ControleLeilao

var vencedor: Player
var jogadoers_participantes: Array[Player]
var maior_lance: int = 0
var idx_jogador_atual: int = -1
var propriedade: Espaco
var box_leilao: PackedScene



func iniciar_leilao(players: Array[Player], espaco: Espaco, box: PackedScene): 
	
	box_leilao = box
	propriedade = espaco 
	jogadoers_participantes = players.duplicate()
	box_leilao.connect("player_saiu", on_player_saiu)
	box_leilao.connect("novo_lance", on_novo_lance)
	
	avancar_proximo_jogador()


func on_novo_lance(lance: int):
	var jogador_atual = jogadoers_participantes[idx_jogador_atual]
	
	if lance > maior_lance and lance < jogador_atual.dinheiro:
		maior_lance = lance 
		vencedor = jogador_atual
		box_leilao.set_mensagem_lance(jogador_atual.nome_jogador, maior_lance)
	
	else:
		box_leilao.set_mensagem_dinheiro_insuficiente()


func on_player_saiu():
		
		jogadoers_participantes.find(idx_jogador_atual)
		
		if idx_jogador_atual != -1:
			jogadoers_participantes.remove_at(idx_jogador_atual)
			
		verificar_termino()


func verificar_termino():
	
	if jogadoers_participantes.size() <= 1:
		finalizar_leilao()
	
	else:
		avancar_proximo_jogador()


func avancar_proximo_jogador():
	
	var proximo_idx = jogadoers_participantes.find(idx_jogador_atual)
	
	#se ainda existe mais de um jogador faz uma volta circuilar no vetor
	if proximo_idx != -1:
		proximo_idx = (proximo_idx+1) %jogadoers_participantes.size()
	
	#so existe um jogador
	else:
		proximo_idx = 0
		
	idx_jogador_atual = proximo_idx


func finalizar_leilao(): 
	if jogadoers_participantes.size() > 0 and maior_lance > 0:
		propriedade.set_proprietario(vencedor.nome_jogador)
		propriedade.set_comprada(true)
		vencedor.adicionar_propriedade(propriedade)
		vencedor.remover_dinheiro(maior_lance)
		
		box_leilao.set_mensagem_final(vencedor.nome_jogador+" é o vencedor do leilao")
		var timer: Timer
		timer.wait_time = 0.2
		timer.start()
		await(timer.timeout)
		box_leilao.destruir_box()
		box_leilao.destruir_box()
		
	else:
		box_leilao.set_mensagem_final("Ninguem comprou esta propriedade!")
		var timer: Timer
		timer.wait_time = 0.2
		timer.start()
		await(timer.timeout)
		box_leilao.destruir_box()
	
	queue_free()
