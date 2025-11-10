extends Node
class_name ControleLeilao

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
		return jogador_atual.nome_jogador
	
	elif lance < maior_lance:
		return "Seu lance é menor que o atual!"
	
	else:
		return "Dinheiro insuficiente"


func on_player_saiu() -> bool:
	print("Jogador saiu do leilao")
	jogadoers_participantes.find(idx_jogador_atual)
	
	if idx_jogador_atual != 0:
		jogadoers_participantes.remove_at(idx_jogador_atual)
		

	return verificar_termino()


func verificar_termino() -> bool:
	print("Verificando termino")
	if jogadoers_participantes == []:
		return false
		
	elif jogadoers_participantes.size() == 1 and maior_lance == 0:
		return true
	
	elif jogadoers_participantes.size() == 1 and maior_lance > 0:
		return false
	
	else:
		return true



func avancar_proximo_jogador() -> String:
	
	var proximo_idx = idx_jogador_atual+1
	#se ainda existe mais de um jogador faz uma volta circuilar no vetor
	if proximo_idx > 0:
		proximo_idx = proximo_idx %jogadoers_participantes.size()
	
	
	#so existe um jogador
	else:
		proximo_idx = 0
		
		
	idx_jogador_atual = proximo_idx
	
	var nome_jogador = jogadoers_participantes[idx_jogador_atual].nome_jogador
	print("Proximo Jogador:"+nome_jogador)
	return nome_jogador


func finalizar_leilao(): 
	if maior_lance > 0:
		propriedade.set_proprietario(jogadoers_participantes[0].nome_jogador)
		propriedade.set_comprada(true)
		jogadoers_participantes[0].adicionar_propriedade(propriedade)
		jogadoers_participantes[0].remover_dinheiro(maior_lance)
		
		return jogadoers_participantes[0].nome_jogador 
		
		
	else:
		return  ""

	
func destruir_leilao():
	var timer = Timer.new()
	timer.wait_time = 0.2
	timer.start()
	await(timer.timeout)
	queue_free()
