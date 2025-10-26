extends Propriedade
class_name Terreno

@export var cor: Cor
var nCasas: int = 0
var hipotecada: bool = false
var aluguel: int 
var aluguel1: int 
var aluguel2: int  
var aluguel3: int  
var aluguel4: int  
var aluguelHotel: int 
var valorCasa: int 
var valorHotel: int
var nivel: int = 1

func _init(n: String, p: int, pC: int, vHa: int, a0: int, a1: int, a2: int, a3: 
	int, a4: int, aH: int, vC: int, vHo: int) -> void:
	super(n, p, pC, vHa)
	aluguel = a0
	aluguel1 = a1 
	aluguel2 = a2  
	aluguel3 = a3  
	aluguel4 =  a4  
	aluguelHotel = aH  
	valorCasa = vC 
	valorHotel = vHo
	
func aprimorarPropriedade() -> void:
	if nivel == 1:
		nivel += 1
		aluguel = aluguel1

	elif nivel == 2:
		nivel += 1
		aluguel = aluguel2
	
	elif nivel == 3:
		nivel += 1
		aluguel = aluguel3
	
	elif nivel == 4:
		nivel += 1
		aluguel = aluguel3
	
	elif nivel == 5:
		nivel += 1
		aluguel = aluguelHotel
		
