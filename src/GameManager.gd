# GameManager.gd
extends Node
class_name GameManager

## CONFIGURAÇÃO
# 1. Pré-carregue a cena da 'Jogada' (Turn.tscn) que você criou.
const JogadaScene = preload("res://src/corelogic/Jogada.tscn")
# 2. Pré-carregue a cena que guarda os dados do jogador (PlayerData.tscn).
const PlayerScene = preload("res://src/jogador/Player.tscn")

## ESTADO DO JOGO
var players = [] # Array para guardar os nós PlayerData
var jogador_atual_idx = 0
var dado1 = Dado.new()
var dado2 = Dado.new()

## REFERÊNCIAS DA CENA
# O nó 'Players' deve ser um filho deste nó 'GameManager'
@onready var players_node = $Players
# O nó 'Tabuleiro' (para mover peões)
@onready var board_node = $Tabuleiro
# O nó 'UI' (para atualizar botões e texto)
@onready var ui_node: CanvasLayer = $UI


func _ready():
	ui_node.connect("botao_rolar_dados_pressionado", _on_botao_rolar_dados_pressionado)
	## ATENÇÃO  
	comeca_jogo()

# -----------------------------------------------------------------
# 1. FUNÇÕES DE INICIALIZAÇÃO
# -----------------------------------------------------------------

func comeca_jogo():
	# 1. Criar jogadores
	criar_jogadores()
	
	# 2. Iniciar o primeiro turno
	iniciar_proximo_turno()

func criar_jogadores():
	var i = 0
	var x = 1660
	var y = 200
	var offset_x = 150
	var offset_y = 50
	players.resize(DadosJogo.n_jogadores) 
	while i < players.size():
		var peca = DadosJogo.container_pecas[i]
		players[i] = Player.new("Player"+str(i), 1500, "Peao_Player"+str(i))
		y += offset_y
		i += 1
	
	i = 0
	while i < players.size():
		add_child(players[i])
		i += 1
	
# ATENÇÃO
func instanciar_jogador(nome, dinheiro_inicial):
	var novo_jogador = PlayerScene.instantiate()
	novo_jogador.name = nome
	novo_jogador.setup(nome, dinheiro_inicial) # Função do PlayerData.gd
	
	players.append(novo_jogador)
	players_node.add_child(novo_jogador)

# -----------------------------------------------------------------
# 2. O "LOOP" DE JOGO (BASEADO EM EVENTOS)
# -----------------------------------------------------------------

func iniciar_proximo_turno():
	if _checar_vitoria():
		print("FIM DE JOGO!")
		# ... (mostrar tela de vitória) ...
		get_tree().quit() # (Exemplo de como fechar)
		return

	var player_atual = players[jogador_atual_idx]
	
	if player_atual.faliu():
		print(player_atual.nome, " faliu. Pulando turno.")
		_on_jogada_terminada() # Pula direto para o fim do turno
		return

	var jogada_atual = JogadaScene.instantiate()
	add_child(jogada_atual) 
	
	jogada_atual.connect("jogada_terminada", _on_jogada_terminada)
	
	#ui_node.atualizar_hud(player_atual)
	
	jogada_atual.iniciar_jogada(player_atual, board_node)
	
	#ui_node.rolar_dados.visible = true
# VAI PARA JOGADA.INICIAR_JOGADA(), DEPOIS VOLTA E ESPERA O BOTÃO DO DADO SER PRESSIONADO.
	
func _on_botao_rolar_dados_pressionado():
	var jogada_node = find_child("Jogada_*", false, false)
	
	if jogada_node:
		var res1 = dado1.rolar_dado()
		var res2 = dado2.rolar_dado()
		
		#IMPLEMENTAR LÓGICA DA UI
		jogada_node.on_rolar_dados_solicitado(res1, res2)
	else:
		print("GameManager: Botão de dados pressionado, mas não há jogada ativa?")
# VAI PARA JOGADA.ON_ROLAR_DADOS_SOLICITADO()


# 3. FUNÇÃO CHAMADA PELO SINAL DE TÉRMINO
func _on_jogada_terminada():
	print("GameManager: Recebeu sinal de 'jogada_terminada'.")
	
	# 1. Avançar o índice do jogador
	jogador_atual_idx = (jogador_atual_idx + 1) % players.size()

	# 2. Chamar o próximo turno, "fechando" o loop
	iniciar_proximo_turno()


# 4. FUNÇÕES DE CHECAGEM
func _checar_vitoria():
	# (Lógica simples de vitória)
	var jogadores_ativos = 0
	for p in players:
		if not p.faliu():
			jogadores_ativos += 1
	
	return jogadores_ativos <= 1

# 5. RECEBER SINAIS DA UI
# O GameManager é o único que "ouve" a UI.
