extends Espaco
class_name FicouDeVS

func ficouDeVS(player: Player, tabuleiro: Tabuleiro):
	print(player.nome_jogador, " ficou de VS!")
	player.indice_posicao_atual = 40 # (Índice da prisão)
	player.statusVS = true
	print("\nO player está de VS? " + ("sim" if player.statusVS else "nao") + "\n")
	player.turnosRestantesVS = 3
	
	
	tabuleiro.ficouDeVS(player.id_peao)
