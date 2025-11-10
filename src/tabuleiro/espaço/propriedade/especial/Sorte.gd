extends Espaco
class_name Sorte

# NÃO inicialize o 'baralho' aqui fora.
var carta_atual

func realizar_acao(player: Player):
	print("\n comecou funcao em IC \n")

	# 1. Chame getInstance() AQUI DENTRO.
	var baralho = BaralhoSorte.getInstance()
	
	# Verificação de segurança (boa prática)
	if baralho == null:
		print("ERRO CRÍTICO: Singleton BaralhoSorte não encontrado.")
		return

	# 2. Obtenha a carta
	carta_atual = baralho.getRandom()
	
	if carta_atual == null:
		print("ERRO: BaralhoSorte não retornou nenhuma carta.")
		return

	print("\n" + BaralhoSorte.getText(carta_atual) + "\n")
	var operacao = BaralhoSorte.getDelta(carta_atual)
	
	if operacao >= 0:
		player.adicionar_dinheiro(operacao)
	else:
		player.remover_dinheiro(-operacao) # -operacao está correto (ex: -(-100) = 100)
	
	# 3. REMOVIDA a linha 'removeDoBanco'.
	# A carta já foi "puxada" do baralho atual pela função getRandom().
	# baralho.removeDoBanco(BaralhoIC.getTitle(carta)) # <--- NÃO FAÇA ISSO
