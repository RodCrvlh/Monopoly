extends Espaco
class_name VS

@export var dado1: Dado
@export var dado2: Dado

func VS(player: Player, tabuleiro: Tabuleiro):
	var res1: int
	var res2: int
	print("\nturnos restantes do player de vs: " + str(player.turnosRestantesVS) + "\n")
	if player.turnosRestantesVS >= 1:
		res1 = randi_range(1, 6)
		res2 = randi_range(1, 6)
		
		print("\ndado 1 = " + str(res1) + ", dado 2 =" + str(res2) + "\n")
		if res1 == res2:
			player.sairDaVS()
			player.mudar_posicao(res1 + res2)
			tabuleiro.sairDaVS(player, res1 + res2)
		else:
			player.turnosRestantesVS -= 1
			return
	else:
		res1 = randi_range(1, 6)
		res2 = randi_range(1, 6)
		
		print("\ndado 1 = " + str(res1) + ", dado 2 =" + str(res2) + "\n")
		if res1 == res2:
			player.sairDaVS()
			player.mudar_posicao(res1 + res2)
			tabuleiro.sairDaVS(player, res1 + res2)
		else:
			player.sairDaVS()
			tabuleiro.sairDaVS(player, res1 + res2)
			
			
		#rolar dados, se for igual, anda a quantidade, se nao, vai para a casa 10
