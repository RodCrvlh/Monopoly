extends Espaco
class_name  Propriedade

@export var precoCompra: int
@export var valorHipoteca: int
@export var comprada: bool = false
var proprietario: String


func set_proprietario(nome: String):
	proprietario = nome


func set_comprada(sinal: bool):
	comprada = sinal    
