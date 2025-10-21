class_name Propriedade
extends EspacoDado

var precoCompra: int
var valorHipoteca: int
var comprada: bool = false 

func _init(nome: String, posicao: int, pC: int, vH: int) -> void:
	super(nome, posicao)
	precoCompra = pC
	valorHipoteca = vH

func compra(salario: int) -> void:
	if salario >= precoCompra:
		pass 
