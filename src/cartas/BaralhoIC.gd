extends Node
class_name BaralhoIC

## ---------------------------------
## LÓGICA DO SINGLETON
## ---------------------------------

# 1. A variável estática que guarda A ÚNICA instância
static var _instance = null

# 2. O método estático que qualquer script pode chamar
static func getInstance():
	return _instance

## ---------------------------------
## LÓGICA DO BARALHO (Seu código)
## ---------------------------------
var cartas = [
	{
		"tipoOperacao": 1,
		"valor": 200,
		"titulo": "Novo estágio",
		"descricao": "Você conseguiu entrar em um novo estágio! Receba R$200."
	},
	{
		"tipoOperacao": 0,
		"valor": 100,
		"titulo": "Reprovou em uma matéria",
		"descricao": "A prova estava dificil demais. Pague R$100."
	},
	{
		"tipoOperacao": 1,
		"valor": 150,
		"titulo": "Festa da atlética foi um sucesso",
		"descricao": "A atlética fez uma festa muito lucrativa! Receba R$150."
	},
	{
		"tipoOperacao": 0,
		"valor": 50,
		"titulo": "Flagrado colando",
		"descricao": "Você colou e foi pego. Pague R$50 pela multa."
	},
	{
		"tipoOperacao": 1,
		"valor": 100,
		"titulo": "Iniciação científica",
		"descricao": "Você conseguiu entrar em um projeto de iniciação científica. Receba R$100."
	},
	{
		"tipoOperacao": 0,
		"valor": 75,
		"titulo": "Estágio negado",
		"descricao": "O colegiado de Ciência da Computação negou sua quebra de requisito. Pague R$75."
	},
	{
		"tipoOperacao": 1,
		"valor": 50,
		"titulo": "Montagem de computador",
		"descricao": "Você ajudou um menino a montar o PC dele. Receba R$50."
	},
	{
		"tipoOperacao": 0,
		"valor": 200,
		"titulo": "GREVE!",
		"descricao": "GREVE! Pague R$200."
	},
	{
		"tipoOperacao": 1,
		"valor": 250,
		"titulo": "Vencedor de maratona",
		"descricao": "Você ganhou um prêmio em uma maratona de programação! Receba R$250."
	},
	{
		"tipoOperacao": 0,
		"valor": 25,
		"titulo": "Doação Obrigatória",
		"descricao": "Contribua para a caridade. Pague R$25."
	},
	{
		"tipoOperacao": 1,
		"valor": 75,
		"titulo": "Sorteio",
		"descricao": "Você ganhou um sorteio. Receba R$75."
	},
	{
		"tipoOperacao": 0,
		"valor": 150,
		"titulo": "Aulas canceladas",
		"descricao": "Aulas canceladas devido à chuva forte. Pague R$150."
	},
	{
		"tipoOperacao": 1,
		"valor": 120,
		"titulo": "Monitoria",
		"descricao": "Você virou o novo monitor. Receba R$120."
	},
	{
		"tipoOperacao": 0,
		"valor": 80,
		"titulo": "Caneca nova",
		"descricao": "Você comprou a nova caneca da atlética. Pague R$80."
	},
	{
		"tipoOperacao": 1,
		"valor": 300,
		"titulo": "Pleno",
		"descricao": "Você conseguiu um emprego como pleno! Receba R$300."
	}
]

# Variável para guardar a pilha de cartas atual
var baralho_atual = []


# Função chamada automaticamente quando o nó entra na árvore
func _ready():
	# 3. LÓGICA DE INICIALIZAÇÃO DO SINGLETON
	# Se uma instância já existe E NÃO SOU EU, destrua-se.
	if _instance != null and _instance != self:
		print("ERRO: Duplicata de BaralhoIC detectada. Destruindo.")
		queue_free()
		return

	# Se não houver instância, EU me torno a instância.
	_instance = self
	print("Singleton BaralhoIC pronto.")

	# --- INICIALIZAÇÃO DO BARALHO ---
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
# Esta função PRECISA de uma instância (não pode ser static)
func getRandom() -> Dictionary:
	# Verifica se o baralho atual está vazio
	if baralho_atual.is_empty():
		print("Baralho de ICs vazio. Reembaralhando...")
		embaralhar_baralho()

	# Pega e remove a carta do topo do baralho (pilha)
	return baralho_atual.pop_front()


### 2. removeDoBanco (Função de Instância)
# Remove permanentemente uma carta da lista MESTRA ('cartas')
# Esta função PRECISA de uma instância (não pode ser static)
func removeDoBanco(titulo_da_carta: String):
	var carta_removida = false
	
	# Procura na lista MESTRA
	for i in range(cartas.size()):
		if cartas[i].titulo == titulo_da_carta:
			cartas.remove_at(i)
			carta_removida = true
			break # Para o loop após encontrar e remover

	# Se removeu da lista mestra, também remove do baralho atual
	# para evitar que ela seja sorteada nesta rodada.
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
# chamadas de qualquer lugar, mesmo sem o getInstance().

### 3. getDelta (Static)
# Retorna a variação de dinheiro (positiva ou negativa) de uma carta.
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
