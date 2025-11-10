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
var leilao: ControleLeilao
var box_leilao: LeilaoBox
## REFERÊNCIAS DA CENA
# O nó 'Players' deve ser um filho deste nó 'GameManager'
@onready var players_node = $Players
# O nó 'Tabuleiro' (para mover peões)
@onready var board_node = $Tabuleiro
# O nó 'UI' (para atualizar botões e texto)
@onready var ui_node: Ui = $Ui

func _init():
	DadosJogo.instanciando_pecas()
	
func _ready():
	ui_node.rolar_dados.connect("botao_rolar_dados_pressionado", _on_botao_rolar_dados_pressionado)
	ui_node.connect("vender", _on_vender_propriedade)
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
	
	players.resize(DadosJogo.n_jogadores) 
	while i < players.size():
		var peca = DadosJogo.container_pecas[i]
		players[i] = Player.new("Player"+str(i), 1500, i)
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
	
	
	
	jogada_atual.iniciar_jogada(player_atual, board_node)
	
	ui_node.set_rolar_dados_visibility(true)
# VAI PARA JOGADA.INICIAR_JOGADA(), DEPOIS VOLTA E ESPERA O BOTÃO DO DADO SER PRESSIONADO.
	
func _on_botao_rolar_dados_pressionado():
	
	ui_node.set_rolar_dados_visibility(false)
	
	var jogada_node = find_child("Jogada_*", false, false)
	
	if jogada_node:
		var res1 = dado1.rolar_dado()
		var res2 = dado2.rolar_dado()
		
		#IMPLEMENTAR LÓGICA DA UI
		ui_node.animacao_rolar(res1, res2)
		#ui_node.encontrar_box()
		
		#Volta para jogada
		jogada_node.on_rolar_dados_solicitado(res1, res2)
		
		var player_atual = players[jogador_atual_idx]
		player_atual.mudar_posicao(res1+res2)
		
		
		var posicao_jogador = player_atual.get_posicao()
		
		#pega o espaco e ativa a box correspondente
		var espaco = board_node.get_espaco(posicao_jogador)
		var box = ui_node.ativar_box(espaco, player_atual)
		
		if box:
			box.connect("compra_sim", _on_compra_sim)
			box.connect("compra_nao", _on_compra_nao)
			box.connect("pagar_aluguel", _on_pagar_aluguel)
			
		
		jogada_node._finalizar_a_jogada()
	
	else:
		print("GameManager: Botão de dados pressionado, mas não há jogada ativa?")
# VAI PARA JOGADA.ON_ROLAR_DADOS_SOLICITADO()
		
		#atualiza a posicao do jogador atual

func _on_compra_sim(espaco: Espaco):
	
	print("GameManager: Sinal compra sim foi recebido")
	var player_atual = players[jogador_atual_idx]
	
	var controle_compra = ControleCompra.new()
	
	var posicao_jogador = player_atual.get_posicao()
	
	player_atual.remover_dinheiro(espaco.precoCompra)
	player_atual.adicionar_propriedade(espaco)
	espaco.set_comprada(true)
	espaco.set_proprietario(player_atual.nome_jogador)
	
	ui_node.set_label_dinheiro(player_atual.dinheiro, jogador_atual_idx)
	
	if espaco is Disciplina:
		
		var disciplina:Disciplina = espaco as Disciplina
		print("Espaco é disciplina")
		
		if controle_compra.verificar_monopolio(player_atual, espaco):
			disciplina.aprimorar(0, 0)
	
	elif espaco is OrgaoBolsa:
		
		var orgao_bolsa:OrgaoBolsa = espaco as OrgaoBolsa
		
		print("Espaco é orgao bolsa")
		var cont = controle_compra.verificar_orgao_bolsa(player_atual)
		
		if cont != 0:
			orgao_bolsa.aprimorar(cont, 0)
		
	elif espaco is Freelance:
		
		var freelance:Freelance = espaco as Freelance
		
		print("Espaco é freelance")
		var cont = controle_compra.verificar_freelance(player_atual)
		
		#Rola os dados para definiro valor de aluguel
		var res1 = dado1.rolar_dado()
		var res2 = dado2.rolar_dado()
		
		#IMPLEMENTAR LÓGICA DA UI
		ui_node.animacao_rolar(res1, res2)
		#ui_node.encontrar_box()
		
		if cont != 0:
			freelance.aprimorar(res1+res2,cont)

