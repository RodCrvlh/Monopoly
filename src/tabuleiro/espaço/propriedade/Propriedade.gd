extends Espaco
class_name  Propriedade

@export var precoCompra: int
@export var valorHipoteca: int
@export var comprada: bool = false


func set_comprada(sinal: bool):
	comprada = sinal    

func aprimorar(a: int, b:int):
	print("Esta indo para propriedades")
	pass
