extends Espaco
class_name Imposto

func pagarImposto(player: Player):
	player.remover_dinheiro(200)
