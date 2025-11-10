extends Node
class_name ControleLeilao

var vencedor: Player
var jogadoers_participantes: Array
var maior_lance: int = 0
var idx_jogador_atual: int = -1
var propriedade: Espaco
var box_leilao: PackedScene



func iniciar_leilao(players: Array, espaco: Espaco, box: PackedScene): 
	print("Leilao foi iniciado")
	box_leilao = box
	
	
	propriedade = espaco 
	jogadoers_participantes = players.duplicate()

	
	avancar_proximo_jogador()


func on_novo_lance(lance: int) -> String:
	var jogador_atual = jogadoers_participantes[idx_jogador_atual]
	print("Lance do jogador "+jogador_atual.nome_jogador+"valor:"+str(lance))
	
	if lance > maior_lance and lance < jogador_atual.dinheiro:
		maior_lance = lance 
		vencedor = jogador_atual
		return jogador_atual.nome_jogador
	
	elif lance < maior_lance:
		return "Seu lance é menor que o atual!"
	
	else:
		return "Dinheiro insuficiente"


func on_player_saiu() -> bool:
	print("Jogador saiu do leilao")
	jogadoers_participantes.find(idx_jogador_atual)
	
	
	jogadoers_participantes.remove_at(idx_jogador_atual)
	idx_jogador_atual -= 1

	return verificar_termino()


func verificar_termino() -> bool:
	print("Verificando termino")
	
	if jogadoers_participantes.size() == 1 and maior_lance == 0:
		return true
		
	if jogadoers_participantes.size() == 1 and maior_lance >= 0:
		
		return false
		
	elif jogadoers_participantes.size() < 1:
		return false
	
	else:
		return true


func avancar_proximo_jogador() -> String:
	
	
	var proximo_idx = idx_jogador_atual+1
	
	#se ainda existe mais de um jogador faz uma volta circuilar no vetor
	if proximo_idx == jogadoers_participantes.size():
		proximo_idx = proximo_idx %jogadoers_participantes.size()
	
	
	idx_jogador_atual = proximo_idx
	
	var nome_jogador = jogadoers_participantes[idx_jogador_atual].nome_jogador
	print("Proximo Jogador:"+nome_jogador)
	return nome_jogador


func finalizar_leilao(): 
	if maior_lance > 0:
		propriedade.set_proprietario(vencedor.nome_jogador)
		propriedade.set_comprada(true)
		vencedor.adicionar_propriedade(propriedade)
		vencedor.remover_dinheiro(maior_lance)
		
		return vencedor.nome_jogador 
		
		
	else:
		return  ""


func destruir_leilao():
	var timer = Timer.new()
	timer.wait_time = 0.2
	timer.start()
	await(timer.timeout)
	queue_free()