func _on_vender_propriedade(divida: int):
	var controle_venda = ControleVenda.new()
	
	if controle_venda.verificar_venda(players[jogador_atual_idx], divida):
		var box_venda = ui_node.ativar_box_venda(players[jogador_atual_idx], divida, controle_venda.valores_propriedades)
		
	
func _on_compra_nao(espaco: Espaco):
	print("GameManager: Sinal compra nao foi recebido")
	
	leilao = ControleLeilao.new()
	var jogador_leilao_idx = (jogador_atual_idx - 1) % players.size()  
	
	box_leilao = ui_node.ativar_box_leilao(players[jogador_leilao_idx].nome_jogador)
	box_leilao.set_nome_jogador_atual(players[jogador_leilao_idx].nome_jogador)
	
	
	box_leilao.connect("player_saiu", on_player_saiu)
	box_leilao.connect("dar_lance", on_dar_lance)
	leilao.iniciar_leilao(players, espaco, ui_node.box_container[2])


func on_dar_lance(valor_lance: int):
	print("Jogador deu Lance")
	
	#var box_leilao = find_child("Box_Leilao", false, false)
	
	var saida = leilao.on_novo_lance(valor_lance)
	
	if saida == "Seu lance é menor que o atual!":
		box_leilao.set_mensagem_lance_menor()
		
	
	elif saida == "Dinheiro insuficiente":
		box_leilao.set_mensagem_dinheiro_insuficiente()
		
		
	else:
		var nome_novo_jogador = leilao.avancar_proximo_jogador()
		box_leilao.set_mensagem_lance(valor_lance)
		box_leilao.set_nome_jogador_atual(nome_novo_jogador)


func on_player_saiu():
	
	var ainda_ha_jogadores = leilao.on_player_saiu()
	
	print(str(ainda_ha_jogadores))
	if ainda_ha_jogadores:
		var nome_jogador = leilao.avancar_proximo_jogador()
		box_leilao.set_nome_jogador_atual(nome_jogador)

	else:
		var nome_vencedor = leilao.finalizar_leilao()
		var id_vencedor: int
		var i = 0
		
		while i < players.size():
			if nome_vencedor == players[i].nome_jogador:
				id_vencedor = i
			i += 1
		
		
		ui_node.set_label_dinheiro(players[id_vencedor].dinheiro, id_vencedor)
		leilao.destruir_leilao()
	
		box_leilao.set_mensagem_final(nome_vencedor)
		await(box_leilao.terminou)


func _on_pagar_aluguel(espaco: Espaco):

	print("Jogador esta pagando aluguel")
	var player_atual = players[jogador_atual_idx]
	player_atual.remover_dinheiro(espaco.aluguel_atual)
	
	var i = 0
	while  i< players.size():
		if players[i].nome_jogador == espaco.proprietario:
			players[i].adicionar_dinheiro(espaco.aluguel_atual)
			ui_node.set_label_dinheiro(players[i].dinheiro, i)
		
		i += 1
	
	ui_node.set_label_dinheiro(player_atual.dinheiro, jogador_atual_idx)


# 3. FUNÇÃO CHAMADA PELO SINAL DE TÉRMINO
func _on_jogada_terminada():
	print("GameManager: Recebeu sinal de 'jogada_terminada'.")
	
	var player_atual = players[jogador_atual_idx]
	ui_node.set_label_dinheiro(player_atual.dinheiro, jogador_atual_idx)
	
	# 1. Avançar o índice do jogador
	jogador_atual_idx = (jogador_atual_idx + 1) % players.size()
	
	ui_node.mover_label_sua_vez(player_atual.get_id_peao())
	
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
