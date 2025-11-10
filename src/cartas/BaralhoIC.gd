extends Baralho
class_name BaralhoIC

## ---------------------------------
## LÓGICA DO SINGLETON
## ---------------------------------
static var _instance = null
static func getInstance():
	return _instance

func _ready():
	# Lógica do Singleton
	if _instance != null and _instance != self:
		print("ERRO: Duplicata de BaralhoIC detectada. Destruindo.")
		queue_free()
		return
	_instance = self
	print("Singleton BaralhoIC pronto.")
	
	# --- CORREÇÃO AQUI ---
	# Atribui a lista de cartas à variável 'cartas' herdada do pai
	cartas = [
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
	
	# Chama o _ready() da classe PAI (Baralho)
	# agora que 'cartas' já tem valor.
	super._ready() 

# A declaração de 'var cartas = [...]' foi REMOVIDA daqui de baixo.
