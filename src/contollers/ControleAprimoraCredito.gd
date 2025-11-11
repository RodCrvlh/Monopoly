extends Node
class_name ControleAprimoraCredito

func coordena_aprimora_credito(espaco:Espaco, player_atual:Player, players: Array[Player]) -> int:
	var i = 0
	while  i< players.size():
		if players[i].nome_jogador == player_atual.nome_jogador:
			player_atual.remover_dinheiro(espaco.valor_casa)
				
				
	espaco.aprimora_credito()
	return i
