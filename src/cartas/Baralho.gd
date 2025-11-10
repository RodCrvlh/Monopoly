extends Node
class_name Baralho

# A lista de cartas. Ela será VAZIA aqui e definida nas classes filhas.
var cartas = []

# Variável para guardar a pilha de cartas atual
var baralho_atual = []


# Função chamada automaticamente quando o nó entra na árvore
func _ready():
	# Inicializa o gerador de números aleatórios
	randomize()
	# Cria o primeiro baralho
	embaralhar_baralho()


# Função auxiliar para (re)criar e embaralhar a pilha de cartas
func embaralhar_baralho():
	# Copia todas as cartas do "banco" para o baralho atual
	baralho_atual = cartas.duplicate()
	# Embaralha o baralho atual
	baralho_atual.shuffle()


## ---------------------------------
## FUNÇÕES DE JOGO
## ---------------------------------

### 1. getRandom (Função de Instância)
# Sorteia e remove a próxima carta do baralho.
func getRandom() -> Dictionary:
	# Verifica se o baralho atual está vazio
	if baralho_atual.is_empty():
		print("Baralho base vazio. Reembaralhando...")
		embaralhar_baralho()

	# Pega e remove a carta do topo do baralho (pilha)
	return baralho_atual.pop_front()


### 2. removeDoBanco (Função de Instância)
# Remove permanentemente uma carta da lista MESTRA ('cartas')
func removeDoBanco(titulo_da_carta: String):
	var carta_removida = false
	
	# Procura na lista MESTRA
	for i in range(cartas.size()):
		if cartas[i].titulo == titulo_da_carta:
			cartas.remove_at(i)
			carta_removida = true
			break # Para o loop após encontrar e remover

	# Se removeu da lista mestra, também remove do baralho atual
	if carta_removida:
		print("Carta '%s' removida permanentemente do banco." % titulo_da_carta)
		for i in range(baralho_atual.size()):
			if baralho_atual[i].titulo == titulo_da_carta:
				baralho_atual.remove_at(i)
				break
	else:
		print("Carta '%s' não encontrada no banco." % titulo_da_carta)


## ---------------------------------
## FUNÇÕES ESTÁTICAS (Helpers)
## ---------------------------------
# Estas funções não precisam de uma instância e podem ser
# chamadas de qualquer lugar.

### 3. getDelta (Static)
static func getDelta(carta: Dictionary) -> int:
	if not carta:
		return 0
	if carta.tipoOperacao == 1:
		return carta.valor
	elif carta.tipoOperacao == 0:
		return -carta.valor
	return 0

### 4. getText (Static)
static func getText(carta: Dictionary) -> String:
	if not carta:
		return ""
	else:
		return carta.titulo + "\n" + carta.descricao

### 5. getTitle (Static)
static func getTitle(carta: Dictionary) -> String:
	if not carta:
		return ""
	else:
		return carta.titulo
