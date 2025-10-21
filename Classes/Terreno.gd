extends Propriedade
class_name Terreno

@export var cor: Cor
var nCasas: int = 0
var hipotecada: bool = false
var aluguel0: int 
var aluguel1: int 
var aluguel2: int  
var aluguel3: int  
var aluguel4: int  
var aluguelHotel: int 
var valorCasa: int 
var valorHotel: int

func _init(n: String, p: int, pC: int, vHa: int, a0: int, a1: int, a2: int, a3: 
	int, a4: int, aH: int, vC: int, vHo: int) -> void:
	super(n, p, pC, vHa)
	aluguel0 = a0
	aluguel1 = a1 
	aluguel2 = a2  
	aluguel3 = a3  
	aluguel4 =  a4  
	aluguelHotel = aH  
	valorCasa = vC 
	valorHotel = vHo
	
