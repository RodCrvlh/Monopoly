extends Node
class_name ControleCompraDisciplina

func verificar_propriedade(player: Player, disciplina: Disciplina) -> bool:
		
	var i = 0
	var cont = 0
	 
	while i < player.propriedades_possuidas.size():
		if player.propriedades_possuidas[i] is Disciplina:
			if player.propriedades_possuidas[i].cor == disciplina.cor:
				cont += 1
				
		i += 1

	if disciplina.cor == Disciplina.Cor.MARROM or disciplina.cor == Disciplina.Cor.AZULESCURO:
		if cont == 2:
			return true 
	
	elif cont == 3:
		return true
		
	
	return false
