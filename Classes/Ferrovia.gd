extends Propriedade
class_name Ferrovia

var aluguel1: int
var aluguel2: int
var aluguel3: int
var aluguel4: int

func _init(n: String, p:int, pc: int, vH: int, a1: int, a2: int, a3: int, a4: int) -> void:
	super(n, p, pc, vH)
	aluguel1 = a1
	aluguel2 = a2
	aluguel3 = a3
	aluguel4 = a4
