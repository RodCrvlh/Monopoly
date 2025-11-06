class_name Propriedade
extends EspacoDado

var preco_compra: int
var valorHipoteca: int
var comprada: bool = false 
var proprietario: String 

func _init(nome: String, posicao: int, pC: int, vH: int) -> void:
	super(nome, posicao)
	preco_compra = pC
	valorHipoteca = vH

func compra(salario: int) -> void:
	if salario >= preco_compra:
		pass 

func aprimorarPropriedade() -> void:
	pass
	
func setProprietario(jogador: String) -> void:
	proprietario = jogador
