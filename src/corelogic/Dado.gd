extends Node
class_name Dado

var resultado: int

func rolar_dado():
	resultado = randi_range(1, 6)
	return resultado
