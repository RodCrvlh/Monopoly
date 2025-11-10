extends Node
class_name ControleVenda

var valores_propriedades: Array[int]

func verificar_venda(jogador: Player, divida: int):
	
	var dinheiro_venda_total = 0
	var i = 0
	
	var tamanho_vetor = jogador.propriedades_possuidas.size()
	valores_propriedades.resize(tamanho_vetor)
	while i < tamanho_vetor:
		var n_casas = jogador.propriedades_possuidas[i].n_casas
		var valor_casa = jogador.propriedades_possuidas[i].valor_casa/2  
		valores_propriedades +=  n_casas*valor_casa
		dinheiro_venda_total += valores_propriedades[i]
		i += 1
	
	if dinheiro_venda_total > divida:
		return true
		
	else:
		jogador.declarar_falencia()
		return false
