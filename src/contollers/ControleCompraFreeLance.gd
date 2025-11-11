extends Node
class_name ControleCompraFreeLance

func verificar_freelance(player: Player) -> int:
	var i = 0
	var cont = 0
	while i < player.propriedades_possuidas.size():
		if player.propriedades_possuidas[i] is OrgaoBolsa: 
			cont += 1
		
		i+= 1

	return cont
