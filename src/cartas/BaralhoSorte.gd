extends Baralho
class_name BaralhoSorte

## ---------------------------------
## LÓGICA DO SINGLETON
## ---------------------------------
static var _instance = null
static func getInstance():
	return _instance

func _ready():
	# Lógica do Singleton
	if _instance != null and _instance != self:
		print("ERRO: Duplicata de BaralhoSorte detectada. Destruindo.")
		queue_free()
		return
	_instance = self
	print("Singleton BaralhoSorte pronto.")

	# --- CORREÇÃO AQUI ---
	# Atribui a lista de cartas à variável 'cartas' herdada do pai
	cartas = [
		{
			"tipoOperacao": 1,
			"valor": 50,
			"titulo": "Dinheiro no Chão",
			"descricao": "Você achou R$50 no chão do bandejão! Que sorte!"
		},
		{
			"tipoOperacao": 0,
			"valor": 90,
			"titulo": "Multa da Biblioteca",
			"descricao": "Você esqueceu de devolver um livro por 3 meses. Pague R$90 de multa."
		},
		{
			"tipoOperacao": 1,
			"valor": 75,
			"titulo": "Xerox Grátis",
			"descricao": "A máquina de xerox bugou e imprimiu seu TCC de graça. Economizou R$75."
		},
		{
			"tipoOperacao": 0,
			"valor": 250,
			"titulo": "PC Quebrou",
			"descricao": "Seu notebook quebrou na semana de provas. Pague R$250 pelo conserto."
		},
		{
			"tipoOperacao": 1,
			"valor": 300,
			"titulo": "Bolsa Inesperada",
			"descricao": "Sua solicitação de bolsa de última hora foi aprovada! Receba R$300."
		},
		{
			"tipoOperacao": 0,
			"valor": 60,
			"titulo": "Perdeu a Carteirinha",
			"descricao": "Perdeu o passe de ônibus e teve que pagar inteira a semana toda. Pague R$60."
		},
		{
			"tipoOperacao": 1,
			"valor": 100,
			"titulo": "Coffee Break",
			"descricao": "O evento da SeComp teve coffee break sobrando. Você pegou lanche para a semana. Receba R$100."
		},
		{
			"tipoOperacao": 0,
			"valor": 50,
			"titulo": "Ônibus Errado",
			"descricao": "Pegou o ônibus errado e foi parar do outro lado da cidade. Pague R$50 de Uber para voltar."
		},
		{
			"tipoOperacao": 1,
			"valor": 120,
			"titulo": "Sorte na Prova",
			"descricao": "Caiu exatamente a única matéria que você estudou. Bônus de confiança: Receba R$120."
		},
		{
			"tipoOperacao": 0,
			"valor": 25,
			"titulo": "Aposta Perdida",
			"descricao": "Apostou que terminava o trabalho em uma noite. Perdeu. Pague R$25."
		},
		{
			"tipoOperacao": 1,
			"valor": 40,
			"titulo": "Carona Milagrosa",
			"descricao": "Conseguiu uma carona na chuva e economizou o Uber. Receba R$40."
		},
		{
			"tipoOperacao": 0,
			"valor": 150,
			"titulo": "Custo da Calourada",
			"descricao": "A festa foi boa demais. Pague R$150 pela 'ressaca financeira'."
		},
		{
			"tipoOperacao": 1,
			"valor": 180,
			"titulo": "Professor Bonzinho",
			"descricao": "O professor arredondou sua nota de 4.8 para 5.0! Economizou η DP. Receba R$180."
		},
		{
			"tipoOperacao": 0,
			"valor": 80,
			"titulo": "Crise do Café",
			"descricao": "A máquina de café do IC quebrou. Você teve que comprar café premium. Pague R$80."
		},
		{
			"tipoOperacao": 1,
			"valor": 200,
			"titulo": "Ponto Extra",
			"descricao": "Você respondeu uma pergunta aleatória do professor e ganhou um ponto na média. Receba R$200."
		}
	]
	
	# Chama o _ready() da classe PAI (Baralho)
	# agora que 'cartas' já tem valor.
	super._ready()

# A declaração de 'var cartas = [...]' foi REMOVIDA daqui de baixo.
