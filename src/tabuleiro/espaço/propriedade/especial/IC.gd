extends Espaco
class_name IC

# NÃO inicialize o 'baralho' aqui fora.

func realizar_acao(player: Player):
	print("\n comecou funcao em IC \n")

	# 1. Chame getInstance() AQUI DENTRO.
	var baralho = BaralhoIC.getInstance()
	
	# Verificação de segurança (boa prática)
	if baralho == null:
		print("ERRO CRÍTICO: Singleton BaralhoIC não encontrado.")
		return

	# 2. Obtenha a carta
	var carta = baralho.getRandom()
	
	if carta == null:
		print("ERRO: BaralhoIC não retornou nenhuma carta.")
		return

	print("\n" + BaralhoIC.getText(carta) + "\n")
	var operacao = BaralhoIC.getDelta(carta)
	
	if operacao >= 0:
		player.adicionar_dinheiro(operacao)
	else:
		player.remover_dinheiro(-operacao) # -operacao está correto (ex: -(-100) = 100)
	
	# 3. REMOVIDA a linha 'removeDoBanco'.
	# A carta já foi "puxada" do baralho atual pela função getRandom().
	# baralho.removeDoBanco(BaralhoIC.getTitle(carta)) # <--- NÃO FAÇA ISSO
