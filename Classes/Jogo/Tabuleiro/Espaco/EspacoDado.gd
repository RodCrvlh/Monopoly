extends Resource
class_name EspacoDado

var nome: String
var posicao: int



func _init(n: String, p: int) -> void:
	nome = n
	posicao = p

func set_nome(n: String) -> void:
	nome = n      
	
func set_posicao(p: int) -> void:
	posicao = p      
