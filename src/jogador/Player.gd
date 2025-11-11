extends Node
class_name Player

## SINAIS
signal dinheiro_mudou(novo_valor)
signal posicao_mudou(novo_indice)
signal faliu_sinal

## 1. VARIÁVEIS DE ESTADO (PROPRIEDADES)
var nome_jogador: String = "Jogador"
var id_peao: int

var dinheiro: int = 0:
	set(valor):
		dinheiro = valor
		emit_signal("dinheiro_mudou", dinheiro)
var divida: int = 0
var indice_posicao_atual: int = 0:
	set(valor):
		indice_posicao_atual = valor
		emit_signal("posicao_mudou", indice_posicao_atual)

var esta_na_prisao: bool = false
var turnos_restantes_prisao: int = 0
var esta_falido: bool = false

# Inventário
var propriedades_possuidas: Array[Espaco]


## 2. FUNÇÃO DE INICIALIZAÇÃO
func _init(p_nome: String, dinheiro_inicial: int, p_id_peao: int):
	self.nome_jogador = p_nome
	self.id_peao = p_id_peao
	self.dinheiro = dinheiro_inicial


## 3. FUNÇÕES DE LÓGICA INTERNA (MÉTODOS)
func adicionar_dinheiro(valor: int):
	if esta_falido:
		return
	self.dinheiro += valor
	print(nome_jogador, " recebeu $", valor, ". Total: $", dinheiro)


func remover_dinheiro(valor: int) -> bool:
	if dinheiro >= valor:
		self.dinheiro = dinheiro - valor
		print(nome_jogador, " pagou $", valor, ". Total: $", dinheiro)
		return true
	else:
		divida = valor
		return false


func declarar_falencia():
	print(nome_jogador, " FALIU!")
	esta_falido = true
	nome_jogador += "faliu"
	dinheiro = 0
	var i = 0
	while i < propriedades_possuidas.size():
		if propriedades_possuidas[i] is Disciplina:
			propriedades_possuidas[i].resetar()
		
		elif propriedades_possuidas[i] is OrgaoBolsa:
			propriedades_possuidas[i].resetar()
		
		elif propriedades_possuidas[i] is Freelance:
			propriedades_possuidas[i].resetar()
		
		i+= 1
	propriedades_possuidas
	emit_signal("faliu_sinal")


func faliu() -> bool:
	return esta_falido


func mudar_posicao(passos: int):
	if esta_na_prisao:
		return

	var nova_posicao = (indice_posicao_atual + passos) % 40 
	
	# Checar se passou pelo "Início" (Go)
	if nova_posicao < indice_posicao_atual:
		print(nome_jogador, " passou pelo Início!")
		adicionar_dinheiro(200)
		
	self.indice_posicao_atual = nova_posicao


func adicionar_propriedade(recurso_propriedade):
	propriedades_possuidas.append(recurso_propriedade)
	
func remover_propriedade(recurso_propriedade):
	propriedades_possuidas.erase(recurso_propriedade)


func remover_propriedade_por_idx(idx: int):
	remover_propriedade(propriedades_possuidas[idx])
	
	
func ir_para_prisao():
	print(nome_jogador, " foi para a prisão!")
	self.indice_posicao_atual = 40 # (Índice da prisão)
	esta_na_prisao = true
	turnos_restantes_prisao = 3


func tentar_sair_prisao():
	# ... (lógica para pagar, usar carta ou rolar dados) ...
	pass


func get_id_peao() -> int:
	return id_peao


func get_posicao() -> int:
	return indice_posicao_atual
