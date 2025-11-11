extends Espaco
class_name Imposto

func pagarImposto(player: Player):
	var nao_pagou = player.remover_dinheiro(200)
	
	
